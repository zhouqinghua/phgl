from phgl_main import *

class uart_rx_monitor_pad(bundle):
    def set_par(self):
        super(uart_rx_monitor_pad, self).set_par()

    def set_var(self):
        super(uart_rx_monitor_pad, self).set_var()
        self.var(outp('tx'))
        self.var(inp('rx'))

class uart_rx_monitor(module):
    def set_par(self):
        super(uart_rx_monitor, self).set_par()
        self.p.par('div', 100)
        self.p.par('print_mode', 'string')
        self.p.par('parity', 0)
        self.p.par('sync_delay', 2)

    def set_port(self):
        super(uart_rx_monitor, self).set_port()
        self.io = uart_rx_monitor_pad('io')

    def main(self):
        super(uart_rx_monitor, self).main()

        #cfg
        cfg_div = bits('cfg_div', w = 16, init = self.p.div)
        cfg_parity = bits('cfg_parity', w = 2, init = self.p.parity)

        #baud rate divider
        baud_16x_cnt = reg_r(w = cfg_div.get_w())
        with when(baud_16x_cnt >= cfg_div):
            baud_16x_cnt /= 0
        with other():
            baud_16x_cnt /= baud_16x_cnt + 1
        baud_16x_tick = bits('baud_16x_tick')
        baud_16x_tick /= baud_16x_cnt == 0

        #tx side
        #{{{
        self.io.tx /= 1
        #}}}

        #rx side
        #{{{
        rx_16x_clk = bits('rx_16x_clk')
        rx_16x_clk /= baud_16x_tick

        (s_rx_ready, s_rx_start, s_rx_data, s_rx_parity, s_rx_stop) = range(5)
        rx_state = reg_rs('rx_state', w = 3)
        rx_data_cnt = reg_r(w = 4)
        rx_data_bits_num = mux(cfg_parity == 0, 7, 8)
        rx_stop_cnt = reg_r(w = 2)
        rx_sample_cnt = reg_r(w = 4)
        rx_sample_start = rx_sample_cnt.match_any([0])
        rx_sample_middle= rx_sample_cnt.match_any([7,8,9])
        rx_sample_stop_valid = rx_sample_cnt.match_any([10])        
        rx_sample_end = rx_sample_cnt.match_any([15])
        rx_reg_sync = async_dff(self.io.rx, self.p.sync_delay)
        rx_dly1 = reg()
        rx_sample_data = reg('rx_sample_data', w = 3)
        rx_vote_v = count_ones_cmp(rx_sample_data, 2)
        rx_shift_data = reg('rx_shift_data', w = 9)
        (rx_error_ok, rx_error_start, rx_error_data, rx_error_stop) = range(4)
        rx_error_code = reg_rs('rx_error_code', w = 3, rs = rx_error_ok)
        rx_valid = reg_r('rx_valid')

        with when(rx_16x_clk):
            rx_dly1 /= rx_reg_sync
            rx_sample_cnt /= rx_sample_cnt + 1
            with when(rx_sample_middle):
                rx_sample_data /= cat([rx_sample_data[1:0], rx_reg_sync])

            with when(rx_state == s_rx_ready):
                with when(rx_dly1 & ~rx_reg_sync):
                    rx_state /= s_rx_start
                    rx_sample_cnt /= 0
                    rx_error_code /= rx_error_ok
                    rx_valid /= 0
            with when(rx_state == s_rx_start):
                with when(rx_sample_end):
                    with when(~rx_vote_v):
                        rx_state /= s_rx_data
                        rx_data_cnt /= 0
                        rx_error_code /= rx_error_ok
                    with other(): #fake start
                        rx_state /= s_rx_ready
                        rx_error_code /= rx_error_start
            with when(rx_state == s_rx_data):
                with when(rx_sample_end):
                    rx_data_cnt /= rx_data_cnt + 1
                    rx_shift_data /= cat([
                        rx_vote_v,
                        rx_shift_data[rx_shift_data.get_w() - 1 : 1]])
                    with when(rx_data_cnt == rx_data_bits_num):
                        rx_state /= s_rx_stop
                        rx_stop_cnt /= 0
            with when(rx_state == s_rx_stop):
                #tmp with when(rx_sample_end):
                with when(rx_sample_stop_valid):
                    with when(rx_stop_cnt == 0):
                        rx_state /= s_rx_ready
                        with when(rx_vote_v):
                            rx_error_code /= rx_error_ok
                            rx_valid /= 1
                        with other(): #error stop bit
                            rx_error_code /= rx_error_stop

        #rx_data print
        rx_print_valid =  ~reg_r(next = rx_valid) & rx_valid
        rx_print_data = mux(cfg_parity == 0, rx_shift_data[8:1], rx_shift_data[7:0])
        rx_data_check_error_odd = rx_shift_data.r_xor()
        rx_data_check_error_even = ~rx_data_check_error_odd
        with when(rx_print_valid):
            vprint("%0s", rx_print_data, macro = 0)

            with when(
                (cfg_parity == 1) & 
                rx_data_check_error_odd): #odd check
                rx_error_code /= rx_error_data
            with when(
                (cfg_parity == 2) & 
                rx_data_check_error_even): #even check
                rx_error_code /= rx_error_data

        #}}}

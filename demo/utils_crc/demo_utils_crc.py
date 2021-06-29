from phgl_imp import *

class utils_crc_top(module):
    def set_port(self):
        super(utils_crc_top, self).set_port()
        self.io.var(inp('req_valid'))
        self.io.var(inp('req_data', w = 8))
        self.io.var(outp('crc32_out', w = 32))

    def main(self):
        super(utils_crc_top, self).main()

        #eth packet crc32
        crc_init_v = 0xffffffff
        crc_poly = 0x104c11db7
        crc_reg = reg('crc_reg', w = 32)
        crc_old = mux(l2h(self.io.req_valid), crc_init_v, crc_reg)
        with when(self.io.req_valid):
            crc_reg /= crc32(crc_old, self.io.req_data, crc_poly, 1)
        self.io.crc32_out /= crc_reg

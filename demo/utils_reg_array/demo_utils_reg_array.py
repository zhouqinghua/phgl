from phgl_imp import *

class utils_reg_array_top(module):
    def set_port(self):
        super(utils_reg_array_top, self).set_port()

    def main(self):
        super(utils_reg_array_top, self).main()

        sram0 = reg_array('sram0', size = 256, data_width = 32, mask_width = 4)

        cnt = reg_r('cnt', w = 10)
        wr_en = bits('wr_en')
        rd_en = bits('rd_en')
        rddata = bits('rddata', w = 32)

        cnt /= cnt + 1
        wr_en /= cnt[9:8] == 0
        rd_en /= cnt[9:8] == 1
        sram0.io.en /= wr_en | rd_en
        sram0.io.wmode /= wr_en
        sram0.io.addr /= cnt[7:0]
        sram0.io.wmask /= bin2oh(cnt[1:0])
        sram0.io.wdata /= cnt[7:0].rep(4)
        rddata /= sram0.io.rdata

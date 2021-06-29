from phgl_main import *

class reg_array(module):
    def set_par(self):
        super(reg_array, self).set_par()
        self.p.par('o_reg', 1)
        self.p.par('size', 2)
        self.p.par('data_width', 1)
        self.p.par('mask_width', 1)
        self.p.par('delay', 1) #read delay
        assert(self.p.data_width % self.p.mask_width == 0)

    def set_port(self):
        super(reg_array, self).set_port()
        self.io.var(inp('en'))
        self.io.var(inp('wmode'))
        self.io.var(inp('addr', w = log2_ceil(self.p.size)))
        self.io.var(inp('wmask', w = self.p.mask_width))
        self.io.var(inp('wdata', w = self.p.data_width))
        self.io.var(outp('rdata', w = self.p.data_width))

    def main(self):
        super(reg_array, self).main()
        m = mem('m', self.p.size, self.p.data_width)
        if (self.p.delay > 0):
            if (self.p.o_reg):
                rd_out = bits('rd_out', w = self.p.data_width)
                rd_addr = reg('rd_addr', w = log2_ceil(self.p.size), next = self.io.addr)
            else:
                rd_out = reg('rd_out', w = self.p.data_width)
                rd_addr = bits('rd_addr', w = log2_ceil(self.p.size), init = self.io.addr)
        else:
            rd_out = bits('rd_out', w = self.p.data_width)
            rd_addr = bits('rd_addr', w = log2_ceil(self.p.size), init = self.io.addr)

        wen = bits('wen', w = self.p.mask_width)
        for i in range(self.p.mask_width):
            wen[i] /= self.io.en & self.io.wmode & self.io.wmask[i]

        with blk('posedge'):
            mask_size = int(self.p.data_width / self.p.mask_width)
            for i in range(self.p.mask_width):
                index_l = i * mask_size
                index_h = (i + 1) * mask_size -1
                with if0 (wen[i]):
                    m[self.io.addr][index_h : index_l] /= self.io.wdata[index_h : index_l]
        rd_out /= m[rd_addr]
        self.io.rdata /= rd_out

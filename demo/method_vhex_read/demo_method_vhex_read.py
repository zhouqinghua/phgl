from phgl_imp import *

class method_vhex_read_top(module):
    def set_port(self):
        super(method_vhex_read_top, self).set_port()
        self.io.var(inp('in0'))
        self.io.var(inp('in1'))
        self.io.var(outp('out'))

    def main(self):
        super(method_vhex_read_top, self).main()

        rom0 = vec('rom0', bits, 128, w = 32)

        hex0 = vhex_read('./method_vhex_read/hex0.txt')
        hex1 = vhex_read('./method_vhex_read/hex1.txt')
        hex2 = vhex_read('./method_vhex_read/hex2.txt', fill = 1)
        print('hex0--------')
        for i in range(len(hex0)):
            print('hex0 address[0x%x] = 0x%x' %(hex0[i][0], hex0[i][1]))
            rom0[hex0[i][0]] /= hex0[i][1]
        print('hex1--------')
        for i in range(len(hex1)):
            print('hex1 address[0x%x] = 0x%x' %(hex1[i][0], hex1[i][1]))
            rom0[hex1[i][0]] /= hex1[i][1]
        print('hex2--------')
        for i in range(len(hex2)):
            print('hex2 address[0x%x] = 0x%x' %(hex2[i][0], hex2[i][1]))
            rom0[hex2[i][0]] /= hex2[i][1]

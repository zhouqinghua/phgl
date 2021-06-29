from phgl_imp import *

def crc(data_old, data_new, poly, width):
    assert(isinstance(poly, int))
    crc_tmp = (
        bits(init = data_old, w = width) if (isinstance(data_old, (int, value))) else
        data_old)
    for i in range(data_new.get_w()):
        crc_tmp = (
            cat([crc_tmp[width - 2 : 0], 0]) ^ 
            (
                (crc_tmp[width - 1] ^ data_new[data_new.get_w() - 1 - i]).rep(width) & 
                value(poly).to_bits().lsb(width)))
    return crc_tmp

def crc4(data_old, data_new, poly, refin):
    return crc(data_old, data_new.order_invert() if (refin) else data_new, poly, 4)

def crc5(data_old, data_new, poly, refin):
    return crc(data_old, data_new.order_invert() if (refin) else data_new, poly, 5)

def crc8(data_old, data_new, poly, refin):
    return crc(data_old, data_new.order_invert() if (refin) else data_new, poly, 8)

def crc16(data_old, data_new, poly, refin):
    return crc(data_old, data_new.order_invert() if (refin) else data_new, poly, 16)

def crc32(data_old, data_new, poly, refin):
    return crc(data_old, data_new.order_invert() if (refin) else data_new, poly, 32)

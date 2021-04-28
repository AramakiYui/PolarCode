%CRCУ��
function [b] = crc_check(info_bits)
    global PCparams;
    info = info_bits(1:PCparams.K);
    crc = info_bits(PCparams.K+1:PCparams.K+PCparams.crc_size);
    crc_check = mod(PCparams.crc_matrix * info',2 )';
    b = 1- any(crc~=crc_check);
end
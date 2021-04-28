%PolarCode编码，得到x序列
function y=pencode(u, F_kron_n) 
    global PCparams;

    x = PCparams.FZlookup;
    if PCparams.crc_size ~=0
        crc = mod(PCparams.crc_matrix*u', 2)';
    else
        crc = [];
    end
    
    u = [u crc];
    x (x == -1) = u;%-1为信息比特位置
    x = x(PCparams.bitreversedindices+1);
    y = mod(x*F_kron_n,2);
end
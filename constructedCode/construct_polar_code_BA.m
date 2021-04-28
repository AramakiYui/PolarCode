%ʹ�ð��ϲ����Ͻ緽������Polar Code
%Author:����
function construct_polar_code_BA(N,design_snr_dB)
    n = ceil(log2(N)); 
    NN = 2^n;
    if(NN~=N)
        fprintf('The num N must be the power of 2!');
        return;
    end
    
    file_name = sprintf('constructedCode//PolarCode_block_length_%d_designSNR_%.2fdB_method_Bhattacharyya.txt',N,design_snr_dB);
    fid = fopen(file_name,'w+');
    bitreversedindices = zeros(1,N);
    for index = 1 : N
        bitreversedindices(index) = bin2dec(wrev(dec2bin(index-1,n)));
    end
    
    z = zeros(1,N);
    design_snr_num = 10^(design_snr_dB/10);
    z(1) = log(exp(-design_snr_num));
    for lev = 1:n
        B = 2^lev;
        for j = 1:B/2
            T = z(j);
            z(j) = log(2)+T + log1p(-exp(T-log(2)));
            z(B/2+j) = 2*T;
        end
    end
    
    z = z(bitreversedindices+1);
    [~,indices] = sort(z,'ascend');
    for ii = 1:length(z)
        fprintf(fid,'%d\r\n',indices(ii));
    end
    fclose(fid);
end

%使用高斯近似GA方法构造Polar Code
%Author:马恺
function construct_polar_code_GA(N,sigma)
    n = ceil(log2(N)); 
    NN = 2^n;
    if(NN~=N)
        fprintf('The num N must be the power of 2!');
        return;
    end
    
    file_name = sprintf('constructedCode//PolarCode_block_length_%d_sigma_%.2f_method_GA.txt',N,sigma);
    fid = fopen(file_name,'w+');
    bitreversedindices = zeros(1,N);
    for index = 1 : N
        bitreversedindices(index) = bin2dec(wrev(dec2bin(index-1,n)));
    end
    initialize_phi();%初始化φ(x)和φ(x)的反函数表
    
    mean_llr = 2/sigma^2;
    channels = mean_llr*ones(1, N);
    
    for i=1:n
        c1 = channels(1:2:N);
        c2 = channels(2:2:N);
        channels = [phi_x_inv(1 - (1 - phi_x_table(c1)).*(1 - phi_x_table(c2)))', c1 + c2];
    end
    channels = channels(bitreversedindices+1);

    [~,indices] = sort(channels,'descend');
    for ii = 1:length(channels)
        fprintf(fid,'%d\r\n',indices(ii));
    end
    fclose(fid);
end

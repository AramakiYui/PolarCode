%Polar码初始化程序，主要构建PolarCode的数据结构
function initPC(N,K,construction_method,design_snr_dB,sigma,crc_size)
global PCparams;

%将码长N向上调整为2的n次幂
n = ceil(log2(N));
N = 2^n;

%N:码长
%K:信息位长
%n = log2(N)
%FZlookup:长向量，为0表示冻结比特的位置，为-1表示信息比特的位置
%L:用于存储运算过程中的左信息值对数似然比（算法中的L矩阵）
%B:用于存储运算过程中的右信息值硬判决比特（算法中的B矩阵）
%bitreversedindices:比特反序矩阵
%crc_size:CRC校验位大小
PCparams = struct('N', N, ...
                  'K', K, ...
                  'n', n, ...
                  'FZlookup', zeros(1,N), ...
                  'L', zeros(N,n+1), ...
                  'B', zeros(N,n+1),...
                  'bitreversedindices',zeros(N,1),...
				  'crc_size',0);

%比特反序矩阵初始化
for index = 1 : N
	PCparams.bitreversedindices(index) = bin2dec(wrev(dec2bin(index-1,n)));
end

%CRC校验矩阵（SCL译码用）
if crc_size ~= 0
    PCparams.crc_size = crc_size;
	PCparams.crc_matrix = floor(2*rand(PCparams.crc_size, K));
end

switch construction_method
    case 0
        construct_polar_code_BA(N,design_snr_dB);
        constructed_code_file_name = sprintf('constructedCode//PolarCode_block_length_%d_designSNR_%.2fdB_method_Bhattacharyya.txt',N,design_snr_dB);
    case 1
        construct_polar_code_GA(N,sigma);
        constructed_code_file_name = sprintf('constructedCode//PolarCode_block_length_%d_sigma_%.2f_method_GA.txt',N,sigma);
end

%根据构造方式不同加载信息比特序列
indices = load(constructed_code_file_name);
PCparams.FZlookup = zeros(1,N);
if PCparams.crc_size == 0
    PCparams.FZlookup(indices(1:K)) = -1;
else
    PCparams.FZlookup(indices(1:K+PCparams.crc_size)) = -1;
end

end

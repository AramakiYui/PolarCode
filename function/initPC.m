%Polar���ʼ��������Ҫ����PolarCode�����ݽṹ
function initPC(N,K,construction_method,design_snr_dB,sigma,crc_size)
global PCparams;

%���볤N���ϵ���Ϊ2��n����
n = ceil(log2(N));
N = 2^n;

%N:�볤
%K:��Ϣλ��
%n = log2(N)
%FZlookup:��������Ϊ0��ʾ������ص�λ�ã�Ϊ-1��ʾ��Ϣ���ص�λ��
%L:���ڴ洢��������е�����Ϣֵ������Ȼ�ȣ��㷨�е�L����
%B:���ڴ洢��������е�����ϢֵӲ�о����أ��㷨�е�B����
%bitreversedindices:���ط������
%crc_size:CRCУ��λ��С
PCparams = struct('N', N, ...
                  'K', K, ...
                  'n', n, ...
                  'FZlookup', zeros(1,N), ...
                  'L', zeros(N,n+1), ...
                  'B', zeros(N,n+1),...
                  'bitreversedindices',zeros(N,1),...
				  'crc_size',0);

%���ط�������ʼ��
for index = 1 : N
	PCparams.bitreversedindices(index) = bin2dec(wrev(dec2bin(index-1,n)));
end

%CRCУ�����SCL�����ã�
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

%���ݹ��췽ʽ��ͬ������Ϣ��������
indices = load(constructed_code_file_name);
PCparams.FZlookup = zeros(1,N);
if PCparams.crc_size == 0
    PCparams.FZlookup(indices(1:K)) = -1;
else
    PCparams.FZlookup(indices(1:K+PCparams.crc_size)) = -1;
end

end

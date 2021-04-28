%Polar Encoder and SC,BP,SCAN Decoder for BPSK+AWGN Channel
%Author:����
clear;
tic;
global PCparams;
addpath('function');
addpath('constructedCode')

N = 256;                                        %�볤
K = 128;                                        %��Ϣλ����
Rc = K/N;                                       %����
Rm = 1;                                         %BPSKͨ��ϵͳ�ĵ�����
ebn0 = 1:0.5:3;                                 %���������
SNR = ebn0 + 10*log10(Rc*Rm) + 10*log10(2);     %��������ȣ�ʵ���ź� + 10*log10(2)2��������ϵ��
SNR_num = 10.^(SNR/10);

design_snr_dB = 0;  %���ϲ��������켫�������
sigma = 0.9;        %��˹���Ʒ����켫����������������

min_frame_errors = 10;
min_frame_num = 10000;
max_frame_num = 1e7;

construction_method = input('Choose Polar Code Construction Method: 0---Bhattacharyya  1---GA\n');
decoding_method = input('Choose the Decoding Method: 0---SC  1---SSC  2---CA_SCL  3---BP 4---SCAN\n');

switch decoding_method
    case 0      %SC
        crc_size = 0;
        initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
    case 1      %SSC
        crc_size = 0;
        initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
        [decoder_tree_initial, G_set, B_set] = intial_tree_G( );
    case 2      %CA-SCL,����List��С��CRCУ��λ��
        scl_list_size = input('Input the list size of the SCL: at least 1 \n');
        crc_size = input('Input the CRC size of the SCL: at least 0 \n');
        initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
    case 3      %BP,�������������һ��Ϊ40
        bp_iter_num = input('Input the iternum of the BP: usually 40 \n');
        crc_size = 0;
        initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
    case 4      %SCAN,�������������һ��Ϊ1-4
        scan_iter_num = input('Input the iternum of the SCAN: usually 1-4 \n');
        crc_size = 0;
        initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
    otherwise
        disp('Invalid input!Use SC decoding algorithm by default!');
        crc_size = 0;
        initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
end

n = PCparams.n;
F = [1 0;1 1];
B = 1;
for ii=1:n
    B = kron(B,F);%n�ο����ڿ���
end
F_kron_n = B;

FER = zeros(1,length(ebn0));
BER = zeros(1,length(ebn0));
bpsk_FER=zeros(1,length(ebn0));       
bpsk_BER=zeros(1,length(ebn0));   

for j = 1:length(ebn0)
	fprintf('\n Now running:%.2f  [%d of %d] \n\t Iteration-Counter: %53d',ebn0(j),j,length(ebn0),0);
	tt=tic();
	for l = 1:max_frame_num
        de_bpsk = zeros(1,N);
        u=randi(2,1,K)-1;%����0��1��ɵģ�1��K)���󣬼���Ϣ����
		x=pencode(u,F_kron_n);%�ŵ�����
        tx_waveform=bpsk(x);%BPSK����
        rx_waveform=awgn(tx_waveform,SNR(j),'measured');%AWGN����
        de_bpsk(rx_waveform>0)=1;
        
        nfails = sum(de_bpsk ~= x);
        bpsk_FER(j) = bpsk_FER(j) + (nfails>0);
        bpsk_BER(j) = bpsk_BER(j) + nfails;
        
        initia_llr = -2*rx_waveform*SNR_num(j);%��ʼ������Ȼ��
        switch decoding_method
            case 0
                [u_llr] = polar_SC_decode(initia_llr);
            case 1
                u_hard_decision = polar_SSC_decode(decoder_tree_initial, G_set, B_set, initia_llr);
                u_llr = 1-2*u_hard_decision;
            case 2
                [u_llr] = polar_SCL_decode(initia_llr,scl_list_size);
            case 3
                [u_llr,~] = polar_BP_decode(initia_llr,bp_iter_num);
            case 4
                [u_llr,~] = polar_SCAN_decode(initia_llr,scan_iter_num);
        end
        if PCparams.crc_size
            uhat_crc_llr = u_llr(PCparams.FZlookup == -1)';
            uhat_llr = uhat_crc_llr (1:PCparams.K);
        else
            uhat_llr = u_llr(PCparams.FZlookup == -1)';
        end
		uhat = zeros(1,K);
        uhat(uhat_llr<0) =1;

		nfails = sum(uhat ~= u);
        FER(j) = FER(j) + (nfails>0);
        BER(j) = BER(j) + nfails;
        if mod(l,20)==0
            for iiiii=1:53
                fprintf('\b');
            end
            fprintf(' %7d   ---- %7d FEs, %7d BEs found so far',l,FER(j),BER(j));
        end
        if l>=min_frame_num && FER(j)>=min_frame_errors%��֡�ʴﵽ��Сֵ��֡���ﵽ10000����ǰֹͣ
            break;
        end
	end
    FER(j) = FER(j)/l;
    BER(j) = BER(j)/(K*l);

    bpsk_BER(j) = bpsk_BER(j)/(N*l);
    bpsk_FER(j) = bpsk_FER(j)/l;

    fprintf('\n\t Total time taken: %.2f sec (%d samples)',toc(tt),l);
end

semilogy(ebn0,BER,'bs-','LineWidth',1.5,'MarkerSize',6)
xlabel('Eb/No (dB)')
hold on;
semilogy(ebn0,FER,'gs:','LineWidth',1.5,'MarkerSize',6)
hold on;
semilogy(ebn0,bpsk_BER,'rv-','LineWidth',1.5,'MarkerSize',6)
hold on;
semilogy(ebn0,bpsk_FER,'rv:','LineWidth',1.5,'MarkerSize',6)
grid on;
switch decoding_method
    case 0
        legend('Polar Code SC BER','Polar Code SC FER','BPSK BER','BPSK FER');
    case 1
        legend('Polar Code SSC BER','Polar Code SSC FER','BPSK BER','BPSK FER');
    case 2
        legend('Polar Code SCL BER','Polar Code SCL FER','BPSK BER','BPSK FER');
    case 3
        legend('Polar Code BP BER','Polar Code BP FER','BPSK BER','BPSK FER');
    case 4
        legend('Polar Code SCAN BER','Polar Code SCAN FER','BPSK BER','BPSK FER');
end

toc
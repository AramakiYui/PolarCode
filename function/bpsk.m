% ����BPSK���ƣ���xΪ0��s=1����xΪ0��s=-1
function [waveform]=bpsk(bitseq)
    waveform=ones(1,length(bitseq));
    waveform(bitseq==0)=-1;
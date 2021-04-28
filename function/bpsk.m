% 进行BPSK调制，若x为0，s=1；若x为0，s=-1
function [waveform]=bpsk(bitseq)
    waveform=ones(1,length(bitseq));
    waveform(bitseq==0)=-1;
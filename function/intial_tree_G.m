%��ʼ��SSC��
function [decoder_tree_initial, G, B] = intial_tree_G( )
%�������������������ṹ���Լ�SSC����ʱ���õ���G���󣬺�B_N����
%������ȷ������SSC������ʱ���ã�
%=============��ʼ����=================
global PCparams;
n=PCparams.n;
FZlookup = PCparams.FZlookup;
node = cell(1,7);
%node{1} = node_type���ڵ����ͣ���ʾ0�ڵ�1�ڵ㼰��Ͻڵ㣬�ֱ���0 1 -1��ʾ
%node{2} = L; ���飬��ʾL����
%node{3} = B; ���飬��ʾB����
%node{4} = left_node; int�ͣ���Žڵ�����
%node{5} = right_node; int�ͣ���Žڵ�����
%node{6} = parent_node; int�ͣ���Žڵ�����
%node{7} = state ;
%int�ͣ���ʾ��ǰ�ڵ�ļ���״̬��0��ʾ�����ߣ���1������£��ж������ӽڵ��Ƿ�Ϊ2�����ǣ��������ߣ������ǣ������ߣ� 2��ʾ������
%û�и��ڵ�����ӽڵ���-1��ʾ
node_type = -1;
node_num = 2^(n+1)-1;
decoder_tree_initial = cell(1,node_num);
for layer_index = n:-1:0
    for node_index = 2^layer_index:2^(layer_index+1)-1
        if layer_index == n
            node = { -FZlookup(node_index-2^layer_index+1), zeros(1,2^(n-layer_index)), zeros(1,2^(n-layer_index)), -1, -1, floor(node_index/2),0 };   
        elseif layer_index == 0
            if decoder_tree_initial{node_index*2}{1}==0 && decoder_tree_initial{node_index*2+1}{1}==0
                node_type = 0;
            elseif decoder_tree_initial{node_index*2}{1}==1 && decoder_tree_initial{node_index*2+1}{1}==1
                node_type = 1;
            else
                node_type = -1;
            end
             node = {node_type, zeros(1,2^(n-layer_index)), zeros(1,2^(n-layer_index)), node_index*2, node_index*2+1, -1, 0};
        else
            %�ж������ӽڵ��Ƿ���0�ڵ�����Ƿ���1�ڵ�
            if decoder_tree_initial{node_index*2}{1}==0 && decoder_tree_initial{node_index*2+1}{1}==0
                node_type = 0;
            elseif decoder_tree_initial{node_index*2}{1}==1 && decoder_tree_initial{node_index*2+1}{1}==1
                node_type = 1;
            else
                node_type = -1;
            end
            node = {node_type, zeros(1,2^(n-layer_index)), zeros(1,2^(n-layer_index)), node_index*2, node_index*2+1, floor(node_index/2),0};       
        end
        decoder_tree_initial{node_index} = node;
    end
end
%=============��ʼ�������=================
%=============��������ʼ==================
%����֤�㷨���Ӷȼ���( 300.64 -  74.57 )/300.64 = 75.2%
%�㷨���裺
%�Ӹ��ڵ㿪ʼ�������ڵ㣬�ж����ͣ�����ڵ�Ϊ0�ڵ����Ϊ1�ڵ㣬���ýڵ�ΪҶ�ڵ�
%�൱�ڰ���֦����
for ii = 1:node_num
    if decoder_tree_initial{ii}{1} == 0 || decoder_tree_initial{ii}{1} == 1
        decoder_tree_initial{ii}{4} = -1;
        decoder_tree_initial{ii}{5} = -1;
    end
end

%=============���������==================
%============Ԥ��G_n~G_1=================
%G{1}��ʾlayer=0-->G{n}��ʾlayer=n-1 G{n+1}��ʾlayer = n
%Ԥ��bitreversedindices B{1}��ʾlayer=0��bitreversedindices-->B{n}��ʾlayer=n-1
F = [1 0; 1 1];
GG = 1;
G = cell(1,n+1);
B = cell(1,n+1);
for ii = 1:n
    GG =kron(GG,F);
    bitreversedindices = zeros(1,2^ii);
    for index = 1 : 2^ii
        bitreversedindices(index) = bin2dec(wrev(dec2bin(index-1,ii)));
    end
    B{n-ii+1} = bitreversedindices;
    G{n-ii+1} = GG;
end
G{n+1} =1;
B{n+1} = 0;
end
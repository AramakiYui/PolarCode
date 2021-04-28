%SSC�����㷨
function u_hat = polar_SSC_decode(decoder_tree_initial, G, B, LLR)
%======================================
%============��������ʼ===================
global PCparams;
n=PCparams.n;
u_hat = zeros(1,2^(n+1)-1);%��ʼ���������

node_index = 1; %ȡ��һ���ڵ㣬�����ڵ�
decoder_tree = decoder_tree_initial;
decoder_tree{node_index}{2} = LLR; %��ʼ�����ڵ��LLR
while decoder_tree{1}{7}~=2
    if decoder_tree{node_index}{7} == 0  && decoder_tree{node_index}{4} ~=-1 %�ڵ�δ����Ҳ���Ҷ�ڵ�
        %1. �������ӽڵ��LLR���ڵ�״̬=1
        node_llr = decoder_tree{node_index}{2};
        left_node_llr = fFunction( node_llr(1:2:end), node_llr(2:2:end) );
        decoder_tree{node_index}{7} = 1;
        %2. ��ȡ���ӽڵ�
        node_index = decoder_tree{node_index}{4};
        decoder_tree{node_index}{2} =  left_node_llr;
        continue;
    elseif decoder_tree{node_index}{7} == 0  && decoder_tree{node_index}{4} ==-1 %�ڵ�δ�������Ҷ�ڵ�(Ҷ�ڵ�ֻ����0�ڵ����1�ڵ�)
        % ����ڵ��B���ڵ�״̬=2
        %�жϽڵ����ͣ�������Ϣ���أ�
        layer = floor(log2(node_index)); %�ýڵ�λ����һ��
        layer_num = 2^(n-layer);                 %�ò��ӦL��B��ά��
        if decoder_tree{node_index}{1} == 0 %�ڵ�����Ϊ0�ڵ�
            decoder_tree{node_index}{3} = zeros(1, layer_num);  
        elseif decoder_tree{node_index}{1} == 1 %�ڵ�����Ϊ1�ڵ�
            decoder_tree{node_index}{3} = ( decoder_tree{node_index}{2}<0 );
            u_temp = decoder_tree{node_index}{3};
            u_temp = u_temp( B{layer+1}+1 );

            u_hat( node_index*layer_num:(node_index+1)*layer_num-1 ) = mod( u_temp*G{layer+1}, 2 );
        end
        decoder_tree{node_index}{7} = 2;
        % ȡ���ڵ�
        node_index = decoder_tree{node_index}{6};
        continue;
    elseif decoder_tree{node_index}{7} == 1  && decoder_tree{ decoder_tree{node_index}{5} }{7} ==0 %�ڵ㼤���һ��(�϶�����Ҷ�ڵ㣩���������ӽڵ�δ�����
        %�������ӽڵ�L
        right_node_index = decoder_tree{node_index}{5};
        left_node_index = decoder_tree{node_index}{4};
        node_llr = decoder_tree{node_index}{2};
        right_node_llr =  node_llr(1:2:end).*( 1-2* decoder_tree{left_node_index}{3} ) + node_llr(2:2:end);
        decoder_tree{right_node_index}{2} = right_node_llr;
        %ȡ���ӽڵ�
        node_index =  right_node_index;
        continue;
    elseif decoder_tree{node_index}{7} == 1 && decoder_tree{ decoder_tree{node_index}{5} }{7} ==2 %�ڵ㼤���һ��(�϶�����Ҷ�ڵ㣩���������ӽڵ㼤�������
        %����ýڵ��B, �ڵ�״̬=2��
        right_node_index = decoder_tree{node_index}{5};
        left_node_index = decoder_tree{node_index}{4};
        
        decoder_tree{node_index}{3}(1:2:end) = xor( decoder_tree{left_node_index}{3}, decoder_tree{right_node_index}{3} );
        decoder_tree{node_index}{3}(2:2:end) = decoder_tree{right_node_index}{3};
        decoder_tree{node_index}{7} = 2;
        %ȡ���ڵ�
        node_index = decoder_tree{node_index}{6};
        continue;
    end 
end
u_hat = u_hat(2^n:end);
end
%�����ʼ·��
function l_index = assignInitialPath( )
    global PCparams;
    l_index = PCparams.inactivePathIndices(PCparams.inactivePathIndicesSize);
    PCparams.inactivePathIndicesSize = PCparams.inactivePathIndicesSize - 1;
    PCparams.activePathArray(l_index + 1) = 1;

    for lambda = 0 : PCparams.n
        s = PCparams.inactiveArrayIndices(lambda + 1, PCparams.inactiveArrayIndicesSize(lambda + 1));
        PCparams.inactiveArrayIndicesSize(lambda + 1) = PCparams.inactiveArrayIndicesSize(lambda + 1) - 1;
        PCparams.pathIndexToArrayIndex(lambda + 1, l_index + 1) = s;%POPһ�����б�·��l_index������
        PCparams.arrayReferenceCount(lambda + 1, l_index + 1) = 1;%array++��������
    end
end
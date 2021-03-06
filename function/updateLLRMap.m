%
function updateLLRMap(lambda,phi)
    global PCparams;
    n = PCparams.n;
    if lambda == 0
        return;
    end
    psi = floor(phi/2);
    if mod(phi,2)==0
        updateLLRMap(lambda-1,psi);
    end
    for omega=0:2^(n-lambda)-1
        if mod(phi,2)==0
            %do sth
            PCparams.L(phi+omega*2^lambda+1,n+1-lambda) = fFunction(PCparams.L(psi+2*omega*2^(lambda-1)+1,n+2-lambda),PCparams.L(psi+(2*omega+1)*2^(lambda-1)+1,n+2-lambda)+PCparams.B(phi+1+omega*2^lambda+1,n+1-lambda));
        else
            %do sth
            PCparams.L(phi+omega*2^lambda+1,n+1-lambda) = PCparams.L(psi+(2*omega+1)*2^(lambda-1)+1,n+2-lambda)+fFunction(PCparams.L(psi+2*omega*2^(lambda-1)+1,n+2-lambda),PCparams.B(phi-1+omega*2^lambda+1,n+1-lambda));
        end
    end
end

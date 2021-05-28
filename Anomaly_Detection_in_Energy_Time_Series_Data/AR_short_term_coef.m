function [a] = AR_short_term_coef(x, P)
    
    H = zeros(length(x), P);
    
    for n=1:length(x)
        for k=1:P
            if(n <= k)
                H(n,k)=0;
            else
                H(n,k) = x(n-k);
            end
        end
    end
    a = (H'*H)^(-1)*H'*x';
end


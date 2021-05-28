function [a] = AR_coef(x, N)    
    for n=1:length(x)
        if(n <= N)                  % For values in [1, N]
            H(n) = 0;
        else                        % For value in [N+1, lentgh(x)] 
           H(n) = x(n-N); 
        end
    end
    H = H';
    a = (H'*H)^(-1)*H'*x;
end
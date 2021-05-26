function [a] = AR_coef(ts, n, N)
    H = ts.data(n - N);
    x = ts.data(n);
    a = (H'*H)^(-1)*H'*x;
end
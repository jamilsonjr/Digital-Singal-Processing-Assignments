function [idx_array] = top_three_frequencies(dft, M)
    
    if( length(dft(:,1)) > length(dft(1, :)) )
        dft=dft';
    end
    idx_array = zeros(1, 3);
    top_three_array = zeros(1, 3);
    flag = 1;
    sorted_dft = sort(abs(dft(1, :))/M);
    i = 0;
    while(flag <= 3)
        if(isempty(find(top_three_array == sorted_dft(end-i))))
            top_three_array(i+1) = sorted_dft(end-i);
            idx = find(abs(dft(1, :))/M == top_three_array(i+1));
            idx_array(flag) = idx(1)-1;
            flag = flag + 1;
        else
            i = i + 1;
        end
    end
end
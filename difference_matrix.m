%% compute difference matrix (flow)
function diff_mat = difference_matrix (x, norm)    
    difmat = zeros (size (x, 2), size (x, 2));
    for i = 1:size(x, 2)
        for j = 1 :size (x, 2)
            d =  abs (x (:,i) - x(:,j)) .^ norm; % L1 norm
            sx = sum (d) ^ (1/norm);
            diff_mat (i,j) = sx;        
        end
    end

end
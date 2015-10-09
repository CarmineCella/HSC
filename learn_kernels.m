function filters = learn_kernels (sc, K, idx)
    filters = cell (1, K);
    for i = 1 : K
        %kk1 = max (sc(:, idx==i)); % kernel over frequencies
        
        %kk1 = max (sc(:, idx==i)')'; % kernel over time
        kk1 = mean( sc(:, idx==i), 2);
        %%kk1 = median( sc(:, idx==i), 2);
        % NOTE: kernel over frequencies gives a multiscale approach, with kernels
        % at different scales; on the other hand, kernel over time build
        % constant size vectors that impose stationarity constraints.
        filters{i} = kk1;
    end
    
end

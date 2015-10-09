function features = make_features (sc, K, kernels)
    features = cell (1, K);
   
    for i = 1 : K
        c1 = conv2 (sc, kernels{i}');
        features{i} =  (c1); % pooling
    end 
end
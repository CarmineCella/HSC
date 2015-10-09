function paths = decompose_path (sc_log, sc_lin, indexes, params, h, tag)
    disp (sprintf ('[decomposing order %d, %s]', h, tag));
    K = 2; % binary decomposition
    
%     [W, H] = nnmf (sc_lin, 2);
%     figure
%     subplot (2 + 1, 1, 1)
%     imagesc (W);
% 
%     for i = 1 : 2
%         subplot (2 + 1, 1, i + 1)
%         plot (H(i, :));    
%     end
%     
    %% compute difference matrix
    diff_mat = difference_matrix (sc_log, params.Lp_norm);

    %% estimate variance on histogram of difference matrix
    [variance, xhisto, yhisto] = estimate_variance (diff_mat, sc_log, params.variance_scales (h));

    %% compute adjacency, degree and Laplacian matrices
    [A, D, L] = make_laplacian (diff_mat, variance, .5);

    %% clustering on eigenvectors of Laplacian matrix
    [labels, C, min_Ld_cluster, max_Ld_cluster, principal_eig] = spectral_clustering (L, K, sc_log);

    %% segment input data
    %[positions, segments_lin] = segment_data (sc_lin, indexes, K, labels);
    [positions, segments_log] = segment_data (sc_log, indexes, K, labels);
    
    %% calculate new kernels and make convolutions
    filters_lin = learn_kernels (sc_lin, K, labels);
    %filters_log = learn_kernels (sc_log, K, labels);

    convolutions_lin = make_features (sc_lin, K, filters_lin);
    %convolutions_log = make_features (sc_log, K, filters_log);
    
    %% store data
    decomposition.diff_histo.x = xhisto;
    decomposition.diff_histo.y = yhisto;
    decomposition.diff_histo.variance = variance;

    decomposition.Laplace = L;
    decomposition.clusters.data = principal_eig;
    decomposition.clusters.C = C;
    decomposition.clusters.labels = labels;

    decomposition.segments = segments_log;
    decomposition.positions = positions;

    decomposition.filters = filters_lin;
    decomposition.features = convolutions_lin;
    
    decomposition.order = h;
    decomposition.tag = tag;
    
    left = [];
    right = [];
    
    if (h > 1) 
        left = decompose_path (segments_log{1}, sc_lin, positions{1}, params, h - 1, 'left');
        right = decompose_path (segments_log{2}, sc_lin, positions{2}, params, h - 1, 'right');
    end
    
    paths = [decomposition left right];
end

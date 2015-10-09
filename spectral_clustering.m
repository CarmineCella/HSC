function [idx, C, min_Ld_cluster, max_Ld_cluster, principal_eig] = spectral_clustering (L, K, sc) 
    [u,d] = eig(L);
    [evals, ma]= sort (diag(d), 'descend');
    U = u(:, ma);
    principal_eig = [U(:,2)  U(:,3)];

%     [W, H] = nnmf (U, K);
%     figure
%     subplot (K + 1, 1, 1)
%     imagesc (W);
% 
%     for i = 1 : K
%         subplot (K + 1, 1, i + 1)
%         plot (H(i, :));    
%     end

    [idx, C] = kmeans (principal_eig, K);

    min_max = 0;
    min_Ld_cluster = 0;
    Ld = zeros (1, K);
    for i = 1 : K 
        Ld (i)= sum (pdist (sc(:, idx==i)));
    end
    [min_max, min_Ld_cluster] = min (Ld);
    [min_max, max_Ld_cluster] = min (Ld);
end

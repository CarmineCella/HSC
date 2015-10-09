function [var, xhisto, yhisto] = estimate_variance (diff_mat, sc, variance_scale)
    [yhisto, xhisto] = hist (diff_mat(:), length (sc));
    var = (sum (yhisto .* xhisto / sum (yhisto))) * variance_scale;
end

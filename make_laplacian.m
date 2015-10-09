function [A, D, L] = make_laplacian (diff_mat, var, alpha)
    A = exp (-(diff_mat.^2)/(var^2));

    szadj = size (A);
    D = zeros (szadj(1), szadj(1));

    for i = 1 : szadj(1)
        D (i,i) = sum (A (i,:));
    end

    L = (D^(-alpha)) * A * (D^(-alpha));
    %L = D - A;
    %L = (D^alpha)^(-1) * A;
end

 
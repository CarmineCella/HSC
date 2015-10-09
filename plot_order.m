function plot_order (paths, h)   
    %% plot results
    ord = [];
    for i = 1 : length (paths)
        if (paths(i).order == h)
            ord = [ord paths(i)];
        end
    end
    
    for i = 1 : length (ord)
        figure
        t = sprintf ('Variance ad decomposition order %d', h);
        set(gcf,'numbertitle','off','name', t)         
        plot (ord (i).diff_histo.x, ord (i).diff_histo.y)
        hold on
        stem (ord (i).diff_histo.variance, max (ord (i).diff_histo.y))
        title ('Histogram and variance')
    end
    
    cols = 2 * length (ord);
    rows = 4;

    figure
    t = sprintf ('Decomposition order %d', h);
    set(gcf,'numbertitle','off','name', t) 
    for i = 1 : length (ord)
        subplot (rows, cols, (2*i) - 1)
        imagesc (ord (i).Laplace)
        title ('Laplacian matrix')
   
        subplot (rows, cols, (2*i));
        gscatter(ord(i).clusters.data (:,1), ord (i).clusters.data (:,2), ord(i).clusters.labels)
        hold on
        scatter (ord(i).clusters.C(:,1), ord(i).clusters.C(:,2), 500, 'X','LineWidth', 5);
        title ('Spectral clustering')

        subplot (rows, cols, ((2*i)-1) + 1 * cols)
        imagesc (ord (i).segments{1});
        title ('Segment 1');

        subplot (rows, cols, ((2*i)) + 1 * cols)
        imagesc (ord (i).segments{2});
        title ('Segment 2');
        
        subplot (rows, cols, ((2*i)-1) + 2 * cols)
        plot (ord (i).filters{1});
        title ('Kernel 1');

        subplot (rows, cols, ((2*i)) + 2 * cols)
        plot (ord (i).filters{2});
        title ('Kernel 2');
        
        subplot (rows, cols, ((2*i)-1) + 3 * cols)
        imagesc (ord (i).features{1});
        title ('Feature 1');

        subplot (rows, cols, ((2*i)) + 3 * cols)
        imagesc (ord (i).features{2});
        title ('Feature 2');

    end
end
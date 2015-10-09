function plot_summaries (paths, sc, params)
    figure
    for i = 1 : length (paths)
       set(gcf,'numbertitle','off','name', 'Segments overview') 
       subplot (length (paths), 2, (2*i) - 1)
       t1 = zeros (size (sc));
       t1(:, paths (i).positions{1}) = sc(:, paths (i).positions{1});
       imagesc (t1)
       t = sprintf ('Segment 1, order %d, %s', paths(i).order, paths(i).tag);
       title (t)
       subplot (length (paths), 2, (2*i))
       t2 = zeros (size (sc));
       t2(:, paths (i).positions{2}) = sc(:, paths (i).positions{2});
       imagesc (t2)
       t = sprintf ('Segment 2, order %d, %s', paths(i).order, paths(i).tag);
       title (t)   
    end

    figure
    set(gcf,'numbertitle','off','name', 'Kernels overview') 
    for i = 1 : length (paths)
       subplot (length (paths), 2, (2*i) - 1)
       plot (paths(i).filters{1})
       t = sprintf ('Kernel 1, order %d, %s', paths(i).order, paths(i).tag);
       title (t)
       subplot (length (paths), 2, (2*i))
       plot (paths(i).filters{2})
       t = sprintf ('Kernel 2, order %d, %s', paths(i).order, paths(i).tag);
       title (t)   
    end

    figure
    set(gcf,'numbertitle','off','name', 'Features overview') 
    for i = 1 : length (paths)
       subplot (length (paths), 2, (2*i) - 1)
       imagesc (paths(i).features{1})
       t = sprintf ('Feature 1, order %d, %s', paths(i).order, paths(i).tag);
       title (t)
       subplot (length (paths), 2, (2*i))
       imagesc (paths(i).features{2})
       t = sprintf ('Feature 2, order %d, %s', paths(i).order, paths(i).tag);
       title (t)   
    end
    
    %% alternative view of features
    figure
    set(gcf,'numbertitle','off','name', 'Features maps') 
    rebuild = [];
    for i = 1 : length (paths)
        rebuild = [rebuild (paths (i).features{1}) (paths(i).features{2})];
    end
    imagesc (rebuild)
    title ('Chained features');

    %% alternate view of filters
    figure
    set(gcf,'numbertitle','off','name', 'Kernels') 
    maxlen = length (paths(1).filters{1});
    kernels_mat = zeros (maxlen, 2^length(params.variance_scales));

    for i = 1 : length (paths)
        l = length (paths (i).filters{1});
        kernels_mat([1:l], (2*i)-1) = paths(i).filters{1};
        l = length (paths (i).filters{2});
        kernels_mat([1:l], 2*i) = paths(i).filters{2};
    end
    imagesc (kernels_mat);
    title ('Kernels as a matrix')    
end

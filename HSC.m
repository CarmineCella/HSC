% HIERARCHICAL SPECTRAL CLUSTERING ON SCATTERING COEFFICIENTS
% Carmine E. Cella, ENS, april 2015
%

addpath(genpath('../../libs/scatnet-0.2/'));

paths = []; % full decomposition paths

%% parameters and structures
params = struct ('filename', 'samples/bird_sample1_short.wav', ...
                 'T', 2^11, ...
                 'renormalize', 0, ...
                 'Lp_norm', 1, ...
                 'variance_scales', [1 1], ... 
                 'plot_scattering', 1, ...
                 'plot_results', 1, ...
                 'plot_summaries', 1 );

diff_histo = struct ('x', [], ...
                     'y', [], ...
                     'variance', []);
clusters = struct ('data', [], ...
                   'C', [], ...
                   'labels', []);
               
order = length (params.variance_scales); % NB: the size of the variance_scales vector
                                         % determines the order of the network

decomposition = struct ('diff_histo', diff_histo, ...
                'Laplace', [], ...
                'clusters', clusters, ...
                'segments', [], ...
                'positions', [], ...
                'filters', [], ...
                'features', [], ...
                'order', 0, ...
                'tag', '');     

%% load data
disp ('[reading input data]')
[y, Fs] = audioread (params.filename);
N = length (y);

%% make audio filters
disp ('[making audio filters]');
Wop = make_audio_filters (params.T, N);

%% computer scattering
disp ('[computing scattering]');
[sc_log, sc_lin] = compute_scattering (y, Wop, params);
%%
sc_lin = bsxfun(@minus, sc_lin, mean (sc_lin, 2));
sz = size (sc_lin);

%% create decomposition paths
s = size (sc_log); 
indexes = zeros (1, s (2));
for i = 1 : s(2)
    indexes (1, i) = i;
end

paths = decompose_path (sc_log, sc_lin, indexes, params, order, 'left');

%% plot analysis           
close all

if (params.plot_summaries == 1) 
    plot_summaries (paths, sc_log, params);
end

if (params.plot_results == 1)
    for h = 1 : order 
        plot_order (paths, h);
    end
end

if (params.plot_scattering == 1)
    figure
    set(gcf,'numbertitle','off','name', 'Original signal') 
    subplot (2, 1, 1)
    imagesc (sc_log);
    title ('Log joint scattering vectors (1, 2)');
    subplot (2, 1, 2)
    imagesc (sc_lin);
    title ('Lin joint scattering vectors (1, 2)');
    
end

%% synthesis in time domain (experimental)

for i = 1 : length (paths)
    olap = zeros (size (y));
    for c = 1 : 2
        iptrs = paths (i).positions{c};
        for t = i : length (iptrs);
            iptr = iptrs(t) * (params.T / 2);
            eptr = min (length(y), iptr + params.T);
            olap([iptr:eptr]) = y([iptr:eptr]);
        end
        nn = sprintf ('order_%d_%s_cluster_%d.wav', paths(i).order, paths(i).tag, c);

        audiowrite (nn, olap, Fs);
    end
end

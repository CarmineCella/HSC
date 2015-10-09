function Wop = make_audio_filters (T, N)
    filt_opt = default_filter_options('audio', T);
    Wop = wavelet_factory_1d (N, filt_opt);
end

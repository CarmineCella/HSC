function [sc_log, sc_lin] = compute_scattering (data, Wop, params)

    S = scat (data, Wop);

    if (params.renormalize ~= 0) 
        S = renorm_scat (S);
    end
    
    S1 = log_scat (S);
    
    sc_lin = format_scat (S);
    sc_log = format_scat (S1);
end

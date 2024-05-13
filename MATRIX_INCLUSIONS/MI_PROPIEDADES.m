function [k,m] = MI_PROPIEDADES(prog,cp,cs,ro)

    m = ro*cs^2;
    
    if prog == 'C'
        k = (ro*cp^2)-m;
    elseif prog == 'S'
        k = ro*cp^2 -4*m/3;
    end
 

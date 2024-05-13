function [cp,cs] = MI_PROPIEDADES_INV(prog,k,m,r)
    
    if prog == 'C'
        cp = sqrt((k+m)/r);
        
    elseif prog == 'S'
        cp = sqrt((3*k+4*m)/(3*r));

    end
    cs = sqrt(m/r);
 
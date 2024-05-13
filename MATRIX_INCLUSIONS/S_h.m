% h function of the self-consistent method for spherical inclusions
function f=S_h(x)
    if norm(x)==0
        f=1;
    else
        f=3*(sin(x)-x*cos(x))/(x^3);
    end
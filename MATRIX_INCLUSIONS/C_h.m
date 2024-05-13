% h function of the self-consistent method for cylindrical inclusions
function f=C_h(x)
    if x==0
        f=1;
    else
        f=(2/x)*besselj(1,x);
    end
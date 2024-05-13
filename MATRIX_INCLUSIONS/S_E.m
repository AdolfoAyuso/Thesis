% epsilon function of the self-consistent method for 
% spherical inclusions

function f=S_E(x)
    f=(1-i*x)*exp(i*x)*S_h(x);
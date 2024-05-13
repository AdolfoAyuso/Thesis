% Applies the fixed point method until it converges or the process
% exceeds 10,000 iterations.

function [ro0,ka0,mu0] = MI_EFFECTIVE_PROPERTIES(prog,wave_type,k,m,r,c,a,w,k1,m1,r1,kM,mM,rM)
    [ro0,ka0,mu0] = MI_APROX(prog,wave_type,k,m,r,c,a,w,k1,m1,r1,kM,mM,rM);
    epsi = 0.0000000000001;
    q = 1;
    while (q <= 10000) && (norm((r1-ro0)/r1)>epsi || norm((k1-ka0)/k1)>epsi || norm((m1-mu0)/m1)>epsi)
       r1 = ro0;
       k1 = ka0;
       m1 = mu0;
       [ro0,ka0,mu0] = MI_APROX(prog,wave_type,k,m,r,c,a,w,k1,m1,r1,kM,mM,rM);
       q = q + 1;
       if q==10000
           disp('This iteration needs more precision');
       end
    end
    
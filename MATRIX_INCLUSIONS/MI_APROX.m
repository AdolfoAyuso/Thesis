% Computes the next aproximation of the fixed point method.

function [ro0,ka0,mu0] = MI_APROX(prog,wave_type,k,m,r,c,a,w,k0,m0,r0,kM,mM,rM)

    if prog == 'C'
        cp0=sqrt((k0+m0)/r0);
    elseif prog == 'S'
        cp0=sqrt((3*k0+4*m0)/(3*r0));
    end
    cs0=sqrt(m0/r0);

    tot_k=0;
    tot_m=0;
    tot_r=0;

    for inc=1:length(k)
        kp=w*a(inc)/cp0;
        ks=w*a(inc)/cs0;
        if wave_type=='P'
            ka=kp;
        elseif wave_type=='S'
            ka=ks;
        end

        if prog == 'C'
            hh1 = C_h(ka)^2;
            [Ks, Ms, Rm] = C_I(kp,ks,r0,cp0,cs0);
            kfac(inc) = c(inc)*hh1*(k(inc)-kM)/(1+4*Ks*(k(inc)-k0));
            mfac(inc) = c(inc)*hh1*(m(inc)-mM)/(1+4*Ms*(m(inc)-m0)); 
            rfac(inc) = c(inc)*hh1*(r(inc)-rM)/(1+Rm*(r(inc)-r0));

        elseif prog == 'S'
            hh1 = S_h(ka)*S_h(-ka);
            Ep = S_E(kp);
            Es = S_E(ks);

            num = c(inc)*hh1*(k(inc)-kM);
            den = 1+(3*(k(inc)-k0)*Ep)/(3*k0+4*m0);
            kfac(inc) = num/den;
            
            num = c(inc)*hh1*(m(inc)-mM);
            den = 1+2*(m(inc)-m0)*(2*m0*Ep+(3*k0+4*m0)*Es)/(5*m0*(3*k0+4*m0));
            mfac(inc) = num/den; 

            num = c(inc)*hh1*(r(inc)-rM);
            den = 1+(r(inc)-r0)*(3-Ep-2*Es)/(3*r0); 
            rfac(inc) = num/den;

        end
        
        tot_k=tot_k+kfac(inc);
        tot_m=tot_m+mfac(inc);
        tot_r=tot_r+rfac(inc);
      
    end

    ro0 = rM + tot_r;
    ka0 = kM + tot_k;
    mu0 = mM + tot_m;
    
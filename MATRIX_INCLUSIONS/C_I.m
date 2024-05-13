% epsilon function of the self-consistent method for 
% cyilindrical inclusions

function [Ks, Ms, Rm]=C_I(kp,ks,r,cp,cs)
    karray=[kp,ks];
    eps=10^-30;
    for i=1:2
        ka=karray(i);
        n=0;
        total=0;
        while 1
            if ka==0 || isnan(ka)
                break
            end
            f1=factorial(2*n+1)/((factorial(n)*factorial(n+1))^2);
            f1=((-1)^n)*((ka/2)^(2*n))*f1;
            f1=f1/(n+2);
            f2=psi(2*n+2)-psi(n+2)-psi(n+1)+log(ka/2)-1/(2*n+4);
            f2=2*1i*f2/pi;
            f2=1+f2;
            total=total+f1*f2;
            n=n+1;
            if abs(f1*f2)<=eps 
                break;
            end
        end
        I(i)=0.5*ka*ka*pi*1i*total;
    end
    Ip=I(1);
    Is=I(2);
    
    Ks=(1/4)*((1+Ip)/(r*cp^2));
    Ms=(1/8)*((1+Ip)/(r*cp^2)+(1+Is)/(r*cs^2));
    Rm=-(1/2)*((Ip+Is)/r);    
  
clc;
%Variables definition
Q=[0];
W=[0];
syms w;
limsup=3*10^6;         %6*10^5;
n=1000;
step=limsup/n;
h1=0.005;
h2=0.005;
E1=2*10^9;
E2=2*10^11;
ro1=1000;
ro2=3000;
c1=sqrt(E1/ro1);
c2=sqrt(E2/ro2);
k=(ro1*c1)/(ro2*c2);
sg=(1+k^2)/(2*k);
a1=h1/c1;
a2=h2/c2;

Fpart=cos(a1*w)*cos(a2*w)-sg*sin(a1*w)*sin(a2*w);
%Fnew=vpa(subs(F,Q,0.5))
%vpasolve(Fnew==0,w)

for iter=1:step:limsup
 Fnew=vpa(subs(Fpart,w,(iter)*(2*pi)));
 if real(acos(Fnew))<=3
    Q=[Q,acos(Fnew)];
 else
     Q=[Q,3];
 end
 W=[W,iter];
end
l1=plot(Q,W,'r');
xlabel('Q'); 
ylabel('\omega');
grid;


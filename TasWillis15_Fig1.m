%willisjmps15 Figure 1a method applied to Lead - Silicone
clc;
clear;
limsup=40;
step=0.1;
f=0:step:limsup;
w=(2*pi*1000).*f;
mu1=1.49*10^10;
mu2=4*10^5;
ro1=11600;
ro2=1300;
h2=0.0013;
h1=0.003;
h=h1+h2;
K2=0.1/h;

coef11=(ro1/mu1)*(w.^2);
coef12=(ro2/mu2)*(w.^2);
k11=sqrt(coef11-(K2^2));
k12=sqrt(coef12-(K2^2));
num2=mu2*k12;
num1=mu1*k11;
coefaux1=num2./num1;
coefaux2=num1./num2;
coefaux=coefaux1+coefaux2;

trM1=cos(h2*k12).*cos(h1*k11);
trM2=0.5*coefaux.*sin(h2*k12).*sin(h1*k11);
trM=trM1-trM2;
atrM=acos(trM);
iatrM=imag(acos(trM));
ratrM=real(acos(trM));

l1=plot(f,ratrM);
l1.Color='blue';
%l1.LineWidth=2;
hold on
l2=plot(f, iatrM);
l2.Color='green';
xlabel('f (kHz)'); 
ylabel('K1h'); 
headline='K2h='+string(K2*h);
prompt=text(limsup/10, max(max(ratrM),max(iatrM))+0.5, headline);
grid;


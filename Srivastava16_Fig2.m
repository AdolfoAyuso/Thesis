%srivastavajmps16 Figure 2
clc;
clear;
w=8*2*pi*10^5;
mu1=8*10^10;
mu2=3*10^9;
ro1=8000;
ro2=1180;
h1=0.0013;
h2=0.003;
h=h1+h2;
coef11=(ro1/mu1)*(w^2);
coef12=(ro2/mu2)*(w^2);

limsup=30;
imK2h=0:0.01:limsup;
K2=-i*imK2h/h;
k11=sqrt(coef11-(K2.^2));
k12=sqrt(coef12-(K2.^2));
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

l1=plot(imK2h,ratrM);
l1.Color='blue';
hold on
l2=plot(imK2h, iatrM);
l2.Color='green';
legend({'real(K1h)','imag(K1h)'},'Location','southwest')
xlabel('imag(k2h)'); 
ylabel('K1h'); 
headline='f='+string(w/(2*pi*1000))+' kHz';
prompt=text(limsup/10, max(max(ratrM),max(iatrM)), headline);
grid;

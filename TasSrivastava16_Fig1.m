%srivastavajmps16 Figure 1 (a, b and c) method applied to Lead - Silicone
clc
w=5*2*pi*10^5;
mu1=1.49*10^10;
mu2=4*10^4;
ro1=11600;
ro2=1300;
h1=0.0013;
h2=0.003;
h=h1+h2;
coef11=(ro1/mu1)*(w^2);
coef12=(ro2/mu2)*(w^2);

limsup=4000;
step=0.1;
K2h=0:step:limsup;
K2=K2h/h;
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

for j = 1:(limsup*(1/step))
    if sign(iatrM(j))*sign(iatrM(j+1)) == -1
        x=(j+1)*step;
    end
end 
disp(x)

l1=plot(K2h,ratrM);
l1.Color='blue';
hold on
l2=plot(K2h, iatrM);
%ylim([-10000 10000])
l2.Color='red';
%legend({'real(K1h)','imag(K1h)'},'Location','southwest')
xlabel('K2h'); 
ylabel('K1h'); 
headline='f='+string(w/(2*pi*1000))+' kHz';
%prompt=text(limsup/10, 700, headline);

%{
plot(K2h,ratrM)
hold on
plot(K2h, iatrM)


K2h=real(round(K2h,3)).';
k11=round(k11,3).';
k12=round(k12,3).';
trM1=round(trM1,3).';
trM2=round(trM2,3).';
trM=round(trM,3).';
PSGT1=table(K2h,k11,k12,trM1,trM2,trM);
rowN=[];
for c = 1:(limsup*(1/step)+1)
    rowN=[rowN,c];
end 
rowN=string(rowN)
PSGT2=table(K2h,k11,k12,trM1,trM2,trM,'RowNames',rowN);
writetable(PSGT2,'PSGT.txt','Delimiter','\t','WriteRowNames',true);
type PSGT.txt
%}

clc;
%Variables definition
Q=[0];
f=[0];
limsup=5*10^6;        
n=10000;
step=limsup/n;
h=[3,0.065,0.87,0.065]*10^(-3);  %c) [1,0.23,0.44,0.23,1,0.23,0.44,0.23]  %b) [1.6,0.45,1.3,0.45]    %a) [3,0.8]
E=[800,0.3,30000,0.3]*10^9;  %c) [8.68,320,8.68,320,8.68,320,8.68,320]    %b) [8.68,320,8.68,320]   %a) [8.68,320]
ro=[1000,300,8000,300];  %c) [1180,7954,1180,7954,1180,7954,1180,7954]    %b) [1180,7954,1180,7954] %a) [1180,7954]
c=[];
for iter=1:length(h)
    c=[c,sqrt(E(iter)/ro(iter))];
end

for iter=1:step:limsup
     w=(iter)*(2*pi);
     M1=[cos(w*(h(1)/c(1))),-(w*(E(1)/c(1)))*sin(w*(h(1)/c(1)));(1/(w*(E(1)/c(1))))*sin(w*(h(1)/c(1))),cos(w*(h(1)/c(1)))];
     for jter=2:length(h)
         M2=[cos(w*(h(jter)/c(jter))),-(w*(E(jter)/c(jter)))*sin(w*(h(jter)/c(jter)));(1/(w*(E(jter)/c(jter))))*sin(w*(h(jter)/c(jter))),cos(w*(h(jter)/c(jter)))];
         if jter==2
            M=M2*M1;
         else
            M=M2*M;
         end
         trM=trace(M);
         trM=(1/2)*trM;
     end
     if real(acos(trM))<=3
        Q=[Q,acos(trM)];
     else
        Q=[Q,3];
     end
        f=[f,iter];
end

l1=plot(Q,f,'r');
xlabel('Q'); 
ylabel('Frequency (Hz)');
grid;

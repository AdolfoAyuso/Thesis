clc;
syms w Q;
syms f(w);
%Variables definition
Qarray=[];      %Q=qa
branch=[];
branchrow=[];
branchplot=[];
temp=0;
a=0.003+0.0013;                   %0.005+0.005;  %h1+h2
b=0.003;                          %0.005;        %h2
D1=1/(1.49*10^10);                %1/(2*10^9);  %For Nemat Nasser
D2=1/(4*10^4);                    %1/(2*10^11);
DD=D2-D1;
ro1=11600;                        %1000;
ro2=1300;                         %3000;
Dro=ro2-ro1;
N=6;            %mode
n=2*N+1;
n1=(a-b)/a;
n2=b/a;
rot=ro1*n1+ro2*n2;
Dt=D1*n1+D2*n2;
s=100;

%Initialization of H, OM and PHI to size nxn
H=zeros(n);
Hr=zeros(n);
OM=zeros(n);
PHI=zeros(n);

%Definition of OM, without w
for j=1:n
    for k=1:n
        if k==j
            OM(k,j)=rot;
        else
            OM(k,j)=Dro*sin(pi*abs(k-j)*(b/a))/(pi*abs(k-j));
        end
    end
end
OM;

%Definition of PHI
for j=1:n
    for k=1:n
        if k==j
            PHI(k,j)=Dt;
        else
            PHI(k,j)=DD*sin(pi*abs(k-j)*(b/a))/(pi*abs(k-j));
        end
    end
end
PHI;

for iter=0.01:0.01:3.01
    Q=vpa(subs(Q,Q,iter));
    %Definition of H
    %H=sym(H);
    for j=1:n
        for k=1:n
            if k==j
                H(k,j)=(Q+2*pi*(k-1-N))/a;
            end
        end
    end
    H;

    mat1=H\OM;  %inv(H)*OM
    mat2=PHI*mat1;
    mat3=vpa((w^2)*mat2,3);
    mat4=vpa(mat3-H,3);
    f(w)=vpa(det(-H+mat3),3);
    f(w)=vpa(subs(f(w),Q,iter));
    roots=vpa(solve(f(w)==0,w)/(2*pi));
    Qarray=[Qarray,iter];
    for jter=1:n
        branchrow=[branchrow,roots(n+jter)];
    end
    branch=[branch;branchrow];
    branchrow=[];
end



for jter=1:n
    for iter=1:length(branch)
        temp=branch(iter,jter);
        branchplot=[branchplot,temp];
    end
    plot(Qarray,branchplot,'b');
    hold on;
    branchplot=[];
end
xlabel('Q'); 
ylabel('Frequency (Hz)');
headline='N='+string(N);
title(headline)
grid;


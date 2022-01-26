clc;
syms w Q;
syms f(w);
%Variables definition
Qarray=[];      %Q=qa
branch1=[];
branch2=[];
branch3=[];
branch4=[];
a=0.005+0.005;  %h1+h2
b=0.005;        %h2
D1=1/(2*10^9);
D2=1/(2*10^11);
DD=D2-D1;
ro1=1000;
ro2=3000;
Dro=ro2-ro1;
N=5;            %mode
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
    branch1=[branch1,roots(n+1)];
    branch2=[branch2,roots(n+2)];
    branch3=[branch3,roots(n+3)];
    branch4=[branch4,roots(n+4)];
end
l1=plot(Qarray,branch1,'b');
hold on;
l2=plot(Qarray,branch2,'r');
hold on;
l3=plot(Qarray,branch3,'g');
hold on;
l4=plot(Qarray,branch4,'m');
legend({'1m','2m','3m','4m'},'Location','southeast')
xlabel('Q'); 
ylabel('\omega');
grid;


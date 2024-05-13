%{
This program reproduces the results in the article:
"Negative effective dynamic mass-density and stiffness: 
Micro-architecture and phononic transport in periodic composites."

Also, allows for further experimentation with similar multi-layered 
metamaterials composed of symmetric unit cells.
%}

clear;
clc;

%Symbolic Variables
syms w Q x nm;
syms f(w);

%Variables definition
Qarray=[];      
branch=[];
branchrow=[];
branchplot=[];
N=3;
n=2*N+1;

%{
To use this program, three array-like inputs of the same length 
(the number of layers in the symmetric unit cell of our composite) 
are expected:
h -> Width of each layer in meters
E -> Stiffness of each layer in Pa
ro -> Density of each layer in kg/m^3

For further understanding, compare the values in the article
with the inputs in the Nemat-Nasser Validation scenario
%}

% Dissertation Figure

title_string = "Silicon Matrix, B1.";

h=[1.80625,1.45,1.80625,0.5,1.80625,0.435,1.80625,0.5,1.80625,1.45,1.80625]*10^(-3);                       
E=[0.0000325,8.7,0.0000325,2.2,0.0000325,320,0.0000325,2.2,0.0000325,8.7,0.0000325]*10^9; 
ro=[1300,1180,1300,1100,1300,8000,1300,1100,1300,1180,1300];

% Nemat-Nasser Validation

%title_string = "Nemat-Nasser Validation";

%h=[1.45,0.5,0.435,0.5,1.45]*10^(-3);                       
%E=[8.7,0.02,320,0.02,8.7]*10^9; 
%ro=[1180,1100,8000,1100,1180];

% Experiment changing the proportions

%title_string = "Silicon Matrix, Experiment";

%h=[0.066,0.15,0.067,0.05,0.067,0.2,0.067,0.05,0.067,0.15,0.066]*10^(-3);                       
%E=[0.0000325,8.7,0.0000325,0.0002,0.0000325,320,0.0000325,0.0002,0.0000325,8.7,0.0000325]*10^9; 
%ro=[1300,1180,1300,1100,1300,8000,1300,1100,1300,1180,1300];

%h=[0.2,0.2,0.2,0.2,0.2]*10^(-3);                       
%E=[0.34,0.2,0.34,0.2,0.34]*10^9; 
%ro=[1180,1100,1180,1100,1180];  

%h=[0.25,0.5,0.25]*10^(-3);                       
%E=[1.7309,8.3575,1.7309]*10^9; 
%ro=[1202,11300,1202];  

a=sum(h);
D=[];
for iter=1:length(h)
    D=[D,1/E(iter)];
end
Vf=[];
for iter=1:length(h)
    Vf=[Vf,h(iter)/a];
end
rot=dot(Vf,ro);
Dt=dot(Vf,D);
singrow=[];
sing=[];        %matrix size=length(Qarray)*n

%Multilaminate
vaux=exp(2*pi*1i*x*nm/a);
xarray=[];
for iter=1:(length(h)+1)
    if iter==1
        xarray=[xarray,-a/2];
    else
        xarray=[xarray,xarray(iter-1)+h(iter-1)];
    end
end
raux=0;
for iter=1:length(h)
    raux=raux+ro(iter)*(subs(vaux,x,xarray(iter+1))-subs(vaux,x,xarray(iter)));
end
raux=raux/(2*pi*1i*nm);
Daux=0;
for iter=1:length(h)
    Daux=Daux+D(iter)*(subs(vaux,x,xarray(iter+1))-subs(vaux,x,xarray(iter)));
end
Daux=Daux/(2*pi*1i*nm);

%Initialization of H, OM and PHI to size nxn
H=zeros(n);
Hr=zeros(n);
OM=zeros(n);
PHI=zeros(n);
U=[];
S=[];
U2=[];
S2=[];

%Definition of OM, without w
for j=1:n
    for k=1:n
        if k==j
            OM(k,j)=rot;
        else
            OM(k,j)=subs(raux,nm,k-j);
        end
    end
end
OM=real(OM);

%Definition of PHI
for j=1:n
    for k=1:n
        if k==j
            PHI(k,j)=Dt;
        else
            PHI(k,j)=subs(Daux,nm,k-j);
        end
    end
end
PHI=real(PHI);

%For negative, uncomment
%for iter=-3.01:0.01:-0.01
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
    mat3=vpa((w^2)*mat2);
    mat4=vpa(mat3-H);
    f(w)=vpa(det(-H+mat3));
    f(w)=vpa(subs(f(w),Q,iter));
    roots=vpa(solve(f(w)==0,w)/(2*pi));
    Qarray=[Qarray,iter];
    for jter=1:n
        branchrow=[branchrow,roots(n+jter)];
        mat3=((roots(n+jter)*2*pi)^2)*mat2;
        mat4=mat3-H;
        singrow=[singrow,rank(mat4)];
        %Urow=[Urow,mat4];
    end
    mat3=((branchrow(1)*2*pi)^2)*mat2;
    mat4=mat3-H;
    mat5=double(mat4);
    Ucol=null(mat5);
    U=[U,Ucol];
    Scol=H\OM;
    Scol=((branchrow(1)*2*pi)^2)*Scol;
    Scol=Scol*Ucol;
    S=[S,Scol];
    %Second branch
    mat3=((branchrow(2)*2*pi)^2)*mat2;
    mat4=mat3-H;
    mat5=double(mat4);
    Ucol2=null(mat5);
    U2=[U2,Ucol2];
    Scol2=H\OM;
    Scol2=((branchrow(2)*2*pi)^2)*Scol2;
    Scol2=Scol2*Ucol2;
    S2=[S2,Scol2];
    %
    branch=[branch;branchrow];
    sing=[sing;singrow];
    branchrow=[];
    singrow=[];
end

%Dispersion
f1=figure;
%for jter=1:n
for jter=1:2
    for iter=1:length(branch)
        temp=branch(iter,jter);
        branchplot=[branchplot,temp];
    end
    plot(Qarray,branchplot,'b');
    hold on;
    branchplot=[];
end
xlabel('Q'); 
ylabel('Frequency');
grid;


%First branch
S=1i*S;
u=[];
du=[];
sigma=[];
dsigma=[];
aux=0;
faux1=0;
ftemp1=0;
faux2=0;
ftemp2=0;
for iter=1:length(Qarray)
    for jter=1:n
        aux=-N+jter-1;
        faux1=U(jter,iter)*exp((1i*x/a)*(Qarray(iter)+2*pi*aux));
        ftemp1=ftemp1+faux1;
        %Option 1
        faux2=S(jter,iter)*exp((1i*x/a)*(Qarray(iter)+2*pi*aux));
        %Option 2
        %faux2=vpa(S(jter,iter)*exp((1i*x/a)*(2*pi*aux)));
        ftemp2=ftemp2+faux2;
    end
    u=[u,ftemp1];
    du=[du,diff(ftemp1,x)];
    sigma=[sigma,ftemp2];
    dsigma=[dsigma,diff(ftemp2,x)];
    ftemp1=0;
    ftemp2=0;
end
for iter=1:length(Qarray)
    u(iter)=u(iter)*exp(-(1i*x/a)*Qarray(iter));
    du(iter)=du(iter)*exp(-(1i*x/a)*Qarray(iter));
    sigma(iter)=sigma(iter)*exp(-(1i*x/a)*Qarray(iter));
    dsigma(iter)=dsigma(iter)*exp(-(1i*x/a)*Qarray(iter));
end


%Second branch
S2=1i*S2;
u2=[];
du2=[];
sigma2=[];
dsigma2=[];
aux=0;
faux1=0;
ftemp1=0;
faux2=0;
ftemp2=0;
for iter=1:length(Qarray)
    for jter=1:n
        aux=-N+jter-1;
        faux1=vpa(U2(jter,iter)*exp((1i*x/a)*(Qarray(iter)+2*pi*aux)));
        ftemp1=vpa(ftemp1+faux1);
        %Option 1
        faux2=vpa(S2(jter,iter)*exp((1i*x/a)*(Qarray(iter)+2*pi*aux)));
        %Option 2
        %faux2=vpa(S(jter,iter)*exp((1i*x/a)*(2*pi*aux)));
        ftemp2=vpa(ftemp2+faux2);
    end
    u2=[u2,ftemp1];
    du2=[du2,diff(ftemp1,x)];
    sigma2=[sigma2,ftemp2];
    dsigma2=[dsigma2,diff(ftemp2,x)];
    ftemp1=0;
    ftemp2=0;
end
for iter=1:length(Qarray)
    u2(iter)=u2(iter)*exp(-(1i*x/a)*Qarray(iter));
    du2(iter)=du2(iter)*exp(-(1i*x/a)*Qarray(iter));
    sigma2(iter)=sigma2(iter)*exp(-(1i*x/a)*Qarray(iter));
    dsigma2(iter)=dsigma2(iter)*exp(-(1i*x/a)*Qarray(iter));
end

%First branch
ut=[];
dut=[];
sigmat=[];
dsigmat=[];
aux=0;
for iter=1:length(Qarray)
    aux=int(u(iter),x,-a/2,a/2);
    aux=aux/a;
    ut=[ut,aux];
    aux=int(du(iter),x,-a/2,a/2);
    aux=aux/a;
    dut=[dut,aux];
    aux=int(sigma(iter),x,-a/2,a/2);
    aux=aux/a;
    sigmat=[sigmat,aux];
    aux=int(dsigma(iter),x,-a/2,a/2);
    aux=aux/a;
    dsigmat=[dsigmat,aux];
end

%Second branch
ut2=[];
dut2=[];
sigmat2=[];
dsigmat2=[];
aux=0;
for iter=1:length(Qarray)
    aux=int(u2(iter),x,-a/2,a/2);
    aux=aux/a;
    ut2=[ut2,aux];
    aux=int(du2(iter),x,-a/2,a/2);
    aux=aux/a;
    dut2=[dut2,aux];
    aux=int(sigma2(iter),x,-a/2,a/2);
    aux=aux/a;
    sigmat2=[sigmat2,aux];
    aux=int(dsigma2(iter),x,-a/2,a/2);
    aux=aux/a;
    dsigmat2=[dsigmat2,aux];
end

%First branch
reff=[];
Deff=[];
Effbranch=[];
Vrf=[];
aux=0;
aux2=0;
for iter=1:length(Qarray)
    aux=-dsigmat(iter)/ut(iter);
    aux=aux/((branch(iter,1)*2*pi)^2);
    reff=[reff,aux];
    %{
    aux2=(Qarray(iter)^2)/((branch(iter,1)*2*pi)^2);
    aux2=aux2/(aux*a*a);
    Deff=[Deff,aux2];
    %}
    aux2=dut(iter)/sigmat(iter);
    Deff=[Deff,aux2];
    Effbranch=[Effbranch,branch(iter,1)];
    aux3=(branch(iter,1)*2*pi)*a;
    aux3=aux3/Qarray(iter);
    aux3=aux3^2;
    aux3=aux*aux2*aux3;
    Vrf=[Vrf,aux3];
end

%Second branch
reff2=[];
Deff2=[];
Effbranch2=[];
Vrf2=[];
aux=0;
aux2=0;
for iter=1:length(Qarray)
    aux=-dsigmat2(iter)/ut2(iter);
    aux=aux/((branch(iter,2)*2*pi)^2);
    reff2=[reff2,aux];
    %{
    aux2=(Qarray(iter)^2)/((branch(iter,2)*2*pi)^2);
    aux2=aux2/(aux*a*a);
    Deff2=[Deff2,aux2];
    %}
    aux2=dut2(iter)/sigmat2(iter);
    Deff2=[Deff2,aux2];
    Effbranch2=[Effbranch2,branch(iter,2)];
    aux3=(branch(iter,2)*2*pi)*a;
    aux3=aux3/Qarray(iter);
    aux3=aux3^2;
    aux3=aux*aux2*aux3;
    Vrf2=[Vrf2,aux3];
end

f2=figure;
plot(reff,Effbranch,'b');
hold on
plot(reff2,Effbranch2,'b');
grid;
xlabel('\rho'); 
ylabel('Frequency')
str_aux = 'Effective Density (kg/m^{3}). ' + title_string;
title(str_aux);

f3=figure;
plot(Deff,Effbranch,'r');
hold on
plot(Deff2,Effbranch2,'r');
grid;
xlabel('D'); 
ylabel('Frequency')
str_aux = 'Effective Compliance (Pa). ' + title_string;
title(str_aux);

% A scaling factor is computed, so that both plots may be combined
rn1 = 0;
rn2 = 0;
Dn1 = 0;
Dn2 = 0;
rscaling = 1;
Dscaling = 1;

while abs(reff(1))*rscaling<1
    rscaling = rscaling*10;
    rn1 = rn1+1;
end

while abs(reff(1))*rscaling>10
    rscaling = rscaling/10;
    rn2 = rn2+1;
end

while abs(Deff(1))*Dscaling<0.1
    Dscaling = Dscaling*10;
    Dn1 = Dn1+1;
end

while abs(Deff(1))*Dscaling>1
    Dscaling = Dscaling/10;
    Dn2 = Dn2+1;
end
%

% Both rho and D are plotted at once, allowing for comparison 
f4=figure;
plot(reff*rscaling,Effbranch,'b');
xlim([-15 15]);
hold on;
plot(Deff*Dscaling,Effbranch,'r');                  
xlim([-15 15]);
hold on;
plot(reff2*rscaling,Effbranch2,'b');
xlim([-15 15]);
hold on;
plot(Deff2*Dscaling,Effbranch2,'r');               
xlim([-15 15]);
str1=strcat('\rho*10\^(',string(rn2-rn1),') kg/m^{3}');
str2=strcat('D*10\^(',string(Dn2-Dn1), ') Pa');
legend(str1,str2)
grid;
str_aux = 'Normalized Effective Relationships. ' + title_string;
title(str_aux);
ylabel('Frequency');
%
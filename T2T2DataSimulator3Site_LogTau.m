%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Programme to Simulate 3 Site T2-T2 exchange data
% Log tau spacings
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

% Input paramters

%M0a=50;
%M0b=30;
%M0c=20;

M0a=49;
M0b=0.1;
M0c=49;


%T2a=400;
%T2b=400*6;
%T2c=400*6*3;

T2a=400;
T2b=800;
T2c=8000;

 
tau_ab=inf; % exchange time = 1/rate
    tau_ba=tau_ab*M0b/M0a; % conservation of mass reaquirement
tau_ca=10; % exchange time = 1/rate
    tau_ac=tau_ca*M0a/M0c; % conservation of mass reaquirement
tau_bc=inf; % exchange time = 1/rate
    tau_cb=tau_bc*M0c/M0b; % conservation of mass reaquirement
  % 0 0.01 0.1 10
  %
  
  %T1=inf
  %T1=4*T2
  
    
tau_echo_0=32; % first echo time
N_echo=64;
echo_time_mult=1.06;

t_mix=100; % mixing time

dt=1; % simulation step time << smallest relaxation or exchange time

%%%%%%%%%%%%%%%%%%%%%%

% Calculated simulation Paramters

T2=[T2a,inf,inf;inf,T2b,inf;inf,inf,T2c];
T1=inf; % 4*T2 from McD and Korb 2005 PRE

R2=1./T2; % rates = 1/times
R1=1./T1;

kab=1/tau_ab; kac=1/tau_ac;
kbc=1/tau_bc; kba=1/tau_ba;
kca=1/tau_ca; kcb=1/tau_cb;
kaa=kab+kac;
kbb=kbc+kba;
kcc=kca+kcb;

k=[kaa,-kba,-kca; -kab,kbb,-kcb; -kac,-kbc,kcc];

D2=-R2-k; % relaxation exchange matrices
D1=-R1-k;

M0=[M0a;M0b;M0c]; % Initial M vector
Mstart=M0; % used to track 1st CPMG
t=0;


%%%%%%%%%%%%%%%%%%%%%%%

for i=1:N_echo 
    
        % Do first / next echo of first CPMG
        M=Mstart;
        N1=floor(tau_echo_0*(echo_time_mult^i)/dt);

        for p=1:N1
            M=M+D2*M*dt;
        end
        
        % Keep hold of M at end of ith echo of 1st CPMG 
        % to speed up next cycle
        Mstart=M; 

        % Continue with mixing time
        N2=floor(t_mix/dt);

        for p=1:N2
            M=M+D1*M*dt;
        end
        
        % Continue with 2nd CPMG
        for j=1:N_echo
            N3=floor(tau_echo_0*(echo_time_mult^j)/dt);
            
                for p=1:N3
                    M=M+D2*M*dt;
                end
        
            % Add total magnetisation to data array
            data(i,j)=sum(M);
        end
end
    
t_vector=(tau_echo_0*echo_time_mult.^[1:1:N_echo])';
for i=2:N_echo
    t_vector(i)=t_vector(i-1)+t_vector(i);
end
figure (1)
imagesc(data)
figure (2)
plot(t_vector)
csvwrite('datafile.csv',data);
csvwrite('timefile.csv',t_vector);


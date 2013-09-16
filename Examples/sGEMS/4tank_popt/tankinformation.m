



function mpc_prob=tankinformation(option)
% Non-linear Continuous model for the tank application

% dh1'=-a1/S*sqrt(2*g*h1)+a2/S*sqrt(2*g*h2)+gamma_a/S*q_a;
% dh2'=-a2/S*sqrt(2*g*h2)+(1-gamma_b)/S*q_b
% dh3'=-a3/S*sqrt(2*g*h3)+a4/S*sqrt(2*g*h4)+gamma_b/S*q_b;
% dh4'=-a4/S*sqrt(2*g*h4)+(1-gamma_a)/S*q_a
 
% Outputs
% h1,h2,h3,h4

% Inputs
% gamma_a, gamma_b


nx = 4 ;% state dimensions
nu = 2; %input dimensions 
Ts = 5/3600; %sampling time of 5 seconds (in hours)

%Constants (expressed in meters for length and volume and hours for time) 
mpc_prob.param.S=15^2*10^-4;
mpc_prob.param.qmax=0.39; %Maximum pump flows for our plant
mpc_prob.param.a=[5.868; 3.626; 6.289; 2.063]*10^-5; %Tank outlet ratios
mpc_prob.param.g=9.8*(3600^2); %
 
a=[5.868; 3.626; 6.289; 2.063]*10^-5;
S=15^2*10^-4;
g=9.8*(3600^2);

%Working point
%Linearization levels
x1=19.05*10^-2;     
x2=9.58*10^-2;  
x3=13.76*10^-2;     
x4=23.88*10^-2;     


%Flow ratios
mpc_prob.param.gamma1=0.588;
mpc_prob.param.gamma2=0.5414;

%-a(1)/S*sqrt(2*g*x1)+a(2)/S*sqrt(2*g*x2)+mpc_prob.param.gamma1/S*0.39;
%-a(2)/S*sqrt(2*g*x2)+(1-mpc_prob.param.gamma2)/S*0.39;
%-a(3)/S*sqrt(2*g*x3)+a(4)/S*sqrt(2*g*x4)+mpc_prob.param.gamma2/S*0.39;
%-a(4)/S*sqrt(2*g*x4)+(1-mpc_prob.param.gamma1)/S*0.39;




%We take the initial data as the linearization points
mpc_prob.init.h1   = x1;     
mpc_prob.init.h2   = x2;     
mpc_prob.init.h3   = x3;      
mpc_prob.init.h4   = x4;     
mpc_prob.init.q_a   = 0.39;
mpc_prob.init.q_b   = 0.39;



%We set an initial reference point
mpc_prob.ref.h1   = 12.05*10^-2;
mpc_prob.ref.h2   = 16.58*10^-2;
mpc_prob.ref.h3   = 12.75*10^-2;
mpc_prob.ref.h4   = 16.88*10^-2;
mpc_prob.ref.q_a   = 0.29;
mpc_prob.ref.q_b   = 0.19;


mpc_prob.xlin = [x1;x2;x3;x4]; % point around which is linearized
mpc_prob.ulin=[ mpc_prob.param.qmax; mpc_prob.param.qmax];
%Tank time constants
tau=mpc_prob.param.S*sqrt(2*mpc_prob.xlin/mpc_prob.param.g)./mpc_prob.param.a;
% Inser the reference here:


% Continuous Linearized system, we partition the plat into two subystems
% (tanks 1 and 4) and (tanks 2 and 3)
Ac=[   -1/tau(1)     1/tau(2)   0           0;
        0           -1/tau(2)   0           0; 
        0               0    -1/tau(3)     1/tau(4);
        0               0       0         -1/tau(4)];
        

Bc=[ mpc_prob.param.gamma1/mpc_prob.param.S 0;
        0   (1-mpc_prob.param.gamma2)/mpc_prob.param.S;
        0  mpc_prob.param.gamma2/mpc_prob.param.S;
     (1-mpc_prob.param.gamma1)/mpc_prob.param.S 0 ];


    
% Discrete Linearized system
Cc=eye(4);
Dc=0;
sys=ss(Ac,Bc,Cc,Dc);
[sysd,G] = c2d(sys,Ts,'zoh');
A=sysd.a;
B=sysd.b;
 



%%%%% Define number of subsystems, subystems dimensions for the problem (state dimensions,
%%%%% inequality constraint dimensions, equality constraint dimensions)
mpc_prob.M=2;
mpc_prob.n_i=[ 2 ; 2 ];
mpc_prob.m_i=ones(mpc_prob.M,1);
mpc_prob.n_ineq_x=zeros(mpc_prob.M,1);
mpc_prob.n_ineq_u=zeros(mpc_prob.M,1);
mpc_prob.n_eq_x=zeros(mpc_prob.M,1);
mpc_prob.n_eq_u=zeros(mpc_prob.M,1);

%%%%Define matrices for subsystems (used for computing final costs)
mpc_prob.subsyst(1).Ai=A(1:2,1:2);
mpc_prob.subsyst(2).Ai=A(3:4,3:4);


%%%%% Define initial state for the entire system
mpc_prob.x_init=[mpc_prob.init.h1; mpc_prob.init.h2; mpc_prob.init.h3; mpc_prob.init.h4]-mpc_prob.xlin;
mpc_prob.u_init=[mpc_prob.init.q_a; mpc_prob.init.q_b]-mpc_prob.ulin;


mpc_prob.xref=[mpc_prob.ref.h1; mpc_prob.ref.h2; mpc_prob.ref.h3; mpc_prob.ref.h4 ];
mpc_prob.uref=[mpc_prob.ref.q_a; mpc_prob.ref.q_b];
    
%mpc_prob.ref.q_a; mpc_prob.ref.q_b];

%[mpc_prob.xref , mpc_prob.uref]= equilibrium(mpc_prob.xref,mpc_prob.uref);

mpc_prob.ref.h1   = mpc_prob.xref(1);
mpc_prob.ref.h2   = mpc_prob.xref(2);
mpc_prob.ref.h3   = mpc_prob.xref(3);
mpc_prob.ref.h4   = mpc_prob.xref(4);
mpc_prob.ref.q_a   = mpc_prob.uref(1);
mpc_prob.ref.q_b   = mpc_prob.uref(2);

mpc_prob.xref=mpc_prob.xref-mpc_prob.xlin;
mpc_prob.uref=mpc_prob.uref-mpc_prob.ulin;

%%%% Solving option: no state elimination (1 for admm, 2 for dual
%%%% decomposition) vs state elimination (3) (pcdm)
mpc_prob.solve_option=option

%%%%% Define parameters for POPT solver, as stated in the POPT help
mpc_prob.N=10;
mpc_prob.algo=1;  
mpc_prob.eps=0.001; 
mpc_prob.eps_dual=0.01;
if(mpc_prob.solve_option==1)
    mpc_prob.rho_option=2;
else
    mpc_prob.rho_option=3;
end
mpc_prob.rho=10;
mpc_prob.iter_tol=40;


%%%%%% Cost matrices for subsystems 
for i=1:mpc_prob.M
    mpc_prob.cost(i).Q=1*eye(mpc_prob.n_i(i));
    mpc_prob.cost(i).R=0.00001*eye(mpc_prob.m_i(i));       
    %Matrices Ai for each subsystem are stable, so the final cost matrices are the
    %solution of the lyapunov equations
    mpc_prob.cost(i).P=dlyap(mpc_prob.subsyst(i).Ai,mpc_prob.cost(i).Q);
end
 
mpc_prob.solved=0;
 
%%%%%%% Define constraint matrices for subsystems
for i=1:mpc_prob.M         
    mpc_prob.constr(i).lb_u=[];
    mpc_prob.constr(i).ub_u=[];
    mpc_prob.constr(i).lb_x=[];    
    mpc_prob.constr(i).ub_x=[];
    mpc_prob.constr(i).lb_N=[];
    mpc_prob.constr(i).ub_N=[];        
    mpc_prob.constr(i).Fu=[];
    mpc_prob.constr(i).gu=[];
    mpc_prob.constr(i).Cu=[];
    mpc_prob.constr(i).du=[];     
    mpc_prob.constr(i).Fx=[];
    mpc_prob.constr(i).Cx=[];
    mpc_prob.constr(i).dx=[];
    mpc_prob.constr(i).F_N=[];
    mpc_prob.constr(i).g_N=[];
    mpc_prob.constr(i).C_N=[];
    mpc_prob.constr(i).d_N=[];    
end

mpc_prob.constr(1).lb_u=[0]-mpc_prob.ulin(1);
mpc_prob.constr(1).ub_u=[0.9]-mpc_prob.ulin(1);


mpc_prob.constr(2).lb_u=[0]-mpc_prob.ulin(2);
mpc_prob.constr(2).ub_u=[0.9]-mpc_prob.ulin(2);

mpc_prob.constr(1).lb_x=[0; 0]-mpc_prob.xlin(1:2);
mpc_prob.constr(1).ub_x=[0.6; 0.6]-mpc_prob.xlin(1:2);

mpc_prob.constr(1).lb_N=[0.0; 0]-mpc_prob.xlin(1:2);
mpc_prob.constr(1).ub_N=[0.6; 0.6]-mpc_prob.xlin(1:2);

mpc_prob.constr(2).lb_x=[0; 0]-mpc_prob.xlin(3:4);
mpc_prob.constr(2).ub_x=[0.6; 0.6]-mpc_prob.xlin(3:4);

mpc_prob.constr(2).lb_N=[0; 0.0]-mpc_prob.xlin(3:4);
mpc_prob.constr(2).ub_N=[0.6; 0.6]-mpc_prob.xlin(3:4);




%%%%%%%% Computing main QP problem matrices for MPC
mpc_prob=compute_QP(mpc_prob);

%%%%%% Computing constraint matrices and other matrices for the MPC QP
mpc_prob=compute_coupling(mpc_prob,A,B);
mpc_prob.reset_ref=0;   
end

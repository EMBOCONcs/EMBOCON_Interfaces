clear all;
clc;
close all;


setupCraneDense;

%initial state vector
% x0 = zeros(8,1);
x0 = [0; 0.75; 0; 0; 0; pi/4; 0; 0];

%reference state vector
xref = [1;1.5;0;0;0;0;0;0];

%number of simulation steps
Nsim = 6000;

%logging variables initialization
xlog = zeros(8,Nsim+1);
ulog = zeros(2,Nsim);

xcurr = x0;
xlog(:,1) = xcurr;

for k1 = 1:Nsim
    
    if rem(Nsim-k1,100)==0
        Nsim-k1 %print counter
    end
        
    %run controller on FPGA
    u_FPGA = UDPclient_int32_ml_mex([xcurr;xref;1]);

    ucurr = u_FPGA(1:2);
    
    xcurr = A*xcurr + B*ucurr;
    
    ulog(:,k1) = double(ucurr);
    xlog(:,k1+1) = xcurr;
    
end

figure
plot(xlog')
figure
plot(ulog')
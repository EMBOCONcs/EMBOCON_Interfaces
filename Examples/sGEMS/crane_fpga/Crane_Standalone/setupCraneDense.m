craneInformation;


% Build the QP matrices
S = zeros(size(Q,1), size(R,2));
d = [xmax;-xmin;umax;-umin];
x_0 = zeros(8,1);
w_0 = zeros(8,1);
xr  = -Q*xref;
xrT = -P*xref;
ur  = -R*uref; 
T = 25;


Gx = [zeros(4,6), [eye(2);-eye(2)]];
gx = [10;10;10;10];

Gu = [eye(2);-eye(2)];
gu = [1;1;1;1];

Rlambda = zeros(2);



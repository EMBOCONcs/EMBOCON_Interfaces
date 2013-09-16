function mpc_prob=compute_QP(mpc_prob)

if(mpc_prob.solve_option<=3)
    for i=1:mpc_prob.M    
        mpc_prob.cost(i).H=blkdiag(kron(eye(mpc_prob.N),mpc_prob.cost(i).R),kron(eye(mpc_prob.N-1),mpc_prob.cost(i).Q),mpc_prob.cost(i).P);
        ref_x=mpc_prob.xref(sum(mpc_prob.n_i(1:i-1))+1:sum(mpc_prob.n_i(1:i-1))+mpc_prob.n_i(i));
        ref_u=mpc_prob.uref(sum(mpc_prob.m_i(1:i-1))+1:sum(mpc_prob.m_i(1:i-1))+mpc_prob.m_i(i));                
        mpc_prob.cost(i).h=-mpc_prob.cost(i).H*[kron(ones(mpc_prob.N,1),ref_u); kron(ones(mpc_prob.N,1),ref_x)];
        mpc_prob.subsyst(i).ref=[kron(ones(mpc_prob.N,1),ref_u); kron(ones(mpc_prob.N,1),ref_x)];
        
    end
   % d={'Q','R','P'};
   % fields=isfield(mpc_prob.cost,d);      
   % mpc_prob.cost=rmfield(mpc_prob.cost,d(fields));
else
    mpc_prob.Hx=blkdiag(kron(eye(mpc_prob.N-1),blkdiag(mpc_prob.cost(:).Q)),blkdiag(mpc_prob.cost(:).P));    
    mpc_prob.Hu=[];
    for i=1:mpc_prob.M    
    mpc_prob.Hu=blkdiag(mpc_prob.Hu,kron(eye(mpc_prob.N),mpc_prob.cost(i).R));
    end
    mpc_prob.xref=kron(ones(mpc_prob.N,1),mpc_prob.xref);
    position=1; u_temp=[];   
    for i=1:mpc_prob.M        
        u_temp=[u_temp; kron(ones(mpc_prob.N,1),mpc_prob.u_init(position:position+mpc_prob.m_i(i)-1))];
        position=position+mpc_prob.m_i(i);
    end
    mpc_prob.u_init=u_temp;   
    u_temp=[];
    position=1;
    for i=1:mpc_prob.M        
        u_temp=[u_temp; kron(ones(mpc_prob.N,1),mpc_prob.uref(position:position+mpc_prob.m_i(i)-1))];
        position=position+mpc_prob.m_i(i);
    end
    mpc_prob.uref=u_temp;   
    %mpc_prob=rmfield(mpc_prob,'cost');
end
    
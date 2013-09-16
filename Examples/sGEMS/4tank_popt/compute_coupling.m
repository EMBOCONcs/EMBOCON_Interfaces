function [mpc_prob]=compute_coupling(mpc_prob,A,B)
    n_total=sum(mpc_prob.n_i);
    m_total=sum(mpc_prob.m_i);    
    HAB=[]; Ap=[]; b=[];
   %%%%%% Computing coupling constraint matrix
   if(mpc_prob.solve_option<=3)
       HAB=blkdiag(-B, kron(eye(mpc_prob.N-1),[-A -B]));
       HAB=[HAB zeros(size(HAB,1),n_total)];
       position=m_total+1;     
       for i=1:mpc_prob.N
           HAB((i-1)*n_total+1:i*n_total,position:position+n_total-1)=eye(n_total);
           position=position+n_total+m_total;
       end       
       mpc_prob.HAB=HAB;
       mpc_prob.n_coupling=size(HAB,1);
       mpc_prob.b=[A*mpc_prob.x_init; zeros((mpc_prob.N-1)*n_total,1)];   
       
       mpc_prob.lambda=zeros(size(mpc_prob.b));
       
       for i=1:mpc_prob.M       
           mpc_prob.coupling(i).A=[];
           position=sum(mpc_prob.m_i(1:i-1))+1;        
           mpc_prob.coupling(i).A=[mpc_prob.coupling(i).A HAB(:,position:position+mpc_prob.m_i(i)-1)];
           for j=1:mpc_prob.N-1
               position=position+n_total+m_total;
               mpc_prob.coupling(i).A=[mpc_prob.coupling(i).A HAB(:,position:position+mpc_prob.m_i(i)-1)];
           end
           position=sum(mpc_prob.m_i)+sum(mpc_prob.n_i(1:i-1))+1;
           for j=1:mpc_prob.N            
               mpc_prob.coupling(i).A=[mpc_prob.coupling(i).A HAB(:,position:position+mpc_prob.n_i(i)-1)];
               position=position+n_total+m_total;
           end
           if(mpc_prob.solve_option==1)
           mpc_prob.coupling(i).z=mpc_prob.b/mpc_prob.M;
           end
       end
       mpc_prob.n_ineq=zeros(mpc_prob.M,1);
       mpc_prob.n_eq=zeros(mpc_prob.M,1);
       mpc_prob.box_option=ones(mpc_prob.M,1);
       for i=1:mpc_prob.M
           mpc_prob.dim_var(i)=mpc_prob.N*(mpc_prob.n_i(i)+mpc_prob.m_i(i));
           mpc_prob.constr(i).F=[];
           mpc_prob.constr(i).C=[];
           mpc_prob.constr(i).g=[];
           mpc_prob.constr(i).d=[];
           mpc_prob.constr(i).lb=[];
           mpc_prob.constr(i).ub=[];
         
        %%%Computing inequality constraint matrices
        if((~isempty(mpc_prob.constr(i).Fx))&&(~isempty(mpc_prob.constr(i).Fu)))
            mpc_prob.constr(i).F=blkdiag(kron(eye(mpc_prob.N),mpc_prob.constr(i).Fu),kron(eye(mpc_prob.N-1),mpc_prob.constr(i).Fx),mpc_prob.constr(i).F_N);
            mpc_prob.constr(i).g=[kron(ones(mpc_prob.N,1),mpc_prob.constr(i).gu);kron(ones(mpc_prob.N-1,1),mpc_prob.constr(i).gx); mpc_prob.constr(i).g_N];
            mpc_prob.n_ineq(i)=mpc_prob.N*(size(mpc_prob.constr(i).Fx,1)+size(mpc_prob.constr(i).Fu,1));
        else
            if(~isempty(mpc_prob.constr(i).Fu))
                mpc_prob.constr(i).F=kron(eye(mpc_prob.N),mpc_prob.constr(i).Fu);
                mpc_prob.constr(i).F=[mpc_prob.constr(i).F zeros(size(mpc_prob.constr(i).F,1),mpc_prob.n_i(i)*mpc_prob.N)];
                 mpc_prob.constr(i).g=[kron(ones(mpc_prob.N,1),mpc_prob.constr(i).gu)];
                 mpc_prob.n_ineq(i)=mpc_prob.N*size(mpc_prob.constr(i).Fu,1);
            end
            if(~isempty(mpc_prob.constr(i).Fx))
                mpc_prob.constr(i).F=blkdiag(kron(eye(mpc_prob.N-1),mpc_prob.constr(i).Fx),mpc_prob.constr(i).F_N);                        
                mpc_prob.constr(i).F=[zeros(size(mpc_prob.constr(i).F,1),mpc_prob.m_i(i)*mpc_prob.N) mpc_prob.constr(i).F];
                mpc_prob.constr(i).g=[kron(ones(mpc_prob.N-1,1),mpc_prob.constr(i).gx); mpc_prob.constr(i).g_N];
                 mpc_prob.n_ineq(i)=mpc_prob.N*size(mpc_prob.constr(i).Fx,1);
            end
        end
        %%%Computing equality constraint matrices
        if((~isempty(mpc_prob.constr(i).Cx))&&(~isempty(mpc_prob.constr(i).Cu)))
            mpc_prob.constr(i).C=blkdiag(kron(eye(mpc_prob.N),mpc_prob.constr(i).Cu),kron(eye(mpc_prob.N-1),mpc_prob.constr(i).Cx),mpc_prob.constr(i).C_N);
            mpc_prob.constr(i).d=[kron(ones(mpc_prob.N,1),mpc_prob.constr(i).du);kron(ones(mpc_prob.N-1,1),mpc_prob.constr(i).dx); mpc_prob.constr(i).d_N];
            mpc_prob.n_eq(i)=mpc_prob.N*(size(mpc_prob.constr(i).Cx,1)+size(mpc_prob.constr(i).Cu,1));
        else
            if(~isempty(mpc_prob.constr(i).Cu))
                mpc_prob.constr(i).C=kron(eye(mpc_prob.N),mpc_prob.constr(i).Cu);
                 mpc_prob.constr(i).C=[mpc_prob.constr(i).C zeros(size(mpc_prob.constr(i).C,1),mpc_prob.n_i(i)*mpc_prob.N)];
                 mpc_prob.constr(i).d=[kron(ones(mpc_prob.N,1),mpc_prob.du)];                 
                 mpc_prob.n_eq(i)=mpc_prob.N*size(mpc_prob.constr(i).Cu,1);
            end
             if(~isempty(mpc_prob.constr(i).Cx))
                mpc_prob.constr(i).C=blkdiag(kron(eye(mpc_prob.N-1),mpc_prob.constr(i).Cx),mpc_prob.constr(i).C_N);                                        
                mpc_prob.constr(i).C=[zeros(size(mpc_prob.constr(i).C,1),mpc_prob.m_i(i)*mpc_prob.N) mpc_prob.constr(i).C];
                 mpc_prob.constr(i).d=[kron(ones(mpc_prob.N-1,1),mpc_prob.dx); mpc_prob.d_N];
                  mpc_prob.n_ineq(i)=mpc_prob.N*size(mpc_prob.constr(i).Cx,1);
            end
        end
        if(isempty(mpc_prob.constr(i).lb_u)&&isempty(mpc_prob.constr(i).lb_x)&&isempty(mpc_prob.constr(i).lb_N))            
            mpc_prob.box_option(i)=0;
        else
            if(isempty(mpc_prob.constr(i).lb_x))
                mpc_prob.constr(i).lb_x=-bitmax*ones(mpc_prob.n_i(i),1);                
            end
            if(isempty(mpc_prob.constr(i).lb_u))
                mpc_prob.constr(i).lb_u=-bitmax*ones(mpc_prob.m_i(i),1);                
            end
            if(isempty(mpc_prob.constr(i).lb_N))
                mpc_prob.constr(i).lb_N=-bitmax*ones(mpc_prob.n_i(i),1);                
            end
            mpc_prob.constr(i).lb_x(mpc_prob.constr(i).lb_x==-inf)=-bitmax;
            mpc_prob.constr(i).lb_u(mpc_prob.constr(i).lb_u==-inf)=-bitmax;
            mpc_prob.constr(i).lb_N(mpc_prob.constr(i).lb_N==-inf)=-bitmax;       
            mpc_prob.constr(i).lb=[kron(ones(mpc_prob.N,1),mpc_prob.constr(i).lb_u);kron(ones(mpc_prob.N-1,1),mpc_prob.constr(i).lb_x);mpc_prob.constr(i).lb_N];                        
            
            if(isempty(mpc_prob.constr(i).ub_x))
                mpc_prob.constr(i).ub_x=bitmax*ones(mpc_prob.n_i(i),1);                
            end
            if(isempty(mpc_prob.constr(i).ub_u))
                mpc_prob.constr(i).ub_u=bitmax*ones(mpc_prob.m_i(i),1);                
            end
            if(isempty(mpc_prob.constr(i).ub_N))
                mpc_prob.constr(i).ub_N=bitmax*ones(mpc_prob.n_i(i),1);                
            end
            mpc_prob.constr(i).ub_x(mpc_prob.constr(i).ub_x==inf)=bitmax;
            mpc_prob.constr(i).ub_u(mpc_prob.constr(i).ub_u==inf)=bitmax;
            mpc_prob.constr(i).ub_N(mpc_prob.constr(i).ub_N==inf)=bitmax;       
            mpc_prob.constr(i).ub=[kron(ones(mpc_prob.N,1),mpc_prob.constr(i).ub_u);kron(ones(mpc_prob.N-1,1),mpc_prob.constr(i).ub_x);mpc_prob.constr(i).ub_N];                       
        end
       end
       
   else
       lin=B;
       lin=[lin zeros(size(lin,1),mpc_prob.N*m_total-size(lin,2))];                    
       HAB=lin;    
       Ap=A;
       for i=2:mpc_prob.N      
           lin=B;
           for j=1:i-1;
               lin=[(A^j)*B lin];            
           end
           lin=[lin zeros(size(lin,1),mpc_prob.N*m_total-size(lin,2))];
          
           HAB=[HAB; lin];       
           Ap=[Ap; A^i];        
       end
       mpc_prob.Ap=Ap;
       mpc_prob.AB=[];
       for i=1:mpc_prob.M                  
           position=sum(mpc_prob.m_i(1:i-1))+1;
           col=HAB(:,position:position+mpc_prob.m_i(i)-1);
           mpc_prob.AB=[mpc_prob.AB col];        
           position=position+m_total;
           for j=1:mpc_prob.N-1
               col=HAB(:,position:position+mpc_prob.m_i(i)-1);
               mpc_prob.AB=[mpc_prob.AB col];
               position=position+m_total;        
           end
       end
       for i=1:mpc_prob.M           
            mpc_prob.dim_var(i)=mpc_prob.N*(mpc_prob.m_i(i));
            if((~isempty(mpc_prob.constr(i).lb_u))||(~isempty(mpc_prob.constr(i).ub)))                
                mpc_prob.box_option(i)=1;
                if(isfield(mpc_prob.constr(i),'lb_u'))
                    if(isempty(mpc_prob.constr(i).lb_u))
                        mpc_prob.constr(i).lb_u=-bitmax*ones(mpc_prob.m_i(i),1);
                    end
                else
                mpc_prob.constr(i).lb_u=-bitmax*ones(mpc_prob.m_i(i),1);
                end
                if(isfield(mpc_prob.constr(i),'ub_u'))
                    if(isempty(mpc_prob.constr(i).ub_u))
                        mpc_prob.constr(i).ub_u=bitmax*ones(mpc_prob.m_i(i),1);
                    end
                else
                     mpc_prob.constr(i).ub_u=bitmax*ones(mpc_prob.m_i(i),1);
                end
                mpc_prob.constr(i).lb_u(mpc_prob.constr(i).lb_u==-inf)=-bitmax;
                mpc_prob.constr(i).ub_u(mpc_prob.constr(i).ub_u==inf)=bitmax;
                
                mpc_prob.constr(i).lb=kron(ones(mpc_prob.N,1),mpc_prob.constr(i).lb_u);
                mpc_prob.constr(i).ub=kron(ones(mpc_prob.N,1),mpc_prob.constr(i).ub_u);              
            end                 
            if(mpc_prob.n_ineq_u(i)~=0)
                if(isfield(mpc_prob.constr(i),'Fu'))
                    if(~isempty(mpc_prob.constr(i).Fu))
                        mpc_prob.constr(i).F=kron(eye(mpc_prob.N),mpc_prob.constr(i).Fu);
                        mpc_prob.constr(i).g=kron(ones(mpc_prob.N,1),mpc_prob.constr(i).gu);
                    end 
                end
            end
            if(mpc_prob.n_eq_u(i)~=0)
                if(isfield(mpc_prob.constr(i),'Cu'))
                    if(~isempty(mpc_prob.constr(i).Cu))
                        mpc_prob.constr(i).C=kron(eye(mpc_prob.N),mpc_prob.constr(i).Cu);
                        mpc_prob.constr(i).d=kron(ones(mpc_prob.N,1),mpc_prob.constr(i).du);                 
                    end
                end
           end
       end
       mpc_prob.constr=rmfield(mpc_prob.constr,{'Fu' 'gu' 'Cu' 'du'});     
       mpc_prob.AB=(mpc_prob.AB)';
       
       mpc_prob.n_ineq=mpc_prob.N*mpc_prob.n_ineq_u;
       mpc_prob.n_eq=mpc_prob.N*mpc_prob.n_eq_u;
      
   end
    mpc_prob.A=A;
    
    %%%%Removing unncesseray data from modified data structure
       d={'Fx','Fu','Cx','Cu','gx','gu','dx','du','F_N','g_N','C_N','d_N','lb_x','ub_x','lb_u','ub_u','lb_N','ub_N'};
       fields=isfield(mpc_prob.constr,d);        
       %mpc_prob.constr=rmfield(mpc_prob.constr,d(fields));
       d={'n_ineq_x','n_ineq_u','n_eq_x','n_eq_u'};
       fields=isfield(mpc_prob,d);      
       mpc_prob=rmfield(mpc_prob,d(fields));
   
end
       
    %%%%%% Computing constraint matrices for subsystems
    
        

    
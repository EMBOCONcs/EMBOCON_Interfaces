
# include <mex.h>
# include <string.h>
#include <stdlib.h>
#include "lapack_mpc.h"
#include <math.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>



/*extern test * createQP(int n, int m); */



void print_mat_double(double * rez, int n, int m)
{
    int i; int j;
    for(i=0;i<n;i++)
    { mexPrintf("\n");
        for(j=0;j<m;j++)
            mexPrintf("%f ",rez[i*m+j]);
    }
    mexPrintf("\n");
}

void print_mat_int(int * rez, int n, int m)
{
    int i; int j;
    for(i=0;i<n;i++)
    { printf("\n");
        for(j=0;j<m;j++)
            printf("%d ",(int)rez[i*m+j]);
    }
    printf("\n");
}


void vectorize(double * rez, double * A, int n, int m)
{

    int i; int j;
    
    for(j=0;j<m;j++)
        for(i=0;i<n;i++)
        {           
            rez[j*n+i]=A[i*m+j];           
        }
}

mxArray * init_mpc()
{

    mxArray * subs;
    subs=mexGetVariable("base","mpc_prob");
    if(subs==NULL)
    {
        printf("finding failed\n");            
    }
    else
    {
        printf("finding success");
    
    }
 
mxArray *algo_t, * eps_t, * iter_tol_t, * box_option_t, *Mt , * x_init_t, *solve_option, *m_it, *rez, *n_ineq_x_t,*n_eq_x_t, *n_ineq_u_t, * n_eq_u_t, *n_it,*A,*b,*F,*g,*C,*d, *Hx_t, * Fx_t, *AB_t, * Hu_t, *Nt, *Ap_t, * xref_t, *uref_t;
double *At,*bt,*Ft,*gt,*Ct,*dt, *Hx, * Fx, *AB, *Hu, *Ap,  * n_ineq, * x_init,  * n_eq_u, * n_ineq_u , * n_i,* m_i, *xref, *uref,  eps, solve_option_t;

double * box_option;
int i,j,M, algo, iter_tol, N;

solve_option=mxGetField(subs,0,"solve_option");
solve_option_t=mxGetScalar(solve_option);

n_it=mxGetField(subs,0,"n_i");
m_it=mxGetField(subs,0,"m_i");

M=mxGetScalar(mxGetField(subs,0,"M"));
N=mxGetScalar(mxGetField(subs,0,"N"));
n_i=mxGetPr(n_it);
m_i=mxGetPr(m_it);


int n_total=0;
int m_total=0;
int n_sum=0;
int m_sum=0;
double * reset_ref=mxCalloc(1,sizeof(double));

for(i=0;i<M;i++)
{
    n_sum=n_sum+(int)n_i[i];
    m_sum=m_sum+(int)m_i[i];
}

n_total=n_sum*N;
m_total=m_sum*N;

double * alpha=(double *)mxMalloc(sizeof(double));
double * beta=(double *)mxMalloc(sizeof(double));

x_init_t=mxGetField(subs,0,"x_init");
x_init=mxGetPr(x_init_t);

char * tran=(char *)mxMalloc(sizeof(char));
*tran='T';
char * no=(char *)mxMalloc(sizeof(char));
*no='N';

int * incx=(int *)mxMalloc(sizeof(int));
*incx=(int)1;

if((solve_option_t==4)||(solve_option_t==5))   
{    
    AB=mxGetPr(mxGetField(subs,0,"AB"));        
    Hx=mxGetPr(mxGetField(subs,0,"Hx"));         
    Hu=mxGetPr(mxGetField(subs,0,"Hu"));   
    Ap=mxGetPr(mxGetField(subs,0,"Ap"));
    xref=mxGetPr(mxGetField(subs,0,"xref"));
    uref=mxGetPr(mxGetField(subs,0,"uref"));   
   
    double * H=mxCalloc(m_total*m_total,sizeof(double));
    double * h=mxCalloc(m_total,sizeof(double));
    
    double * H_temp=mxCalloc(n_total*m_total,sizeof(double));
    double * h_temp=mxCalloc(n_total,sizeof(double));
    
    double * H_AB_set;
    
    *alpha=(double)1;
    *beta=(double)0;
    
    dgemm_(no,no,&m_total,&n_total, &n_total,alpha, AB, &m_total, Hx, &n_total, beta, H_temp, &m_total );
    dgemm_(no,tran,&m_total,&m_total, &n_total,alpha, H_temp, &m_total, AB, &m_total, beta, H, &m_total );    
    int m_total2=m_total*m_total;
    daxpy_(&m_total2, alpha, Hu, incx, H, incx);    
 
    dgemv_( no, &n_total, &n_sum, alpha, Ap, &n_total, x_init, incx, beta, h_temp, incx );
    *alpha=(double)-1;
  
    daxpy_(&n_total, alpha, xref, incx, h_temp, incx);
    *alpha=(double)1;
    dgemv_( no, &m_total, &n_total, alpha, H_temp, &m_total, h_temp, incx, beta, h, incx );
    *alpha=(double)-1;
    *beta=1;
    dgemv_( no, &m_total, &m_total, alpha, Hu, &m_total, uref, incx, beta, h, incx );    
    
    int dims[2];
      
    mxAddField(subs, "H");        
    mxAddField(subs, "h");            
    mxAddField(subs,"H_AB");
    
    dims[0]=1; dims[1]=n_total*m_total;
    
    mxArray * H_AB=mxCreateNumericArray( 2,dims , mxDOUBLE_CLASS, mxREAL);
    H_AB_set=mxGetPr(H_AB);
    dcopy_(&dims[1],H_temp,incx,H_AB_set,incx);
    mxSetField(subs, 0, "H_AB", H_AB);
    
     dims[0]=1; dims[1]=m_total*m_total;
   
    
    mxArray * H_t=mxCreateNumericArray( 2,dims , mxDOUBLE_CLASS, mxREAL);
    H_temp=mxGetPr(H_t);
    dcopy_(&dims[1],H,incx,H_temp,incx);
    
    dims[1]=m_total;
    mxArray * h_t=mxCreateNumericArray( 2,dims , mxDOUBLE_CLASS, mxREAL);
    h_temp=mxGetPr(h_t);      
    dcopy_(&dims[1],h,incx,h_temp,incx);       
    
    mxSetField(subs, 0, "H", H_t);
    mxSetField(subs, 0, "h", h_t);   
    
  /*
    mxFree(H);
    mxFree(h);   
    mxFree(H_temp);
    mxFree(alpha);
    mxFree(beta);
    mxFree(tran);
    mxFree(no);
    mxFree(incx);
    */
    
    mexPrintf("\n\nINITIALIZATION DONE FOR PCDM\n\n");
          
}
else
{
}

       return subs;
   
}

void update_ref(mxArray * subs, const double xref[])
{
    
    int condition_update=1;
    mxArray * ref;  mxArray * ref_temp;   
    double * set=(double *)mxMalloc(sizeof(double));
    
    /*
     ref=mxGetField(subs,0,"ref");         
        
        ref_temp=mxGetField(ref,0,"h1");
        set=mxGetPr(ref_temp);
        if(*set!=xref[0])
            condition_update=1;
        mexPrintf("\n references=%f %f \n",*set,xref[0]);
        
        ref_temp=mxGetField(ref,0,"h2");
        set=mxGetPr(ref_temp);
        if(*set!=xref[1])
            condition_update=1;
        mexPrintf("\n references=%f %f \n",*set,xref[1]);
        
    
        ref_temp=mxGetField(ref,0,"h3");
        set=mxGetPr(ref_temp);
       if(*set!=xref[2])
            condition_update=1;
        mexPrintf("\n references=%f %f \n",*set,xref[2]);
        
        
        ref_temp=mxGetField(ref,0,"h4");
        set=mxGetPr(ref_temp);
       if(*set!=xref[3])
            condition_update=1;
        mexPrintf("\n references=%f %f \n",*set,xref[3]);
    
    
        ref_temp=mxGetField(ref,0,"q_a");
        set=mxGetPr(ref_temp);
         if(*set!=xref[4])
            condition_update=1;
        mexPrintf("\n references=%f %f \n",*set,xref[4]);
       
    
        ref_temp=mxGetField(ref,0,"q_b");
        set=mxGetPr(ref_temp);
         if(*set!=xref[5])
            condition_update=1;
        mexPrintf("\n references=%f %f \n",*set,xref[5]);
      
   if(condition_update==1)
       mexPrintf("\n\nREF IS NEW\n\n");
   else
       mexPrintf("\n\nREF IS NOT NEW\n\n");
    
    */
    if(condition_update==1)    
    
    {
    
    int * incx=(int *)mxMalloc(sizeof(int));
      *incx=(int)1;  
   int M=mxGetScalar(mxGetField(subs,0,"M"));
   int N=mxGetScalar(mxGetField(subs,0,"N"));
   int solve_option=mxGetScalar(mxGetField(subs,0,"solve_option"));
   int i;

   char * tran=(char *)mxMalloc(sizeof(char));
   *tran='T';
   char * no=(char *)mxMalloc(sizeof(char));
   *no='N';
   
   double * alpha=(double *)mxMalloc(sizeof(double));
   double * beta=(double *)mxMalloc(sizeof(double));

      
      mxArray * subsyst; mxArray * rez;
    double * n_i; double * m_i; double * ref_set; int j; double * ref_get;
    double * x_lin_get; double * u_lin_get; double * u_temp; double * x_temp;
    double * ref_new;
    
    n_i=mxGetPr(mxGetField(subs,0,"n_i"));
    m_i=mxGetPr(mxGetField(subs,0,"m_i"));
    
        
        ref=mxGetField(subs,0,"ref");   
      
        
        ref_temp=mxGetField(ref,0,"h1");
        set=mxGetPr(ref_temp);
        *set=(double)xref[0];
        mxSetField(ref,0,"h1",ref_temp);
        
        ref_temp=mxGetField(ref,0,"h2");
        set=mxGetPr(ref_temp);
        *set=(double)xref[1];
        mxSetField(ref,0,"h2",ref_temp);    
    
        ref_temp=mxGetField(ref,0,"h3");
        set=mxGetPr(ref_temp);
        *set=(double)xref[2];
        mxSetField(ref,0,"h3",ref_temp);
        
        ref_temp=mxGetField(ref,0,"h4");
        set=mxGetPr(ref_temp);
        *set=(double)xref[3];
        mxSetField(ref,0,"h4",ref_temp);
    
    
        ref_temp=mxGetField(ref,0,"q_a");
        set=mxGetPr(ref_temp);
        *set=(double)xref[4];
        mxSetField(ref,0,"q_a",ref_temp);
    
        ref_temp=mxGetField(ref,0,"q_b");
        set=mxGetPr(ref_temp);
        *set=(double)xref[5];
        mxSetField(ref,0,"q_b",ref_temp);
   
        
        int poz_x=0; int dim; int poz_u=0; 
        int dim_u, dim_x; int poz_u2=0; int k;
        int poz_x2=0;
        mexPrintf("\nfine till here\n");
  
   if(solve_option<=3)
    {
            subsyst=mxGetField(subs,0,"subsyst");
        x_lin_get=mxGetPr(mxGetField(subs,0,"xlin"));
        u_lin_get=mxGetPr(mxGetField(subs,0,"ulin"));
        for(i=0;i<M;i++)
            poz_u=poz_u+(int)n_i[i];        
        
        for(i=0;i<M;i++)
        {
            rez=mxGetField(subsyst,i,"ref");
            ref_get=mxGetPr(rez);
            dim=(int)mxGetNumberOfElements(rez); 
            ref_new=mxCalloc(dim,sizeof(double));
            
            u_temp=mxCalloc(m_i[i],sizeof(double));
            for(j=poz_u;j<poz_u+(int)m_i[i];j++)
                u_temp[j-poz_u]=(double)xref[j];
            for(j=poz_u2;j<poz_u2+(int)m_i[i];j++)
                u_temp[j-poz_u2]=(double)u_temp[j-poz_u2]-(double)u_lin_get[j];
            for(k=0;k<N;k++)
                for(j=0;j<m_i[i];j++)
                    ref_new[k*(int)m_i[i]+j]=(double)u_temp[j];
            
            x_temp=mxCalloc(n_i[i],sizeof(double));
            for(j=poz_x;j<poz_x+(int)n_i[i];j++)
                x_temp[j-poz_x]=(double)xref[j];
            for(j=poz_x2;j<poz_x2+(int)n_i[i];j++)
                x_temp[j-poz_x2]=(double)x_temp[j-poz_x2]-(double)x_lin_get[j];
            for(k=0;k<N;k++)
                for(j=0;j<n_i[i];j++)
                    ref_new[k*(int)n_i[i]+j+N*(int)m_i[i]]=(double)x_temp[j];
           dcopy_(&dim,ref_new,incx,ref_get,incx);
           mxSetField(subsyst,i,"ref",rez);
           
                        
            poz_u2=poz_u2+(int)m_i[i];
            poz_x2=poz_x2+(int)n_i[i];
            poz_x=poz_x+(int)n_i[i];
            poz_u=poz_u+(int)m_i[i];
        
            /*
            mxFree(ref_new);
            mxFree(u_temp);
            mxFree(x_temp);
             */
            
        }
        
        
        mxArray * cost=mxGetField(subs,0,"cost");
        mxArray * ref_temp; double * h_temp; double * h_get; double * ref_get;
        mxArray * h_subs; double * H_get; mxArray * H;
        
        *alpha=(double)-1;
        *beta=(double)0;
        for(i=0;i<M;i++)
        {      
            ref_temp=mxGetField(subsyst,i,"ref");    
            ref_get=mxGetPr(ref_temp);
            dim=(int)mxGetNumberOfElements(ref_temp);     
            h_temp=(double* )mxCalloc(dim,sizeof(double));
            H=mxGetField(cost,i,"H");
            h_subs=mxGetField(cost,i,"h");
            h_get=mxGetPr(h_subs);
            H_get=mxGetPr(H);
      
            dgemv_( no, &dim, &dim, alpha, H_get, &dim, ref_get, incx, beta, h_temp, incx );   
            dcopy_(&dim,h_temp,incx,h_get,incx);    
            mxSetField(cost,i,"h",h_subs);
            mxFree(h_temp);
        }  
    }
    else
    {        
        x_lin_get=mxGetPr(mxGetField(subs,0,"xlin"));
        u_lin_get=mxGetPr(mxGetField(subs,0,"ulin"));
        poz_u=0;
        for(i=0;i<M;i++)
            poz_u=poz_u+(int)n_i[i];        
        x_temp=mxCalloc(poz_u,sizeof(double));
        rez=mxGetField(subs,0,"xref");
        dim=(int)mxGetNumberOfElements(rez); 
        ref_get=mxGetPr(rez);
        ref_new=mxCalloc(dim,sizeof(double));
        for(i=0;i<poz_u;i++)
            x_temp[i]=(double)xref[i]-(double)x_lin_get[i];        
        for(k=0;k<N;k++)
                for(j=0;j<poz_u;j++)
                    ref_new[(int)k*poz_u+j]=(double)x_temp[j];
        dcopy_(&dim,ref_new,incx,ref_get,incx);
        mxSetField(subs,0,"xref",rez);
        mexPrintf("\nfine till here2\n");
        mxFree(ref_new);
        int dim2;
        
        rez=mxGetField(subs,0,"uref");
        ref_get=mxGetPr(rez);
        dim=(int)mxGetNumberOfElements(rez); 
        ref_new=mxCalloc(dim,sizeof(double));
        int poz_subs=0;
        
        for(i=0;i<M;i++)
        {           
            
            u_temp=mxCalloc(m_i[i],sizeof(double));
            for(j=poz_u;j<poz_u+(int)m_i[i];j++)
                u_temp[j-poz_u]=(double)xref[j];
            for(j=poz_u2;j<poz_u2+(int)m_i[i];j++)
                u_temp[j-poz_u2]=(double)u_temp[j-poz_u2]-(double)u_lin_get[j];
            for(k=0;k<N;k++)
                for(j=0;j<m_i[i];j++)
                    ref_new[poz_subs+k*(int)m_i[i]+j]=(double)u_temp[j];           
                      
                        
            poz_u2=poz_u2+(int)m_i[i];            
            poz_u=poz_u+(int)m_i[i]; 
            poz_subs=poz_subs+N*(int)m_i[i];
            mxFree(u_temp);          
        }
               mexPrintf("\nfine till here3\n");
            dcopy_(&dim,ref_new,incx,ref_get,incx);
            mxSetField(subs,0,"uref",rez);
            
            int n_total=0;
            int m_total=0;
            int n_sum=0;
            int m_sum=0;
            
            double *    Hx=mxGetPr(mxGetField(subs,0,"Hx"));         
            double * Hu=mxGetPr(mxGetField(subs,0,"Hu"));   
            double * Ap=mxGetPr(mxGetField(subs,0,"Ap"));
            double * H_AB=mxGetPr(mxGetField(subs,0,"H_AB"));
            double * ref_x=mxGetPr(mxGetField(subs,0,"xref"));
            double * ref_u=mxGetPr(mxGetField(subs,0,"uref"));   
            
            mxArray * h_get=mxGetField(subs,0,"h");
            double * h_replace=mxGetPr(h_get);
            mxArray * x_init_t=mxGetField(subs,0,"x_init");
            double * x_init=mxGetPr(x_init_t);
           

            for(i=0;i<M;i++)
            {
                n_sum=n_sum+(int)n_i[i];
                m_sum=m_sum+(int)m_i[i];
            }

            n_total=n_sum*N;
            m_total=m_sum*N;
            
             double * h=mxCalloc(m_total,sizeof(double));
             mexPrintf("\nfine till here4\n");
            double * h_temp=mxCalloc(n_total,sizeof(double));
            
            *alpha=(double)1;
            *beta=(double)1;
            
            dgemv_( no, &n_total, &n_sum, alpha, Ap, &n_total, x_init, incx, beta, h_temp, incx );
            *alpha=(double)-1;
             mexPrintf("\nfine till here5\n");
            daxpy_(&n_total, alpha, ref_x, incx, h_temp, incx);
            *alpha=(double)1;
            dgemv_( no, &m_total, &n_total, alpha, H_AB, &m_total, h_temp, incx, beta, h, incx );
             mexPrintf("\nfine till here6\n");
            *alpha=(double)-1;
            *beta=(double)1;
            dgemv_( no, &m_total, &m_total, alpha, Hu, &m_total, ref_u, incx, beta, h, incx );   
             mexPrintf("\nfine till here7\n");

            dcopy_(&m_total,h,incx,h_replace,incx);
             mexPrintf("\nfine till here8\n");
             mexPrintf("m_total=%d\n",m_total);
            mxSetField(subs,0,"h",h_get);
             mexPrintf("\nfine till here9\n");
             /*
            mxFree(h_temp);
            mxFree(h);
              */

            
     
    }
    }

    
mexPrintf("\n\n NEW REFERENCE UPDATED \n\n");



}


void update_mpc(mxArray * subs, double * xcur)
{
    double * alpha=(double *)mxMalloc(sizeof(double));
    double * beta=(double *)mxMalloc(sizeof(double));

    char * tran=(char *)mxMalloc(sizeof(char));
    *tran='T';
    char * no=(char *)mxMalloc(sizeof(char));
    *no='N';
    
    
    mxArray * ref; mxArray * ref_temp;     
    ref=mxGetField(subs,0,"ref");   
    ref_temp=mxGetField(ref,0,"h1");
    double * set=(double *)mxMalloc(sizeof(double));
    set=mxGetPr(ref_temp);
    mexPrintf("new reference here=%f\n",*set);

    int m_total=0;
    
    int * incx=(int *)mxMalloc(sizeof(int)); int i;
      *incx=(int)1;  
    int solve_option=mxGetScalar(mxGetField(subs,0,"solve_option"));
   
    double * x_init; mxArray * x_init_t; mxArray * xlin_t;
    int dim;
    x_init_t=mxGetField(subs,0,"x_init");
    dim=(int)mxGetNumberOfElements(x_init_t);     
    x_init=mxGetPr(x_init_t);       
    dcopy_(&dim,xcur,incx,x_init,incx);
    xlin_t=mxGetField(subs,0,"xlin");
    double * xlin=mxGetPr(xlin_t);
    *alpha=(double)-1;
    daxpy_(&dim,alpha,xlin,incx,x_init,incx);    
    mxSetField(subs,0,"x_init",x_init_t);
 
    
    int M=mxGetScalar(mxGetField(subs,0,"M"));
    int N=mxGetScalar(mxGetField(subs,0,"N"));
    
 
    
    int n_total=0;
  
    int n_sum=0;
    int m_sum=0;
    
    double * n_i=mxGetPr(mxGetField(subs,0,"n_i"));
    double * m_i=mxGetPr(mxGetField(subs,0,"dim_var"));
    
    for(i=0;i<M;i++)
    {
        m_total=m_total+(int)m_i[i];
        n_sum=n_sum+(int)n_i[i];
    }
    
    
    if((solve_option==4)||(solve_option==5))
    {
        n_total=n_sum*N;   
       
        
        
    double * Ap=mxGetPr(mxGetField(subs,0,"Ap"));
    double * Hx=mxGetPr(mxGetField(subs,0,"Hx")); 
    double * Hu=mxGetPr(mxGetField(subs,0,"Hu")); 
    double * AB=mxGetPr(mxGetField(subs,0,"AB")); 
   
    
    mxArray * h_t=mxGetField(subs,0,"h");
    
    double * h=mxGetPr(h_t); 
    double * xref=mxGetPr(mxGetField(subs,0,"xref")); 
    double * uref=mxGetPr(mxGetField(subs,0,"uref")); 
    double * h_temp=mxCalloc(n_total,sizeof(double));
    double * h_temp2=mxCalloc(n_total,sizeof(double));
               
    *alpha=(double)1;
    *beta=(double)0;    
    dgemv_( no, &n_total, &n_sum, alpha, Ap, &n_total, x_init, incx, beta, h_temp, incx );   
    *alpha=(double)-1;  
    daxpy_(&n_total, alpha, xref, incx, h_temp, incx);    
    *alpha=(double)1;    
    *beta=(double)1;
    dgemv_(no,&n_total,&n_total,alpha, Hx, &n_total, h_temp, incx, beta, h_temp2,incx ); 
     
     *alpha=(double)1;    
    *beta=(double)0;
    dgemv_(no,&m_total,&n_total,alpha, AB, &m_total, h_temp2, incx, beta, h,incx );    
    
    *alpha=(double)-1;
    *beta=(double)1;
    dgemv_( no, &m_total, &m_total, alpha, Hu, &m_total, uref, incx, beta, h, incx );   
       

     mxSetField(subs,0,"h",h_t);

     mxFree(h_temp);
     mxFree(h_temp2);
     mexPrintf("UPDATED\n");
     
     
    }
    else
    { 
        int dim_b;
        mxArray * coupling=mxGetField(subs,0,"coupling");              
        double * A=mxGetPr(mxGetField(subs,0,"A"));          
        mxArray * b_t=mxGetField(subs,0,"b");
        dim_b=(int)mxGetNumberOfElements(b_t);     
        double * b=mxGetPr(b_t);        
        double * b_temp=mxCalloc(dim ,sizeof(double));        
        *alpha=(double)1;
        *beta=(double)0;        
        dgemv_(no, &n_sum,&n_sum,alpha,A,&n_sum,x_init,incx,beta,b_temp,incx);          
        for(i=0;i<dim;i++)
            b[i]=b_temp[i];       
        
        
            
        
        *alpha=(double)1/(double)N;
       mxSetField(subs,0,"b",b_t);
       if(solve_option==1)
       {     double * z_temp; mxArray * z_t;
           for(i=0;i<M;i++)
           {
           z_t=mxGetField(coupling,i,"z");
           z_temp=mxGetPr(z_t);
           dcopy_(&dim_b,b,incx,z_temp,incx);
           dscal_(&dim_b,alpha,z_temp,incx);
           mxSetField(coupling,i,"z",z_t);
           }
       }
       
       mxFree(b_temp);
       mexPrintf("UPDATE CONSTRAINED\n");
      
        
       
    
    }
    
}


void write_mpc(mxArray * subs)
{

    mxArray * solve_option_t; int i;
    int solve_option;
    solve_option_t=mxGetField(subs,0,"solve_option");
    solve_option=mxGetScalar(solve_option_t);
    
    mexPrintf("\n\nSOLVE OPTION=%d\n\n",solve_option);
    
    
   
    
    mxArray * rez; int dim; int temp_int, n_coupling; double temp_double; double * dim_double; double * mat_temp; 
        int * dim_int, * box_option; int M; int * n_eq, * n_ineq;
      
        M=mxGetScalar(mxGetField(subs,0,"M"));         
        dim_int=(int *)mxCalloc(M,sizeof(int));
        box_option=(int *)mxCalloc(M,sizeof(int));
        n_eq=(int *)mxCalloc(M,sizeof(int));
        n_ineq=(int *)mxCalloc(M,sizeof(int));
        
        mexPrintf("\n\n writing, solve_option=%d\n\n",solve_option);
    
    if(solve_option<=3)
    {
             FILE * f_mpc;
            if(solve_option==1)
                f_mpc=fopen("admm.bin","wb");         
            else
                f_mpc=fopen("ddecomp.bin","wb");         
        
            rez=mxGetField(subs,0,"algo");        
            temp_int=mxGetScalar(rez);        
            fwrite(&temp_int,1,sizeof(int),f_mpc);        
            
       
            fwrite(&M,1,sizeof(int),f_mpc);                
            
            rez=mxGetField(subs,0,"eps");        
            temp_double=mxGetScalar(rez);                
            fwrite(&temp_double,1,sizeof(double),f_mpc);            
            
            rez=mxGetField(subs,0,"eps_dual");        
            temp_double=mxGetScalar(rez);                
            fwrite(&temp_double,1,sizeof(double),f_mpc); 
        
            rez=mxGetField(subs,0,"iter_tol");        
            temp_int=mxGetScalar(rez);                
            fwrite(&temp_int,1,sizeof(int),f_mpc);   
        
            rez=mxGetField(subs,0,"rho_option");        
            temp_int=mxGetScalar(rez);                
            fwrite(&temp_int,1,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"rho");        
            temp_double=mxGetScalar(rez);                
            fwrite(&temp_double,1,sizeof(double),f_mpc);         
            
            rez=mxGetField(subs,0,"n_coupling");        
            n_coupling=mxGetScalar(rez);                
            fwrite(&n_coupling,1,sizeof(int),f_mpc);          
            
            
                
            rez=mxGetField(subs,0,"dim_var");                      
            dim_double=mxGetPr(rez);               
            dim=(int)mxGetNumberOfElements(rez);     
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                dim_int[i]=(int)dim_double[i];        
            fwrite(dim_int, dim,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"n_ineq");              
            dim_double=mxGetPr(rez);        
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                n_ineq[i]=(int)dim_double[i];
            fwrite(n_ineq, dim,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"n_eq");             
            dim_double=mxGetPr(rez);
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                n_eq[i]=(int)dim_double[i];
            fwrite(n_eq, dim,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"box_option");             
            dim_double=mxGetPr(rez);
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                box_option[i]=(int)dim_double[i];
            fwrite(box_option, dim,sizeof(int),f_mpc);
            
            rez=mxGetField(subs,0,"lambda");              
            mat_temp=mxGetPr(rez);        
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);        
            fwrite(mat_temp, dim,sizeof(double),f_mpc);   
        
            rez=mxGetField(subs,0,"b");              
            mat_temp=mxGetPr(rez);        
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);        
            fwrite(mat_temp, dim,sizeof(double),f_mpc);   
        
            mxArray * cost;
            cost=mxGetField(subs,0,"cost");
            
            mxArray * constr;
            constr=mxGetField(subs,0,"constr");
        
            mxArray * coupling;
            coupling=mxGetField(subs,0,"coupling");
          
       
        for(i=0;i<M;i++)
        {    
         
         
             rez=mxGetField(cost,i,"H");   
             mat_temp=mxGetPr(rez);               
             dim=(int)mxGetNumberOfElements(rez);
            
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc);   
             
              
             rez=mxGetField(cost,i,"h");   
             mat_temp=mxGetPr(rez);             
             dim=(int)mxGetNumberOfElements(rez);
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc);   
             
             if(n_ineq[i]!=0)
             {
             rez=mxGetField(constr,i,"F");   
             mat_temp=mxGetPr(rez);             
             dim=(int)mxGetNumberOfElements(rez);
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc); 
            
             
             rez=mxGetField(constr,i,"g");   
             mat_temp=mxGetPr(rez);             
             dim=(int)mxGetNumberOfElements(rez);
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc);          
             
             }
                          
             if(n_eq[i]!=0)
             {                                   
             rez=mxGetField(constr,i,"C");   
             mat_temp=mxGetPr(rez);             
             dim=(int)mxGetNumberOfElements(rez);
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc); 
             
             rez=mxGetField(constr,i,"d");   
             mat_temp=mxGetPr(rez);             
             dim=(int)mxGetNumberOfElements(rez);
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc); 
            
             }
            
             if(n_coupling!=0)
             {             
              
              
             rez=mxGetField(coupling,i,"A");   
             mat_temp=mxGetPr(rez);             
             dim=(int)mxGetNumberOfElements(rez);
             fwrite(&dim,1,sizeof(int),f_mpc);        
             fwrite(mat_temp, dim,sizeof(double),f_mpc); 
                      
             if(solve_option==1)
             {
                 rez=mxGetField(coupling,i,"z");   
                 mat_temp=mxGetPr(rez);             
                 dim=(int)mxGetNumberOfElements(rez);
                 fwrite(&dim,1,sizeof(int),f_mpc);        
                 fwrite(mat_temp, dim,sizeof(double),f_mpc);                     
             }
             }
             
             if(box_option[i]!=0)                 
             {
                 rez=mxGetField(constr,i,"lb");   
                 mat_temp=mxGetPr(rez);             
                 dim=(int)mxGetNumberOfElements(rez);
                 fwrite(&dim,1,sizeof(int),f_mpc);        
                 fwrite(mat_temp, dim,sizeof(double),f_mpc); 
             
                 rez=mxGetField(constr,i,"ub");   
                 mat_temp=mxGetPr(rez);             
                 dim=(int)mxGetNumberOfElements(rez);
                 fwrite(&dim,1,sizeof(int),f_mpc);        
                 fwrite(mat_temp, dim,sizeof(double),f_mpc);            
             
             }
             
        }   
            fclose(f_mpc);
         
             
    }
    else
    {         
        int M,N,i;
        double * dim_t; 
       
        mxArray * Mt, * Nt, *n_it;
        
        Mt=mxGetField(subs,0,"M");        
        dim_t=mxGetPr(mxGetField(subs,0,"dim_var"));
       
        M=mxGetScalar(Mt);
       
        
        
        
        int n_total=0;
                
        for(i=0;i<M;i++)
        {
            n_total=n_total+(int)dim_t[i];    
        }      
        
        printf("n_total=%d",n_total);
        
                    
        
                        
           
    
           
        if(solve_option==4)            
        {
             FILE * f_mpc;
                double * H; double * h;
               f_mpc=fopen("pcdm.bin","wb"); 
                    mxArray * H_t; mxArray * h_t; 
              H_t=mxGetField(subs,0,"H");   
            dim=(int)mxGetNumberOfElements(H_t);        
            H=mxGetPr(H_t);     
      
            h_t=mxGetField(subs,0,"h");   
            h=mxGetPr(h_t);   
        
              mxArray * constr;
            constr=mxGetField(subs,0,"constr");
            mexPrintf("\n FINE TILL HERE\n");          
                       
                       
                       
            rez=mxGetField(subs,0,"algo");        
            temp_int=mxGetScalar(rez);        
            fwrite(&temp_int,1,sizeof(int),f_mpc);    
        
            fwrite(&M,1,sizeof(int),f_mpc);            
                   
            rez=mxGetField(subs,0,"eps");     
            temp_double=mxGetScalar(rez);                
            fwrite(&temp_double,1,sizeof(double),f_mpc);    
            
            rez=mxGetField(subs,0,"iter_tol");        
            temp_int=mxGetScalar(rez);                
            fwrite(&temp_int,1,sizeof(int),f_mpc);          
            
            
            dim_int=(int *)mxCalloc(M,sizeof(int));
            box_option=(int *)mxCalloc(M,sizeof(int));
      
            rez=mxGetField(subs,0,"box_option");                      
            dim_double=mxGetPr(rez);               
            dim=(int)mxGetNumberOfElements(rez);     
            fwrite(&dim,1,sizeof(int),f_mpc);   
            for(i=0;i<M;i++)
                box_option[i]=(int)dim_double[i];        
            fwrite(box_option, dim,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"dim_var");                      
            dim_double=mxGetPr(rez);               
            dim=(int)mxGetNumberOfElements(rez);     
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                dim_int[i]=(int)dim_double[i];        
            fwrite(dim_int, dim,sizeof(int),f_mpc);   
            
            /*print_mat_int(dim_int,1,M); */
            
            rez=mxGetField(subs,0,"n_ineq");              
            dim_double=mxGetPr(rez);        
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                n_ineq[i]=(int)dim_double[i];
            fwrite(n_ineq, dim,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"n_eq");             
            dim_double=mxGetPr(rez);
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);
            for(i=0;i<M;i++)
                n_eq[i]=(int)dim_double[i];
            fwrite(n_eq, dim,sizeof(int),f_mpc);   
            
            rez=mxGetField(subs,0,"u_init");              
            mat_temp=mxGetPr(rez);        
            dim=(int)mxGetNumberOfElements(rez);        
            fwrite(&dim,1,sizeof(int),f_mpc);        
            fwrite(mat_temp, dim,sizeof(double),f_mpc);   
     
          
         
            int position_H=0;
            int position_h=0;
            
        
         int j;
        
            int dim1;
            int dim2;
     
            for(i=0;i<M;i++)
            {    
                dim1=(int)dim_t[i]*n_total;
                dim2=(int)dim_t[i];
            
                fwrite(&dim1,1,sizeof(int),f_mpc);                  
                fwrite(H+position_H,1,(int)dim_t[i]*n_total*sizeof(double),f_mpc);
                fwrite(&dim2,1,sizeof(int),f_mpc);        
                fwrite(h+position_h,(int)dim_t[i],sizeof(double),f_mpc);
                
         
                
                position_H=position_H+dim1;
                position_h=position_h+dim2;
           
                
                if(n_ineq[i]!=0)
                {
                    rez=mxGetField(constr,i,"F");   
                    mat_temp=mxGetPr(rez);             
                    dim=(int)mxGetNumberOfElements(rez);
                    fwrite(&dim,1,sizeof(int),f_mpc);        
                    fwrite(mat_temp, dim,sizeof(double),f_mpc); 
                    
                    rez=mxGetField(constr,i,"g");   
                    mat_temp=mxGetPr(rez);             
                    dim=(int)mxGetNumberOfElements(rez);
                    fwrite(&dim,1,sizeof(int),f_mpc);        
                    fwrite(mat_temp, dim,sizeof(double),f_mpc); 
                }
              
             
                if(n_eq[i]!=0)
                {
                    rez=mxGetField(constr,i,"C");   
                    mat_temp=mxGetPr(rez);             
                    dim=(int)mxGetNumberOfElements(rez);
                    fwrite(&dim,1,sizeof(int),f_mpc);        
                    fwrite(mat_temp, dim,sizeof(double),f_mpc); 
             
                    rez=mxGetField(constr,i,"d");   
                    mat_temp=mxGetPr(rez);             
                    dim=(int)mxGetNumberOfElements(rez);
                    fwrite(&dim,1,sizeof(int),f_mpc);        
                    fwrite(mat_temp, dim,sizeof(double),f_mpc); 
                }
             
             if(box_option[i]!=0)
             {                
                 rez=mxGetField(constr,i,"lb");   
                 mat_temp=mxGetPr(rez);             
                 dim=(int)mxGetNumberOfElements(rez);
                 fwrite(&dim,1,sizeof(int),f_mpc);        
                 fwrite(mat_temp, dim,sizeof(double),f_mpc); 
                 
                 rez=mxGetField(constr,i,"ub");   
                 mat_temp=mxGetPr(rez);             
                 dim=(int)mxGetNumberOfElements(rez);
                 fwrite(&dim,1,sizeof(int),f_mpc);        
                 fwrite(mat_temp, dim,sizeof(double),f_mpc);       
                 
             }
             
            }
            
           fclose(f_mpc);
        }
        if(solve_option==5)
        {
            
            mexPrintf("\n FINE TILL HERE\n");
                double * H; double * h;
            
                FILE * f_mpc2;
                
                f_mpc2=fopen("centralized.bin","wb");
                
              
                 mxArray * H_t; mxArray * h_t; 
                 H_t=mxGetField(subs,0,"H");   
            dim=(int)mxGetNumberOfElements(H_t);        
            H=mxGetPr(H_t);     
      
            h_t=mxGetField(subs,0,"h");   
            h=mxGetPr(h_t);   
        
              mxArray * constr;
            constr=mxGetField(subs,0,"constr");
            
                
                
            mexPrintf("INIT n_total=%d\n",n_total);
                double * lb=mxCalloc(n_total,sizeof(double));
                double * ub=mxCalloc(n_total,sizeof(double));
                int k=0, j=0;
                for(i=0;i<M;i++)
                {
                    rez=mxGetField(constr,i,"lb");   
                    mat_temp=mxGetPr(rez);             
                    dim=(int)mxGetNumberOfElements(rez);
                    for(j=k;j<k+dim;j++)
                        lb[j]=mat_temp[j-k];
                    
                    rez=mxGetField(constr,i,"ub");   
                    mat_temp=mxGetPr(rez);             
                    dim=(int)mxGetNumberOfElements(rez);
                    for(j=k;j<k+dim;j++)
                        ub[j]=mat_temp[j-k];
                    
                    k=k+dim;                
                    
                }
                print_mat_double(lb,n_total,1);
                print_mat_double(ub,n_total,1);
                /*mxFree(lb);*/
                /*mxFree(ub);*/
             
               
                int n_total2=n_total*n_total;
                fwrite(&n_total,1,sizeof(int),f_mpc2);  
                
                fwrite(&n_total2,1,sizeof(int),f_mpc2);        
                fwrite(H,n_total2,sizeof(double),f_mpc2);
                
                fwrite(&n_total,1,sizeof(int),f_mpc2);  
                fwrite(h,n_total,sizeof(double),f_mpc2);
                
                fwrite(&n_total,1,sizeof(int),f_mpc2);  
                fwrite(lb,n_total,sizeof(double),f_mpc2);
                
                fwrite(&n_total,1,sizeof(int),f_mpc2);  
                fwrite(ub,n_total,sizeof(double),f_mpc2);
                
                mxFree(lb);
                mxFree(ub);
                   fclose(f_mpc2);
             mexPrintf("\nWRITING DONE\n");
        
        
        }
         
        
       
       
    }
         /*fclose(f_mpc);*/
         
        return;

    
}


mxArray * step_mpc(mxArray * subs, double * ucur)
{
    
    
    mxArray * dim_t, * solve_option_t, *M_t, *N_t, * m_i;
    
    
    int solve_option, i, j,N, M, m_total=0, solved;
 
    solve_option_t=mxGetField(subs,0,"solve_option");
    mxArray * mpc_solved=mxGetField(subs,0,"solved");
    double * solved_prob=mxCalloc(1,sizeof(double));
    double * get_solved;
    get_solved=mxGetPr(mpc_solved);
             int copy1=1;
    
    
    solve_option=mxGetScalar(solve_option_t);
    M_t=mxGetField(subs,0,"M");
    N_t=mxGetField(subs,0,"N");
     
     N=mxGetScalar(N_t);
     M=mxGetScalar(M_t);

     mexPrintf("\nFINE at step\n");
    
     write_mpc(subs);
     
      int * incx=(int *)mxMalloc(sizeof(int));
      *incx=(int)1;  
    
     
    if((solve_option==4)||(solve_option==5))
    {
       
      double * m_i;
      
      m_i=mxGetPr(mxGetField(subs,0,"dim_var"));
    
      for(i=0;i<M;i++)
          m_total=m_total+(int)m_i[i];
     
      char * args[5];
      
      char buffer[50];
    sprintf( buffer, " %d ", M );
      
      args[0]=" mpirun ";
      args[1]=" -n ";
      args[2]=buffer;
      args[3]=" ./pcdm ";
      args[4]=NULL; 
      
      
      int ret;    
      if(solve_option==4)
      {
          
          ret=system("mpirun -n 2 ./pcdm");       
      }
      else
          ret=system("./centralized");
          
     
     
     mexPrintf("\n\n SOLVING DONE\n\n");
      
      int m_input=m_total/N;
      
      double * sol=(double *)mxCalloc(m_total,sizeof(double));
      double * sol2=(double *)mxCalloc(m_total,sizeof(double));
      
       double * ulin=mxGetPr(mxGetField(subs,0,"ulin"));
       dcopy_(&m_input,ulin,incx,ucur,incx);
      
       double iter;
       double fval;
       int ret2;
      FILE * f_mpc, * f_mpc2;
      
      if(solve_option==4)
      {
          f_mpc=fopen("pcdm_out.bin","rb");
          ret2=fread(&solved,sizeof(int),1,f_mpc);
          ret2=fread(sol,sizeof(double),m_total,f_mpc);
          ret2=fread(&fval,sizeof(double),1,f_mpc);
          ret2=fread(&iter,sizeof(int),1,f_mpc);
            
          *solved_prob=(double)solved;
          dcopy_(&copy1,solved_prob,incx,get_solved,incx);  
          mxSetField(subs,0,"solved",mpc_solved);
          mexPrintf("\n\nIterations done=%d\n\n",iter);
          fclose(f_mpc);
      }
      
      else
      {
           f_mpc=fopen("centralized_out.bin","rb");  
              ret2=fread(&solved,sizeof(int),1,f_mpc);
            ret2=fread(sol,sizeof(double),m_total,f_mpc);
          
              *solved_prob=(double)solved;
          dcopy_(&copy1,solved_prob,incx,get_solved,incx);  
          mxSetField(subs,0,"solved",mpc_solved);
          fclose(f_mpc);
      
      }
       mexPrintf("sol=\n");
       print_mat_double(sol,m_total,1);
         
    
      int position=0, k=0;
      
      for(i=0;i<M;i++)
      {
          for(j=position;j<position+(int)m_i[i]/N;j++)
          {
                ucur[k]=ucur[k]+sol[j];       
                ucur[k]=fabs(ucur[k]);
                      k++;                                
          }
          position=position+m_i[i];          
      }
         
      mxArray * u_init_t; double * u_init; 
      int * incx=(int *)mxMalloc(sizeof(int));
      *incx=(int)1;  
      u_init_t=mxGetField(subs,0,"u_init");
      u_init=mxGetPr(u_init_t);
      position=0; 
    
      for(i=0;i<M;i++)
      {
          for(j=position;j<position+(int)m_i[i]/N;j++)
          {
              for(k=0;k<N-1;k++)
              {
                  sol[j+k*(int)m_i[i]/N]=sol[j+(k+1)*(int)m_i[i]/N];                  
                  
                  
                  if(k==N-2)
                   sol[j+(k+1)*(int)m_i[i]/N]=(double)0;   
              }
          }             
          position=position+(int)m_i[i];
      }
     
      dcopy_(&m_total,sol,incx,u_init,incx);      
      mxSetField(subs,0,"u_init",u_init_t);
      mxFree(sol);            
      mexPrintf("\n\nSTEP DONE FOR PCDM\n\n");
     
    }
    else
    { 
          int n_total=0, m_input=0, dim_total=0, position=0, iter,k=0;
          double * n_i=mxGetPr(mxGetField(subs,0,"n_i"));
          double * m_i=mxGetPr(mxGetField(subs,0,"m_i"));
          double * dim_var=mxGetPr(mxGetField(subs,0,"dim_var"));
          for(i=0;i<M;i++)
          {
              n_total=n_total+(int)n_i[i];          
              m_input=m_input+(int)m_i[i];
              dim_total=dim_total+(int)dim_var[i];
          }
           char * args[5];           
           char buffer[50];
           sprintf( buffer, " %d ", M );     
           
           int ret;
           if(solve_option==1)
           {
           args[0]=" mpirun ";
           args[1]=" -n ";
           args[2]=buffer; 
           args[3]=" ./admm ";
           args[4]=NULL; 
           ret=system("mpirun -n 2 ./admm");   
           
           }
           else
           {
           args[0]=" mpirun ";
           args[1]=" -n ";
           args[2]=buffer; 
           args[3]=" ./ddecomp ";
           args[4]=NULL; 
           if(solve_option==3)
               ret=system("mpirun -n 2 ./ddecompfast");              
           else
               ret=system("mpirun -n 2 ./ddecomp");              
           }
          
           
           double * sol=(double *)mxCalloc(dim_total,sizeof(double));
         
           double * ulin=mxGetPr(mxGetField(subs,0,"ulin"));
           dcopy_(&m_input,ulin,incx,ucur,incx);      
       
           double fval;
           FILE * f_mpc;
           if(solve_option==1)
               f_mpc=fopen("admm_out.bin","rb");
           else
               f_mpc=fopen("ddecomp_out.bin","rb");
           ret=fread(&solved,sizeof(int),1,f_mpc);
           ret=fread(sol,sizeof(double),dim_total,f_mpc);
           ret=fread(&fval,sizeof(double),1,f_mpc);           
           ret=fread(&iter,sizeof(int),1,f_mpc);           
           
           mexPrintf("\n\nIterations done=%d\n\n",iter);
           
           *solved_prob=(double)solved;
           dcopy_(&copy1,solved_prob,incx,get_solved,incx);  
           mxSetField(subs,0,"solved",mpc_solved);
           
           
           fclose(f_mpc);  k=0; position=0;   
           for(i=0;i<M;i++)
           {
               for(j=position;j<position+m_i[i];j++)
               {
                   if(solved==1)
                       ucur[k]=ucur[k]+sol[j];                          
                   k++;
               }
               position=position+(int)N*(m_i[i]+n_i[i]);                   
           }
           position=0;                      
           
           for(i=0;i<M;i++)
           {
               for(j=position;j<position+m_i[i];j++)
               {
                   for(k=0;k<N-1;k++)
                   {
                       sol[j+k*(int)m_i[i]]=sol[j+(k+1)*(int)m_i[i]];                  
                       
                  if(k==N-2)
                   sol[j+(k+1)*(int)m_i[i]]=(double)0;   
                   }
               }             
               position=position+(int)N*(m_i[i]+n_i[i]);
           }
           
           
    }
      
    return subs;

}






void mxFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) 
{
    
 
      

   
}

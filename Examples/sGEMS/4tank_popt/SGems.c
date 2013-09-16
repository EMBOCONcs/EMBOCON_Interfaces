/*
 * Include Files
 *
 */
#if defined(MATLAB_MEX_FILE)
#include "tmwtypes.h"
#include "simstruc_types.h"
#else
#include "rtwtypes.h"
#endif
#include "S_quadtank_control_bus.h"

/*
 *Include files
 */
#include <mex.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "lapack_mpc.h"
#include "EMBOCON_ObserverInterface.h"
#include "EMBOCON_OptimizerInterface.h"

/*
 *Defines
 */
#define u_width 1
#define y_width 1

/*
 * Create external references here.  
 */
/* %%%-SFUNWIZ_wrapper_externs_Changes_BEGIN --- EDIT HERE TO _END */
/* extern double func(double a); */
/* %%%-SFUNWIZ_wrapper_externs_Changes_END --- EDIT HERE TO _BEGIN */

/*
 * Output functions
 *
 */


extern int makeOptStep(emb_optimizer optim, emb_opt_context opt_context, const double xcur[], const double uprev[], double ucur[]);
extern int setOptParameter(emb_optimizer optim, emb_opt_context opt_context, const double optp[]);
const mxArray * subs;


void SGems(const ref_bus *xref,    const run_bus *x,    control_bus *u, mxArray * subs)
{

/*Initialize necessary arguments for observer */
void *obs=subs;
void *obs_context;



double * ucur=(double *)mxCalloc(2,sizeof(double));
const double xprev[4];
double xcur[4];


const double ycur[] = { (*x).h1, (*x).h2,  (*x).h3, (*x).h4};

/*Update the MPC problem to current state*/
int flagObs=makeObsStep(obs,  obs_context,  ucur, ycur,  xprev,  xcur);


double * x_init=mxGetPr(mxGetField(subs,0,"x_init"));

/*Initialize necessary arguments for optimizer*/
void *optim=subs;
void *opt_context;

double * ref=(double *)mxCalloc(7,sizeof(double));
ref[0]=xref->h1;
ref[1]=xref->h2;
ref[2]=xref->h3;
ref[3]=xref->h4;
ref[4]=xref->q_a;
ref[5]=xref->q_b;
ref[6]=xref->reset_ref;
/*mexPrintf("ref=%f\n",ref[0]);*/
if(ref[6]==1)
{
     int condition_update=0;
    mxArray * ref2;  mxArray * ref_temp;   
    double * set=(double *)mxMalloc(sizeof(double));
    
     ref2=mxGetField(subs,0,"ref");         
        
        ref_temp=mxGetField(ref2,0,"h1");
        set=mxGetPr(ref_temp);
        if(*set!=ref[0])
            condition_update=1;
      
        
        ref_temp=mxGetField(ref2,0,"h2");
        set=mxGetPr(ref_temp);
        if(*set!=ref[1])
            condition_update=1;

        
    
        ref_temp=mxGetField(ref2,0,"h3");
        set=mxGetPr(ref_temp);
       if(*set!=ref[2])
            condition_update=1;
       
        
        
        ref_temp=mxGetField(ref2,0,"h4");
        set=mxGetPr(ref_temp);
       if(*set!=ref[3])
            condition_update=1;
      
    
    
        ref_temp=mxGetField(ref2,0,"q_a");
        set=mxGetPr(ref_temp);
         if(*set!=ref[4])
            condition_update=1;
       
       
    
        ref_temp=mxGetField(ref2,0,"q_b");
        set=mxGetPr(ref_temp);
         if(*set!=ref[5])
            condition_update=1;
        
      
   if(condition_update==1)
   {
    mexPrintf("resetting references for %f\n",ref[6]);
    int flagOptim=setOptParameter(optim,  opt_context, ref);
   }
   else
   {
            int flagOptim=0;
   }
}
/*mxFree(ref);*/

const double uprev[2];
/*Solve MPC problem, get new inputs in ucur*/
int flagOpt;
flagOpt=makeOptStep(optim,  opt_context, xcur, uprev, ucur);
    
/*If the problem was solved successfully, we set the inputs to the new values*/
/*flagOpt=0;*/

if((flagOpt==1)||(flagOpt==2))
{
    (*u).q_a =ucur[0];
    (*u).q_b =ucur[1];   
    mexPrintf("Problem solved successfully");
    print_mat_double(ucur,1,2);
   
     
}
/*If the problem was not solved successfully, e.g the constraints are inconsistent, we set the inputs to the reference values*/
else
{
    if(flagOpt==0)
        mexPrintf("Infeasibility detected \n");
    if(flagOpt==2)
        mexPrintf("Maximum number of iterations reached \n");
    if(flagOpt==3)
        mexPrintf("Parameters nearly zero \n");
    
    double * uref=mxGetPr(mxGetField(subs,0,"uref"));
    double * ulin=mxGetPr(mxGetField(subs,0,"ulin"));
    (*u).q_a =uref[0]+ulin[0];
    (*u).q_b =uref[1]+ulin[1];    
    
}


}







#include <cstdlib>
#include "wrapper.h"



test* createQP( int  n, int m)
{
USING_NAMESPACE_QPOASES    
    
QProblem *q=new QProblem(n,m);

return (test *)q;    
}

test* createQPsimp( int  n)
{
USING_NAMESPACE_QPOASES    
    
QProblemB *q=new QProblemB(n);

return (test *)q;    
}

test* createSQP( int  n, int m)
{
USING_NAMESPACE_QPOASES    
    
SQProblem *q=new SQProblem(n,m);

return (test *)q;    
}


int init_solveQPsimp(test * QP, double * H, double *g, double *lb, double *ub, int nWSR)
{
    USING_NAMESPACE_QPOASES    
    returnValue ret;
    QProblemB *QP1=(QProblem *)QP;    
    ret=QP1->init(H,g,lb,ub,nWSR,0);
    if(ret!=SUCCESSFUL_RETURN)
        return 1;
    else
        return 0;
    
}

int init_solveQP(test* QP,double* H,double* g,double* A,double* lb,double* ub,double* lbA,double* ubA, int  nWSR, int a)
{
USING_NAMESPACE_QPOASES    
returnValue ret;
QProblem *QP1=(QProblem *)QP;    
ret=QP1->init( H,g,A,lb,ub,lbA,ubA, nWSR,0 );
if(ret!=SUCCESSFUL_RETURN)
    return 1;
else
    return 0;
    
}

int init_solveSQP(test* QP,double* H,double* g,double* A,double* lb,double* ub,double* lbA,double* ubA, int  nWSR, int a)
{
USING_NAMESPACE_QPOASES    
         returnValue ret;
SQProblem *QP1=(SQProblem *)QP;    
ret=QP1->init( H,g,A,lb,ub,lbA,ubA, nWSR,0 );
if(ret!=SUCCESSFUL_RETURN)
    return 1;
else
    return 0;
    
}

int hotstart_SQP(test* QP,double * H, double* g, double * A,double* lb,double* ub,double* lbA,double* ubA, int  nWSR, int a)
{

USING_NAMESPACE_QPOASES  
        
  returnValue ret;

SQProblem *QP1=(SQProblem *)QP;
        //nWSR=10;

ret=QP1->hotstart(H,g,A,lb,ub,lbA,ubA, nWSR,0 );

if(ret!=SUCCESSFUL_RETURN)
    return 1;
else
    return 0;


}


int hotstart_QP(test* QP,double* g,double* lb,double* ub,double* lbA,double* ubA, int  nWSR, int a)
{

USING_NAMESPACE_QPOASES 
        
        returnValue ret;
QProblem *QP1=(QProblem *)QP;
        
//nWSR=10;
ret=QP1->hotstart(g,lb,ub,lbA,ubA, nWSR,0 );
if(ret!=SUCCESSFUL_RETURN)
    return 1;
else
    return 0;

}

void get_sol(test* QP, double *x)
{
USING_NAMESPACE_QPOASES
QProblem *QP1=(QProblem *)QP;

QP1->getPrimalSolution(x);    
}

void get_solsimp(test* QP, double *x)
{
USING_NAMESPACE_QPOASES
QProblemB *QP1=(QProblemB *)QP;

QP1->getPrimalSolution(x);    
}


void get_solS(test* QP, double *x)
{
USING_NAMESPACE_QPOASES
SQProblem *QP1=(SQProblem *)QP;

QP1->getPrimalSolution(x);    
}

void set_printnone(test* QP)
{
USING_NAMESPACE_QPOASES            
QProblem *QP1=(QProblem *)QP;

Options myOpt;  
myOpt.printLevel= PL_NONE;
QP1->setOptions(myOpt);    
}

void set_printnonesimp(test* QP)
{
USING_NAMESPACE_QPOASES            
QProblemB *QP1=(QProblemB *)QP;

Options myOpt;  
myOpt.printLevel= PL_NONE;
QP1->setOptions(myOpt);    
}


void set_printnoneS(test* QP)
{
USING_NAMESPACE_QPOASES            
SQProblem *QP1=(SQProblem *)QP;

Options myOpt;  
myOpt.printLevel= PL_NONE;
QP1->setOptions(myOpt);
}


int infeasible(test *QP)
{
    USING_NAMESPACE_QPOASES  
    BooleanType infeasible;             
    BooleanType solved;             
     
    
    
    QProblem *QP1=(QProblem *)QP;
    
    infeasible=QP1->isInfeasible();
    solved=QP1->isSolved( );
    
     if((infeasible==BT_TRUE))
         printf("infeasible \n");
    
    if((solved!=BT_TRUE))
         printf("not solved \n");
    
    if((infeasible==BT_TRUE)||(solved!=BT_TRUE))
        return 1;
    else
        return 0;
    
}


int infeasibleS(test *QP)
{
   USING_NAMESPACE_QPOASES  
    BooleanType infeasible;             
    BooleanType solved;             
     
    SQProblem *QP1=(SQProblem *)QP;
    
    infeasible=QP1->isInfeasible();
    solved=QP1->isSolved( );
    
   
        
    if((infeasible==BT_TRUE)||(solved!=BT_TRUE))
        return 1;
    else
        return 0;
    
}

void read_vector_double(FILE ** f1, double ** rez)
{
    int * length=(int *)malloc(sizeof(int));

    fread(length, sizeof(int), 1, *f1);

    if(*length!=0)
    {    *rez=(double *)malloc(*length*sizeof(double));
    fread(*rez,sizeof(double),*length,*f1);
    }

}



void read_vector_int(FILE ** f1, int ** rez)
{
    int * length=(int *)malloc(sizeof(int));

    fread(length, sizeof(int), 1, *f1);

    if(length!=0)
    {    *rez=(int *)malloc(*length*sizeof(int));
    fread(*rez,sizeof(int),*length,*f1);
    }

}



/*

int isfeasible(test *QP)
{
    
    USING_NAMESPACE_QPOASES            
    SQProblem *QP1=(SQProblem *)QP; 


}
 */
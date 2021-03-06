/*
 *    This file was auto-generated by ACADO Toolkit.
 *
 *    ACADO Toolkit -- A Toolkit for Automatic Control and Dynamic Optimization.
 *    Copyright (C) 2008-2011 by Boris Houska, Hans Joachim Ferreau et al., K.U.Leuven.
 *    Developed within the Optimization in Engineering Center (OPTEC) under
 *    supervision of Moritz Diehl. All rights reserved.
 *
 */


#include <stdio.h>
#include <math.h>
#include <time.h>
#include <sys/stat.h>
#include <sys/time.h>

#ifndef ACADO_H
#define ACADO_H

#ifndef __MATLAB__
#ifdef __cplusplus
extern "C"
{
#endif
#endif
#include "qpoases/solver.hpp"


/* COMMON DEFINITIONS:              */
/* -------------------------------- */




/* Number of control intervals */
#define ACADO_N   12
/* Number of differential states */
#define ACADO_NX  8
/* Number of differential state derivatives */
#define ACADO_NDX  0
/* Number of algebraic states */
#define ACADO_NXA  0
/* Number of controls */
#define ACADO_NU  2
/* Number of parameters */
#define ACADO_NP  0
/* Number of output functions */
#define NUM_OUTPUTS  0


/* GLOBAL VARIABLES:                */
/* -------------------------------- */
typedef struct ACADOvariables_ {
int resetIntegrator;

/* Matrix of size: 13 x 8 (row major format) */
real_t x[ 104 ];

/* Matrix of size: 12 x 2 (row major format) */
real_t u[ 24 ];

/* Matrix of size: 12 x 8 (row major format) */
real_t xRef[ 96 ];

/* Matrix of size: 12 x 2 (row major format) */
real_t uRef[ 24 ];


} ACADOvariables;


/* GLOBAL WORKSPACE:                */
/* -------------------------------- */
typedef struct ACADOworkspace_ {
/* Row vector of size: 260 */
real_t acado_aux[ 260 ];

/* Column vector of size: 90 */
real_t rk_xxx[ 90 ];

/* Matrix of size: 4 x 88 (row major format) */
real_t rk_kkk[ 352 ];

/* Column vector of size: 90 */
real_t state[ 90 ];

/* Matrix of size: 12 x 8 (row major format) */
real_t residuum[ 96 ];

/* Row vector of size: 24 */
real_t g1[ 24 ];

/* Matrix of size: 8 x 24 (row major format) */
real_t H01[ 192 ];

/* Matrix of size: 24 x 24 (row major format) */
real_t H11[ 576 ];

/* Row vector of size: 24 */
real_t lbA[ 24 ];

/* Row vector of size: 24 */
real_t ubA[ 24 ];

/* Matrix of size: 12 x 8 (row major format) */
real_t d[ 96 ];

/* Row vector of size: 8 */
real_t deltaX0[ 8 ];

/* Matrix of size: 96 x 8 (row major format) */
real_t C[ 768 ];

/* Matrix of size: 96 x 8 (row major format) */
real_t QC[ 768 ];

/* Matrix of size: 8 x 8 (row major format) */
real_t Gx[ 64 ];

/* Matrix of size: 96 x 24 (row major format) */
real_t E[ 2304 ];

/* Matrix of size: 96 x 24 (row major format) */
real_t QE[ 2304 ];

/* Matrix of size: 8 x 2 (row major format) */
real_t Gu[ 16 ];

/* Matrix of size: 12 x 8 (row major format) */
real_t Dx[ 96 ];

/* Row vector of size: 96 */
real_t QDx[ 96 ];

/* Matrix of size: 12 x 2 (row major format) */
real_t Du[ 24 ];

/* Matrix of size: 12 x 2 (row major format) */
real_t RDu[ 24 ];


} ACADOworkspace;


/* GLOBAL FORWARD DECLARATIONS:          */
/* ------------------------------------- */
void integrate( real_t* rk_eta );
void acado_rhs_ext( real_t*, real_t* );
void condense1( int index, real_t* yy );
void condense2(  );
void expand(  );
void setupQP(  );
void multiplyQC1( real_t* C1, real_t* QC1 );
void multiplyQE1( real_t* E1, real_t* QE1 );
void multiplyQDX1( real_t* Dx1, real_t* QDx1 );
void multiplyRDU1( real_t* Du1, real_t* RDu1 );
void multiplyQC2( real_t* C1, real_t* QC1 );
void multiplyQE2( real_t* E1, real_t* QE1 );
void multiplyQDX2( real_t* Dx1, real_t* QDx1 );
void multiplyC( real_t* Gx, real_t* C1, real_t* C1_new );
void multiplyE( real_t* Gx, real_t* E1, real_t* E1_new );
void multiplyG1( real_t* E, real_t* QDx, real_t* g1 );
void multiplyCD1( real_t* Gx, real_t* d1, real_t* d1_new );
void multiplyEU1( real_t* Gu, real_t* u1, real_t* d1_new );
void multiplyH01( real_t* C, real_t* QE, real_t* H01 );
void multiplyH11( real_t* E, real_t* QE, real_t* H11 );
real_t getObjectiveValue(  );
void preparationStep(  );
void initialValueEmbedding(  );
int feedbackStep( real_t* x0 );
void shiftControls( real_t* uEnd );
void shiftStates( real_t* xEnd );
real_t getKKT(  );
real_t* getAcadoVariablesX(  );
real_t* getAcadoVariablesU(  );
real_t* getAcadoVariablesXRef(  );
real_t* getAcadoVariablesURef(  );
void printStates(  );
void printControls(  );
real_t getTime(  );
void printHeader(  );
/* ------------------------------------- */


/* EXTERN DECLARATIONS:                  */
/* ------------------------------------- */
extern ACADOworkspace acadoWorkspace;
extern ACADOvariables acadoVariables;
/* ------------------------------------- */
#ifndef __MATLAB__
#ifdef __cplusplus

} /* extern "C" */
#endif
#endif
#endif

/* END OF FILE. */


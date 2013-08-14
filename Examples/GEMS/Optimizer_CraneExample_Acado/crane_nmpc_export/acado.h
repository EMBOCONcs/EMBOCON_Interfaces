/*
 *    This file was auto-generated by ACADO Code Generation Tool.
 *
 *    ACADO Code Generation tool is a sub-package of ACADO toolkit --
 *    A Toolkit for Automatic Control and Dynamic Optimization.
 *    Copyright (C) 2008 - 2013 by Boris Houska, Hans Joachim Ferreau,
 *    Milan Vukov and Rien Quirynen.
 *    Developed within the Optimization in Engineering Center (OPTEC) under
 *    supervision of Moritz Diehl. All rights reserved.
 *
 *    ACADO Toolkit is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation; either
 *    version 3 of the License, or (at your option) any later version.
 *
 *    ACADO Toolkit is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public
 *    License along with ACADO Toolkit; if not, write to the Free Software
 *    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
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
#define ACADO_N   25
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
/** Matrix of size: 26 x 8 (row major format) */
real_t x[ 208 ];

/** Matrix of size: 25 x 2 (row major format) */
real_t u[ 50 ];

/** Matrix of size: 25 x 8 (row major format) */
real_t xRef[ 200 ];

/** Matrix of size: 25 x 2 (row major format) */
real_t uRef[ 50 ];


} ACADOvariables;


/* GLOBAL WORKSPACE:                */
/* -------------------------------- */
typedef struct ACADOworkspace_ {
real_t rk_dim8_swap;

/** Column vector of size: 8 */
int rk_dim8_perm[ 8 ];

/** Column vector of size: 8 */
real_t rk_dim8_bPerm[ 8 ];

/** Column vector of size: 23 */
real_t acado_aux[ 23 ];

real_t rk_ttt;

/** Row vector of size: 18 */
real_t rk_xxx[ 18 ];

/** Column vector of size: 8 */
real_t rk_kkk[ 8 ];

/** Column vector of size: 8 */
real_t rk_diffK[ 8 ];

/** Matrix of size: 8 x 8 (row major format) */
real_t rk_A[ 64 ];

/** Column vector of size: 8 */
real_t rk_b[ 8 ];

/** Column vector of size: 16 */
real_t rk_rhsTemp[ 16 ];

/** Row vector of size: 80 */
real_t rk_diffsTemp2[ 80 ];

int resetIntegrator;

/** Matrix of size: 8 x 10 (row major format) */
real_t rk_diffsNew2[ 80 ];

/** Row vector of size: 90 */
real_t state[ 90 ];

/** Matrix of size: 25 x 8 (row major format) */
real_t residuum[ 200 ];

/** Column vector of size: 50 */
real_t g1[ 50 ];

/** Matrix of size: 8 x 50 (row major format) */
real_t H01[ 400 ];

/** Matrix of size: 50 x 50 (row major format) */
real_t H11[ 2500 ];

/** Column vector of size: 50 */
real_t lbA[ 50 ];

/** Column vector of size: 50 */
real_t ubA[ 50 ];

/** Matrix of size: 25 x 8 (row major format) */
real_t d[ 200 ];

/** Column vector of size: 8 */
real_t deltaX0[ 8 ];

/** Matrix of size: 200 x 8 (row major format) */
real_t C[ 1600 ];

/** Matrix of size: 200 x 8 (row major format) */
real_t QC[ 1600 ];

/** Matrix of size: 8 x 8 (row major format) */
real_t Gx[ 64 ];

/** Matrix of size: 200 x 50 (row major format) */
real_t E[ 10000 ];

/** Matrix of size: 200 x 50 (row major format) */
real_t QE[ 10000 ];

/** Matrix of size: 8 x 2 (row major format) */
real_t Gu[ 16 ];

/** Matrix of size: 25 x 8 (row major format) */
real_t Dx[ 200 ];

/** Column vector of size: 200 */
real_t QDx[ 200 ];

/** Matrix of size: 25 x 2 (row major format) */
real_t Du[ 50 ];

/** Matrix of size: 25 x 2 (row major format) */
real_t RDu[ 50 ];


} ACADOworkspace;


/* GLOBAL FORWARD DECLARATIONS:          */
/* ------------------------------------- */
void integrate( real_t* rk_eta );
void solve_dim8_system( real_t* A, real_t* b );
void solve_dim8_triangular( real_t* A, real_t* b );
void solve_dim8_system_reuse( real_t* A, real_t* b );
void acado_rhs( real_t*, real_t* );
void acado_diffs( real_t*, real_t* );
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

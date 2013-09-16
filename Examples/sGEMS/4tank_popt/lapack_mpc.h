

double dasum_(int *n, double *dx, int *incx);

/* Subroutine */ int daxpy_(int *n, double *da, double *dx, 
	int *incx, double *dy, int *incy);



/* Subroutine */ int dcopy_(int *n, double *dx, int *incx, 
	double *dy, int *incy);

double ddot_(int *n, double *dx, int *incx, double *dy, 
	int *incy);

/* Subroutine */ int dgbmv_(char *trans, int *m, int *n, int *kl, 
	int *ku, double *alpha, double *a, int *lda, 
	double *x, int *incx, double *beta, double *y, 
	int *incy);

/* Subroutine */ 

int dgemm_(char *transa, char *transb, int *m, int *
	n, int *k, double *alpha, double *a, int *lda, 
	double *b, int *ldb, double *beta, double *c__, 
	int *ldc);

/* Subroutine */ 
int dgemv_(char *trans, int *m, int *n, double *
	alpha, double *a, int *lda, double *x, int *incx, 
	double *beta, double *y, int *incy);


/* Subroutine */ int dger_(int *m, int *n, double *alpha, 
	double *x, int *incx, double *y, int *incy, 
	double *a, int *lda);

double dnrm2_(int *n, double *x, int *incx);

/* Subroutine */ int drot_(int *n, double *dx, int *incx, 
	double *dy, int *incy, double *c__, double *s);

/* Subroutine */ int drotg_(double *da, double *db, double *c__, 
	double *s);

/* Subroutine */ int drotm_(int *n, double *dx, int *incx, 
	double *dy, int *incy, double *dparam);

/* Subroutine */ int drotmg_(double *dd1, double *dd2, double *
	dx1, double *dy1, double *dparam);

/* Subroutine */ int dsbmv_(char *uplo, int *n, int *k, double *
	alpha, double *a, int *lda, double *x, int *incx, 
	double *beta, double *y, int *incy);

/* Subroutine */ int dscal_(int *n, double *da, double *dx, 
	int *incx);

double dsdot_(int *n, float *sx, int *incx, float *sy, int *
	incy);

/* Subroutine */ int dspmv_(char *uplo, int *n, double *alpha, 
	double *ap, double *x, int *incx, double *beta, 
	double *y, int *incy);

/* Subroutine */ int dspr_(char *uplo, int *n, double *alpha, 
	double *x, int *incx, double *ap);

/* Subroutine */ int dspr2_(char *uplo, int *n, double *alpha, 
	double *x, int *incx, double *y, int *incy, 
	double *ap);

/* Subroutine */ int dswap_(int *n, double *dx, int *incx, 
	double *dy, int *incy);

/* Subroutine */ int dsymm_(char *side, char *uplo, int *m, int *n, 
	double *alpha, double *a, int *lda, double *b, 
	int *ldb, double *beta, double *c__, int *ldc);

/* Subroutine */ int dsymv_(char *uplo, int *n, double *alpha, 
	double *a, int *lda, double *x, int *incx, double 
	*beta, double *y, int *incy);

/* Subroutine */ int dsyr_(char *uplo, int *n, double *alpha, 
	double *x, int *incx, double *a, int *lda);

/* Subroutine */
/* int dsyr2_(char *uplo, int *n, double *alpha, 
	double *x, int *incx, double *y, int *incy, 
	double *a, int *lda);
*/
/* Subroutine */ int dsyr2k_(char *uplo, char *trans, int *n, int *k, 
	double *alpha, double *a, int *lda, double *b, 
	int *ldb, double *beta, double *c__, int *ldc);

/* Subroutine */ int dsyrk_(char *uplo, char *trans, int *n, int *k, 
	double *alpha, double *a, int *lda, double *beta, 
	double *c__, int *ldc);
	
/* Subroutine */int dsytrf_(char *uplo, int *n, double *a, int *
	lda, int *ipiv, double *work, int *lwork, int *info);

/* Subroutine */int dsytrs_(char *uplo, int *n, int *nrhs, 
	double *a, int *lda, int *ipiv, double *b, int *
	ldb, int *info);

/* Subroutine */ int dtbmv_(char *uplo, char *trans, char *diag, int *n, 
	int *k, double *a, int *lda, double *x, int *incx);

/* Subroutine */ int dtbsv_(char *uplo, char *trans, char *diag, int *n, 
	int *k, double *a, int *lda, double *x, int *incx);

/* Subroutine */ int dtpmv_(char *uplo, char *trans, char *diag, int *n, 
	double *ap, double *x, int *incx);

/* Subroutine */ int dtpsv_(char *uplo, char *trans, char *diag, int *n, 
	double *ap, double *x, int *incx);

/* Subroutine */ int dtrmm_(char *side, char *uplo, char *transa, char *diag, 
	int *m, int *n, double *alpha, double *a, int *
	lda, double *b, int *ldb);

/* Subroutine */ int dtrmv_(char *uplo, char *trans, char *diag, int *n, 
	double *a, int *lda, double *x, int *incx);

/* Subroutine */ int dtrsm_(char *side, char *uplo, char *transa, char *diag, 
	int *m, int *n, double *alpha, double *a, int *
	lda, double *b, int *ldb);

double sasum_(int *n, float *sx, int *incx);
/* Subroutine */ int dtrsv_(char *uplo, char *trans, char *diag, int *n, 
	double *a, int *lda, double *x, int *incx);

int dgeev_(char *jobvl, char *jobvr, int *n, double *
	a, int *lda, double *wr, double *wi, double *vl, 
	int *ldvl, double *vr, int *ldvr, double *work, 
	int *lwork, int *info);

int dpotrf_(char *uplo, int *n, double *a, int *
	lda, int *info);

int idamax_(int *n, double *dx, int *incx);

double sasum_(int *n, float *sx, int *incx);




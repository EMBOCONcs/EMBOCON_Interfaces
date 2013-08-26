#define N_INPUTS 17 //number of data to send to FPGA
#define N_OUTPUTS 2 //number of data to read back from FPGA

#define FLOAT_FIX 1 // set 0=FLOAT (floating-point single precision), 1=FIX (fixed-point up to 32 bits word length)

//FPGA controller implementation is based on fixed-point arithmetic. Therefore a data scaling is required before/after to send/receive data to/from FPGA
//the scaling factor is equal to the fraction length of the fixed-point data rapresentation chosen
#define SCALE_INT32 8 // number of bit for the fraction length

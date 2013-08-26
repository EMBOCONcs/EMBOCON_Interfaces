
/*------------------------------------------------------------------------
 *
 * UDPclient_library.c
 *
 * Sends and read int32 data type to/from the FPGA via UDP/IP packets beacuse FPGA controller implementation supports fixed-point arithmetic
 * Main function is UDPclient_combined: 
 *      - inputs and outputs data are double
 *      - converts input and output data to int32 data type before/after sending/receiving data to/from FPGA. Scaling factor (SCALE_INT32) is defined into FPGAcontroller_library.h
 *
 *-----------------------------------------------------------------------*/

#include "FPGAcontroller_library.h"
#include "UDPclient_int32_library.h"
#include <stdio.h>
#include <string.h>

#include <stdint.h>
#include <math.h>
#include <stdio.h>
#include <string.h>


/* Return values */
#define RETVAL_OK           0
#define RETVAL_WSA_FAIL     1
#define RETVAL_NO_HOST      2
#define RETVAL_NO_SOCKET    3
#define RETVAL_NO_SEND      4
#define RETVAL_NO_READ      5
#define RETVAL_TIMEOUT      6
#define RETVAL_WRONGSIZE    7

       
//#ifdef _WIN32
	WSADATA wsaData;
//#endif

/* 
 * int UDPclient_setup(char *strHostname, int port_number, 
 *      int *socket_handle, struct sockaddr_in *server_address, int *saddr_len) 
 *
 * Setup the UDP client.
 *
 *          *strHostname:          Pointer to null-terminated string with server hostname
 *           port_number:           Integer port number on which server is listening
 *
 *          *socket_handle:        Pointer to integer variable in which to store socket handle
 * 
 */
int UDPclient_setup(char *strHostname, int port_number, 
        int *socket_handle, struct sockaddr_in *server_address, int *saddr_len){
   
    
    
    //printf("strHostname: %s",strHostname);
    
    struct hostent *server;		/* Server host entity */
    
    /* If running Windows, WINSOCK needs to be initialised, so do this here */
    #ifdef _WIN32
    	// Initialize Winsock
		if ( (WSAStartup(MAKEWORD(2,2), &wsaData)) != 0) {    		
            return(RETVAL_WSA_FAIL);
		}
	#endif
            
   // printf("Got here\n");
    
    /* Populate the host entity for the server */
    server = gethostbyname(strHostname);

    if (server == NULL) {
        #ifdef _WIN32
                WSACleanup();
        #endif
        return(RETVAL_NO_HOST);
    }

    
    /* Create socket with the socket() system call. */
    *socket_handle = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (*socket_handle < 0){
        #ifdef _WIN32
                WSACleanup();
        #endif
        return(RETVAL_NO_SOCKET);
    }
    
    
    *saddr_len = sizeof(*server_address);
    
    /* Configure the server address */
    memset( (void *) server_address, 0, *saddr_len);
    port_number = 2007;
    
    
    server_address->sin_family = AF_INET;
    memcpy((char *)&server_address->sin_addr.s_addr,
          (char *)server->h_addr,
          server->h_length);
    server_address->sin_port = htons(port_number);
    return(RETVAL_OK);
    
    
}



/* Close the socket handle that was created */
void UDPclient_close(int *socket_handle){
    #ifdef _WIN32
        closesocket(*socket_handle);
        WSACleanup();
    #else
        close(*socket_handle);
    #endif
}
    
    

/* Create the packet and wait for a reply */
int UDPclient_call(int *socket_handle, struct sockaddr_in *server_address, int *saddr_len,  signed long int *buf_in, signed long int *buf_out,
        int ninputs, int noutputs, int timeout, double *eTime){
    
       
    int k;						// Iterator
    struct timeval tv;			// Select timeout structure
    fd_set Reader;				// Struct for select function
    int retval;					// Return value from calls to functions
    int ss;                     // Select return
    
    /* Platform specific variables for timing */
    #ifdef _WIN32
        LARGE_INTEGER t1;
        LARGE_INTEGER t2;
        LARGE_INTEGER freq;
    #else
        struct timeval t1;          // For timing call length
        struct timeval t2;          // For timing call length
    #endif 
      
    /* 
     * Start timer 
     *
     * (This is platform specific)
     *
     */
                
    #ifdef _WIN32
        QueryPerformanceCounter(&t1);
    #else
        gettimeofday(&t1, NULL);
    #endif
    
    /* Set timeout values */
    tv.tv_sec = timeout;
    tv.tv_usec = 0;

    /* Set up FDS */
    FD_ZERO(&Reader);
    FD_SET(*socket_handle, &Reader);
    
    
    /*
     * SEND PACKET
     */
    retval = sendto(*socket_handle, (void *)buf_in, ninputs*sizeof(signed long int), 0,
                (struct sockaddr *)server_address, *saddr_len);
    if (!retval){
        UDPclient_close(socket_handle);
        return(RETVAL_NO_SEND);
    }
    
     
    
    /*
     * Wait for an incoming packet (or time out)
     */
    ss = select(*socket_handle+1, &Reader, NULL, NULL, &tv);
    
    /* If a packet arrives, process it */
    if (ss){
        retval = recvfrom(*socket_handle, (void *)buf_out, noutputs*sizeof(signed long int), 0,
                       (struct sockaddr *)server_address, saddr_len);
    
        /* If there is a problem, crash */
        if (retval < 0) {
            #ifdef _WIN32
                closesocket(*socket_handle);
                WSACleanup();
            #else
                close(*socket_handle);
            #endif
            return(RETVAL_NO_READ);
        }
        
        if (retval != noutputs*sizeof(float)){
            return(RETVAL_WRONGSIZE);
        }
    } else {
        /* Otherwise, if a timeout occurs, crash */
        UDPclient_close(socket_handle);
        return(RETVAL_TIMEOUT);
    }
    
    /* Finish timing */
    #ifdef _WIN32
        QueryPerformanceCounter(&t2);
        QueryPerformanceFrequency(&freq);
        *eTime = (double)(t2.QuadPart-t1.QuadPart)/(double)freq.QuadPart*1000;
    #else
        gettimeofday(&t2, NULL);
        *eTime = (t2.tv_sec - t1.tv_sec) * 1000.0;      /* sec to ms */
        *eTime += (t2.tv_usec - t1.tv_usec) / 1000.0;   /* us to ms  */
    #endif 
                
    return(RETVAL_OK);
}


/* UDP client error */
void UDPclient_error(int retval){
    switch(retval){
        case 1:
            printf("ERROR, Winsock failed to initialise");
            break;
        case 2:
            printf("ERROR, no such host");
            break;
        case 3:
            printf("ERROR, failed to initialise socket");
            break;
        case 4:
            printf("ERROR, failed to send UDP packet");
            break;
        case 5:
            printf("ERROR, failed to read UDP packet");
            break;
        case 6:
            printf("ERROR, timeout waiting for UDP packet");
            break;
        case 7:
            printf("ERROR, wrong sized reply");
            break;
        default:
            break;
    }
    
}


/* UDP client combined all in one */
int UDPclient_combined( char *strHostname,  double *din,  double *dout, int ninputs, int noutputs, double *eTime){
    
    int socket_handle; // Handle for the socket
    int port_number;	// Port number
    struct sockaddr_in server_address;	// Server address
    int saddr_len;
    int retval;
    int i;

    signed long int intput_s[N_INPUTS];
    signed long int output_s[N_OUTPUTS];


    /* Setup */
    retval =  UDPclient_setup(strHostname, 2007, &socket_handle, &server_address, &saddr_len);

    /* Check return value */
    if (retval != 0) {
        return(retval);
    }
    

    
    for ( i = 0; i < N_INPUTS; i++) //x_hat
	{
        if (FLOAT_FIX==1) { //fixed-point
			intput_s[i]=(signed long int)(din[i]*pow(2,SCALE_INT32)); 
			}
		else
		{
			if (FLOAT_FIX==0) { //floating-point
				intput_s[i]=(signed long int)din[i]; 
			}
		}

	}
    

    /* Call the UDP client */
    retval = UDPclient_call(&socket_handle, &server_address, &saddr_len, intput_s, output_s, ninputs, noutputs, 60, eTime);
    
    /* Check return value */
    if (retval != 0) {
        return(retval);
    }
    
    
    for ( i = 0; i < N_OUTPUTS; i++) //x_hat
	{
		if (FLOAT_FIX==1) { //fixed-point
			dout[i] = (double)((double)output_s[i])/pow(2,SCALE_INT32);
		}
		else
		{
			if (FLOAT_FIX==0) { //floating-point
				dout[i] = (double)output_s[i];
			}
		}
	}
    
    
    
    UDPclient_close(&socket_handle);
    
}

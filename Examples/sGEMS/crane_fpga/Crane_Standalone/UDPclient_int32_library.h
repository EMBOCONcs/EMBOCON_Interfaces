
/*------------------------------------------------------------------------
 *
 * UDPclient_int32_library.h
 *
 * Sends and read int32 type data to/from the FPGA via UDP/IP packets
 *
 *-----------------------------------------------------------------------*/


#ifndef _UDPCLIENT_LIBRARY_H
#define _UDPCLIENT_LIBRARY_H

/* Standard libraries */
#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<string.h>
#include<fcntl.h>


/* Include socket libraries for different platforms */
//#ifdef _WIN32
	#include<winsock.h>
	#include<time.h>
	#pragma comment(lib, "wsock32.lib")
/*#else
	#include<sys/socket.h>
	#include<arpa/inet.h>
	#include<netinet/in.h>
	#include<netdb.h>
	#include<sys/select.h>
	#include<sys/time.h>
    #include<unistd.h>
#endif*/


        

int  UDPclient_setup(char *strHostname, int port_number, int *socket_handle, struct sockaddr_in *server_address, int *saddr_len);
void UDPclient_close(int *socket_handle);
int  UDPclient_call(int *socket_handle, struct sockaddr_in *server_address, int *saddr_len,  signed long int *buf_in, signed long int *buf_out, int ninputs, int noutputs, int timeout, double *eTime);
void UDPclient_error(int retval);
int UDPclient_combined( char *strHostname,  double *din,  double *dout, int ninputs, int noutputs, double *eTime);

#endif
/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#include <stdio.h>
#include <string.h>

#include "lwip/err.h"
#include "lwip/udp.h"

#include "controller.h"


#define NOUTPUTS 2 //nu
#define NINPUTS 17 //2*nx+1


#define START_READING 1

/* Variables used for handling the packet */
unsigned char *payload_ptr;		/* Payload pointer */
unsigned int   payload_temp;		/* 32-bit interpretation of payload */
unsigned char *payload_temp_char = (unsigned char *)&payload_temp;  /* Char interpretation of payload */
//float *payload_flt = (float *)&payload_temp;	/* Float interpretation of payload */


Xint32 mpc_xvec[NINPUTS];
Xint32 outvec[NOUTPUTS];


int transfer_data() {
	return 0;
}

void init_circuit(){
			/* Controller Reset */
			CONTROLLER_mReset(0x77200000);
}

void print_app_header()
{
	xil_printf("-------- Interface framework for FPGA embedded controller  ---------\n\r");
	xil_printf("----------- by Andrea Suardi [a.suardi@imperial.ac.uk] -------------\n\r");
	xil_printf("---------------------- Rev 1.0 August 2013 -------------------------\n\r");
	xil_printf("\n\r");
	xil_printf("\n\r");
	xil_printf("Starting UDP/IP server ...\n\r");
	xil_printf("\n\r");
	xil_printf("\n\r");
	init_circuit();
}


inline static void get_payload(){
	payload_temp_char[0] = *payload_ptr++;
	payload_temp_char[1] = *payload_ptr++;
	payload_temp_char[2] = *payload_ptr++;
	payload_temp_char[3] = *payload_ptr++;
}



void udp_server_function(void *arg, struct udp_pcb *pcb,
		struct pbuf *p, struct ip_addr *addr, u16_t port){


	struct pbuf pnew;
	int k1;
	int k;


	init_circuit();


	/* Only respond when the packet is the correct length */
	if (p->len == (NINPUTS)*sizeof(unsigned int)){


		/* Pick up a pointer to the payload */
		payload_ptr = (unsigned char *)p->payload;

		//printf("New UDP packet\n");

		/* Get the payload out */
		for(k1=0;k1<NINPUTS;k1++){
			get_payload();
			mpc_xvec[k1] = payload_temp;
			//printf("mpc_xvec[%d]=%d\n",k1,payload_temp);
		}




		/* Load in values that do change from problem to problem */


		for(k1=0;k1<NINPUTS;k1++){
			CONTROLLER_mWriteReg(0x77200000, 4, mpc_xvec[k1]);
		}
		CONTROLLER_mWriteReg(0x77200000, 0, 0xFFFFFFFF); //start command




		//printf("Got here\n");

		/* Trigger calculation and wait for result */


		/* Poll the output ready register (REG2) until it becomes unity*/
		//printf("Waiting data ready ...\n");
		Xint32 Data_Reg3;
		while(1){
			Data_Reg3=CONTROLLER_mReadReg(0x77200000, 3*4); //reading from REG3
			//printf("%d\n", Data_Reg3);
			if (Data_Reg3 == START_READING){
				break;
			}
		}



		//printf("Reading data ...\n");

		// read stuff from
		for (k=0; k<NOUTPUTS; k++){

			outvec[k]=CONTROLLER_mReadReg(0x77200000, 2*4);//reading from REG2

		}

		float *payload_read_fl = (float *)outvec;

		for (k=0; k<NOUTPUTS; k++){
			//printf("output data [%d]=%d\n", k,outvec[k]);
		}




		/* We now need to return the result */
		pnew.next = NULL;
		pnew.payload = (unsigned char *)outvec;
		pnew.len = NOUTPUTS*sizeof(Xint32);
		pnew.type = PBUF_RAM;
		pnew.tot_len = pnew.len;
		pnew.ref = 1;
		pnew.flags = 0;


		udp_sendto(pcb, &pnew, addr, port);
		//printf("Got here\n");

		//STOP_TIMER(tval);



		/* Print the output */
	/*	for(k1=0;k1<52;k1++){
			tmpval = *(int *)(outvec+k1);
			//tmpvalf = tmpval/(262144.0);
			tmpvalf = tmpval/(65536);
			printf("u[%d]=%5.4f\n", k1,tmpvalf);
		}*/

	}


	/* Clear the received pbuf */
	pbuf_free(p);


	//printf("Time was: %d\n", tval);
}



int start_application()
{
	struct udp_pcb *pcb;
	err_t err;
	unsigned port = 2007;

	/* create new TCP PCB structure */
	pcb = udp_new();
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}

	/* bind to specified @port */
	err = udp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* specify callback to use for incoming connections */
	udp_recv(pcb, udp_server_function, NULL);

	xil_printf("TCP echo server started @ port %d\n\r", port);

	return 0;
}

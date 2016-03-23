/*
 ******************************************************************************
 ***** EMBOCON SIMULATION APPLICATION INTERFACE *******************************
 ******************************************************************************
 * EMBOCON_SimulationApplicationInterface.c
 *
 *  Created on: 10.10.2011
 *      Author: schoppmeyerc
 *      E-Mail: christian.schoppmeyer@bci.tu-dortmund.de
 *      Version: 1.0
 ******************************************************************************
 ******************************************************************************
 ******************************************************************************
 */

#include "EMBOCON_SimulationApplicationInterface.h"

/* Header files with a description of contents used */

emb_simapp createSimApp()
{
	return 0;
}

void freeSimApp(emb_simapp simapp)
{
	return;
}

void initSimApp(emb_simapp simapp)
{
	return 0;
}

int makeSimStep(emb_simapp simapp, const double ucur[], double meascur[], double pcur[])
{
	return 0;
}

emb_size_type getSimParameterCount(emb_simapp simapp)
{
	return 0;
}

emb_size_type getSimStateCount(emb_simapp simapp)
{
	return 0;
}

int getTrueStates(emb_simapp simapp, double xtrue[])
{
	return 0;
}

int getTrueParameters(emb_simapp simapp, double ptrue[])
{
	return 0;
}

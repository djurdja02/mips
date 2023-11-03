#ifndef _SCB_H_
#define _SCB_H_

#include <stdint.h>

#include "utility.h"

typedef struct
{
	uint32_t volatile CPUID;
	uint32_t volatile ICSR;
	uint32_t volatile VTOR;
	uint32_t volatile AIRCR;
	uint32_t volatile SCR;
	uint32_t volatile CCR;
	uint32_t volatile SHPR1;
	uint32_t volatile SHPR2;
	uint32_t volatile SHPR3;
	uint32_t volatile SHCSR;
	uint32_t volatile CFSR;
	uint32_t volatile HFSR;
	uint32_t volatile dummy0[1];
	uint32_t volatile MMAR;
	uint32_t volatile BFAR;
} SCB_RegisterMapType;
#define SCB ((SCB_RegisterMapType*) 0xE000E008)
#define SET_PRIORITY(num) \
		SET_VALUE(SCB->SHPR3,16 , 23, num);
#define SCB_ICSR_PENDSV 1<<28
#define SET_GROUP_PRIOR() \
	SCB->AIRCR |=(0x5FA)<<16; \
	SCB->AIRCR |=0x5<<8;

#endif

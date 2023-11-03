#ifndef _STK_H_
#define _STK_H_

#include <stdint.h>

typedef struct
{
	uint32_t volatile CTRL;
	uint32_t volatile LOAD;
	uint32_t volatile VAL;
	uint32_t volatile CALIB;
} STK_RegisterMapType;
#define STK ((STK_RegisterMapType*) 0xE000E010)
#define CTRL_ENABLE 1
#define CTRL_TICKINT 1<<1
#define CTRL_CLKSOURCE 1<<2

#endif

#include "test.h"
#include "scb.h"
#include <stdint.h>
#include "stk.h"
uint32_t milis;
void start(){
	milis=0;
	STK->CTRL |= CTRL_ENABLE | CTRL_TICKINT | CTRL_CLKSOURCE;
	STK->LOAD = 8000-1;
	STK->VAL = 0;
}
uint32_t stop(){
	STK->CTRL &=~(CTRL_ENABLE | CTRL_TICKINT | CTRL_CLKSOURCE);
	return milis;}

void systick_handler(){
	milis++;
}
int main(){
	test4();
	//test5
	SET_GROUP_PRIOR();
	SET_PRIORITY(0xF0);
	SCB->ICSR |=SCB_ICSR_PENDSV;
	test7();
	while(1){
	}
	return 0;
}

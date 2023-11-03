/*
 *  SADRZAJ OVE DATOTEKE NE MENJATI
 */

#include <stdint.h>

uint8_t const rodata[] = "VMA:FLASH, LMA:FLASH";
uint8_t data[] = "VMA:RAM, LMA:FLASH";

void test4()
{
	// proveriti da li je sadrzaj iz FLASH memorije
	// prekopiran u inicijalno praznu RAM memoriju
}

void test5()
{
	// proveriti da li je postavljen prioritet PendSV izuzetka na dobar nacin
}


void test6()
{
	// proveriti da li se poziva sa periodom od 500ms
}extern void start();
extern uint32_t stop();
uint32_t time_elapsed = 0;

void test7()
{
	start();
	uint32_t consumer = 0;
	for (uint32_t i = 0; i < 250000; i++)
	{
		consumer++;
	}
	time_elapsed = stop();
}


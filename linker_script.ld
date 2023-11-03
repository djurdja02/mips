_main_stack_pointer = 0x20002800;

MEMORY
{
	FLASH(rx) : ORIGIN = 0x08000000, LENGTH = 32K
	SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 10K
}

SECTIONS
{
	.vector_table : 
	{
		*(.vector_table)
	} > FLASH
	
	.text :
	{
		*(.text)
		*(.text*)
	} > FLASH
	
	.rodata :
	{
		*(.rodata)
		*(.rodata*)
	} > FLASH
	
	.data :
	{
		_vma_start_adr_ = .;
		*(.data)
		*(.data*)
		_vma_end_adr_ = .;
	} > SRAM AT> FLASH
	
	_lma_start_adr_ = LOADADDR(.data);
	
	.bss :
	{
		*(.bss)
		*(.bss*)
		*(COMMON)
	} > SRAM
}

# OnChip_Dual_RAM

Random Access Memory (RAM) blocks are used to store data temporarily in a digital system.
In a single port RAM, writing and reading can be done through one port only.
Dual-ported RAM (DPRAM) is a type of random-access memory that allows multiple reads or writes to occur at the same time, or nearly the same time, unlike single-ported RAM which allows only one access at a time.

 The dual RAM consists of two RAMs.This information will be written from a host computer such as
a PC into one of the RAMs through peripheral connect interface (PCI) bus. Initially, one of the double memory buffers, RAM 1, is filled and once it is full, the
 information is written to the second RAM. While the second memory,
RAM 2, is being written into, the RAM 1 will be read concurrently.
An important feature in
this design is that the data is written at the rate of 64 bits per clock cycle.

 The validity of the
input data signals, ‘di [63:0]’ is signaled by ‘din_valid’. Also, the validity of each
of the 8 bits in the 64 bit data bus is indicated by the ‘be [7:0]’ pin referred to as
the byte enable signal. In order to write a pixel block, we need only 3 bits address,
wa [2:0], corresponding to eight locations, each location being 64 bits in width.
Data is written at the positive edge of ‘pci_clk’ signal.
The signal, ‘rnw’, meaning read negative (low) and write positive (high), is
used to configure one of the RAMs in write mode while the other RAM block is
configured in the read mode. That is how we achieve concurrent processing of
both writing and reading of the double buffer. It should be noted that RAM 1 and
RAM 2 are dual RAMs of size 8 × 64 bits each. If RAM 2 is in read only mode,
then RAM 2 is automatically configured to the write only mode and vice versa.
The RAM is written row-wise and read column-wise. 

 The ‘switch_bank’ signal, which is the inverted signal of ‘rnw’, configures
ram2 in read mode if rnw is high and in write mode if it is low. Naturally, rnw
configures ram1 in write mode for rnw = 1 and in read mode for rnw = 0. The
RAM data output ‘do2 or ‘do1’ is registered after a clock cycle delay at the positive edge of ‘clk_sys’.

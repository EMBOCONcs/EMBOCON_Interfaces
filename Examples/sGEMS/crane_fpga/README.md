Example of linking EMBOCON supervisor interface with a controller running on FPGA
=================================================================================

*Author*: Andrea Suardi, a.suardi@imperial.ac.uk, Imperial College London 2013

## Requirements for simulation

- Matlab R2012a or later with compatible C-compiler.
- Xilinx evaluation board
- FPGA controller implementation integrated

## Simulation instructions

1. To setup the FPGA refers to FPGA_documentation.pdf

2. Compile the generated code with the GEMS supervisor by running ```crane_mpt_compile.m```.

3. Run the simulation script ```crane_embocon_sim.mdl``` in Simulink.

4. Plot the results using the script ```plot_datasim_mpt.m```.

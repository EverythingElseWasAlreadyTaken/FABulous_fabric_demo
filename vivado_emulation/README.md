# Vivado Project for Emulating a FABulous FPGA Fabric

This project is designed to emulate a FABulous FPGA fabric using Vivado, which
can be used
to verify the functionality of the FPGA design before deploying it on actual hardware.

Based on the Digilent Nexys Video Board:
<https://digilent.com/reference/programmable-logic/nexys-video/start>

But this can be done similarly with any other FPGA board.

The `FABulous_fabric_emulation.xpr.7z` contains an archived Vivado project (compressed with 7zip)
for the Nexys Video Board, which is used to emulate the FPGA fabric.
If you just want to run the emulation, extract it and flash the bitstream to your board. We also provide the bitstreams for each fabric in the respective directory. You can use [OpenFPGALoader](https://github.com/trabucayre/openFPGALoader) to upload the bitstream with the following command:

```
openFPGALoader -b nexysVideo <vivado_bitfile>
```

If you want to store the bitstream persistently in the flash, add the `-f`
option before the bitfile:

```
openFPGALoader -b nexysVideo -f <vivado_bitfile>
```

> [!NOTE] 
> This only uploads the bitstream of the FABulous fabric itself to the 
> board. Skip to 
["Programming the emulated FPGA fabric"](#programming-the-emulated-fpga-fabric)
> to learn how to upload a bitstream to the emulated FABulous fabric.

Of course, you can also use the `Hardware Manager` inside Vivado to upload the
given bitfiles.

After that, you can use the `upload_bitstream/board.py` script to upload the bitstream
to the emulated FPGA fabric.

If you want to set up the emulation environment yourself, follow the steps below.

# Set up the emulation environment

1. Set up Vivado according to the Digilent tutorial:
   > <https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-vitis>
2. Launch Vivado and create a new project in Vivado
3. Add the `../fabric/Fabric/` and `../fabric/Tiles/` directories of the fabric you want to emulate to the design sources.

> [!NOTE]
> Make sure the `Add sources from subdirectories` box is checked.   
> You can decide if you want to check `Copy sources into project` on your
> personal preference. If you're unsure just leave it unchecked.
    
5. Add the `./top.v` file as a design source.
6. Add the files in `./constraints` to the constraints sources.
7. Choose the Nexys Video board as your target board
8. After creating the project, set `efpga_loops.xdc` for implementation only in the source file
   properties.
9. Make sure that `top.v` is set as the top module.
10. We recommend running the synthesis for all tiles as Out-of-Context, since
   this drastically reduces the synthesis time.
   For this, select all Tiles and the block RAM instances in the `Sources` view
   and right click on them. Then select `Set Out-of-Context for Synthesis...` in
   the dialog. You can also select all of them at once.
   We also recommend disabling the `phys_opt_design` step of the
   implementation. This is done under `Settings -> Implementation ->
11. Run the clocking wizard to create the clock constraints.

> [!NOTE]
> Make sure to set the clock frequency to 10 MHz.
> Make sure the names of the clock ports match the constraints and the top.v.

   The default settings should be fine. Below are the most important settings:

   * Clock frequency: 10 MHz
   * Input clock: `clk_in`
   * Output clock: `clk_out1`
   * Enable `reset` and `locked` outputs 
   * Reset type is `Active High`

12. Generate the bitstream by clicking on the `Generate Bitstream` button in the `Flow Navigator`.
    This will take a while, so be patient.
13. Program the FPGA with the Hardware Manager (`Open Hardware Manager`).
14. Now the heartbeat LED (`LED0`) should blink.
15. Program the emulated FPGA fabric with the `upload_bitstream/board.py` script.

## Programming the emulated FPGA fabric

First, make sure that a cable is also plugged into the `UART` port of the board. 

Go to the `upload_bitstream` directory in this project.

```
cd upload_bitstream
```

You should first install the required Python packages:

```
pip install -r requirements.txt
```

Then you can use the `board.py` script to upload the bitstream to the emulated FPGA fabric via UART.

```
./board.py -i 0403:6001 upload ../../fabric/Test/build/sequential_16bit_en.bin -b 46080
```

`led[0]` should always blink, indicating that the upload was successful.
`led[1]` should blink when the upload of the bitstream is in progress.

The `sequential_16bit_en` is a counter example that is mapped to `led[7:2]` of the
Nexys Video board. It has an enable and a reset mapped to the dip switches `sw[1:0]`
of the board. To enable the counter set `sw[1]` and for reset set `sw[0]`.
`sw[2]` is a global reset.
Check the constraints file `constraints/Nexys_Video_Master.xdc` for more information on the pin mappings
and the `top.v` for more details on the design.

Read the `README.md` in the `upload_bitstream` directory for more information on how to use the script.

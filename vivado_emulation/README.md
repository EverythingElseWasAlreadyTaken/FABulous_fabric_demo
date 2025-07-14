# Vivado Project for Emulating a FABulous FPGA Fabric

This project is designed to emulate a FABulous FPGA fabric using Vivado,
to verify the functionality of the FPGA design before deploying it on actual hardware.

Based on Digilent Nexys Video Board:
<https://digilent.com/reference/programmable-logic/nexys-video/start>

But this can be done similarly with any other FPGA board.

The `FABulous_fabric_emulation.xpr.7z` contains an archived Vivado project (compressed with 7zip)
for the Nexys video board, which is used to emulate the FPGA fabric.
If you just want to run the emulation, extract it and flash the Bitstream to your board.
After that, you can use the `upload_bitstream/board.py` script to upload the bitstream
to the emulated FPGA fabric.

If you want to setup the emulation environment yourself, follow the steps below.

# Setup the emulation environment

1. Setup Vivado according to the Digilent tutorial:
   > <https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-vitis>
2. Launch Vivado and Create a new project in Vivado
3. Add the `../fabric/` directory to the design sources.
   > [!Note]
   > Make sure the `Add sources from subdirectories` box is checked.
   > You can decide if you want to check `Copy sources into project` on your
   > personal preference. If you're unsure just leave it unchecked.
4. Add the `./top.v` file as a design source.
5. Add the files in `./constraints` to the constraints sources.
6. Choose the Nexys Video board as your target board
7. After creating the project, set `efpga_loops.xdc` for implementation only in the source file
   properties.
8. Make sure that `top.v` is set as the top module.
9. We recommend running the synthesis for all tiles as Out-of-Context, since
   this drastically reduces the synthesis time.
   For this, select all Tiles and the block RAM instances in the `Sources` view
   and right click on them. Then select `Set Out-of-Context for Synthesis...` in
   the dialog.
10. Run the clocking wizard to create the clock constraints.

    > [!Note]
    > Make sure to set the clock period 10 MHz
    > Make sure the names of the clk ports match the constraints and the top.v

11. Generate the bitstream by clicking on the `Generate Bitstream` button in the Flow Navigator.
    This will take a while, so be patient.
12. Program the FPGA with the Hardware Manager.
13. Now the heartbeat LED (LED0) should blink.
14. Program the emulated FPGA fabric with the `upload_bitstream/board.py` script.

## Programming the emulated FPGA fabric

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

led\[0\] should always blink, indicating that the upload was successful.
led\[1\] should blink when the upload of the bitstream is in progress.

The sequential_16bit_en is a counter example that is mapped to led\[7:2\] of the
nexys-video board. They have an enable and a reset, mapped to the dip switches sw\[1:0\]
of the board. To enable the counter set sw\[1\] and for reset set sw\[0\].
sw\[2\] is a global reset.
Check the constraints file `constraints/Nexys_Video_Master.xdc` for more information on the pin mappings
and the `top.v` for more details on the design.

Read the `README.md` in the `upload_bitstream` directory for more information on how to use the script.

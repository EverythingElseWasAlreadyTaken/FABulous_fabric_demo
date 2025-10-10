# FABulous fabric demo

This repository contains some simple FABulous demo fabrics.

Take a look at the [FABulous documentation](https://fabulous.readthedocs.io/en/fabulous2.0-development/) to find out more about the FABulus framework.

## Folder structure

- **FABulous_fabric_demo**
  - **FABulous** - Git submodule with the used version of the FABulous framework
  - **fabric_10x10** - FABulous project, containing the generated FPGA fabric and a demo user design
    - 10x10 Tiles
    - 56 LUT4AB tiles(8 LUT4 each) = 448 LUT4
    - 8 register file tiles
    - 8 W_IO tiles on the WEST side of the fabric (2 I/O for tri-state output + 8 config_access bits each)
    - See [fabric_10x10/fabric.csv](fabric_10x10/farbic.csv) for more details on fabric tiles.
  - **fabric_32x11** - FABulous project, containing the generated FPGA fabric and a demo user design
    - 32x11 Tiles
    - 252 LUT4AB tiles(8 LUT4 each) = 2016 LUT4
    - 18 register file tiles
    - 28 N_IO tiles (1 INPUT and 1 OUTPUT each)
    - See [fabric_32x11/fabric.csv](fabric_32x10/farbic.csv) for more details on fabric tiles.

  - **vivado_emulation** - emulation setup for the FABulous fabric on a Digilent Nexys Video board
    - Based on fabric_10x10

## Setup

The fabric was generated using the latest version of FABulous, which is added
as git submodule.

To clone the repository with the FABulous submodule, use:

```bash
git clone https://github.com/EverythingElseWasAlreadyTaken/FABulous_fabric_demo.git --recurse-submodules
```

Follow the [FABulous Quick Start Guide](https://fabulous.readthedocs.io/en/fabulous2.0-development/Usage.html) to set up FABulous.

## Emulation

We have also emulated the fabric on a Digilent Nexys Video board.
For more information on the emulation, see [vivado_emulation/README.md](/vivado_emulation/README.md).

# FABulous fabric demo

This is a simple FABulous fabric demo of a 10x10 fabric.
It contains 56 LUT4AB tiles with 8 LUT4s each, 8 register file tiles and 8 W_IO tiles with
2 I/O for tri-state output each and 8 config_access bits each.

See [fabric/fabric.csv](fabric/fabric.csv) for more details on fabric tiles.

Take a look at the [FABulous documentation](https://fabulous.readthedocs.io/en/fabulous2.0-development/) to find out more about the FABulus framework.

## Folder structure

- **FABulous_demo_diff**
  - **FABulous** - Git submodule with the used version of the FABulous framework
  - **fabric** - FABulous project, containing the generated FPGA farbic and a demo user design
  - **vivado_emulation** - emulation setup for the FABulous fabric on a Digilent Nexys Video board

## Setup

The fabric was generated using the latest version of FABulous, which is added
as git submodule.

To clone the repository with the FABulous submodule, use:

```bash
git clone https://github.com/EverythingElseWasAlreadyTaken/FABulous_demo_diff.git --recurse-submodules
```

Follow the [FABulous Quick Start Guide](https://fabulous.readthedocs.io/en/fabulous2.0-development/Usage.html) to set up FABulous.

## Emulation

We have also emulated the fabric on a Digilent Nexys Video board.
For more information on the emulation, see [vivado_emulation/README.md](/vivado_emulation/README.md).

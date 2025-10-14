# FABulous simulation

This assumes FABulous is installed properly and the default instructions were followed to build the default fabric.
FABulous provides a simulation environment to test the fabric and the bitstream generated for it.
For simple use cases, there is the `run_simulation command` in the FABulous shell.
For more complex use cases it can be useful to create an own flow, like the following example `make` based flow.

Please make sure to use recent versions of (Yosys)[https://github.com/YosysHQ/yosys], (nextpnr-generic)[https://github.com/YosysHQ/nextpnr] (_not_ the old FABulous nextpnr fork)
and (iverilog)[https://github.com/steveicarus/iverilog] or use the (OSS-CAD-Suite)[https://github.com/YosysHQ/oss-cad-suite-build] which provides nightly builds of the necessary dependencies.

Also, make sure you have the `make` package installed:

```
$ sudo apt-get install make
```

We provide two example designs here, the **Sequential 16-Bit Counter Test** and
the **RegFile 20 Test**:

---

# Sequential 16-Bit Counter Test - Quick Start Guide

## Overview

The `sequential_16bit_en` test is a simple test suite for a sequential 16-bit counter with an enable signal.
It verifies that the counter implemented in the fabric behaves identically to a golden reference model.

The simulation compares the outputs of the synthesized counter design, running on a
simulated FPGA fabric, against a simulation of the same counter design.

## Quick Start

### Run the Simulation

To run the complete test flow (synthesis, place and route, bitstream generation, and simulation), use the following command:

```bash
cd fabric_32x11/Test
make sim
```

**Time**: ~2-3 minutes

## What Does This Test Do?

The test verifies the functionality of a 16-bit counter with an enable signal:

1.  **Phase 1**: The fabric is configured with the bitstream for the counter design.
2.  **Phase 2**: The counter is enabled and reset.
3.  **Phase 3**: The counter is enabled and its output is monitored for 100 clock cycles.
4.  **Phase 4**: The output of the fabric is compared against a golden reference model of the counter.

## Additional Commands

### Build Only (No Simulation)

```bash
make build_test_design
```

### View Waveforms

```bash
make run_GTKWave
```

### Clean Build Artifacts

```bash
make clean
```

## Files

- **user_design/top_wrapper.v**: The top-level wrapper for the user design, replaces constraint file.
- **user_design/sequential_16bit_en.v**: The Verilog code for the 16-bit counter.
- **Test/sequential_16bit_en_tb.v**: The testbench that compares the fabric output with a golden model.
- **Test/Makefile**: The build system for running the test.

---

# RegFile 20 Test - Quick Start Guide

## Overview

The `regfile_test_20` is a parameterizable test suite for the
FABulous FPGA RegFile_32x4 primitives.
It can test anywhere from **1 to 20 RegFile instances** with configurable synthesis and simulation parameters.

## Quick Start

### Test with 4 RegFiles (Fast - Recommended for Development)

```bash
cd fabric_32x11/Test
make -f Makefile_regfile_20 sim NUM_REGFILES=4
```

**Time**: ~2-3 minutes
**Coverage**: 2 combinatorial + 2 registered RegFiles

### Test with 10 RegFiles (Medium Coverage)

```bash
make -f Makefile_regfile_20 sim NUM_REGFILES=10
```

**Time**: ~5-7 minutes
**Coverage**: 5 combinatorial + 5 registered RegFiles

### Test with 20 RegFiles (Full Coverage)

```bash
make -f Makefile_regfile_20 sim NUM_REGFILES=20
```

**Time**: ~10-15 minutes
**Coverage**: 10 combinatorial + 10 registered RegFiles (100%)

## What Does This Test Do?

The test verifies all aspects of the RegFile_32x4 primitive:

1. **Phase 1**: Reset all RegFiles
2. **Phase 2**: Write unique patterns to each RegFile
3. **Phase 3**: Read back from combinatorial RegFiles (0-cycle latency)
4. **Phase 4**: Read back from registered RegFiles (1-cycle latency)
5. **Phase 5**: Test simultaneous dual-port reads
6. **Phase 6**: Test write-read timing (immediate read after write)
7. **Phase 7**: Compare fabric output vs golden model

## Additional Commands

### Build Only (No Simulation)

```bash
make -f Makefile_regfile_20 build_test_design NUM_REGFILES=10
```

### View Waveforms

```bash
make -f Makefile_regfile_20 run_GTKWave
```

### Clean Build Artifacts

```bash
make -f Makefile_regfile_20 clean
```

## Files

- **user_design/regfile_test_20.v** - Parameterizable design with 1-20 RegFile instances
- **user_design/top_wrapper_regfile_20.v** - The top-level wrapper for the user design, replaces a constraint file
- **Test/regfile_test_20_tb.v** - Dynamic testbench with 7-phase verification
- **Test/Makefile_regfile_20** - Build system with parameter support

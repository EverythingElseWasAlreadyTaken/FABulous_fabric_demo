# Software

The main functionality of `board.py` is uploading a bitstream over UART to the
board. It was created using `argparse`, so for a full breakdown of the commands
simply use

```console
./board.py -h
```

This is the general usage of the command:

```console
board.py [-h] [-i DEVICE_ID] [-v] upload ...
```

Below, the main use cases are given as examples. By default, devices with the VID
`0403` and PID `6014` and a baud rate of 57600 are used.

> [!IMPORTANT]:
> Make sure to adjust the files to your local files.

### Main use cases

Uploading a bitstream:

```console
./board.py upload bitstream.bin
```

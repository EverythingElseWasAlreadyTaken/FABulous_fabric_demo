#!/usr/bin/env python3

import argparse
import sys

from loguru import logger
from modules.ftdi_access import (
    DEFAULT_FTDI_ID,
    MultipleDevicesError,
    NoDeviceFoundError,
)
from pyftdi.i2c import I2cController
from modules.upload_bitstream import upload_bitstream


class Commands:
    UPLOAD_COMMAND = "upload"


def setup_logger(verbosity: int):
    # Remove the default logger to avoid duplicate logs
    logger.remove()
    logger.level("INFO", color="<green>")

    # Define logger format
    if verbosity >= 1:
        log_format = (
            "[<level>{level:}</level>]: "
            "<cyan>[{time:DD-MM-YYYY HH:mm:ss]}</cyan> | "
            "<green>[{name}</green>:<green>{function}</green>:<green>{line}]</green> - "
            "<level>{message}</level>"
        )
    else:
        log_format = "[<level>{level:}</level>]: " "<level>{message}</level>"

    # Add logger to write logs to stdout
    logger.add(sys.stdout, format=log_format, level="DEBUG", colorize=True)


def setup_parser() -> argparse.Namespace:
    """Set up the parser for the command line arguments

    :returns: The parsed arguments.
    :rtype: argsparse.Namespace
    """
    clock_command = "config_clocks"
    upload_command = "upload"
    supported_commands = [clock_command, upload_command]
    parser = argparse.ArgumentParser(description="FABulous board configuration")

    # Create subparsers for clock and upload
    subparsers = parser.add_subparsers(dest="command")

    # Define the clock arguments
    clock_parser = subparsers.add_parser(
        clock_command, help="Run the clock functionality."
    )
    clock_parser.add_argument(
        "register_config",
        type=str,
        help="Specifies the register config to be used.",
    )
    parser.add_argument(
        "-i",
        "--device_id",
        help=f"""Specify the ID of the FDTI board. Find it out using lsusb.
        Defaults to {DEFAULT_FTDI_ID}""",
        type=str,
        default=DEFAULT_FTDI_ID,
    )
    parser.add_argument(
        "-v",
        "--verbose",
        default=False,
        action="count",
        help="Show detailed log information including function and line number",
    )

    # Define the upload arguments
    upload_parser = subparsers.add_parser(
        upload_command, help="Run the upload functionality."
    )
    upload_parser.add_argument(
        "bitstream_file",
        type=str,
        help="Specifies the bitstream file to be uploaded.",
    )
    upload_parser.add_argument(
        "-b",
        "--baudrate",
        help="Specifies the baudrate. Defaults to 57600 which is the eFPGAs baud rate at 10 MHz.",
        type=int,
        default=57600,
    )

    # Parse the arguments
    args = parser.parse_args()

    # Check the command line parameters
    if args.command not in supported_commands:
        parser.print_help()
        exit(1)

    return args


def main():
    """The main function containing the application logic."""
    args = setup_parser()
    i2c = I2cController()
    setup_logger(args.verbose)

    try:
        match args.command:
            case Commands.UPLOAD_COMMAND:
                upload_bitstream(args.bitstream_file, args.baudrate, args.device_id)

            case _:
                # Should already be handled by argparse
                logger.error(f"Command {args.command} is unknown")

    except KeyboardInterrupt:
        logger.info("Exiting...")
        # Just catch all known errors and exit
    except (
        OnlyLinuxSupportedError,
        OutDatedLinuxKernelVersionError,
        ProgramNotInstalledError,
        FileNotFoundError,
        CrystalError,
        MultipleDevicesError,
        NoDeviceFoundError,
    ):
        exit(1)


if __name__ == "__main__":

    main()

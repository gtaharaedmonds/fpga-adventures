#!/usr/bin/env python3
"""
Intel HEX to COE Converter

This script converts Intel HEX files to Xilinx COE (Coefficient) files for use in Vivado.
Usage: python hex2coe.py input.hex output.coe [options]

Options:
  --memory-width=N    Width of each memory word in bits (default: 8)
  --radix=N           Radix for output values: 2 (binary), 10 (decimal), 16 (hex) (default: 16)
  --depth=N           Memory depth (number of words, default: auto-calculate)
"""

import sys
import argparse
from intelhex import IntelHex


def hex_to_coe(hex_file, coe_file, memory_width=8, radix=16, depth=None):
    """
    Convert an Intel HEX file to a Xilinx COE file.

    Args:
        hex_file: Path to input Intel HEX file
        coe_file: Path to output COE file
        memory_width: Width of each memory word in bits (8, 16, 32, etc.)
        radix: Radix for output values (2=binary, 10=decimal, 16=hex)
        depth: Memory depth (number of words, default: auto-calculate)
    """
    # Load the Intel HEX file
    ih = IntelHex()
    ih.loadhex(hex_file)

    # Get min/max address
    min_addr = ih.minaddr()
    max_addr = ih.maxaddr()

    # Calculate bytes per word
    bytes_per_word = memory_width // 8
    if memory_width % 8 != 0:
        bytes_per_word += 1
        print(
            f"Warning: Memory width {memory_width} is not a multiple of 8. Using {bytes_per_word} bytes per word."
        )

    # Calculate adjusted address range to align with word boundaries
    aligned_min_addr = (min_addr // bytes_per_word) * bytes_per_word
    aligned_max_addr = ((max_addr // bytes_per_word) + 1) * bytes_per_word - 1

    # Calculate depth if not provided
    if depth is None:
        depth = (aligned_max_addr - aligned_min_addr + 1) // bytes_per_word

    # Create format strings based on radix
    if radix == 2:  # Binary
        format_str = "{:0" + str(memory_width) + "b}"
        radix_name = "BIN"
    elif radix == 10:  # Decimal
        format_str = "{}"
        radix_name = "DEC"
    else:  # Hexadecimal (default)
        hex_digits = memory_width // 4
        if memory_width % 4 != 0:
            hex_digits += 1
        format_str = "{:0" + str(hex_digits) + "x}"
        radix_name = "HEX"

    # Write the COE file
    with open(coe_file, "w") as f:
        # Write the COE header
        f.write(f"memory_initialization_radix={radix};\n")
        f.write(f"memory_initialization_vector=\n")

        # Process the data in word-sized chunks
        count = 0
        for addr in range(aligned_min_addr, aligned_max_addr + 1, bytes_per_word):
            word_value = 0
            for offset in range(bytes_per_word):
                byte_addr = addr + offset
                if byte_addr <= max_addr and byte_addr >= min_addr:
                    # Get the byte value, shift it to its position in the word
                    byte_val = ih[byte_addr]
                    word_value |= byte_val << (8 * (bytes_per_word - offset - 1))

            # Format according to the specified radix
            if radix == 10:
                value_str = format_str.format(word_value)
            elif radix == 2:
                value_str = format_str.format(word_value)
            else:  # Hex
                value_str = format_str.format(word_value)

            # Add a comma after each entry except the last one
            count += 1
            if count < depth:
                f.write(value_str + ",\n")
            else:
                f.write(value_str + ";")
                break

    print(f"Converted {hex_file} to {coe_file}")
    print(f"Memory width: {memory_width} bits")
    print(f"Memory depth: {count} words")
    print(f"Radix: {radix_name}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Convert Intel HEX file to Xilinx COE file"
    )
    parser.add_argument("input", help="Input HEX file")
    parser.add_argument("output", help="Output COE file")
    parser.add_argument(
        "--memory-width", type=int, default=8, help="Memory width in bits (default: 8)"
    )
    parser.add_argument(
        "--radix",
        type=int,
        choices=[2, 10, 16],
        default=16,
        help="Radix for output: 2 (binary), 10 (decimal), 16 (hex) (default: 16)",
    )
    parser.add_argument(
        "--depth", type=int, help="Memory depth (default: auto-calculate)"
    )

    args = parser.parse_args()

    hex_to_coe(args.input, args.output, args.memory_width, args.radix, args.depth)

#!/usr/bin/env python3
"""
Creating Ethernet frames with manually calculated FCS (Frame Check Sequence)
"""

from scapy.all import *
import struct
import binascii
import zlib


def calculate_ethernet_crc32(data):
    """Calculate CRC32 checksum (FCS) for Ethernet frame using the correct polynomial"""
    # The Ethernet FCS is a 32-bit CRC with the standard polynomial
    # Initialize with all 1's (0xFFFFFFFF)
    crc = 0xFFFFFFFF

    for b in data:
        crc ^= b
        for _ in range(8):
            crc = (crc >> 1) ^ (0xEDB88320 if crc & 1 else 0)

    # Final XOR with all 1's
    crc ^= 0xFFFFFFFF

    # Return as bytes in little-endian (Ethernet standard)
    return struct.pack("<I", crc)


def create_ethernet_with_fcs():
    # Create the payload data
    data = Raw(load=bytes(i for i in range(0, 100)))

    # Create the Ethernet frame without FCS
    ethernet_frame = Ether(
        src="00:0a:35:01:02:03", dst="FF:FF:FF:FF:FF:FF", type=len(data)
    )

    # Get the raw bytes that will actually be transmitted
    # This extracts just the necessary frame data without Scapy metadata
    frame_bytes = bytes(ethernet_frame)
    payload_bytes = bytes(data)
    wire_bytes = frame_bytes + payload_bytes

    print(f"Frame bytes for CRC calculation: {len(wire_bytes)} bytes")

    # Calculate the CRC32 checksum
    fcs = calculate_ethernet_crc32(wire_bytes)

    # Create the final frame with FCS added
    final_frame = ethernet_frame / data / Raw(load=fcs)

    print("Ethernet frame with FCS:")
    hexdump(final_frame)
    print(f"Frame length: {len(final_frame)} bytes")
    print(f"FCS value: 0x{binascii.hexlify(fcs).decode()}")


create_ethernet_with_fcs()

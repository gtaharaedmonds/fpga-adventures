# First, install Scapy if you haven't already:
# pip install scapy

from scapy.all import *


def create_custom_protocol_frame():
    # Create an Ethernet frame with a custom payload
    data = Raw(load=b"\x01\x02\x03\x04\x05\x06\x07\x08")
    custom_frame = (
        Ether(src="00:0a:35:01:02:03", dst="00:0a:35:01:02:03", type=len(data)) / data
    )
    print("Custom protocol frame:")
    custom_frame.show()
    hexdump(custom_frame)

    # To send this custom frame
    # sendp(custom_frame, iface="eth0")  # Uncomment and change interface name as needed

    # Create frames with specific lengths
    print("\nCreating frames with specific lengths:")

    # 64 bytes (minimum Ethernet frame size)
    # Note: 14 bytes Ethernet header + 46 bytes minimum payload + 4 bytes FCS (added automatically)
    min_frame = Ether(type=0x0800) / Raw(load=b"\x00" * 46)
    print(f"Minimum frame length: {len(min_frame)} bytes (+ 4 bytes FCS)")

    # 100 bytes frame
    # 14 bytes Ethernet header + 86 bytes payload
    medium_frame = Ether(type=0x0800) / Raw(load=b"\x00" * 86)
    print(f"Medium frame length: {len(medium_frame)} bytes")

    # 1500 bytes frame (typical MTU)
    # 14 bytes Ethernet header + 1486 bytes payload
    mtu_frame = Ether(type=0x0800) / Raw(load=b"\x00" * 1486)
    print(f"MTU frame length: {len(mtu_frame)} bytes")

    # 9000 bytes frame (jumbo frame)
    # 14 bytes Ethernet header + 8986 bytes payload
    jumbo_frame = Ether(type=0x0800) / Raw(load=b"\x00" * 8986)
    print(f"Jumbo frame length: {len(jumbo_frame)} bytes")

    # Creating a frame with custom pattern and specific length
    # For example, a 200-byte frame with incrementing bytes
    pattern = bytes([i % 256 for i in range(186)])  # 14 + 186 = 200 bytes
    pattern_frame = Ether(type=0x0800) / Raw(load=pattern)
    print(f"Pattern frame length: {len(pattern_frame)} bytes")

    # To send any of these frames:
    # sendp(min_frame, iface="eth0")
    # sendp(medium_frame, iface="eth0")
    # sendp(mtu_frame, iface="eth0")
    # sendp(jumbo_frame, iface="eth0")  # Note: Requires jumbo frame support on your network
    # sendp(pattern_frame, iface="eth0")


create_custom_protocol_frame()

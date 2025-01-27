load("@rules_hdl//verilog:defs.bzl", "verilog_library")
load(
    "@rules_hdl//vivado:defs.bzl",
    "vivado_create_project",
    "vivado_flow",
)

verilog_library(
    name = "vga",
    srcs = [
        "vga.sv",
    ],
)

verilog_library(
    name = "vga_top",
    srcs = [
        "vga_top.sv",
    ],
    data = [
        "constraints.xdc",
    ],
    deps = [
        ":vga",
    ],
)

vivado_flow(
    name = "vga_vivado",
    module = ":vga_top",
    module_top = "vga_top",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

vivado_create_project(
    name = "vga_project",
    module = ":vga_top",
    module_top = "vga_top",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

load("@rules_hdl//verilog:defs.bzl", "verilog_library")
load(
    "@rules_hdl//vivado:defs.bzl",
    "vivado_create_project",
    "vivado_flow",
)

verilog_library(
    name = "clock_div",
    srcs = [
        "clock_div.sv",
    ],
)

verilog_library(
    name = "nexys_7seg",
    srcs = [
        "nexys_7seg.sv",
    ],
)

verilog_library(
    name = "nexys_7seg_top",
    srcs = [
        "nexys_7seg_top.sv",
    ],
    data = [
        "constraints.xdc",
    ],
    deps = [
        ":clock_div",
        ":nexys_7seg",
    ],
)

vivado_flow(
    name = "nexys_7seg_vivado",
    module = ":nexys_7seg_top",
    module_top = "nexys_7seg_top",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

# vivado_create_project(
#     name = "vga_project",
#     module = ":vga_top",
#     module_top = "vga_top",
#     part_number = "xc7a100tcsg324-1",
#     tags = ["manual"],
#     xilinx_env = "//:xilinx_env.sh",
# )

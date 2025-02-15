load("@rules_hdl//verilog:defs.bzl", "verilog_library")
load(
    "@rules_hdl//vivado:defs.bzl",
    "vivado_create_project",
    "vivado_flow",
)

verilog_library(
    name = "bram",
    srcs = [],
    data = [
        "bram.tcl",
    ],
)

verilog_library(
    name = "init_status",
    srcs = [
        ":init_status.sv",
    ],
)

verilog_library(
    name = "init_status_tb",
    srcs = [
        "init_status_tb.sv",
    ],
    deps = [
        ":bram",
        ":init_status",
    ],
)

vivado_create_project(
    name = "init_status_project",
    module = ":init_status_tb",
    module_top = "init_status_tb",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

verilog_library(
    name = "ksa",
    srcs = [
        ":ksa.sv",
    ],
)

verilog_library(
    name = "ksa_tb",
    srcs = [
        "ksa_tb.sv",
    ],
    deps = [
        ":bram",
        ":ksa",
    ],
)

vivado_create_project(
    name = "ksa_project",
    module = ":ksa_tb",
    module_top = "ksa_tb",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

verilog_library(
    name = "decrypt",
    srcs = [
        "decrypt.sv",
    ],
    data = [
        ":constraints.xdc",
    ],
    deps = [
        ":bram",
        ":init_status",
        ":ksa",
        "//shared:hex_7seg",
        "//shared:nexys_7segs",
    ],
)

vivado_flow(
    name = "decrypt_vivado",
    module = ":decrypt",
    module_top = "decrypt",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

verilog_library(
    name = "decrypt_tb",
    srcs = [
        "decrypt_tb.sv",
    ],
    deps = [
        ":decrypt",
    ],
)

vivado_create_project(
    name = "decrypt_project",
    module = ":decrypt_tb",
    module_top = "decrypt_tb",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

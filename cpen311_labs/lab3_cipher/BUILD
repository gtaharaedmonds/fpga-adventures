load("@rules_hdl//verilog:defs.bzl", "verilog_library")
load(
    "@rules_hdl//vivado:defs.bzl",
    "vivado_flow",
    "xsim_test",
)

verilog_library(
    name = "bram",
    srcs = [],
    data = [
        "bram.tcl",
    ],
)

verilog_library(
    name = "init",
    srcs = [
        "init.sv",
    ],
)

verilog_library(
    name = "init_tb",
    srcs = [
        "init_tb.sv",
    ],
    deps = [
        ":bram",
        ":init",
    ],
)

xsim_test(
    name = "init_test",
    module = ":init_tb",
    module_top = "init_tb",
    part_number = "xc7a100tcsg324-1",
    with_waveform = True,
    xilinx_env = "//3rdparty:xilinx_env.sh",
)

verilog_library(
    name = "ksa",
    srcs = [
        "ksa.sv",
    ],
)

verilog_library(
    name = "ksa_tb",
    srcs = [
        "ksa_tb.sv",
    ],
    data = [
        "ksa_expected.data",
    ],
    deps = [
        ":bram",
        ":ksa",
    ],
)

xsim_test(
    name = "ksa_test",
    module = ":ksa_tb",
    module_top = "ksa_tb",
    part_number = "xc7a100tcsg324-1",
    with_waveform = True,
    xilinx_env = "//3rdparty:xilinx_env.sh",
)

verilog_library(
    name = "prga",
    srcs = [
        "prga.sv",
    ],
)

verilog_library(
    name = "ct_rom",
    srcs = [],
    data = [
        "ct.coe",
        "ct_rom.tcl",
    ],
)

verilog_library(
    name = "decrypt",
    srcs = [
        "decrypt.sv",
    ],
    deps = [
        ":init",
        ":ksa",
        ":prga",
    ],
)

verilog_library(
    name = "decrypt_top",
    srcs = [
        "decrypt_top.sv",
    ],
    data = [
        ":constraints.xdc",
    ],
    deps = [
        ":bram",
        ":ct_rom",
        ":decrypt",
        "//shared:hex_7seg",
        "//shared:nexys_7segs",
    ],
)

vivado_flow(
    name = "decrypt_vivado",
    module = ":decrypt_top",
    module_top = "decrypt_top",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//3rdparty:xilinx_env.sh",
)

verilog_library(
    name = "decrypt_tb",
    srcs = [
        "decrypt_tb.sv",
    ],
    data = [
        ":pt.data",
    ],
    deps = [
        ":bram",
        ":ct_rom",
        ":decrypt",
    ],
)

xsim_test(
    name = "decrypt_test",
    module = ":decrypt_tb",
    module_top = "decrypt_tb",
    part_number = "xc7a100tcsg324-1",
    with_waveform = True,
    xilinx_env = "//3rdparty:xilinx_env.sh",
)

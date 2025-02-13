load("@rules_hdl//verilog:defs.bzl", "verilog_library")
load(
    "@rules_hdl//vivado:defs.bzl",
    "vivado_flow",
)

verilog_library(
    name = "baccarat",
    srcs = [
        "baccarat.sv",
        "card_7seg.sv",
        "datapath.sv",
        "random_card.sv",
        "score_hand.sv",
        "state_machine.sv",
    ],
    data = [
        "constraints.xdc",
    ],
    deps = [
        "//lib:hex_7seg",
        "//lib:nexys_7segs",
    ],
)

vivado_flow(
    name = "baccarat_vivado",
    module = ":baccarat",
    module_top = "baccarat",
    part_number = "xc7a100tcsg324-1",
    tags = ["manual"],
    xilinx_env = "//:xilinx_env.sh",
)

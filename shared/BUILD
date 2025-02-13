load("@rules_hdl//verilog:defs.bzl", "verilog_library")

package(default_visibility = ["//visibility:public"])

verilog_library(
    name = "clk_div",
    srcs = [
        "clk_div.sv",
    ],
)

verilog_library(
    name = "hex_7seg",
    srcs = [
        "hex_7seg.sv",
    ],
)

verilog_library(
    name = "nexys_7segs",
    srcs = [
        "nexys_7segs.sv",
    ],
    deps = [
        ":clk_div",
    ],
)

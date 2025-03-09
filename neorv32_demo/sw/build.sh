cargo build --release

mkdir -p build
cargo objcopy --release --bin neorv32_demo -- -O binary build/neorv32_demo.bin
~/src/fpga-adventures/shared/sw/neorv32_image_gen -app_bin build/neorv32_demo.bin ~/bin/neorv32_exe.bin

# cargo objcopy --release --bin neorv32_demo -- -O ihex neorv32_demo.hex
# cargo objdump --release --bin neorv32_demo -- -d > neorv32_demo.asm
# python3 hex_to_coe.py --radix 16 neorv32_demo.hex neorv32_demo.coe
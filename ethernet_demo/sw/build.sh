cargo build --release

cargo objcopy --release --bin ethernet_demo -- -O binary target/ethernet_demo.bin
../../shared/sw/neorv32_image_gen -app_bin target/ethernet_demo.bin ~/bin/neorv32_exe.bin

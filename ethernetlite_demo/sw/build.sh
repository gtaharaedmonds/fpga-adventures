cargo build --release

cargo objcopy --release --bin ethernetlite_demo -- -O binary ../../target/ethernetlite_demo.bin
../../shared/scripts/neorv32_image_gen -app_bin ../../target/ethernetlite_demo.bin ~/bin/neorv32_exe.bin

cargo objdump --release --bin ethernetlite_demo -- -d > ../../ethernetlite_demo_4u8.asm

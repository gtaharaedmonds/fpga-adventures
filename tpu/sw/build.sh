cargo build --release

cargo objcopy --release --bin tpu -- -O binary ../../target/tpu.bin
../../shared/scripts/neorv32_image_gen -app_bin ../../target/tpu.bin ~/bin/neorv32_exe.bin

# cargo objdump --release --bin tpu -- -d > ../../tpu.asm

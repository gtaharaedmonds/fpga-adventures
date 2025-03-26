VERILATOR = verilator
VERILATOR_FLAGS = --assert --trace -cc --exe --build

Vmmu_2x2: obj_dir/Vmmu_2x2
Vmmu_8x8: obj_dir/Vmmu_8x8

obj_dir/Vmmu_2x2: tile_fifo.sv mac.sv mmu.sv mmu_2x2.sv mmu_2x2_test.cpp
	$(VERILATOR) $(VERILATOR_FLAGS) --top-module mmu_2x2 tile_fifo.sv mac.sv mmu.sv mmu_2x2.sv mmu_2x2_test.cpp

obj_dir/Vmmu_8x8: tile_fifo.sv mac.sv mmu.sv mmu_8x8.sv mmu_8x8_test.cpp
	$(VERILATOR) $(VERILATOR_FLAGS) --top-module mmu_8x8 tile_fifo.sv mac.sv mmu.sv mmu_8x8.sv mmu_8x8_test.cpp

clean:
	rm -rf obj_dir

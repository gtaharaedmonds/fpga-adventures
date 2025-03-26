VERILATOR = verilator
VERILATOR_FLAGS = --assert --trace -cc --exe --build -j 8 -O0

Vmmu_2x2: obj_dir/Vmmu_2x2
Vmmu_64x64: obj_dir/Vmmu_64x64

obj_dir/Vmmu_2x2: tile_fifo.sv mac.sv mmu.sv mmu_2x2.sv mmu_2x2_test.cpp mmu.hpp
	$(VERILATOR) $(VERILATOR_FLAGS) --top-module mmu_2x2 tile_fifo.sv mac.sv mmu.sv mmu_2x2.sv mmu_2x2_test.cpp

obj_dir/Vmmu_64x64: tile_fifo.sv mac.sv mmu.sv mmu_64x64.sv mmu_64x64_test.cpp mmu.hpp
	$(VERILATOR) $(VERILATOR_FLAGS) --top-module mmu_64x64 tile_fifo.sv mac.sv mmu.sv mmu_64x64.sv mmu_64x64_test.cpp

clean:
	rm -rf obj_dir

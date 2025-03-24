VERILATOR = verilator
VERILATOR_FLAGS = --assert --trace -cc --exe --build -j

TARGET = obj_dir/Vmmu

all: $(TARGET)

$(TARGET): mmu.sv mac.sv mac_pkg.sv mmu_tb.cpp
	$(VERILATOR) $(VERILATOR_FLAGS) --top-module mmu mac_pkg.sv mac.sv mmu.sv mmu_tb.cpp

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf obj_dir

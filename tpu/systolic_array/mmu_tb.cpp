#include "Vmmu.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>
#include <iomanip>

#define SIZE 2

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    // Create trace file.
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    uint8_t weights[2][2] = {
      {1, 2}, {3, 4}
    };
    
    uint8_t activations[2][2] = {
      {1, 1}, {1, 1}
    };

    Vmmu* mmu = new Vmmu;
    mmu->trace(tfp, 99);  // Trace 99 levels of hierarchy
    tfp->open("mmu.vcd");  // Open the trace file
    int t = 0;

    mmu->rst_n = false;
    mmu->clk = 0;
    mmu->ctrl = 0;
    mmu->data_in[0] = 0;
    mmu->data_in[1] = 0;
    
    for(int i = 0; i < 2; i++) {
      std::cout << "Acc out initially: "  << mmu->acc_out[i] << std::endl;
    }

    // Reset.
    mmu->rst_n = false;
    mmu->eval();
    tfp->dump(t += 10);
    mmu->rst_n = true;
    mmu->eval();
    tfp->dump(t += 10);

    // Clear accumulators.
    mmu->ctrl = 0;
    mmu->clk = 0;
    mmu->eval();
    tfp->dump(t += 10);
    mmu->clk = 1;
    mmu->eval();
    tfp->dump(t += 10);

    // Load weights.
    mmu->ctrl = 2;
    mmu->clk = 0;
    mmu->eval();
    mmu->clk = 1;
    mmu->eval();

    for(int col = 0; col < SIZE; col++) {
      for(int row = 0; row < SIZE; row++) {
        mmu->data_in[row] = weights[row][SIZE - col - 1]; 
      }

      mmu->clk = 0;
      mmu->eval();
      tfp->dump(t += 10);
      mmu->clk = 1;
      mmu->eval();
      tfp->dump(t += 10);

    }

    // Clear accumulators.
    mmu->ctrl = 0;
    mmu->clk = 0;
    mmu->eval();
    tfp->dump(t += 10);
    mmu->clk = 1;
    mmu->eval();
    tfp->dump(t += 10);

    // Start MMU.
    mmu->ctrl = 1;
    
    for(int i = 0; i < 20; i++) {
      mmu->data_in[0] = 0;
      mmu->data_in[1] = 5;

      mmu->clk = 0;
      mmu->eval();
      tfp->dump(t += 10);
      mmu->clk = 1;
      mmu->eval();
      tfp->dump(t += 10);

      std::cout << "Acc out now 0: "  << mmu->acc_out[0] << std::endl;
      std::cout << "Acc out now 1: "  << mmu->acc_out[1] << std::endl;
    }

    // for (int i = 0; i < 20; i++) {
    //     mmu->clk = 0;
    //     mmu->eval();
    //     mmu->clk = 1;
    //     mmu->eval();

    //     // Reset for the first 2 cycles
    //     mmu->rst_n = (i >= 2);
        
    //     // Enable counting after reset
    //     // mmu->enable = (i >= 2);
        
    //     // Print current values
    //     std::cout << "Cycle " << std::setw(2) << i 
    //             //   << ": count = " << std::setw(3) << (int)mmu->count
    //               << ", rst_n = " << mmu->rst_n << ", "
    //             //   << ", enable = " << mmu->enable
    //               << std::endl;
    // }
    

    // Cleanup.
    tfp->close();
    delete tfp;
    delete mmu;
    
    return 0;
}
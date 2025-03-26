#include "Vmmu_2x2.h"
#include "verilated.h"
#include <cassert>
#include <iostream>
#include <stdbool.h>
#include <stdint.h>

#define TICK(top)                                                              \
  top->clk = 0;                                                                \
  top->eval();                                                                 \
  top->clk = 1;                                                                \
  top->eval();

#define WAIT(top, condition)                                                   \
  while (!(condition)) {                                                       \
    top->clk = 0;                                                              \
    top->eval();                                                               \
    top->clk = 1;                                                              \
    top->eval();                                                               \
  }                                                                            \
  TICK(top); // Do one tick after waiting

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  uint8_t weight[2][2] = {{1, 2}, {3, 4}};
  uint8_t data[2][2] = {{5, 6}, {7, 8}};
  uint8_t expected[2][2] = {{19, 22}, {43, 50}};

  Vmmu_2x2 *top = new Vmmu_2x2;

  top->rst_n = false;
  top->clk = false;
  top->new_weight_push = false;
  top->data_in_push = false;
  top->acc_out_pop = false;
  top->weight_swap = false;
  top->mult_start = false;

  // Reset.
  top->rst_n = false;
  TICK(top);
  top->rst_n = true;
  TICK(top);

  // Enqueue new weight.
  for (int row = 0; row < 2; row++) {
    for (int col = 0; col < 2; col++) {
      top->new_weight_in[row][col] = weight[row][col];
    }
  }

  assert(top->new_weight_rdy);
  top->new_weight_push = true;
  TICK(top);
  top->new_weight_push = false;
  TICK(top);

  // Load weights.
  assert(top->weight_ld_rdy && !top->weight_ld_done);
  top->weight_ld_start = true;
  TICK(top);
  top->weight_ld_start = false;
  WAIT(top, top->weight_ld_done)

  // Swap weights.
  top->weight_swap = true;
  TICK(top);
  top->weight_swap = false;
  TICK(top);

  // Enqueue data.
  for (int row = 0; row < 2; row++) {
    for (int col = 0; col < 2; col++) {
      top->data_in[row][col] = data[row][col];
    }
  }

  assert(top->data_in_rdy);
  top->data_in_push = true;
  TICK(top);
  top->data_in_push = false;
  TICK(top);

  // Run multiplication.
  assert(top->mult_rdy && !top->mult_done);
  top->mult_start = true;
  TICK(top);
  top->mult_start = false;
  WAIT(top, top->mult_done)

  // Pop result.
  assert(top->acc_out_rdy);
  top->acc_out_pop = true;
  TICK(top);
  top->acc_out_pop = false;
  TICK(top);

  for (int row = 0; row < 2; row++) {
    for (int col = 0; col < 2; col++) {
      assert(top->acc_out[row][col] == expected[row][col]);
    }
  }

  std::cout << "Test passed successfully!" << std::endl;

  // Cleanup.
  delete top;

  return 0;
}
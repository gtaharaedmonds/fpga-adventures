#include "Vmmu_8x8.h"
#include "verilated.h"
#include <array>
#include <cassert>
#include <iostream>
#include <stdbool.h>
#include <stdint.h>

#define SIZE 8
typedef std::array<std::array<uint8_t, SIZE>, SIZE> mat_t;

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

static void test_mmu(mat_t weight, mat_t data, mat_t expected) {
  Vmmu_8x8 *top = new Vmmu_8x8;

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
  for (int row = 0; row < SIZE; row++) {
    for (int col = 0; col < SIZE; col++) {
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
  for (int row = 0; row < SIZE; row++) {
    for (int col = 0; col < SIZE; col++) {
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

  for (int row = 0; row < SIZE; row++) {
    for (int col = 0; col < SIZE; col++) {
      assert(top->acc_out[row][col] == expected[row][col]);
    }
  }

  // Cleanup.
  delete top;
}

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  mat_t weight = {0};
  mat_t data = {0};
  mat_t expected = {0};

  for (int row = 0; row < SIZE; row++) {
    for (int col = 0; col < SIZE; col++) {
      weight[row][col] = row == col ? 2 : 0;
      data[row][col] = row * SIZE + col;
      expected[row][col] = (row * SIZE + col) * 2;
    }
  }

  test_mmu(weight, data, expected);

  std::cout << "Test passed successfully!" << std::endl;

  return 0;
}
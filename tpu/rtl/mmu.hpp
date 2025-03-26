#include "verilated.h"
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <memory>
#include <stdbool.h>
#include <stdint.h>

template <typename T, int N> using Tile = std::array<std::array<T, N>, N>;

template <typename T, int N> class Mmu {
public:
  Mmu() {
    top = std::make_unique<T>();
    top->rst_n = false;
    top->clk = false;
    top->new_weight_push = false;
    top->data_in_push = false;
    top->acc_out_pop = false;
    top->weight_swap = false;
    top->mult_start = false;
  }

  void Tick() {
    top->clk = 0;
    top->eval();
    top->clk = 1;
    top->eval();
  }

  void Reset() {
    top->rst_n = false;
    Tick();
    top->rst_n = true;
  }

  void EnqueueWeights(Tile<uint8_t, N> weight) {
    assert(top->new_weight_rdy);

    for (int row = 0; row < N; row++) {
      for (int col = 0; col < N; col++) {
        top->new_weight_in[row][col] = weight[row][col];
      }
    }

    top->new_weight_push = true;
    Tick();
    top->new_weight_push = false;
  }

  void StartLoadWeights() {
    assert(top->weight_ld_rdy && !top->weight_ld_done);

    top->weight_ld_start = true;
    Tick();
    top->weight_ld_start = false;
  }

  void WaitLoadWeights() {
    while (!top->weight_ld_done) {
      top->clk = 0;
      top->eval();
      top->clk = 1;
      top->eval();
    }

    Tick(); // Do one tick after waiting
  }

  void SwapWeights() {
    top->weight_swap = true;
    Tick();
    top->weight_swap = false;
  }

  void EnqueueData(Tile<uint8_t, N> data) {
    assert(top->data_in_rdy);

    for (int row = 0; row < N; row++) {
      for (int col = 0; col < N; col++) {
        top->data_in[row][col] = data[row][col];
      }
    }

    top->data_in_push = true;
    Tick();
    top->data_in_push = false;
  }

  void StartMult() {
    assert(top->mult_rdy && !top->mult_done);

    top->mult_start = true;
    Tick();
    top->mult_start = false;
  }

  void WaitMult() {
    while (!top->mult_done) {
      top->clk = 0;
      top->eval();
      top->clk = 1;
      top->eval();
    }

    Tick(); // Do one tick after waiting
  }

  Tile<uint32_t, N> PopMult() {
    assert(top->acc_out_rdy);

    top->acc_out_pop = true;
    Tick();
    top->acc_out_pop = false;

    Tile<uint32_t, N> result;
    for (int row = 0; row < N; row++) {
      for (int col = 0; col < N; col++) {
        result[row][col] = top->acc_out[row][col];
      }
    }

    return result;
  }

private:
  std::unique_ptr<T> top;
};

#include "Vmmu_64x64.h"
#include "mmu.hpp"

static constexpr int N = 64;

static void test_mmu(Tile<uint8_t, N> weight, Tile<uint8_t, N> data,
                     Tile<uint32_t, N> expected) {
  Mmu<Vmmu_64x64, N> top;
  top.Reset();

  top.EnqueueWeights(weight);
  top.StartLoadWeights();
  top.WaitLoadWeights();
  top.SwapWeights();
  top.EnqueueData(data);
  top.StartMult();
  top.WaitMult();

  Tile<uint32_t, N> result = top.PopMult();
  for (int row = 0; row < N; row++) {
    for (int col = 0; col < N; col++) {
      assert(result[row][col] == expected[row][col]);
    }
  }
}

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  Tile<uint8_t, N> weight;
  Tile<uint8_t, N> data;
  Tile<uint32_t, N> expected;

  for (int row = 0; row < N; row++) {
    for (int col = 0; col < N; col++) {
      weight[row][col] = row == col ? 2 : 0;
      data[row][col] = row * N + col;
      expected[row][col] = ((row * N + col) % 256) * 2; // Only 8 bits per data
    }
  }

  test_mmu(weight, data, expected);

  std::cout << "Test passed successfully!" << std::endl;
  return 0;
}
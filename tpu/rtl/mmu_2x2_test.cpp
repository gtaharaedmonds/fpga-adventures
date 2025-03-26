#include "Vmmu_2x2.h"
#include "mmu.hpp"
#include <cassert>

static constexpr int N = 2;

static void test_mmu(Tile<uint8_t, N> weight, Tile<uint8_t, N> data,
                     Tile<uint32_t, N> expected) {
  Mmu<Vmmu_2x2, N> top;
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

static void test_mmu_multiple() {
  Tile<uint8_t, N> weight = {{{1, 2}, {3, 4}}};
  Tile<uint8_t, N> data[3] = {
      {{{5, 6}, {7, 8}}},
      {{{9, 10}, {11, 12}}},
      {{{0, 0}, {0, 0}}},
  };
  Tile<uint32_t, N> expected[3] = {
      {{{19, 22}, {43, 50}}},
      {{{31, 34}, {71, 78}}},
      {{{0, 0}, {0, 0}}},
  };

  Mmu<Vmmu_2x2, N> top;
  top.Reset();

  top.EnqueueWeights(weight);
  top.StartLoadWeights();
  top.WaitLoadWeights();
  top.SwapWeights();

  // Enqueue data. (x3)
  for (int i = 0; i < 3; i++) {
    top.EnqueueData(data[i]);
  }

  // Run multiplication. (x3)
  for (int i = 0; i < 3; i++) {
    top.StartMult();
    top.WaitMult();
  }

  // Pop results. (x3)
  for (int i = 0; i < 3; i++) {
    Tile<uint32_t, N> result = top.PopMult();

    for (int row = 0; row < N; row++) {
      for (int col = 0; col < N; col++) {
        assert(result[row][col] == expected[i][row][col]);
      }
    }
  }
}

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  test_mmu({{{0, 0}, {0, 0}}}, {{{0, 0}, {0, 0}}}, {{{0, 0}, {0, 0}}});
  test_mmu({{{1, 0}, {0, 0}}}, {{{1, 2}, {3, 4}}}, {{{1, 2}, {0, 0}}});
  test_mmu({{{1, 0}, {0, 1}}}, {{{1, 2}, {3, 4}}}, {{{1, 2}, {3, 4}}});
  test_mmu({{{1, 2}, {3, 4}}}, {{{1, 0}, {0, 1}}}, {{{1, 2}, {3, 4}}});
  test_mmu({{{1, 2}, {3, 4}}}, {{{5, 6}, {7, 8}}}, {{{19, 22}, {43, 50}}});
  test_mmu_multiple();

  std::cout << "Test passed successfully!" << std::endl;

  return 0;
}
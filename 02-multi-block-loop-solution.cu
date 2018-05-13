#include <stdio.h>

__global__ void loop()
{
  /*
   * This idiomatic expression gives each thread
   * a unique index within the entire grid.
   */

  int i = blockIdx.x * blockDim.x + threadIdx.x;
  printf("%d\n", i);
}

int main()
{
  /*
   * Additional execution configurations that would
   * work and meet the exercises contraints are:
   *
   * <<<5, 2>>>
   * <<<10, 1>>>
   */

  loop<<<2, 5>>>();
  cudaDeviceSynchronize();
}

#include <stdio.h>


/*
 * Notice the absence of the previously expected argument `N`.
 */

__global__ void loop()
{
  /*
   * This kernel does the work of only 1 iteration
   * of the original for loop. Indication of which
   * "iteration" is being executed by this kernel is
   * still available via `threadIdx.x`.
   */

  printf("This is iteration number %d\n", threadIdx.x);
}

int main()
{
  /*
   * It is the execution context that sets how many "iterations"
   * of the "loop" will be done.
   */

  loop<<<1, 10>>>();
  cudaDeviceSynchronize();
}

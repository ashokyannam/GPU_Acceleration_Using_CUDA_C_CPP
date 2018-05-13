#include <stdio.h>

__global__ void printSuccessForCorrectExecutionConfiguration()
{

  if(threadIdx.x == 1023 && blockIdx.x == 255)
  {
    printf("Success!\n");
  }
}

int main()
{
  /*
   * This is one possible execution context that will make
   * the kernel launch print its success message.
   */

  printSuccessForCorrectExecutionConfiguration<<<256, 1024>>>();

  /*
   * Don't forget kernel execution is asynchronous and you must
   * sync on its completion.
   */

  cudaDeviceSynchronize();
}

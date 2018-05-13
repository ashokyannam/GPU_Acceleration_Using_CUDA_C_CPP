#include <stdio.h>

void helloCPU()
{
  printf("Hello from the CPU.\n");
}

/*
 * Refactor the `helloGPU` definition to be a kernel
 * that can be launched on the GPU. Update its message
 * to read "Hello from the GPU!"
 */

void helloGPU()
{
  printf("Hello also from the CPU.\n");
}

int main()
{

  helloCPU();

  /*
   * Refactor this call to `helloGPU` so that it launches
   * as a kernel on the GPU.
   */

  helloGPU();

  /*
   * Add code below to synchronize on the completion of the
   * `helloGPU` kernel completion before continuing the CPU
   * thread.
   */
}

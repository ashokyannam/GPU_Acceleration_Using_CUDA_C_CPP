#include <stdio.h>

void init(int *a, int N)
{
  int i;
  for (i = 0; i < N; ++i)
  {
    a[i] = i;
  }
}

__global__
void doubleElements(int *a, int N)
{

  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  int stride = gridDim.x * blockDim.x;

  /*
   * The previous code (now commented out) attempted
   * to access an element outside the range of `a`.
   */

  // for (int i = idx; i < N + stride; i += stride)
  for (int i = idx; i < N; i += stride)
  {
    a[i] *= 2;
  }
}

bool checkElementsAreDoubled(int *a, int N)
{
  int i;
  for (i = 0; i < N; ++i)
  {
    if (a[i] != i*2) return false;
  }
  return true;
}

int main()
{
  int N = 10000;
  int *a;

  size_t size = N * sizeof(int);
  cudaMallocManaged(&a, size);

  init(a, N);

  /*
   * The previous code (now commented out) attempted to launch
   * the kernel with more than the maximum number of threads per
   * block, which is 1024.
   */

  size_t threads_per_block = 1024;
  /* size_t threads_per_block = 2048; */
  size_t number_of_blocks = 32;

  cudaError_t syncErr, asyncErr;

  doubleElements<<<number_of_blocks, threads_per_block>>>(a, N);

  /*
   * Catch errors for both the kernel launch above and any
   * errors that occur during the asynchronous `doubleElements`
   * kernel execution.
   */

  syncErr = cudaGetLastError();
  asyncErr = cudaDeviceSynchronize();

  /*
   * Print errors should they exist.
   */

  if (syncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(syncErr));
  if (asyncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(asyncErr));

  bool areDoubled = checkElementsAreDoubled(a, N);
  printf("All elements were doubled? %s\n", areDoubled ? "TRUE" : "FALSE");

  cudaFree(a);
}

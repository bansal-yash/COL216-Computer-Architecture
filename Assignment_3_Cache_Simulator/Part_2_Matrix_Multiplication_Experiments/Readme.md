# Yash Bansal
# 2022CS51133

## Cache experiment

In this aassignment, we have experimented different matrix operations over matrices of different sizes to test the cache parameters of the computer. The experiments are done by changing the loop order of the multiply and transpose operations, as by changing the loop order, the accesses get changed from linear in an array to accessing different arrays, which can be affected depending on the cache parameters. 

## Result from Matrix Multiplication operations

I have used 6 different loop orders (ijk, jik, kij, kji, ikj, jik), but out of these 6 loop orders, 3 become redundant, in the way that overall memory accesses are occuring to be similar, as can be seen from the image.

<figure>
  <img src="Plots/multiply/plot_to_show_redundancy.png" alt="Image Description" width="750">
  <figcaption>Plot to show redundancy in loop orders</figcaption>
</figure>

After removing the redundant loop orders, the remaining 3 loop order durations are plotted again different n values from 1 to a particular n. The graphs are as follows.

<img src="Plots/multiply/plot_300.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/multiply/plot_500.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/multiply/plot_600.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/multiply/plot_1100.png" alt="Image Description" width="750">

From these plots, the parameters of the cache can be estimated. Firstly, there are high jumps in the time taken for particular values of n :- 256, 512, 1024. There is a significant high amount of time taken for these values of n, which could indicate the number of blocks in a set in the cache, for different cache levels. This is estimated by taking into account the spatial locality of the cache. 

The high fluctuations for higher values of n could indicate the overall cache size, as when complete matrix gets stored in the cache, loads and store take fluctuation amounts of time, as multiple matrices are accesses at the same time.

## Results from In Place matrix Transpose operations

The following are the graphs generated for the two loop orders of the operation.

<img src="Plots/in_place_transpose/plot_500.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/in_place_transpose/plot_1000.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/in_place_transpose/plot_2000.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/in_place_transpose/plot_5000.png" alt="Image Description" width="1000">

## Results from matrix Transpose operation using an additional matrix

The following are the graphs generated for the two loop orders of the operation.

<img src="Plots/additional_matrix_transpose/plot_500.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/additional_matrix_transpose/plot_1000.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/additional_matrix_transpose/plot_2000.png" alt="Image Description" width="750">
<br> <br>

<img src="Plots/additional_matrix_transpose/plot_5000.png" alt="Image Description" width="1000">


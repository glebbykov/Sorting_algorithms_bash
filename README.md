# Welcome to the repository
This repository contains a bash script that sorts an array of integers using 5 different sorting algorithms. The sorting algorithms implemented are:

+ Bubble Sort
+ Insertion Sort
+ Quick Sort
+ Selection Sort
+ Radix Sort

## Usage

The script takes one argument which is the file containing the array of integers. The file should contain one integer per line.

bash
Copy code

./sort.sh random_numbers.txt

## Sorting Algorithms
The sorting algorithms are implemented in separate functions within the script. They are called based on the desired sorting algorithm.

The sorting algorithms are explained below:

+ Bubble Sort: This sorting algorithm compares two adjacent elements and swaps them if they are in the wrong order. The process is repeated until the whole array is sorted.
+ Insertion Sort: This sorting algorithm starts with an unsorted array and builds the sorted array one element at a time.
+ Quick Sort: This sorting algorithm uses a divide-and-conquer approach to sort an array. It selects a pivot element and partitions the array into two sub-arrays, such that all elements in the left sub-array are less than the pivot, and all elements in the right sub-array are greater than the pivot. The two sub-arrays are then sorted recursively.
+ Selection Sort: This sorting algorithm sorts an array by dividing it into two parts: the sorted part at the left end, and the unsorted part at the right end. It selects the minimum element from the unsorted part and swaps it with the first element in the unsorted part.
+ Radix Sort: This sorting algorithm sorts an array of integers by grouping the digits of each integer based on their place value and then sorting the elements based on their least significant digit.

## Note

The script checks if the file exists and if it contains only numeric elements before sorting. If either of these checks fails, the script will return an error message and exit with a status code of 1.

/*
 * Recursively computes Fibonacci numbers.
 * CSC 225, Assignment 6
 * Given code, Winter '20
 * TODO: Complete this file.
 */

#include <stdio.h>
#include "fib.h"

int main(void) {
	int x;
	int y;
	printf("Enter an integer: ");
	scanf("%d", &x);
	y = fib(x);
	printf("f(%d) = %d\n", x, y);
	return 0;
}

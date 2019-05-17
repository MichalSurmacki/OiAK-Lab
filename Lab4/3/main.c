#include <stdio.h>
#include <stdint.h>

extern double my_sin();

int main(){

	double ans = 0;
	printf("Podaj x a oblicze sin(x): ");
	scanf("%f", &ans);
	
	int lo, hi;
        long long int time1;
        asm volatile ( "rdtsc" : "=a" (lo), "=d" (hi) );
        time1 = lo | hi;

	ans = my_sin(ans);

        long long int time2;
        asm volatile ( "rdtsc" : "=a" (lo), "=d" (hi) );
        time2 = lo | hi;
	
	long long int time = time2 - time1;

	printf("sin(x): %f\n", ans);
	
	return 0;

}

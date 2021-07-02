#include <enzyme.h>
#include <stdio.h>

double square(double x) {
    return x * x;
}
double dsquare(double x) {
    // This returns the derivative of square or 2 * x
    return __enzyme_autodiff((void*)square, x);
}

void run() {
    for(double i=1; i<5; i++)
        printf("square(%f)=%f, dsquare(%f)=%f", i, square(i), i, dsquare(i));
}

#include <stdio.h>
#include <math.h>

double down(double x) {
    double n1 = floor(sqrt(x));
    return n1;
}

double up(double x) {
    double n2 = ceil(sqrt(x));
    return n2;
}


int main(void) {
    FILE *f;
    double x;
    f = fopen("/home/artyom/CLionProjects/untitled6/text", "r");
    fscanf(f, "%lf", &x);
    printf("x = %lf\n", x);
    int flag = 0;
    if (x <= -1){
        printf("Insert x > -1");
    }
    else if (x <= 0 && x > -1) {
        x = fabs(x);
        printf("x = %f\n", x);
        double res = 1;
        double i1 = 2;
        double i2 = 3;
        double part;
        part = (1 / i1) * x;
        //printf("%f\n", part);
        res -= part;
        i1 += 2;
        part *= x * (1 / i1);
        //printf("%f\n", part);
        res -= part;
        i1 += 2;
        while (fabs(part) > 0.0005) {
            part *= i2;
            part *= x * (1 / i1);
            res -= part;
            i1 += 2;
            i2 += 2;
        }
        printf("Answer: %f", res);
    }
    else if (x < 1 && x > 0){
        double res = 1;
        double i1 = 2;
        double i2 = 3;
        double part;
        part = (1 / i1) * x;
        //printf("%f\n", part);
        res += part;
        i1 += 2;
        part *= x * (1 / i1);
        //printf("%f\n", part);
        res -= part;
        i1 += 2;
        int i = 0;
        while (fabs(part) > 0.0005) {
            part *= i2;
            part *= x * (1 / i1);
            //printf("%f\n", part);
            if (i == 0) {
                res += part;
            } else {
                res -= part;
            }
            i *= -1;
            i1 += 2;
            i2 += 2;
        }
        printf("Answer: %f", res);
    }
    else {
        x += 1;
        double n1 = down(x);
        double n2 = up(x);
        double n3;
        if ((x - (n1 * n1)) < ((n2 * n2) - x)) {
            n3 = n1 * n1;
            x = ((x - n3) / n3);
        } else {
            n3 = n2 * n2;
            x = ((n3 - x) / n3);
            flag = 1;
        }
        if (!flag) {
            //printf("%f\n", x);
            double res = 1;
            double i1 = 2;
            double i2 = 3;
            double part;
            part = (1 / i1) * x;
            //printf("%f\n", part);
            res += part;
            i1 += 2;
            part *= x * (1 / i1);
            //printf("%f\n", part);
            res -= part;
            i1 += 2;
            int i = 0;
            double per = 0.0005 * sqrt(n3);
            //printf("%f\n", per);
            while (fabs(part) > per) {
                part *= i2;
                part *= x * (1 / i1);
                //printf("%f\n", part);
                if (i == 0) {
                    res += part;
                } else {
                    res -= part;
                }
                i *= -1;
                i1 += 2;
                i2 += 2;
            }
            res *= sqrt(n3);
            printf("Answer: %f", res);
        } else {
            //printf("%f\n", x);
            double res = 1;
            double i1 = 2;
            double i2 = 3;
            double part;
            part = (1 / i1) * x;
            //printf("%f\n", part);
            res -= part;
            i1 += 2;
            part *= x * (1 / i1);
            //printf("%f\n", part);
            res -= part;
            i1 += 2;
            double per = 0.0005 * sqrt(n3);
            // printf("%f\n", per);
            while (fabs(part) > per) {
                part *= i2;
                part *= x * (1 / i1);
                res -= part;
                i1 += 2;
                i2 += 2;
            }
            res *= sqrt(n3);
            printf("Answer: %f", res);
        }
    }
    fclose(f);
}

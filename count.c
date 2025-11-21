#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int c;
    int count = 0;
    while ((c = getchar()) != EOF) {
        if (c == '\n') count++;
    }
    printf("%d\n", count);
    return 0;
}
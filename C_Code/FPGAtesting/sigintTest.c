#include <signal.h>
#include <stdint.h> 
#include <stdio.h>
#include <sys/time.h>

volatile static int cont = 1;
void sigintcatch(int dummy){
    printf("\b\bDummy: %i\n", dummy);
    cont=0;
}

int main(){
    struct timeval tv;
    gettimeofday(&tv, NULL);
    long int secstart = tv.tv_sec;
    long int start = tv.tv_sec*1E6 + tv.tv_usec;
    signal(SIGINT, sigintcatch);
    printf("Starting\n");
    while (cont){
    }
    gettimeofday(&tv, NULL);
    long int stop = tv.tv_sec*1E6 + tv.tv_usec;
    int diff = stop - start; 
    printf("Finito. Took %fs\n", (float)diff/1E6);
    printf("This shit started at %ld s and ended at %ld s\n",start, stop);
    printf("The seconds were %li to %li\n", secstart, tv.tv_sec);
}

long int get_time(){
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec*1E6 + tv.tv_usec;
}
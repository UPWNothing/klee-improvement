#include <stdlib.h>
#include <stdio.h>

int main(int argc,char** argv) {
  int x,y;
  x = *argv[1];
  y = x - 15;
  if (x > 10) {
    printf("x/y=%d",x/y);
  }
  return 0;
}

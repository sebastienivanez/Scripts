CFLAGS=-c -g -Wall -Werror

all: main clean
main: main.o
  g++ -o test main.o
main.o: main.c
  g++ $(CFLAGS) main.c

clean:
  rm *.o

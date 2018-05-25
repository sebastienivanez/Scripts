CFLAGS=-c -g -Wall -Werror

all: main clean
main: main.o
	gcc -o test main.o
main.o: main.c
	gcc $(CFLAGS) main.c

clean:
	rm *.o

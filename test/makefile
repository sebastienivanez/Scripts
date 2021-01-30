# c++11 to use chrono
CFLAGS=-c -g -Wall -Werror -std=c++11

all: main clean
main: main.o
	g++ -o test main.o
main.o: main.c
	g++ $(CFLAGS) main.c

clean:
	rm *.o

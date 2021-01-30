/*! \file
 * Test purposes
 */
 
/* INCLUDES */
#include <assert.h> // To call assert()
#include <cstddef> // To use NULL
#include <cstdlib> // To call atoi()/rand()/srand()
#include <cstring> // To use strcpy()
#include <fcntl.h> // To call open()
#include <iomanip> // To call setw()
#include <iostream> // To call cout/cin
#include <sstream> // To call stringstream
#include <stdbool.h> // To use bool in c
#include <sys/statvfs.h> // To calculate diskUsage/freeDiskSpace
#include <sys/timeb.h> // To use _ftime
#include <stdint.h> // To use uint8_t
#include <stdlib.h> // To call malloc()/system()
#include <stdio.h> // To call printf()
#include <sstream> // To use string
#include <string> // To use string
#include <time.h> // To use
#include <unistd.h> // To call read()/sleep()
#include <vector> // To use vector
#include <chrono> // To use 
#include "BaseType.h"
#include "timeStamp.h"

/* MACROS */
//#define test printf("test = %d\n", TAILLE); printf("test = %d\n", TAILLE);

/*! \namespace std */
using namespace std;
/*! \namespace chrono */
using namespace chrono;

/*!
 * \details Entry function to project.
 * \author  Sebastien Ivanez
 * \date    12/07/2018
 */
int main(int argc, char *argv[])
{
  //auto start = steady_clock::now();
  //auto end = steady_clock::now();
  //duration<double> elapsed_seconds = end;
  //cout << "elapsed time: " << elapsed_seconds.count() << "s\n";
}

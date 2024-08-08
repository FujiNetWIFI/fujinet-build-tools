#include <conio.h>
#include <stdint.h>
#include <stdio.h>

#include "main.h"
#include "hello.h"
#include "util.h"

char *version = "1.0.0";

int main() {
	uint8_t result;

	clrscr();

	// call a 
	result = sum(1, 2);

	printf("main v%s\n", version);
	hello("template");
	printf("1+2 = %u\n", result);

// illustrating use of conditional compilation if required, but subfolders are easier and less messy! please don't do this it's just for illustration
#if defined(__APPLE__)
	// in this example app, goodbye() is only defined in target specific files, so needs the guard above
	goodbye();
#endif

	return 0;
}
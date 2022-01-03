#include <stdio.h>

extern long area();

int main(){
	printf("Welcome to your friendly area calculator.\nThe main program will now call the area function.\n\n");
	printf("The main program received this integer: %ld.\n", area());
	printf("Have a nice day. Main will now return 0 to the operating system.\n");
	return 0;
}

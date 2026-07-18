#include <stdio.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>

const char* msg1 = "Soy el proceso padre!\n";
size_t msg1_len;
const char* msg2 = "Soy el proceso hijo!\n";
size_t msg2_len;
const char* msg3 = "Proceso hijo terminado!\n";
size_t msg3_len;

void child_process()
{
	write(1, msg2, msg2_len);
}

void father_process()
{
	write(1, msg1, msg1_len);
	wait(NULL);
	write(1, msg3, msg3_len);
}

int main()
{
	msg1_len = strlen(msg1);
	msg2_len = strlen(msg2);
	msg3_len = strlen(msg3);
	int res = fork();
	if (res == 0)
	{
		child_process();
		
	} else
	{
		father_process();
	}
}

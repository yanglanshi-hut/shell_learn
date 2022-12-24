#include <stdio.h>
#include <malloc.h>
#include <unistd.h>
#include <time.h>

#define MEM_SIZE 256*1024*1024
#define PTR_NUM 4

int hogvm(long long forks);

int main (int argc, char* argv[])
{
	char *mem= (char *)malloc(MEM_SIZE);

	hogvm(3);
	while(1)
	{
		sleep(60);
	}
	return 0;
}


int hogvm(long long forks)
{
	long long i = 0 ,j = 0, k = 0;
	char **ptr = NULL;
	int pid = 0;

	for (i = 0; i < forks; ++i)
	{
		switch ( pid=fork() ){
		case 0:
			printf("child \n");
			ptr = (char **) malloc (PTR_NUM);
			for(j = 0; j < PTR_NUM; ++j)
			{
				ptr[j] = (char*)malloc(sizeof(char) * MEM_SIZE);
			}
			

			while(1)
			{
				for(j = 0; j < PTR_NUM; ++j)
				{
					for (k = 0; k < MEM_SIZE; ++k)
					{
						ptr[j][k] = 'Z';		
					}	
				}	
							
				printf("----- \n");
			}
		case -1:
			printf("fork faild \n");
		default:
			printf("Dad ! \n");
		}
	}



	return 0;
}

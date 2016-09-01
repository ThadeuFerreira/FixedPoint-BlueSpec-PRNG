#include <stdio.h>
#include <stdlib.h>
#include <time.h>
	

#include <time.h>

#include "ulcg.h"
#include "unif01.h"
#include "bbattery.h"



#define FACT 2.32830643653869628906e-10

#define BUFSIZE 128



/*
 * 
 */  
char *cmd = "/home/thadeu/Bluespec_exec/FixedPointTest/mkFixedTb";    //External simulation

char buf[BUFSIZE];
FILE *fp;

double myrand(){
	 double val;
	if(fgets(buf, BUFSIZE, fp) != NULL){
		
		

				
				char *line = buf;
			   			    	
			    	char *ptr;
				//printf("string = %s", line);
			    	val = strtod(line, &ptr);
				//printf("int = %lu\n", num);

			    	
			    	

			}

	
	return val;
}

int main (void)
{


	if ((fp = popen(cmd, "r")) == NULL) {
	printf("Error opening pipe!\n");
	return -1;
	}

	int i = 0;
	for(i = 0; i < 6; i++){
		fgets(buf, BUFSIZE, fp);
	}

	unif01_Gen * mygen = unif01_CreateExternGen01("BSV_Simulator", myrand);
	bbattery_Crush(mygen);
 	
	if(pclose(fp))  {
        printf("Command not found or exited with error status\n");
        return -1;
   	}


   return 0;
}

#include "types.h"
#include "user.h"
//#include "defs.h"

static int testProcessNumber = 0;

int
main(int argc, char *argv[])
{
  if(argc != 4) {
    printf(2, "Usage: schedulertest <proc1tix> <proc2tix> <duration>");
    exit();
  }
  int tickets[2] = {500, 500};
  tickets[0] = atoi(argv[1]);
	tickets[1] = atoi(argv[2]);
	

	int pid, n;
	//int startTime = mytime();
	printf(2, "pid of parent = %d\n", getpid());
	for(n = 0; n < 2; n++)
	{
		pid = fork();
		if(pid != 0) {
		  //	printf(2, "is this the parent? pid == %d\n", getpid());
			
		}
		else if(pid == 0)
		{
			
		  printf(2, "testPid == %d\n", getpid());
		  printf(2, "tickets == %d\n", tickets[testProcessNumber]);
			
			//int myProcessNumber = testProcessNumber;			
			

			//;
			int m;
			while(1) {			
				m++;
			}

	
		}
		

		testProcessNumber++;
	}
	settickets(getpid(), 500);
	int thispid = getpid();
	  //	printf(2, "pid == %d\n", getpid());
//	int counter, counter2, counter3, counter4;
	int starttime = mytime();
	settickets(getpid() + 1, tickets[0]);
	settickets(getpid() + 2, tickets[1]);
	while(mytime() - starttime < atoi(argv[3]))
		;
	
	//	printf(2, "runtime of Process%d == %d\n", thispid, getruntime(thispid));	
	printf(2, "runtime of Process%d == %d\n", thispid + 1, getruntime(thispid + 1));
	printf(2, "runtime of Process%d == %d\n", thispid + 2, getruntime(thispid + 2));
	
	exit();
	
}



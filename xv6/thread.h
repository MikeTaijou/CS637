int thread_create( void *(*start_routine)(void*), void *arg)
{
	int pid;
	void* newstack = malloc(PAGE);

	if(pid = spork(newstack) == 0)
		(*start_routine)(*arg);
	else
		return pid;
	
}
int thread_waite(void)
{	
	

	return wait();
}

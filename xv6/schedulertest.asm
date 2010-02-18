
_schedulertest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

static int testProcessNumber = 0;

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 28             	sub    $0x28,%esp
  14:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 4) {
  17:	83 39 04             	cmpl   $0x4,(%ecx)
  1a:	0f 85 78 01 00 00    	jne    198 <main+0x198>
    printf(2, "Usage: schedulertest <proc1tix> <proc2tix> <duration>");
    exit();
  }
  int tickets[2] = {500, 500};
  tickets[0] = atoi(argv[1]);
  20:	8b 43 04             	mov    0x4(%ebx),%eax
  23:	89 04 24             	mov    %eax,(%esp)
  26:	e8 b5 02 00 00       	call   2e0 <atoi>
  2b:	89 45 d8             	mov    %eax,-0x28(%ebp)
	tickets[1] = atoi(argv[2]);
  2e:	8b 43 08             	mov    0x8(%ebx),%eax
  31:	89 04 24             	mov    %eax,(%esp)
  34:	e8 a7 02 00 00       	call   2e0 <atoi>
  39:	89 c6                	mov    %eax,%esi
	

	int pid, n;
	//int startTime = mytime();
	printf(2, "pid of parent = %d\n", getpid());
  3b:	e8 48 04 00 00       	call   488 <getpid>
  40:	c7 44 24 04 50 09 00 	movl   $0x950,0x4(%esp)
  47:	00 
  48:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4f:	89 44 24 08          	mov    %eax,0x8(%esp)
  53:	e8 08 05 00 00       	call   560 <printf>
	for(n = 0; n < 2; n++)
	{
		pid = fork();
  58:	e8 a3 03 00 00       	call   400 <fork>
		if(pid != 0) {
  5d:	85 c0                	test   %eax,%eax
  5f:	75 57                	jne    b8 <main+0xb8>
  61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			
		}
		else if(pid == 0)
		{
			
		  printf(2, "testPid == %d\n", getpid());
  68:	e8 1b 04 00 00       	call   488 <getpid>
  6d:	c7 44 24 04 64 09 00 	movl   $0x964,0x4(%esp)
  74:	00 
  75:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  7c:	89 44 24 08          	mov    %eax,0x8(%esp)
  80:	e8 db 04 00 00       	call   560 <printf>
  if(argc != 4) {
    printf(2, "Usage: schedulertest <proc1tix> <proc2tix> <duration>");
    exit();
  }
  int tickets[2] = {500, 500};
  tickets[0] = atoi(argv[1]);
  85:	8b 45 d8             	mov    -0x28(%ebp),%eax
	tickets[1] = atoi(argv[2]);
  88:	89 75 ec             	mov    %esi,-0x14(%ebp)
		}
		else if(pid == 0)
		{
			
		  printf(2, "testPid == %d\n", getpid());
		  printf(2, "tickets == %d\n", tickets[testProcessNumber]);
  8b:	c7 44 24 04 73 09 00 	movl   $0x973,0x4(%esp)
  92:	00 
  93:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  if(argc != 4) {
    printf(2, "Usage: schedulertest <proc1tix> <proc2tix> <duration>");
    exit();
  }
  int tickets[2] = {500, 500};
  tickets[0] = atoi(argv[1]);
  9a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		}
		else if(pid == 0)
		{
			
		  printf(2, "testPid == %d\n", getpid());
		  printf(2, "tickets == %d\n", tickets[testProcessNumber]);
  9d:	a1 b8 09 00 00       	mov    0x9b8,%eax
  a2:	8b 44 85 e8          	mov    -0x18(%ebp,%eax,4),%eax
  a6:	89 44 24 08          	mov    %eax,0x8(%esp)
  aa:	e8 b1 04 00 00       	call   560 <printf>
  af:	eb fe                	jmp    af <main+0xaf>
  b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

	
		}
		

		testProcessNumber++;
  b8:	83 05 b8 09 00 00 01 	addl   $0x1,0x9b8
	int pid, n;
	//int startTime = mytime();
	printf(2, "pid of parent = %d\n", getpid());
	for(n = 0; n < 2; n++)
	{
		pid = fork();
  bf:	e8 3c 03 00 00       	call   400 <fork>
		if(pid != 0) {
  c4:	85 c0                	test   %eax,%eax
  c6:	74 99                	je     61 <main+0x61>

	
		}
		

		testProcessNumber++;
  c8:	83 05 b8 09 00 00 01 	addl   $0x1,0x9b8
	}
	settickets(getpid(), 500);
  cf:	e8 b4 03 00 00       	call   488 <getpid>
  d4:	c7 44 24 04 f4 01 00 	movl   $0x1f4,0x4(%esp)
  db:	00 
  dc:	89 04 24             	mov    %eax,(%esp)
  df:	e8 c4 03 00 00       	call   4a8 <settickets>
	int thispid = getpid();
  e4:	e8 9f 03 00 00       	call   488 <getpid>
  e9:	89 45 dc             	mov    %eax,-0x24(%ebp)
	  //	printf(2, "pid == %d\n", getpid());
//	int counter, counter2, counter3, counter4;
	int starttime = mytime();
  ec:	e8 af 03 00 00       	call   4a0 <mytime>
  f1:	89 c7                	mov    %eax,%edi
	settickets(getpid() + 1, tickets[0]);
  f3:	e8 90 03 00 00       	call   488 <getpid>
  f8:	8b 55 d8             	mov    -0x28(%ebp),%edx
  fb:	89 54 24 04          	mov    %edx,0x4(%esp)
  ff:	83 c0 01             	add    $0x1,%eax
 102:	89 04 24             	mov    %eax,(%esp)
 105:	e8 9e 03 00 00       	call   4a8 <settickets>
	settickets(getpid() + 2, tickets[1]);
 10a:	e8 79 03 00 00       	call   488 <getpid>
 10f:	89 74 24 04          	mov    %esi,0x4(%esp)
 113:	8d 73 0c             	lea    0xc(%ebx),%esi
 116:	83 c0 02             	add    $0x2,%eax
 119:	89 04 24             	mov    %eax,(%esp)
 11c:	e8 87 03 00 00       	call   4a8 <settickets>
 121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(mytime() - starttime < atoi(argv[3]))
 128:	e8 73 03 00 00       	call   4a0 <mytime>
 12d:	89 c3                	mov    %eax,%ebx
 12f:	8b 06                	mov    (%esi),%eax
 131:	29 fb                	sub    %edi,%ebx
 133:	89 04 24             	mov    %eax,(%esp)
 136:	e8 a5 01 00 00       	call   2e0 <atoi>
 13b:	39 c3                	cmp    %eax,%ebx
 13d:	7c e9                	jl     128 <main+0x128>
		;
	
	//	printf(2, "runtime of Process%d == %d\n", thispid, getruntime(thispid));	
	printf(2, "runtime of Process%d == %d\n", thispid + 1, getruntime(thispid + 1));
 13f:	8b 5d dc             	mov    -0x24(%ebp),%ebx
 142:	83 c3 01             	add    $0x1,%ebx
 145:	89 1c 24             	mov    %ebx,(%esp)
 148:	e8 63 03 00 00       	call   4b0 <getruntime>
 14d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 151:	c7 44 24 04 82 09 00 	movl   $0x982,0x4(%esp)
 158:	00 
 159:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 160:	89 44 24 0c          	mov    %eax,0xc(%esp)
 164:	e8 f7 03 00 00       	call   560 <printf>
	printf(2, "runtime of Process%d == %d\n", thispid + 2, getruntime(thispid + 2));
 169:	8b 5d dc             	mov    -0x24(%ebp),%ebx
 16c:	83 c3 02             	add    $0x2,%ebx
 16f:	89 1c 24             	mov    %ebx,(%esp)
 172:	e8 39 03 00 00       	call   4b0 <getruntime>
 177:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 17b:	c7 44 24 04 82 09 00 	movl   $0x982,0x4(%esp)
 182:	00 
 183:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 18a:	89 44 24 0c          	mov    %eax,0xc(%esp)
 18e:	e8 cd 03 00 00       	call   560 <printf>
	
	exit();
 193:	e8 70 02 00 00       	call   408 <exit>

int
main(int argc, char *argv[])
{
  if(argc != 4) {
    printf(2, "Usage: schedulertest <proc1tix> <proc2tix> <duration>");
 198:	c7 44 24 04 18 09 00 	movl   $0x918,0x4(%esp)
 19f:	00 
 1a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1a7:	e8 b4 03 00 00       	call   560 <printf>
    exit();
 1ac:	e8 57 02 00 00       	call   408 <exit>
 1b1:	90                   	nop    
 1b2:	90                   	nop    
 1b3:	90                   	nop    
 1b4:	90                   	nop    
 1b5:	90                   	nop    
 1b6:	90                   	nop    
 1b7:	90                   	nop    
 1b8:	90                   	nop    
 1b9:	90                   	nop    
 1ba:	90                   	nop    
 1bb:	90                   	nop    
 1bc:	90                   	nop    
 1bd:	90                   	nop    
 1be:	90                   	nop    
 1bf:	90                   	nop    

000001c0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	31 d2                	xor    %edx,%edx
 1c3:	89 e5                	mov    %esp,%ebp
 1c5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c8:	53                   	push   %ebx
 1c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d0:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
 1d4:	88 04 13             	mov    %al,(%ebx,%edx,1)
 1d7:	83 c2 01             	add    $0x1,%edx
 1da:	84 c0                	test   %al,%al
 1dc:	75 f2                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1de:	89 d8                	mov    %ebx,%eax
 1e0:	5b                   	pop    %ebx
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    
 1e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	53                   	push   %ebx
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
 1f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1fa:	0f b6 02             	movzbl (%edx),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	75 14                	jne    215 <strcmp+0x25>
 201:	eb 2d                	jmp    230 <strcmp+0x40>
 203:	90                   	nop    
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 208:	83 c2 01             	add    $0x1,%edx
 20b:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 20e:	0f b6 02             	movzbl (%edx),%eax
 211:	84 c0                	test   %al,%al
 213:	74 1b                	je     230 <strcmp+0x40>
 215:	0f b6 19             	movzbl (%ecx),%ebx
 218:	38 d8                	cmp    %bl,%al
 21a:	74 ec                	je     208 <strcmp+0x18>
 21c:	0f b6 d0             	movzbl %al,%edx
 21f:	0f b6 c3             	movzbl %bl,%eax
 222:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 224:	89 d0                	mov    %edx,%eax
 226:	5b                   	pop    %ebx
 227:	5d                   	pop    %ebp
 228:	c3                   	ret    
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 230:	0f b6 19             	movzbl (%ecx),%ebx
 233:	31 d2                	xor    %edx,%edx
 235:	0f b6 c3             	movzbl %bl,%eax
 238:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 23a:	89 d0                	mov    %edx,%eax
 23c:	5b                   	pop    %ebx
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret    
 23f:	90                   	nop    

00000240 <strlen>:

uint
strlen(char *s)
{
 240:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 241:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 243:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 245:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 247:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 24a:	80 3a 00             	cmpb   $0x0,(%edx)
 24d:	74 0c                	je     25b <strlen+0x1b>
 24f:	90                   	nop    
 250:	83 c0 01             	add    $0x1,%eax
 253:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 257:	75 f7                	jne    250 <strlen+0x10>
 259:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
 25b:	89 c8                	mov    %ecx,%eax
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret    
 25f:	90                   	nop    

00000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 10             	mov    0x10(%ebp),%eax
 266:	53                   	push   %ebx
 267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
 26a:	85 c0                	test   %eax,%eax
 26c:	74 14                	je     282 <memset+0x22>
 26e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 272:	31 d2                	xor    %edx,%edx
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 278:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
 27b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 27e:	39 c2                	cmp    %eax,%edx
 280:	75 f6                	jne    278 <memset+0x18>
    *d++ = c;
  return dst;
}
 282:	89 d8                	mov    %ebx,%eax
 284:	5b                   	pop    %ebx
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <strchr>:

char*
strchr(const char *s, char c)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 29a:	0f b6 10             	movzbl (%eax),%edx
 29d:	84 d2                	test   %dl,%dl
 29f:	75 11                	jne    2b2 <strchr+0x22>
 2a1:	eb 25                	jmp    2c8 <strchr+0x38>
 2a3:	90                   	nop    
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a8:	83 c0 01             	add    $0x1,%eax
 2ab:	0f b6 10             	movzbl (%eax),%edx
 2ae:	84 d2                	test   %dl,%dl
 2b0:	74 16                	je     2c8 <strchr+0x38>
    if(*s == c)
 2b2:	38 ca                	cmp    %cl,%dl
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b8:	75 ee                	jne    2a8 <strchr+0x18>
      return (char*) s;
  return 0;
}
 2ba:	5d                   	pop    %ebp
 2bb:	90                   	nop    
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c0:	c3                   	ret    
 2c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2c8:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 2ca:	5d                   	pop    %ebp
 2cb:	90                   	nop    
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d0:	c3                   	ret    
 2d1:	eb 0d                	jmp    2e0 <atoi>
 2d3:	90                   	nop    
 2d4:	90                   	nop    
 2d5:	90                   	nop    
 2d6:	90                   	nop    
 2d7:	90                   	nop    
 2d8:	90                   	nop    
 2d9:	90                   	nop    
 2da:	90                   	nop    
 2db:	90                   	nop    
 2dc:	90                   	nop    
 2dd:	90                   	nop    
 2de:	90                   	nop    
 2df:	90                   	nop    

000002e0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e1:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 2e3:	89 e5                	mov    %esp,%ebp
 2e5:	53                   	push   %ebx
 2e6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e9:	0f b6 13             	movzbl (%ebx),%edx
 2ec:	8d 42 d0             	lea    -0x30(%edx),%eax
 2ef:	3c 09                	cmp    $0x9,%al
 2f1:	77 1c                	ja     30f <atoi+0x2f>
 2f3:	90                   	nop    
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2f8:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 2fb:	0f be d2             	movsbl %dl,%edx
 2fe:	83 c3 01             	add    $0x1,%ebx
 301:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 305:	0f b6 13             	movzbl (%ebx),%edx
 308:	8d 42 d0             	lea    -0x30(%edx),%eax
 30b:	3c 09                	cmp    $0x9,%al
 30d:	76 e9                	jbe    2f8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 30f:	89 c8                	mov    %ecx,%eax
 311:	5b                   	pop    %ebx
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 31a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000320 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 10             	mov    0x10(%ebp),%ecx
 326:	56                   	push   %esi
 327:	8b 75 08             	mov    0x8(%ebp),%esi
 32a:	53                   	push   %ebx
 32b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c9                	test   %ecx,%ecx
 330:	7e 14                	jle    346 <memmove+0x26>
 332:	31 d2                	xor    %edx,%edx
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 338:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 33c:	88 04 16             	mov    %al,(%esi,%edx,1)
 33f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 342:	39 ca                	cmp    %ecx,%edx
 344:	75 f2                	jne    338 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 346:	89 f0                	mov    %esi,%eax
 348:	5b                   	pop    %ebx
 349:	5e                   	pop    %esi
 34a:	5d                   	pop    %ebp
 34b:	c3                   	ret    
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000350 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 356:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 359:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 35c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 35f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 364:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 36b:	00 
 36c:	89 04 24             	mov    %eax,(%esp)
 36f:	e8 d4 00 00 00       	call   448 <open>
  if(fd < 0)
 374:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 376:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 378:	78 19                	js     393 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 37a:	8b 45 0c             	mov    0xc(%ebp),%eax
 37d:	89 1c 24             	mov    %ebx,(%esp)
 380:	89 44 24 04          	mov    %eax,0x4(%esp)
 384:	e8 d7 00 00 00       	call   460 <fstat>
  close(fd);
 389:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 38c:	89 c6                	mov    %eax,%esi
  close(fd);
 38e:	e8 9d 00 00 00       	call   430 <close>
  return r;
}
 393:	89 f0                	mov    %esi,%eax
 395:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 398:	8b 75 fc             	mov    -0x4(%ebp),%esi
 39b:	89 ec                	mov    %ebp,%esp
 39d:	5d                   	pop    %ebp
 39e:	c3                   	ret    
 39f:	90                   	nop    

000003a0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	31 f6                	xor    %esi,%esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 1c             	sub    $0x1c,%esp
 3ab:	8b 7d 08             	mov    0x8(%ebp),%edi
 3ae:	eb 06                	jmp    3b6 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3b0:	3c 0d                	cmp    $0xd,%al
 3b2:	74 39                	je     3ed <gets+0x4d>
 3b4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b6:	8d 5e 01             	lea    0x1(%esi),%ebx
 3b9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3bc:	7d 31                	jge    3ef <gets+0x4f>
    cc = read(0, &c, 1);
 3be:	8d 45 f3             	lea    -0xd(%ebp),%eax
 3c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3c8:	00 
 3c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3d4:	e8 47 00 00 00       	call   420 <read>
    if(cc < 1)
 3d9:	85 c0                	test   %eax,%eax
 3db:	7e 12                	jle    3ef <gets+0x4f>
      break;
    buf[i++] = c;
 3dd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3e1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 3e5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3e9:	3c 0a                	cmp    $0xa,%al
 3eb:	75 c3                	jne    3b0 <gets+0x10>
 3ed:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3ef:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3f3:	89 f8                	mov    %edi,%eax
 3f5:	83 c4 1c             	add    $0x1c,%esp
 3f8:	5b                   	pop    %ebx
 3f9:	5e                   	pop    %esi
 3fa:	5f                   	pop    %edi
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	90                   	nop    
 3fe:	90                   	nop    
 3ff:	90                   	nop    

00000400 <fork>:
 400:	b8 01 00 00 00       	mov    $0x1,%eax
 405:	cd 30                	int    $0x30
 407:	c3                   	ret    

00000408 <exit>:
 408:	b8 02 00 00 00       	mov    $0x2,%eax
 40d:	cd 30                	int    $0x30
 40f:	c3                   	ret    

00000410 <wait>:
 410:	b8 03 00 00 00       	mov    $0x3,%eax
 415:	cd 30                	int    $0x30
 417:	c3                   	ret    

00000418 <pipe>:
 418:	b8 04 00 00 00       	mov    $0x4,%eax
 41d:	cd 30                	int    $0x30
 41f:	c3                   	ret    

00000420 <read>:
 420:	b8 06 00 00 00       	mov    $0x6,%eax
 425:	cd 30                	int    $0x30
 427:	c3                   	ret    

00000428 <write>:
 428:	b8 05 00 00 00       	mov    $0x5,%eax
 42d:	cd 30                	int    $0x30
 42f:	c3                   	ret    

00000430 <close>:
 430:	b8 07 00 00 00       	mov    $0x7,%eax
 435:	cd 30                	int    $0x30
 437:	c3                   	ret    

00000438 <kill>:
 438:	b8 08 00 00 00       	mov    $0x8,%eax
 43d:	cd 30                	int    $0x30
 43f:	c3                   	ret    

00000440 <exec>:
 440:	b8 09 00 00 00       	mov    $0x9,%eax
 445:	cd 30                	int    $0x30
 447:	c3                   	ret    

00000448 <open>:
 448:	b8 0a 00 00 00       	mov    $0xa,%eax
 44d:	cd 30                	int    $0x30
 44f:	c3                   	ret    

00000450 <mknod>:
 450:	b8 0b 00 00 00       	mov    $0xb,%eax
 455:	cd 30                	int    $0x30
 457:	c3                   	ret    

00000458 <unlink>:
 458:	b8 0c 00 00 00       	mov    $0xc,%eax
 45d:	cd 30                	int    $0x30
 45f:	c3                   	ret    

00000460 <fstat>:
 460:	b8 0d 00 00 00       	mov    $0xd,%eax
 465:	cd 30                	int    $0x30
 467:	c3                   	ret    

00000468 <link>:
 468:	b8 0e 00 00 00       	mov    $0xe,%eax
 46d:	cd 30                	int    $0x30
 46f:	c3                   	ret    

00000470 <mkdir>:
 470:	b8 0f 00 00 00       	mov    $0xf,%eax
 475:	cd 30                	int    $0x30
 477:	c3                   	ret    

00000478 <chdir>:
 478:	b8 10 00 00 00       	mov    $0x10,%eax
 47d:	cd 30                	int    $0x30
 47f:	c3                   	ret    

00000480 <dup>:
 480:	b8 11 00 00 00       	mov    $0x11,%eax
 485:	cd 30                	int    $0x30
 487:	c3                   	ret    

00000488 <getpid>:
 488:	b8 12 00 00 00       	mov    $0x12,%eax
 48d:	cd 30                	int    $0x30
 48f:	c3                   	ret    

00000490 <sbrk>:
 490:	b8 13 00 00 00       	mov    $0x13,%eax
 495:	cd 30                	int    $0x30
 497:	c3                   	ret    

00000498 <sleep>:
 498:	b8 14 00 00 00       	mov    $0x14,%eax
 49d:	cd 30                	int    $0x30
 49f:	c3                   	ret    

000004a0 <mytime>:
 4a0:	b8 15 00 00 00       	mov    $0x15,%eax
 4a5:	cd 30                	int    $0x30
 4a7:	c3                   	ret    

000004a8 <settickets>:
 4a8:	b8 16 00 00 00       	mov    $0x16,%eax
 4ad:	cd 30                	int    $0x30
 4af:	c3                   	ret    

000004b0 <getruntime>:
 4b0:	b8 17 00 00 00       	mov    $0x17,%eax
 4b5:	cd 30                	int    $0x30
 4b7:	c3                   	ret    
 4b8:	90                   	nop    
 4b9:	90                   	nop    
 4ba:	90                   	nop    
 4bb:	90                   	nop    
 4bc:	90                   	nop    
 4bd:	90                   	nop    
 4be:	90                   	nop    
 4bf:	90                   	nop    

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	89 ce                	mov    %ecx,%esi
 4c7:	53                   	push   %ebx
 4c8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ce:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d1:	85 c9                	test   %ecx,%ecx
 4d3:	74 04                	je     4d9 <printint+0x19>
 4d5:	85 d2                	test   %edx,%edx
 4d7:	78 77                	js     550 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d9:	89 d0                	mov    %edx,%eax
 4db:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 4e2:	31 db                	xor    %ebx,%ebx
 4e4:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 4e7:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4e8:	31 d2                	xor    %edx,%edx
 4ea:	f7 f6                	div    %esi
 4ec:	89 c1                	mov    %eax,%ecx
 4ee:	0f b6 82 a5 09 00 00 	movzbl 0x9a5(%edx),%eax
 4f5:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 4f8:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 4fb:	85 c9                	test   %ecx,%ecx
 4fd:	89 c8                	mov    %ecx,%eax
 4ff:	75 e7                	jne    4e8 <printint+0x28>
  if(neg)
 501:	8b 45 d0             	mov    -0x30(%ebp),%eax
 504:	85 c0                	test   %eax,%eax
 506:	74 08                	je     510 <printint+0x50>
    buf[i++] = '-';
 508:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 50d:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 510:	8d 73 ff             	lea    -0x1(%ebx),%esi
 513:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 516:	8d 7d f3             	lea    -0xd(%ebp),%edi
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 520:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 523:	83 ee 01             	sub    $0x1,%esi
 526:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 529:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 530:	00 
 531:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 535:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 538:	8b 45 cc             	mov    -0x34(%ebp),%eax
 53b:	89 04 24             	mov    %eax,(%esp)
 53e:	e8 e5 fe ff ff       	call   428 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 543:	83 fe ff             	cmp    $0xffffffff,%esi
 546:	75 d8                	jne    520 <printint+0x60>
    putc(fd, buf[i]);
}
 548:	83 c4 3c             	add    $0x3c,%esp
 54b:	5b                   	pop    %ebx
 54c:	5e                   	pop    %esi
 54d:	5f                   	pop    %edi
 54e:	5d                   	pop    %ebp
 54f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 550:	89 d0                	mov    %edx,%eax
 552:	f7 d8                	neg    %eax
 554:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 55b:	eb 85                	jmp    4e2 <printint+0x22>
 55d:	8d 76 00             	lea    0x0(%esi),%esi

00000560 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 55 0c             	mov    0xc(%ebp),%edx
 56c:	0f b6 02             	movzbl (%edx),%eax
 56f:	84 c0                	test   %al,%al
 571:	0f 84 e9 00 00 00    	je     660 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 577:	8d 4d 10             	lea    0x10(%ebp),%ecx
 57a:	89 d7                	mov    %edx,%edi
 57c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 57f:	31 f6                	xor    %esi,%esi
 581:	eb 21                	jmp    5a4 <printf+0x44>
 583:	90                   	nop    
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 588:	83 fb 25             	cmp    $0x25,%ebx
 58b:	0f 85 d7 00 00 00    	jne    668 <printf+0x108>
 591:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 595:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 599:	83 c7 01             	add    $0x1,%edi
 59c:	84 c0                	test   %al,%al
 59e:	0f 84 bc 00 00 00    	je     660 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 5a4:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5a6:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 5a9:	74 dd                	je     588 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ab:	83 fe 25             	cmp    $0x25,%esi
 5ae:	75 e5                	jne    595 <printf+0x35>
      if(c == 'd'){
 5b0:	83 fb 64             	cmp    $0x64,%ebx
 5b3:	90                   	nop    
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b8:	0f 84 4a 01 00 00    	je     708 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5be:	83 fb 78             	cmp    $0x78,%ebx
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c8:	0f 84 c2 00 00 00    	je     690 <printf+0x130>
 5ce:	83 fb 70             	cmp    $0x70,%ebx
 5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d8:	0f 84 b2 00 00 00    	je     690 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5de:	83 fb 73             	cmp    $0x73,%ebx
 5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5e8:	0f 84 ca 00 00 00    	je     6b8 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ee:	83 fb 63             	cmp    $0x63,%ebx
 5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5f8:	0f 84 5a 01 00 00    	je     758 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5fe:	83 fb 25             	cmp    $0x25,%ebx
 601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 608:	0f 84 22 01 00 00    	je     730 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 60e:	8b 55 08             	mov    0x8(%ebp),%edx
 611:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 614:	31 f6                	xor    %esi,%esi
 616:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 61a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 621:	00 
 622:	89 44 24 04          	mov    %eax,0x4(%esp)
 626:	89 14 24             	mov    %edx,(%esp)
 629:	e8 fa fd ff ff       	call   428 <write>
 62e:	8b 45 08             	mov    0x8(%ebp),%eax
 631:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 634:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 637:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 63e:	00 
 63f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 643:	89 04 24             	mov    %eax,(%esp)
 646:	e8 dd fd ff ff       	call   428 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 64b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 64f:	83 c7 01             	add    $0x1,%edi
 652:	84 c0                	test   %al,%al
 654:	0f 85 4a ff ff ff    	jne    5a4 <printf+0x44>
 65a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 660:	83 c4 2c             	add    $0x2c,%esp
 663:	5b                   	pop    %ebx
 664:	5e                   	pop    %esi
 665:	5f                   	pop    %edi
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 668:	8b 55 08             	mov    0x8(%ebp),%edx
 66b:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 66e:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 671:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 678:	00 
 679:	89 44 24 04          	mov    %eax,0x4(%esp)
 67d:	89 14 24             	mov    %edx,(%esp)
 680:	e8 a3 fd ff ff       	call   428 <write>
 685:	e9 0b ff ff ff       	jmp    595 <printf+0x35>
 68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 690:	8b 45 e0             	mov    -0x20(%ebp),%eax
 693:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 698:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 69a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6a1:	8b 10                	mov    (%eax),%edx
 6a3:	8b 45 08             	mov    0x8(%ebp),%eax
 6a6:	e8 15 fe ff ff       	call   4c0 <printint>
        ap++;
 6ab:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 6af:	e9 e1 fe ff ff       	jmp    595 <printf+0x35>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 6b8:	8b 55 e0             	mov    -0x20(%ebp),%edx
 6bb:	8b 1a                	mov    (%edx),%ebx
        ap++;
 6bd:	83 c2 04             	add    $0x4,%edx
 6c0:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 6c3:	85 db                	test   %ebx,%ebx
 6c5:	0f 84 ba 00 00 00    	je     785 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 6cb:	0f b6 03             	movzbl (%ebx),%eax
 6ce:	84 c0                	test   %al,%al
 6d0:	74 2d                	je     6ff <printf+0x19f>
 6d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 6d8:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6db:	8b 45 08             	mov    0x8(%ebp),%eax
 6de:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6e1:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6eb:	00 
 6ec:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 6f0:	89 04 24             	mov    %eax,(%esp)
 6f3:	e8 30 fd ff ff       	call   428 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6f8:	0f b6 03             	movzbl (%ebx),%eax
 6fb:	84 c0                	test   %al,%al
 6fd:	75 d9                	jne    6d8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ff:	31 f6                	xor    %esi,%esi
 701:	e9 8f fe ff ff       	jmp    595 <printf+0x35>
 706:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 708:	8b 45 e0             	mov    -0x20(%ebp),%eax
 70b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 710:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 713:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 71a:	8b 10                	mov    (%eax),%edx
 71c:	8b 45 08             	mov    0x8(%ebp),%eax
 71f:	e8 9c fd ff ff       	call   4c0 <printint>
        ap++;
 724:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 728:	e9 68 fe ff ff       	jmp    595 <printf+0x35>
 72d:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 730:	8b 4d 08             	mov    0x8(%ebp),%ecx
 733:	8d 55 f3             	lea    -0xd(%ebp),%edx
 736:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 738:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 743:	00 
 744:	89 54 24 04          	mov    %edx,0x4(%esp)
 748:	89 0c 24             	mov    %ecx,(%esp)
 74b:	e8 d8 fc ff ff       	call   428 <write>
 750:	e9 40 fe ff ff       	jmp    595 <printf+0x35>
 755:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 758:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 75b:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 75e:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 760:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 762:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 769:	00 
 76a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 76e:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 771:	8b 45 08             	mov    0x8(%ebp),%eax
 774:	89 04 24             	mov    %eax,(%esp)
 777:	e8 ac fc ff ff       	call   428 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 77c:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 780:	e9 10 fe ff ff       	jmp    595 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 785:	bb 9e 09 00 00       	mov    $0x99e,%ebx
 78a:	e9 3c ff ff ff       	jmp    6cb <printf+0x16b>
 78f:	90                   	nop    

00000790 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 790:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	8b 0d c4 09 00 00    	mov    0x9c4,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 797:	89 e5                	mov    %esp,%ebp
 799:	57                   	push   %edi
 79a:	56                   	push   %esi
 79b:	53                   	push   %ebx
 79c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 79f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	39 d9                	cmp    %ebx,%ecx
 7a4:	73 24                	jae    7ca <free+0x3a>
 7a6:	66 90                	xchg   %ax,%ax
 7a8:	8b 11                	mov    (%ecx),%edx
 7aa:	39 d3                	cmp    %edx,%ebx
 7ac:	72 2a                	jb     7d8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	39 d1                	cmp    %edx,%ecx
 7b0:	72 10                	jb     7c2 <free+0x32>
 7b2:	39 d9                	cmp    %ebx,%ecx
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7b8:	72 1e                	jb     7d8 <free+0x48>
 7ba:	39 d3                	cmp    %edx,%ebx
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7c0:	72 16                	jb     7d8 <free+0x48>
 7c2:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c4:	39 d9                	cmp    %ebx,%ecx
 7c6:	66 90                	xchg   %ax,%ax
 7c8:	72 de                	jb     7a8 <free+0x18>
 7ca:	8b 11                	mov    (%ecx),%edx
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7d0:	eb dc                	jmp    7ae <free+0x1e>
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d8:	8b 73 04             	mov    0x4(%ebx),%esi
 7db:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 7de:	39 d0                	cmp    %edx,%eax
 7e0:	74 1a                	je     7fc <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7e2:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 7e5:	8b 51 04             	mov    0x4(%ecx),%edx
 7e8:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7eb:	39 d8                	cmp    %ebx,%eax
 7ed:	74 22                	je     811 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7ef:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 7f1:	89 0d c4 09 00 00    	mov    %ecx,0x9c4
}
 7f7:	5b                   	pop    %ebx
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7fc:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 7ff:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 801:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 804:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 807:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 80a:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 80d:	39 d8                	cmp    %ebx,%eax
 80f:	75 de                	jne    7ef <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 811:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 814:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 817:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 819:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 81c:	89 0d c4 09 00 00    	mov    %ecx,0x9c4
}
 822:	5b                   	pop    %ebx
 823:	5e                   	pop    %esi
 824:	5f                   	pop    %edi
 825:	5d                   	pop    %ebp
 826:	c3                   	ret    
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 35 c4 09 00 00    	mov    0x9c4,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	83 c0 07             	add    $0x7,%eax
 845:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 848:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 84d:	0f 84 95 00 00 00    	je     8e8 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 853:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 855:	8b 41 04             	mov    0x4(%ecx),%eax
 858:	39 c3                	cmp    %eax,%ebx
 85a:	0f 86 b0 00 00 00    	jbe    910 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 860:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 867:	90                   	nop    
    }
    if(p == freep)
 868:	3b 0d c4 09 00 00    	cmp    0x9c4,%ecx
 86e:	89 ca                	mov    %ecx,%edx
 870:	74 34                	je     8a6 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 872:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 874:	8b 41 04             	mov    0x4(%ecx),%eax
 877:	39 c3                	cmp    %eax,%ebx
 879:	77 ed                	ja     868 <malloc+0x38>
 87b:	89 d6                	mov    %edx,%esi
 87d:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 87f:	39 c3                	cmp    %eax,%ebx
 881:	74 1d                	je     8a0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 883:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 885:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 888:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 88b:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 88e:	89 35 c4 09 00 00    	mov    %esi,0x9c4
      return (void*) (p + 1);
 894:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 897:	83 c4 0c             	add    $0xc,%esp
 89a:	5b                   	pop    %ebx
 89b:	5e                   	pop    %esi
 89c:	5f                   	pop    %edi
 89d:	5d                   	pop    %ebp
 89e:	c3                   	ret    
 89f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 01                	mov    (%ecx),%eax
 8a2:	89 06                	mov    %eax,(%esi)
 8a4:	eb e8                	jmp    88e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 8a6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 8ac:	bf 00 10 00 00       	mov    $0x1000,%edi
 8b1:	b8 00 80 00 00       	mov    $0x8000,%eax
 8b6:	76 04                	jbe    8bc <malloc+0x8c>
 8b8:	89 df                	mov    %ebx,%edi
 8ba:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 8bc:	89 04 24             	mov    %eax,(%esp)
 8bf:	e8 cc fb ff ff       	call   490 <sbrk>
  if(p == (char*) -1)
 8c4:	83 f8 ff             	cmp    $0xffffffff,%eax
 8c7:	74 18                	je     8e1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8c9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8cc:	83 c0 08             	add    $0x8,%eax
 8cf:	89 04 24             	mov    %eax,(%esp)
 8d2:	e8 b9 fe ff ff       	call   790 <free>
  return freep;
 8d7:	8b 15 c4 09 00 00    	mov    0x9c4,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8dd:	85 d2                	test   %edx,%edx
 8df:	75 91                	jne    872 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8e1:	31 c0                	xor    %eax,%eax
 8e3:	eb b2                	jmp    897 <malloc+0x67>
 8e5:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8e8:	c7 05 c4 09 00 00 bc 	movl   $0x9bc,0x9c4
 8ef:	09 00 00 
    base.s.size = 0;
 8f2:	be bc 09 00 00       	mov    $0x9bc,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8f7:	c7 05 bc 09 00 00 bc 	movl   $0x9bc,0x9bc
 8fe:	09 00 00 
    base.s.size = 0;
 901:	c7 05 c0 09 00 00 00 	movl   $0x0,0x9c0
 908:	00 00 00 
 90b:	e9 43 ff ff ff       	jmp    853 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 910:	89 ca                	mov    %ecx,%edx
 912:	e9 68 ff ff ff       	jmp    87f <malloc+0x4f>

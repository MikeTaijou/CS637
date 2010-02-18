
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	83 ec 28             	sub    $0x28,%esp
  10:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  13:	8b 19                	mov    (%ecx),%ebx
  15:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  18:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  1e:	8b 41 04             	mov    0x4(%ecx),%eax
  int i;

  if(argc < 2){
  21:	83 fb 01             	cmp    $0x1,%ebx
  24:	7f 19                	jg     3f <main+0x3f>
    printf(2, "Usage: mkdir files...\n");
  26:	c7 44 24 04 e7 07 00 	movl   $0x7e7,0x4(%esp)
  2d:	00 
  2e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  35:	e8 f6 03 00 00       	call   430 <printf>
    exit();
  3a:	e8 99 02 00 00       	call   2d8 <exit>
  3f:	8d 78 04             	lea    0x4(%eax),%edi
  42:	be 01 00 00 00       	mov    $0x1,%esi
  47:	90                   	nop    
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  48:	8b 07                	mov    (%edi),%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 ee 02 00 00       	call   340 <mkdir>
  52:	85 c0                	test   %eax,%eax
  54:	78 0f                	js     65 <main+0x65>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  56:	83 c6 01             	add    $0x1,%esi
  59:	83 c7 04             	add    $0x4,%edi
  5c:	39 f3                	cmp    %esi,%ebx
  5e:	7f e8                	jg     48 <main+0x48>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  60:	e8 73 02 00 00       	call   2d8 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  65:	8b 07                	mov    (%edi),%eax
  67:	c7 44 24 04 fe 07 00 	movl   $0x7fe,0x4(%esp)
  6e:	00 
  6f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  76:	89 44 24 08          	mov    %eax,0x8(%esp)
  7a:	e8 b1 03 00 00       	call   430 <printf>
  7f:	eb df                	jmp    60 <main+0x60>
  81:	90                   	nop    
  82:	90                   	nop    
  83:	90                   	nop    
  84:	90                   	nop    
  85:	90                   	nop    
  86:	90                   	nop    
  87:	90                   	nop    
  88:	90                   	nop    
  89:	90                   	nop    
  8a:	90                   	nop    
  8b:	90                   	nop    
  8c:	90                   	nop    
  8d:	90                   	nop    
  8e:	90                   	nop    
  8f:	90                   	nop    

00000090 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  90:	55                   	push   %ebp
  91:	31 d2                	xor    %edx,%edx
  93:	89 e5                	mov    %esp,%ebp
  95:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  98:	53                   	push   %ebx
  99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a0:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
  a4:	88 04 13             	mov    %al,(%ebx,%edx,1)
  a7:	83 c2 01             	add    $0x1,%edx
  aa:	84 c0                	test   %al,%al
  ac:	75 f2                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  ae:	89 d8                	mov    %ebx,%eax
  b0:	5b                   	pop    %ebx
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    
  b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	8b 55 08             	mov    0x8(%ebp),%edx
  c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ca:	0f b6 02             	movzbl (%edx),%eax
  cd:	84 c0                	test   %al,%al
  cf:	75 14                	jne    e5 <strcmp+0x25>
  d1:	eb 2d                	jmp    100 <strcmp+0x40>
  d3:	90                   	nop    
  d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  d8:	83 c2 01             	add    $0x1,%edx
  db:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  de:	0f b6 02             	movzbl (%edx),%eax
  e1:	84 c0                	test   %al,%al
  e3:	74 1b                	je     100 <strcmp+0x40>
  e5:	0f b6 19             	movzbl (%ecx),%ebx
  e8:	38 d8                	cmp    %bl,%al
  ea:	74 ec                	je     d8 <strcmp+0x18>
  ec:	0f b6 d0             	movzbl %al,%edx
  ef:	0f b6 c3             	movzbl %bl,%eax
  f2:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  f4:	89 d0                	mov    %edx,%eax
  f6:	5b                   	pop    %ebx
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 100:	0f b6 19             	movzbl (%ecx),%ebx
 103:	31 d2                	xor    %edx,%edx
 105:	0f b6 c3             	movzbl %bl,%eax
 108:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 10a:	89 d0                	mov    %edx,%eax
 10c:	5b                   	pop    %ebx
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
 10f:	90                   	nop    

00000110 <strlen>:

uint
strlen(char *s)
{
 110:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 111:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 113:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 115:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 117:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 11a:	80 3a 00             	cmpb   $0x0,(%edx)
 11d:	74 0c                	je     12b <strlen+0x1b>
 11f:	90                   	nop    
 120:	83 c0 01             	add    $0x1,%eax
 123:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 127:	75 f7                	jne    120 <strlen+0x10>
 129:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
 12b:	89 c8                	mov    %ecx,%eax
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    
 12f:	90                   	nop    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 10             	mov    0x10(%ebp),%eax
 136:	53                   	push   %ebx
 137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
 13a:	85 c0                	test   %eax,%eax
 13c:	74 14                	je     152 <memset+0x22>
 13e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 142:	31 d2                	xor    %edx,%edx
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 148:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
 14b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 14e:	39 c2                	cmp    %eax,%edx
 150:	75 f6                	jne    148 <memset+0x18>
    *d++ = c;
  return dst;
}
 152:	89 d8                	mov    %ebx,%eax
 154:	5b                   	pop    %ebx
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 11                	jne    182 <strchr+0x22>
 171:	eb 25                	jmp    198 <strchr+0x38>
 173:	90                   	nop    
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 178:	83 c0 01             	add    $0x1,%eax
 17b:	0f b6 10             	movzbl (%eax),%edx
 17e:	84 d2                	test   %dl,%dl
 180:	74 16                	je     198 <strchr+0x38>
    if(*s == c)
 182:	38 ca                	cmp    %cl,%dl
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 188:	75 ee                	jne    178 <strchr+0x18>
      return (char*) s;
  return 0;
}
 18a:	5d                   	pop    %ebp
 18b:	90                   	nop    
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	c3                   	ret    
 191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 198:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 19a:	5d                   	pop    %ebp
 19b:	90                   	nop    
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	c3                   	ret    
 1a1:	eb 0d                	jmp    1b0 <atoi>
 1a3:	90                   	nop    
 1a4:	90                   	nop    
 1a5:	90                   	nop    
 1a6:	90                   	nop    
 1a7:	90                   	nop    
 1a8:	90                   	nop    
 1a9:	90                   	nop    
 1aa:	90                   	nop    
 1ab:	90                   	nop    
 1ac:	90                   	nop    
 1ad:	90                   	nop    
 1ae:	90                   	nop    
 1af:	90                   	nop    

000001b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1b0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b1:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	53                   	push   %ebx
 1b6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b9:	0f b6 13             	movzbl (%ebx),%edx
 1bc:	8d 42 d0             	lea    -0x30(%edx),%eax
 1bf:	3c 09                	cmp    $0x9,%al
 1c1:	77 1c                	ja     1df <atoi+0x2f>
 1c3:	90                   	nop    
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 1c8:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 1cb:	0f be d2             	movsbl %dl,%edx
 1ce:	83 c3 01             	add    $0x1,%ebx
 1d1:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d5:	0f b6 13             	movzbl (%ebx),%edx
 1d8:	8d 42 d0             	lea    -0x30(%edx),%eax
 1db:	3c 09                	cmp    $0x9,%al
 1dd:	76 e9                	jbe    1c8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1df:	89 c8                	mov    %ecx,%eax
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1f6:	56                   	push   %esi
 1f7:	8b 75 08             	mov    0x8(%ebp),%esi
 1fa:	53                   	push   %ebx
 1fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1fe:	85 c9                	test   %ecx,%ecx
 200:	7e 14                	jle    216 <memmove+0x26>
 202:	31 d2                	xor    %edx,%edx
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 208:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 20c:	88 04 16             	mov    %al,(%esi,%edx,1)
 20f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 212:	39 ca                	cmp    %ecx,%edx
 214:	75 f2                	jne    208 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 216:	89 f0                	mov    %esi,%eax
 218:	5b                   	pop    %ebx
 219:	5e                   	pop    %esi
 21a:	5d                   	pop    %ebp
 21b:	c3                   	ret    
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 229:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 22c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 22f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 234:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 23b:	00 
 23c:	89 04 24             	mov    %eax,(%esp)
 23f:	e8 d4 00 00 00       	call   318 <open>
  if(fd < 0)
 244:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 246:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 248:	78 19                	js     263 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 1c 24             	mov    %ebx,(%esp)
 250:	89 44 24 04          	mov    %eax,0x4(%esp)
 254:	e8 d7 00 00 00       	call   330 <fstat>
  close(fd);
 259:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 25c:	89 c6                	mov    %eax,%esi
  close(fd);
 25e:	e8 9d 00 00 00       	call   300 <close>
  return r;
}
 263:	89 f0                	mov    %esi,%eax
 265:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 268:	8b 75 fc             	mov    -0x4(%ebp),%esi
 26b:	89 ec                	mov    %ebp,%esp
 26d:	5d                   	pop    %ebp
 26e:	c3                   	ret    
 26f:	90                   	nop    

00000270 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
 275:	31 f6                	xor    %esi,%esi
 277:	53                   	push   %ebx
 278:	83 ec 1c             	sub    $0x1c,%esp
 27b:	8b 7d 08             	mov    0x8(%ebp),%edi
 27e:	eb 06                	jmp    286 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 280:	3c 0d                	cmp    $0xd,%al
 282:	74 39                	je     2bd <gets+0x4d>
 284:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 286:	8d 5e 01             	lea    0x1(%esi),%ebx
 289:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 28c:	7d 31                	jge    2bf <gets+0x4f>
    cc = read(0, &c, 1);
 28e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 291:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 298:	00 
 299:	89 44 24 04          	mov    %eax,0x4(%esp)
 29d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2a4:	e8 47 00 00 00       	call   2f0 <read>
    if(cc < 1)
 2a9:	85 c0                	test   %eax,%eax
 2ab:	7e 12                	jle    2bf <gets+0x4f>
      break;
    buf[i++] = c;
 2ad:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2b1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 2b5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2b9:	3c 0a                	cmp    $0xa,%al
 2bb:	75 c3                	jne    280 <gets+0x10>
 2bd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 2bf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2c3:	89 f8                	mov    %edi,%eax
 2c5:	83 c4 1c             	add    $0x1c,%esp
 2c8:	5b                   	pop    %ebx
 2c9:	5e                   	pop    %esi
 2ca:	5f                   	pop    %edi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	90                   	nop    
 2ce:	90                   	nop    
 2cf:	90                   	nop    

000002d0 <fork>:
 2d0:	b8 01 00 00 00       	mov    $0x1,%eax
 2d5:	cd 30                	int    $0x30
 2d7:	c3                   	ret    

000002d8 <exit>:
 2d8:	b8 02 00 00 00       	mov    $0x2,%eax
 2dd:	cd 30                	int    $0x30
 2df:	c3                   	ret    

000002e0 <wait>:
 2e0:	b8 03 00 00 00       	mov    $0x3,%eax
 2e5:	cd 30                	int    $0x30
 2e7:	c3                   	ret    

000002e8 <pipe>:
 2e8:	b8 04 00 00 00       	mov    $0x4,%eax
 2ed:	cd 30                	int    $0x30
 2ef:	c3                   	ret    

000002f0 <read>:
 2f0:	b8 06 00 00 00       	mov    $0x6,%eax
 2f5:	cd 30                	int    $0x30
 2f7:	c3                   	ret    

000002f8 <write>:
 2f8:	b8 05 00 00 00       	mov    $0x5,%eax
 2fd:	cd 30                	int    $0x30
 2ff:	c3                   	ret    

00000300 <close>:
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 30                	int    $0x30
 307:	c3                   	ret    

00000308 <kill>:
 308:	b8 08 00 00 00       	mov    $0x8,%eax
 30d:	cd 30                	int    $0x30
 30f:	c3                   	ret    

00000310 <exec>:
 310:	b8 09 00 00 00       	mov    $0x9,%eax
 315:	cd 30                	int    $0x30
 317:	c3                   	ret    

00000318 <open>:
 318:	b8 0a 00 00 00       	mov    $0xa,%eax
 31d:	cd 30                	int    $0x30
 31f:	c3                   	ret    

00000320 <mknod>:
 320:	b8 0b 00 00 00       	mov    $0xb,%eax
 325:	cd 30                	int    $0x30
 327:	c3                   	ret    

00000328 <unlink>:
 328:	b8 0c 00 00 00       	mov    $0xc,%eax
 32d:	cd 30                	int    $0x30
 32f:	c3                   	ret    

00000330 <fstat>:
 330:	b8 0d 00 00 00       	mov    $0xd,%eax
 335:	cd 30                	int    $0x30
 337:	c3                   	ret    

00000338 <link>:
 338:	b8 0e 00 00 00       	mov    $0xe,%eax
 33d:	cd 30                	int    $0x30
 33f:	c3                   	ret    

00000340 <mkdir>:
 340:	b8 0f 00 00 00       	mov    $0xf,%eax
 345:	cd 30                	int    $0x30
 347:	c3                   	ret    

00000348 <chdir>:
 348:	b8 10 00 00 00       	mov    $0x10,%eax
 34d:	cd 30                	int    $0x30
 34f:	c3                   	ret    

00000350 <dup>:
 350:	b8 11 00 00 00       	mov    $0x11,%eax
 355:	cd 30                	int    $0x30
 357:	c3                   	ret    

00000358 <getpid>:
 358:	b8 12 00 00 00       	mov    $0x12,%eax
 35d:	cd 30                	int    $0x30
 35f:	c3                   	ret    

00000360 <sbrk>:
 360:	b8 13 00 00 00       	mov    $0x13,%eax
 365:	cd 30                	int    $0x30
 367:	c3                   	ret    

00000368 <sleep>:
 368:	b8 14 00 00 00       	mov    $0x14,%eax
 36d:	cd 30                	int    $0x30
 36f:	c3                   	ret    

00000370 <mytime>:
 370:	b8 15 00 00 00       	mov    $0x15,%eax
 375:	cd 30                	int    $0x30
 377:	c3                   	ret    

00000378 <settickets>:
 378:	b8 16 00 00 00       	mov    $0x16,%eax
 37d:	cd 30                	int    $0x30
 37f:	c3                   	ret    

00000380 <getruntime>:
 380:	b8 17 00 00 00       	mov    $0x17,%eax
 385:	cd 30                	int    $0x30
 387:	c3                   	ret    
 388:	90                   	nop    
 389:	90                   	nop    
 38a:	90                   	nop    
 38b:	90                   	nop    
 38c:	90                   	nop    
 38d:	90                   	nop    
 38e:	90                   	nop    
 38f:	90                   	nop    

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	89 ce                	mov    %ecx,%esi
 397:	53                   	push   %ebx
 398:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 39b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 39e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a1:	85 c9                	test   %ecx,%ecx
 3a3:	74 04                	je     3a9 <printint+0x19>
 3a5:	85 d2                	test   %edx,%edx
 3a7:	78 77                	js     420 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3a9:	89 d0                	mov    %edx,%eax
 3ab:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 3b2:	31 db                	xor    %ebx,%ebx
 3b4:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 3b7:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3b8:	31 d2                	xor    %edx,%edx
 3ba:	f7 f6                	div    %esi
 3bc:	89 c1                	mov    %eax,%ecx
 3be:	0f b6 82 21 08 00 00 	movzbl 0x821(%edx),%eax
 3c5:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 3c8:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 3cb:	85 c9                	test   %ecx,%ecx
 3cd:	89 c8                	mov    %ecx,%eax
 3cf:	75 e7                	jne    3b8 <printint+0x28>
  if(neg)
 3d1:	8b 45 d0             	mov    -0x30(%ebp),%eax
 3d4:	85 c0                	test   %eax,%eax
 3d6:	74 08                	je     3e0 <printint+0x50>
    buf[i++] = '-';
 3d8:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 3dd:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 3e0:	8d 73 ff             	lea    -0x1(%ebx),%esi
 3e3:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 3e6:	8d 7d f3             	lea    -0xd(%ebp),%edi
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 3f0:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3f3:	83 ee 01             	sub    $0x1,%esi
 3f6:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 400:	00 
 401:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 405:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 408:	8b 45 cc             	mov    -0x34(%ebp),%eax
 40b:	89 04 24             	mov    %eax,(%esp)
 40e:	e8 e5 fe ff ff       	call   2f8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 413:	83 fe ff             	cmp    $0xffffffff,%esi
 416:	75 d8                	jne    3f0 <printint+0x60>
    putc(fd, buf[i]);
}
 418:	83 c4 3c             	add    $0x3c,%esp
 41b:	5b                   	pop    %ebx
 41c:	5e                   	pop    %esi
 41d:	5f                   	pop    %edi
 41e:	5d                   	pop    %ebp
 41f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 420:	89 d0                	mov    %edx,%eax
 422:	f7 d8                	neg    %eax
 424:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 42b:	eb 85                	jmp    3b2 <printint+0x22>
 42d:	8d 76 00             	lea    0x0(%esi),%esi

00000430 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 55 0c             	mov    0xc(%ebp),%edx
 43c:	0f b6 02             	movzbl (%edx),%eax
 43f:	84 c0                	test   %al,%al
 441:	0f 84 e9 00 00 00    	je     530 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 447:	8d 4d 10             	lea    0x10(%ebp),%ecx
 44a:	89 d7                	mov    %edx,%edi
 44c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 44f:	31 f6                	xor    %esi,%esi
 451:	eb 21                	jmp    474 <printf+0x44>
 453:	90                   	nop    
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 458:	83 fb 25             	cmp    $0x25,%ebx
 45b:	0f 85 d7 00 00 00    	jne    538 <printf+0x108>
 461:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 465:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 469:	83 c7 01             	add    $0x1,%edi
 46c:	84 c0                	test   %al,%al
 46e:	0f 84 bc 00 00 00    	je     530 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 474:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 476:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 479:	74 dd                	je     458 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47b:	83 fe 25             	cmp    $0x25,%esi
 47e:	75 e5                	jne    465 <printf+0x35>
      if(c == 'd'){
 480:	83 fb 64             	cmp    $0x64,%ebx
 483:	90                   	nop    
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 488:	0f 84 4a 01 00 00    	je     5d8 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 48e:	83 fb 78             	cmp    $0x78,%ebx
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 498:	0f 84 c2 00 00 00    	je     560 <printf+0x130>
 49e:	83 fb 70             	cmp    $0x70,%ebx
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	0f 84 b2 00 00 00    	je     560 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ae:	83 fb 73             	cmp    $0x73,%ebx
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	0f 84 ca 00 00 00    	je     588 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4be:	83 fb 63             	cmp    $0x63,%ebx
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c8:	0f 84 5a 01 00 00    	je     628 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4ce:	83 fb 25             	cmp    $0x25,%ebx
 4d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4d8:	0f 84 22 01 00 00    	je     600 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4de:	8b 55 08             	mov    0x8(%ebp),%edx
 4e1:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4e4:	31 f6                	xor    %esi,%esi
 4e6:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f1:	00 
 4f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f6:	89 14 24             	mov    %edx,(%esp)
 4f9:	e8 fa fd ff ff       	call   2f8 <write>
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 504:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 507:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50e:	00 
 50f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 513:	89 04 24             	mov    %eax,(%esp)
 516:	e8 dd fd ff ff       	call   2f8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 51b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 51f:	83 c7 01             	add    $0x1,%edi
 522:	84 c0                	test   %al,%al
 524:	0f 85 4a ff ff ff    	jne    474 <printf+0x44>
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 530:	83 c4 2c             	add    $0x2c,%esp
 533:	5b                   	pop    %ebx
 534:	5e                   	pop    %esi
 535:	5f                   	pop    %edi
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 538:	8b 55 08             	mov    0x8(%ebp),%edx
 53b:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 53e:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 541:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 548:	00 
 549:	89 44 24 04          	mov    %eax,0x4(%esp)
 54d:	89 14 24             	mov    %edx,(%esp)
 550:	e8 a3 fd ff ff       	call   2f8 <write>
 555:	e9 0b ff ff ff       	jmp    465 <printf+0x35>
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 560:	8b 45 e0             	mov    -0x20(%ebp),%eax
 563:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 568:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 56a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 571:	8b 10                	mov    (%eax),%edx
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	e8 15 fe ff ff       	call   390 <printint>
        ap++;
 57b:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 57f:	e9 e1 fe ff ff       	jmp    465 <printf+0x35>
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 588:	8b 55 e0             	mov    -0x20(%ebp),%edx
 58b:	8b 1a                	mov    (%edx),%ebx
        ap++;
 58d:	83 c2 04             	add    $0x4,%edx
 590:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 593:	85 db                	test   %ebx,%ebx
 595:	0f 84 ba 00 00 00    	je     655 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 59b:	0f b6 03             	movzbl (%ebx),%eax
 59e:	84 c0                	test   %al,%al
 5a0:	74 2d                	je     5cf <printf+0x19f>
 5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 5a8:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ab:	8b 45 08             	mov    0x8(%ebp),%eax
 5ae:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5b1:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5bb:	00 
 5bc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 5c0:	89 04 24             	mov    %eax,(%esp)
 5c3:	e8 30 fd ff ff       	call   2f8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c8:	0f b6 03             	movzbl (%ebx),%eax
 5cb:	84 c0                	test   %al,%al
 5cd:	75 d9                	jne    5a8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5cf:	31 f6                	xor    %esi,%esi
 5d1:	e9 8f fe ff ff       	jmp    465 <printf+0x35>
 5d6:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5db:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 5e0:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5ea:	8b 10                	mov    (%eax),%edx
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	e8 9c fd ff ff       	call   390 <printint>
        ap++;
 5f4:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 5f8:	e9 68 fe ff ff       	jmp    465 <printf+0x35>
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 600:	8b 4d 08             	mov    0x8(%ebp),%ecx
 603:	8d 55 f3             	lea    -0xd(%ebp),%edx
 606:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 608:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 60c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 613:	00 
 614:	89 54 24 04          	mov    %edx,0x4(%esp)
 618:	89 0c 24             	mov    %ecx,(%esp)
 61b:	e8 d8 fc ff ff       	call   2f8 <write>
 620:	e9 40 fe ff ff       	jmp    465 <printf+0x35>
 625:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 628:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62b:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 62e:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 630:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 632:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 639:	00 
 63a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 63e:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 641:	8b 45 08             	mov    0x8(%ebp),%eax
 644:	89 04 24             	mov    %eax,(%esp)
 647:	e8 ac fc ff ff       	call   2f8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 64c:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 650:	e9 10 fe ff ff       	jmp    465 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 655:	bb 1a 08 00 00       	mov    $0x81a,%ebx
 65a:	e9 3c ff ff ff       	jmp    59b <printf+0x16b>
 65f:	90                   	nop    

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	8b 0d 3c 08 00 00    	mov    0x83c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 667:	89 e5                	mov    %esp,%ebp
 669:	57                   	push   %edi
 66a:	56                   	push   %esi
 66b:	53                   	push   %ebx
 66c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 66f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 672:	39 d9                	cmp    %ebx,%ecx
 674:	73 24                	jae    69a <free+0x3a>
 676:	66 90                	xchg   %ax,%ax
 678:	8b 11                	mov    (%ecx),%edx
 67a:	39 d3                	cmp    %edx,%ebx
 67c:	72 2a                	jb     6a8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67e:	39 d1                	cmp    %edx,%ecx
 680:	72 10                	jb     692 <free+0x32>
 682:	39 d9                	cmp    %ebx,%ecx
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 688:	72 1e                	jb     6a8 <free+0x48>
 68a:	39 d3                	cmp    %edx,%ebx
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 690:	72 16                	jb     6a8 <free+0x48>
 692:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 694:	39 d9                	cmp    %ebx,%ecx
 696:	66 90                	xchg   %ax,%ax
 698:	72 de                	jb     678 <free+0x18>
 69a:	8b 11                	mov    (%ecx),%edx
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a0:	eb dc                	jmp    67e <free+0x1e>
 6a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a8:	8b 73 04             	mov    0x4(%ebx),%esi
 6ab:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 6ae:	39 d0                	cmp    %edx,%eax
 6b0:	74 1a                	je     6cc <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b2:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 6b5:	8b 51 04             	mov    0x4(%ecx),%edx
 6b8:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6bb:	39 d8                	cmp    %ebx,%eax
 6bd:	74 22                	je     6e1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6bf:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 6c1:	89 0d 3c 08 00 00    	mov    %ecx,0x83c
}
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5f                   	pop    %edi
 6ca:	5d                   	pop    %ebp
 6cb:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6cc:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 6cf:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6d1:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6d4:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6d7:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6da:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6dd:	39 d8                	cmp    %ebx,%eax
 6df:	75 de                	jne    6bf <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6e1:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6e4:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 6e7:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6e9:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6ec:	89 0d 3c 08 00 00    	mov    %ecx,0x83c
}
 6f2:	5b                   	pop    %ebx
 6f3:	5e                   	pop    %esi
 6f4:	5f                   	pop    %edi
 6f5:	5d                   	pop    %ebp
 6f6:	c3                   	ret    
 6f7:	89 f6                	mov    %esi,%esi
 6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 70c:	8b 35 3c 08 00 00    	mov    0x83c,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 712:	83 c0 07             	add    $0x7,%eax
 715:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 718:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 71d:	0f 84 95 00 00 00    	je     7b8 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 723:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 725:	8b 41 04             	mov    0x4(%ecx),%eax
 728:	39 c3                	cmp    %eax,%ebx
 72a:	0f 86 b0 00 00 00    	jbe    7e0 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 730:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 737:	90                   	nop    
    }
    if(p == freep)
 738:	3b 0d 3c 08 00 00    	cmp    0x83c,%ecx
 73e:	89 ca                	mov    %ecx,%edx
 740:	74 34                	je     776 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 742:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 744:	8b 41 04             	mov    0x4(%ecx),%eax
 747:	39 c3                	cmp    %eax,%ebx
 749:	77 ed                	ja     738 <malloc+0x38>
 74b:	89 d6                	mov    %edx,%esi
 74d:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 74f:	39 c3                	cmp    %eax,%ebx
 751:	74 1d                	je     770 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 753:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 755:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 758:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 75b:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 75e:	89 35 3c 08 00 00    	mov    %esi,0x83c
      return (void*) (p + 1);
 764:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 767:	83 c4 0c             	add    $0xc,%esp
 76a:	5b                   	pop    %ebx
 76b:	5e                   	pop    %esi
 76c:	5f                   	pop    %edi
 76d:	5d                   	pop    %ebp
 76e:	c3                   	ret    
 76f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 770:	8b 01                	mov    (%ecx),%eax
 772:	89 06                	mov    %eax,(%esi)
 774:	eb e8                	jmp    75e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 776:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 77c:	bf 00 10 00 00       	mov    $0x1000,%edi
 781:	b8 00 80 00 00       	mov    $0x8000,%eax
 786:	76 04                	jbe    78c <malloc+0x8c>
 788:	89 df                	mov    %ebx,%edi
 78a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 78c:	89 04 24             	mov    %eax,(%esp)
 78f:	e8 cc fb ff ff       	call   360 <sbrk>
  if(p == (char*) -1)
 794:	83 f8 ff             	cmp    $0xffffffff,%eax
 797:	74 18                	je     7b1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 799:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 79c:	83 c0 08             	add    $0x8,%eax
 79f:	89 04 24             	mov    %eax,(%esp)
 7a2:	e8 b9 fe ff ff       	call   660 <free>
  return freep;
 7a7:	8b 15 3c 08 00 00    	mov    0x83c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7ad:	85 d2                	test   %edx,%edx
 7af:	75 91                	jne    742 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b1:	31 c0                	xor    %eax,%eax
 7b3:	eb b2                	jmp    767 <malloc+0x67>
 7b5:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7b8:	c7 05 3c 08 00 00 34 	movl   $0x834,0x83c
 7bf:	08 00 00 
    base.s.size = 0;
 7c2:	be 34 08 00 00       	mov    $0x834,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7c7:	c7 05 34 08 00 00 34 	movl   $0x834,0x834
 7ce:	08 00 00 
    base.s.size = 0;
 7d1:	c7 05 38 08 00 00 00 	movl   $0x0,0x838
 7d8:	00 00 00 
 7db:	e9 43 ff ff ff       	jmp    723 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7e0:	89 ca                	mov    %ecx,%edx
 7e2:	e9 68 ff ff ff       	jmp    74f <malloc+0x4f>

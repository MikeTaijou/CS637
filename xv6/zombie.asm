
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 5a 02 00 00       	call   270 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0c                	jle    26 <main+0x26>
    sleep(5);  // Let child exit before parent.
  1a:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  21:	e8 e2 02 00 00       	call   308 <sleep>
  exit();
  26:	e8 4d 02 00 00       	call   278 <exit>
  2b:	90                   	nop    
  2c:	90                   	nop    
  2d:	90                   	nop    
  2e:	90                   	nop    
  2f:	90                   	nop    

00000030 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  31:	31 d2                	xor    %edx,%edx
  33:	89 e5                	mov    %esp,%ebp
  35:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  38:	53                   	push   %ebx
  39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  40:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
  44:	88 04 13             	mov    %al,(%ebx,%edx,1)
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 c0                	test   %al,%al
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	89 d8                	mov    %ebx,%eax
  50:	5b                   	pop    %ebx
  51:	5d                   	pop    %ebp
  52:	c3                   	ret    
  53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 14                	jne    85 <strcmp+0x25>
  71:	eb 2d                	jmp    a0 <strcmp+0x40>
  73:	90                   	nop    
  74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  78:	83 c2 01             	add    $0x1,%edx
  7b:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7e:	0f b6 02             	movzbl (%edx),%eax
  81:	84 c0                	test   %al,%al
  83:	74 1b                	je     a0 <strcmp+0x40>
  85:	0f b6 19             	movzbl (%ecx),%ebx
  88:	38 d8                	cmp    %bl,%al
  8a:	74 ec                	je     78 <strcmp+0x18>
  8c:	0f b6 d0             	movzbl %al,%edx
  8f:	0f b6 c3             	movzbl %bl,%eax
  92:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  94:	89 d0                	mov    %edx,%eax
  96:	5b                   	pop    %ebx
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a0:	0f b6 19             	movzbl (%ecx),%ebx
  a3:	31 d2                	xor    %edx,%edx
  a5:	0f b6 c3             	movzbl %bl,%eax
  a8:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  aa:	89 d0                	mov    %edx,%eax
  ac:	5b                   	pop    %ebx
  ad:	5d                   	pop    %ebp
  ae:	c3                   	ret    
  af:	90                   	nop    

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  b1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
  b5:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  ba:	80 3a 00             	cmpb   $0x0,(%edx)
  bd:	74 0c                	je     cb <strlen+0x1b>
  bf:	90                   	nop    
  c0:	83 c0 01             	add    $0x1,%eax
  c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  c7:	75 f7                	jne    c0 <strlen+0x10>
  c9:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
  cb:	89 c8                	mov    %ecx,%eax
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
  cf:	90                   	nop    

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 10             	mov    0x10(%ebp),%eax
  d6:	53                   	push   %ebx
  d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
  da:	85 c0                	test   %eax,%eax
  dc:	74 14                	je     f2 <memset+0x22>
  de:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  e2:	31 d2                	xor    %edx,%edx
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
  e8:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
  eb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
  ee:	39 c2                	cmp    %eax,%edx
  f0:	75 f6                	jne    e8 <memset+0x18>
    *d++ = c;
  return dst;
}
  f2:	89 d8                	mov    %ebx,%eax
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 11                	jne    122 <strchr+0x22>
 111:	eb 25                	jmp    138 <strchr+0x38>
 113:	90                   	nop    
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 118:	83 c0 01             	add    $0x1,%eax
 11b:	0f b6 10             	movzbl (%eax),%edx
 11e:	84 d2                	test   %dl,%dl
 120:	74 16                	je     138 <strchr+0x38>
    if(*s == c)
 122:	38 ca                	cmp    %cl,%dl
 124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 128:	75 ee                	jne    118 <strchr+0x18>
      return (char*) s;
  return 0;
}
 12a:	5d                   	pop    %ebp
 12b:	90                   	nop    
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	c3                   	ret    
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 138:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 13a:	5d                   	pop    %ebp
 13b:	90                   	nop    
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 140:	c3                   	ret    
 141:	eb 0d                	jmp    150 <atoi>
 143:	90                   	nop    
 144:	90                   	nop    
 145:	90                   	nop    
 146:	90                   	nop    
 147:	90                   	nop    
 148:	90                   	nop    
 149:	90                   	nop    
 14a:	90                   	nop    
 14b:	90                   	nop    
 14c:	90                   	nop    
 14d:	90                   	nop    
 14e:	90                   	nop    
 14f:	90                   	nop    

00000150 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 150:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 151:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 153:	89 e5                	mov    %esp,%ebp
 155:	53                   	push   %ebx
 156:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 159:	0f b6 13             	movzbl (%ebx),%edx
 15c:	8d 42 d0             	lea    -0x30(%edx),%eax
 15f:	3c 09                	cmp    $0x9,%al
 161:	77 1c                	ja     17f <atoi+0x2f>
 163:	90                   	nop    
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 168:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 16b:	0f be d2             	movsbl %dl,%edx
 16e:	83 c3 01             	add    $0x1,%ebx
 171:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 175:	0f b6 13             	movzbl (%ebx),%edx
 178:	8d 42 d0             	lea    -0x30(%edx),%eax
 17b:	3c 09                	cmp    $0x9,%al
 17d:	76 e9                	jbe    168 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 17f:	89 c8                	mov    %ecx,%eax
 181:	5b                   	pop    %ebx
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
 184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 18a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000190 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 10             	mov    0x10(%ebp),%ecx
 196:	56                   	push   %esi
 197:	8b 75 08             	mov    0x8(%ebp),%esi
 19a:	53                   	push   %ebx
 19b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 19e:	85 c9                	test   %ecx,%ecx
 1a0:	7e 14                	jle    1b6 <memmove+0x26>
 1a2:	31 d2                	xor    %edx,%edx
 1a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 1a8:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 1ac:	88 04 16             	mov    %al,(%esi,%edx,1)
 1af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1b2:	39 ca                	cmp    %ecx,%edx
 1b4:	75 f2                	jne    1a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 1b6:	89 f0                	mov    %esi,%eax
 1b8:	5b                   	pop    %ebx
 1b9:	5e                   	pop    %esi
 1ba:	5d                   	pop    %ebp
 1bb:	c3                   	ret    
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 1cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1db:	00 
 1dc:	89 04 24             	mov    %eax,(%esp)
 1df:	e8 d4 00 00 00       	call   2b8 <open>
  if(fd < 0)
 1e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1e8:	78 19                	js     203 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 1c 24             	mov    %ebx,(%esp)
 1f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f4:	e8 d7 00 00 00       	call   2d0 <fstat>
  close(fd);
 1f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1fc:	89 c6                	mov    %eax,%esi
  close(fd);
 1fe:	e8 9d 00 00 00       	call   2a0 <close>
  return r;
}
 203:	89 f0                	mov    %esi,%eax
 205:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 208:	8b 75 fc             	mov    -0x4(%ebp),%esi
 20b:	89 ec                	mov    %ebp,%esp
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop    

00000210 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	31 f6                	xor    %esi,%esi
 217:	53                   	push   %ebx
 218:	83 ec 1c             	sub    $0x1c,%esp
 21b:	8b 7d 08             	mov    0x8(%ebp),%edi
 21e:	eb 06                	jmp    226 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 220:	3c 0d                	cmp    $0xd,%al
 222:	74 39                	je     25d <gets+0x4d>
 224:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 226:	8d 5e 01             	lea    0x1(%esi),%ebx
 229:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22c:	7d 31                	jge    25f <gets+0x4f>
    cc = read(0, &c, 1);
 22e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 231:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 238:	00 
 239:	89 44 24 04          	mov    %eax,0x4(%esp)
 23d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 244:	e8 47 00 00 00       	call   290 <read>
    if(cc < 1)
 249:	85 c0                	test   %eax,%eax
 24b:	7e 12                	jle    25f <gets+0x4f>
      break;
    buf[i++] = c;
 24d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 251:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 255:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 259:	3c 0a                	cmp    $0xa,%al
 25b:	75 c3                	jne    220 <gets+0x10>
 25d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 25f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 263:	89 f8                	mov    %edi,%eax
 265:	83 c4 1c             	add    $0x1c,%esp
 268:	5b                   	pop    %ebx
 269:	5e                   	pop    %esi
 26a:	5f                   	pop    %edi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	90                   	nop    
 26e:	90                   	nop    
 26f:	90                   	nop    

00000270 <fork>:
 270:	b8 01 00 00 00       	mov    $0x1,%eax
 275:	cd 30                	int    $0x30
 277:	c3                   	ret    

00000278 <exit>:
 278:	b8 02 00 00 00       	mov    $0x2,%eax
 27d:	cd 30                	int    $0x30
 27f:	c3                   	ret    

00000280 <wait>:
 280:	b8 03 00 00 00       	mov    $0x3,%eax
 285:	cd 30                	int    $0x30
 287:	c3                   	ret    

00000288 <pipe>:
 288:	b8 04 00 00 00       	mov    $0x4,%eax
 28d:	cd 30                	int    $0x30
 28f:	c3                   	ret    

00000290 <read>:
 290:	b8 06 00 00 00       	mov    $0x6,%eax
 295:	cd 30                	int    $0x30
 297:	c3                   	ret    

00000298 <write>:
 298:	b8 05 00 00 00       	mov    $0x5,%eax
 29d:	cd 30                	int    $0x30
 29f:	c3                   	ret    

000002a0 <close>:
 2a0:	b8 07 00 00 00       	mov    $0x7,%eax
 2a5:	cd 30                	int    $0x30
 2a7:	c3                   	ret    

000002a8 <kill>:
 2a8:	b8 08 00 00 00       	mov    $0x8,%eax
 2ad:	cd 30                	int    $0x30
 2af:	c3                   	ret    

000002b0 <exec>:
 2b0:	b8 09 00 00 00       	mov    $0x9,%eax
 2b5:	cd 30                	int    $0x30
 2b7:	c3                   	ret    

000002b8 <open>:
 2b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2bd:	cd 30                	int    $0x30
 2bf:	c3                   	ret    

000002c0 <mknod>:
 2c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c5:	cd 30                	int    $0x30
 2c7:	c3                   	ret    

000002c8 <unlink>:
 2c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2cd:	cd 30                	int    $0x30
 2cf:	c3                   	ret    

000002d0 <fstat>:
 2d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d5:	cd 30                	int    $0x30
 2d7:	c3                   	ret    

000002d8 <link>:
 2d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2dd:	cd 30                	int    $0x30
 2df:	c3                   	ret    

000002e0 <mkdir>:
 2e0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e5:	cd 30                	int    $0x30
 2e7:	c3                   	ret    

000002e8 <chdir>:
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 30                	int    $0x30
 2ef:	c3                   	ret    

000002f0 <dup>:
 2f0:	b8 11 00 00 00       	mov    $0x11,%eax
 2f5:	cd 30                	int    $0x30
 2f7:	c3                   	ret    

000002f8 <getpid>:
 2f8:	b8 12 00 00 00       	mov    $0x12,%eax
 2fd:	cd 30                	int    $0x30
 2ff:	c3                   	ret    

00000300 <sbrk>:
 300:	b8 13 00 00 00       	mov    $0x13,%eax
 305:	cd 30                	int    $0x30
 307:	c3                   	ret    

00000308 <sleep>:
 308:	b8 14 00 00 00       	mov    $0x14,%eax
 30d:	cd 30                	int    $0x30
 30f:	c3                   	ret    

00000310 <mytime>:
 310:	b8 15 00 00 00       	mov    $0x15,%eax
 315:	cd 30                	int    $0x30
 317:	c3                   	ret    

00000318 <settickets>:
 318:	b8 16 00 00 00       	mov    $0x16,%eax
 31d:	cd 30                	int    $0x30
 31f:	c3                   	ret    

00000320 <getruntime>:
 320:	b8 17 00 00 00       	mov    $0x17,%eax
 325:	cd 30                	int    $0x30
 327:	c3                   	ret    
 328:	90                   	nop    
 329:	90                   	nop    
 32a:	90                   	nop    
 32b:	90                   	nop    
 32c:	90                   	nop    
 32d:	90                   	nop    
 32e:	90                   	nop    
 32f:	90                   	nop    

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	89 ce                	mov    %ecx,%esi
 337:	53                   	push   %ebx
 338:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 33b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 33e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 341:	85 c9                	test   %ecx,%ecx
 343:	74 04                	je     349 <printint+0x19>
 345:	85 d2                	test   %edx,%edx
 347:	78 77                	js     3c0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 349:	89 d0                	mov    %edx,%eax
 34b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 352:	31 db                	xor    %ebx,%ebx
 354:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 357:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 358:	31 d2                	xor    %edx,%edx
 35a:	f7 f6                	div    %esi
 35c:	89 c1                	mov    %eax,%ecx
 35e:	0f b6 82 8e 07 00 00 	movzbl 0x78e(%edx),%eax
 365:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 368:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 36b:	85 c9                	test   %ecx,%ecx
 36d:	89 c8                	mov    %ecx,%eax
 36f:	75 e7                	jne    358 <printint+0x28>
  if(neg)
 371:	8b 45 d0             	mov    -0x30(%ebp),%eax
 374:	85 c0                	test   %eax,%eax
 376:	74 08                	je     380 <printint+0x50>
    buf[i++] = '-';
 378:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 37d:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 380:	8d 73 ff             	lea    -0x1(%ebx),%esi
 383:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 386:	8d 7d f3             	lea    -0xd(%ebp),%edi
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 390:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 393:	83 ee 01             	sub    $0x1,%esi
 396:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 399:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a0:	00 
 3a1:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 3a5:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a8:	8b 45 cc             	mov    -0x34(%ebp),%eax
 3ab:	89 04 24             	mov    %eax,(%esp)
 3ae:	e8 e5 fe ff ff       	call   298 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3b3:	83 fe ff             	cmp    $0xffffffff,%esi
 3b6:	75 d8                	jne    390 <printint+0x60>
    putc(fd, buf[i]);
}
 3b8:	83 c4 3c             	add    $0x3c,%esp
 3bb:	5b                   	pop    %ebx
 3bc:	5e                   	pop    %esi
 3bd:	5f                   	pop    %edi
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3c0:	89 d0                	mov    %edx,%eax
 3c2:	f7 d8                	neg    %eax
 3c4:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 3cb:	eb 85                	jmp    352 <printint+0x22>
 3cd:	8d 76 00             	lea    0x0(%esi),%esi

000003d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d9:	8b 55 0c             	mov    0xc(%ebp),%edx
 3dc:	0f b6 02             	movzbl (%edx),%eax
 3df:	84 c0                	test   %al,%al
 3e1:	0f 84 e9 00 00 00    	je     4d0 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3e7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3ea:	89 d7                	mov    %edx,%edi
 3ec:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 3ef:	31 f6                	xor    %esi,%esi
 3f1:	eb 21                	jmp    414 <printf+0x44>
 3f3:	90                   	nop    
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f8:	83 fb 25             	cmp    $0x25,%ebx
 3fb:	0f 85 d7 00 00 00    	jne    4d8 <printf+0x108>
 401:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 405:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 409:	83 c7 01             	add    $0x1,%edi
 40c:	84 c0                	test   %al,%al
 40e:	0f 84 bc 00 00 00    	je     4d0 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 414:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 416:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 419:	74 dd                	je     3f8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 41b:	83 fe 25             	cmp    $0x25,%esi
 41e:	75 e5                	jne    405 <printf+0x35>
      if(c == 'd'){
 420:	83 fb 64             	cmp    $0x64,%ebx
 423:	90                   	nop    
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 428:	0f 84 4a 01 00 00    	je     578 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 42e:	83 fb 78             	cmp    $0x78,%ebx
 431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 438:	0f 84 c2 00 00 00    	je     500 <printf+0x130>
 43e:	83 fb 70             	cmp    $0x70,%ebx
 441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 448:	0f 84 b2 00 00 00    	je     500 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44e:	83 fb 73             	cmp    $0x73,%ebx
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 458:	0f 84 ca 00 00 00    	je     528 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 45e:	83 fb 63             	cmp    $0x63,%ebx
 461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 468:	0f 84 5a 01 00 00    	je     5c8 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 46e:	83 fb 25             	cmp    $0x25,%ebx
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 478:	0f 84 22 01 00 00    	je     5a0 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47e:	8b 55 08             	mov    0x8(%ebp),%edx
 481:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 484:	31 f6                	xor    %esi,%esi
 486:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 48a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 491:	00 
 492:	89 44 24 04          	mov    %eax,0x4(%esp)
 496:	89 14 24             	mov    %edx,(%esp)
 499:	e8 fa fd ff ff       	call   298 <write>
 49e:	8b 45 08             	mov    0x8(%ebp),%eax
 4a1:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4a4:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ae:	00 
 4af:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 4b3:	89 04 24             	mov    %eax,(%esp)
 4b6:	e8 dd fd ff ff       	call   298 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bb:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 4bf:	83 c7 01             	add    $0x1,%edi
 4c2:	84 c0                	test   %al,%al
 4c4:	0f 85 4a ff ff ff    	jne    414 <printf+0x44>
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4d0:	83 c4 2c             	add    $0x2c,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4d8:	8b 55 08             	mov    0x8(%ebp),%edx
 4db:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4de:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e8:	00 
 4e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ed:	89 14 24             	mov    %edx,(%esp)
 4f0:	e8 a3 fd ff ff       	call   298 <write>
 4f5:	e9 0b ff ff ff       	jmp    405 <printf+0x35>
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 500:	8b 45 e0             	mov    -0x20(%ebp),%eax
 503:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 508:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 50a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 511:	8b 10                	mov    (%eax),%edx
 513:	8b 45 08             	mov    0x8(%ebp),%eax
 516:	e8 15 fe ff ff       	call   330 <printint>
        ap++;
 51b:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 51f:	e9 e1 fe ff ff       	jmp    405 <printf+0x35>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 528:	8b 55 e0             	mov    -0x20(%ebp),%edx
 52b:	8b 1a                	mov    (%edx),%ebx
        ap++;
 52d:	83 c2 04             	add    $0x4,%edx
 530:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 533:	85 db                	test   %ebx,%ebx
 535:	0f 84 ba 00 00 00    	je     5f5 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 53b:	0f b6 03             	movzbl (%ebx),%eax
 53e:	84 c0                	test   %al,%al
 540:	74 2d                	je     56f <printf+0x19f>
 542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 548:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 54b:	8b 45 08             	mov    0x8(%ebp),%eax
 54e:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 551:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 554:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55b:	00 
 55c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 560:	89 04 24             	mov    %eax,(%esp)
 563:	e8 30 fd ff ff       	call   298 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 568:	0f b6 03             	movzbl (%ebx),%eax
 56b:	84 c0                	test   %al,%al
 56d:	75 d9                	jne    548 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56f:	31 f6                	xor    %esi,%esi
 571:	e9 8f fe ff ff       	jmp    405 <printf+0x35>
 576:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 578:	8b 45 e0             	mov    -0x20(%ebp),%eax
 57b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 580:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 583:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 58a:	8b 10                	mov    (%eax),%edx
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
 58f:	e8 9c fd ff ff       	call   330 <printint>
        ap++;
 594:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 598:	e9 68 fe ff ff       	jmp    405 <printf+0x35>
 59d:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5a3:	8d 55 f3             	lea    -0xd(%ebp),%edx
 5a6:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5a8:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ac:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b3:	00 
 5b4:	89 54 24 04          	mov    %edx,0x4(%esp)
 5b8:	89 0c 24             	mov    %ecx,(%esp)
 5bb:	e8 d8 fc ff ff       	call   298 <write>
 5c0:	e9 40 fe ff ff       	jmp    405 <printf+0x35>
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5cb:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5ce:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5d0:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5d2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5d9:	00 
 5da:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5de:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
 5e4:	89 04 24             	mov    %eax,(%esp)
 5e7:	e8 ac fc ff ff       	call   298 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5ec:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 5f0:	e9 10 fe ff ff       	jmp    405 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 5f5:	bb 87 07 00 00       	mov    $0x787,%ebx
 5fa:	e9 3c ff ff ff       	jmp    53b <printf+0x16b>
 5ff:	90                   	nop    

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	8b 0d a8 07 00 00    	mov    0x7a8,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 607:	89 e5                	mov    %esp,%ebp
 609:	57                   	push   %edi
 60a:	56                   	push   %esi
 60b:	53                   	push   %ebx
 60c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 60f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 612:	39 d9                	cmp    %ebx,%ecx
 614:	73 24                	jae    63a <free+0x3a>
 616:	66 90                	xchg   %ax,%ax
 618:	8b 11                	mov    (%ecx),%edx
 61a:	39 d3                	cmp    %edx,%ebx
 61c:	72 2a                	jb     648 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61e:	39 d1                	cmp    %edx,%ecx
 620:	72 10                	jb     632 <free+0x32>
 622:	39 d9                	cmp    %ebx,%ecx
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 628:	72 1e                	jb     648 <free+0x48>
 62a:	39 d3                	cmp    %edx,%ebx
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 630:	72 16                	jb     648 <free+0x48>
 632:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 634:	39 d9                	cmp    %ebx,%ecx
 636:	66 90                	xchg   %ax,%ax
 638:	72 de                	jb     618 <free+0x18>
 63a:	8b 11                	mov    (%ecx),%edx
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 640:	eb dc                	jmp    61e <free+0x1e>
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 648:	8b 73 04             	mov    0x4(%ebx),%esi
 64b:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 64e:	39 d0                	cmp    %edx,%eax
 650:	74 1a                	je     66c <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 652:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 655:	8b 51 04             	mov    0x4(%ecx),%edx
 658:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 65b:	39 d8                	cmp    %ebx,%eax
 65d:	74 22                	je     681 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 65f:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 661:	89 0d a8 07 00 00    	mov    %ecx,0x7a8
}
 667:	5b                   	pop    %ebx
 668:	5e                   	pop    %esi
 669:	5f                   	pop    %edi
 66a:	5d                   	pop    %ebp
 66b:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 66c:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 66f:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 671:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 674:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 677:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 67a:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 67d:	39 d8                	cmp    %ebx,%eax
 67f:	75 de                	jne    65f <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 681:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 684:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 687:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 689:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 68c:	89 0d a8 07 00 00    	mov    %ecx,0x7a8
}
 692:	5b                   	pop    %ebx
 693:	5e                   	pop    %esi
 694:	5f                   	pop    %edi
 695:	5d                   	pop    %ebp
 696:	c3                   	ret    
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ac:	8b 35 a8 07 00 00    	mov    0x7a8,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	83 c0 07             	add    $0x7,%eax
 6b5:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 6b8:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ba:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 6bd:	0f 84 95 00 00 00    	je     758 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c3:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 6c5:	8b 41 04             	mov    0x4(%ecx),%eax
 6c8:	39 c3                	cmp    %eax,%ebx
 6ca:	0f 86 b0 00 00 00    	jbe    780 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 6d0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6d7:	90                   	nop    
    }
    if(p == freep)
 6d8:	3b 0d a8 07 00 00    	cmp    0x7a8,%ecx
 6de:	89 ca                	mov    %ecx,%edx
 6e0:	74 34                	je     716 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e2:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 6e4:	8b 41 04             	mov    0x4(%ecx),%eax
 6e7:	39 c3                	cmp    %eax,%ebx
 6e9:	77 ed                	ja     6d8 <malloc+0x38>
 6eb:	89 d6                	mov    %edx,%esi
 6ed:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 6ef:	39 c3                	cmp    %eax,%ebx
 6f1:	74 1d                	je     710 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6f3:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 6f5:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6f8:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 6fb:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 6fe:	89 35 a8 07 00 00    	mov    %esi,0x7a8
      return (void*) (p + 1);
 704:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 707:	83 c4 0c             	add    $0xc,%esp
 70a:	5b                   	pop    %ebx
 70b:	5e                   	pop    %esi
 70c:	5f                   	pop    %edi
 70d:	5d                   	pop    %ebp
 70e:	c3                   	ret    
 70f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 710:	8b 01                	mov    (%ecx),%eax
 712:	89 06                	mov    %eax,(%esi)
 714:	eb e8                	jmp    6fe <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 716:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 71c:	bf 00 10 00 00       	mov    $0x1000,%edi
 721:	b8 00 80 00 00       	mov    $0x8000,%eax
 726:	76 04                	jbe    72c <malloc+0x8c>
 728:	89 df                	mov    %ebx,%edi
 72a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 72c:	89 04 24             	mov    %eax,(%esp)
 72f:	e8 cc fb ff ff       	call   300 <sbrk>
  if(p == (char*) -1)
 734:	83 f8 ff             	cmp    $0xffffffff,%eax
 737:	74 18                	je     751 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 739:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 73c:	83 c0 08             	add    $0x8,%eax
 73f:	89 04 24             	mov    %eax,(%esp)
 742:	e8 b9 fe ff ff       	call   600 <free>
  return freep;
 747:	8b 15 a8 07 00 00    	mov    0x7a8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 74d:	85 d2                	test   %edx,%edx
 74f:	75 91                	jne    6e2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 751:	31 c0                	xor    %eax,%eax
 753:	eb b2                	jmp    707 <malloc+0x67>
 755:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 758:	c7 05 a8 07 00 00 a0 	movl   $0x7a0,0x7a8
 75f:	07 00 00 
    base.s.size = 0;
 762:	be a0 07 00 00       	mov    $0x7a0,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 767:	c7 05 a0 07 00 00 a0 	movl   $0x7a0,0x7a0
 76e:	07 00 00 
    base.s.size = 0;
 771:	c7 05 a4 07 00 00 00 	movl   $0x0,0x7a4
 778:	00 00 00 
 77b:	e9 43 ff ff ff       	jmp    6c3 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 780:	89 ca                	mov    %ecx,%edx
 782:	e9 68 ff ff ff       	jmp    6ef <malloc+0x4f>


_ln:     file format elf32-i386


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
   d:	83 ec 18             	sub    $0x18,%esp
  if(argc != 3){
  10:	83 39 03             	cmpl   $0x3,(%ecx)
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  13:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  16:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  1c:	74 19                	je     37 <main+0x37>
    printf(2, "Usage: ln old new\n");
  1e:	c7 44 24 04 d7 07 00 	movl   $0x7d7,0x4(%esp)
  25:	00 
  26:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  2d:	e8 ee 03 00 00       	call   420 <printf>
    exit();
  32:	e8 91 02 00 00       	call   2c8 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  37:	8b 43 08             	mov    0x8(%ebx),%eax
  3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  3e:	8b 43 04             	mov    0x4(%ebx),%eax
  41:	89 04 24             	mov    %eax,(%esp)
  44:	e8 df 02 00 00       	call   328 <link>
  49:	85 c0                	test   %eax,%eax
  4b:	78 05                	js     52 <main+0x52>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  4d:	e8 76 02 00 00       	call   2c8 <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  52:	8b 43 08             	mov    0x8(%ebx),%eax
  55:	89 44 24 0c          	mov    %eax,0xc(%esp)
  59:	8b 43 04             	mov    0x4(%ebx),%eax
  5c:	c7 44 24 04 ea 07 00 	movl   $0x7ea,0x4(%esp)
  63:	00 
  64:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6b:	89 44 24 08          	mov    %eax,0x8(%esp)
  6f:	e8 ac 03 00 00       	call   420 <printf>
  74:	eb d7                	jmp    4d <main+0x4d>
  76:	90                   	nop    
  77:	90                   	nop    
  78:	90                   	nop    
  79:	90                   	nop    
  7a:	90                   	nop    
  7b:	90                   	nop    
  7c:	90                   	nop    
  7d:	90                   	nop    
  7e:	90                   	nop    
  7f:	90                   	nop    

00000080 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  81:	31 d2                	xor    %edx,%edx
  83:	89 e5                	mov    %esp,%ebp
  85:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  88:	53                   	push   %ebx
  89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
  94:	88 04 13             	mov    %al,(%ebx,%edx,1)
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 c0                	test   %al,%al
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	89 d8                	mov    %ebx,%eax
  a0:	5b                   	pop    %ebx
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 14                	jne    d5 <strcmp+0x25>
  c1:	eb 2d                	jmp    f0 <strcmp+0x40>
  c3:	90                   	nop    
  c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  c8:	83 c2 01             	add    $0x1,%edx
  cb:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	0f b6 02             	movzbl (%edx),%eax
  d1:	84 c0                	test   %al,%al
  d3:	74 1b                	je     f0 <strcmp+0x40>
  d5:	0f b6 19             	movzbl (%ecx),%ebx
  d8:	38 d8                	cmp    %bl,%al
  da:	74 ec                	je     c8 <strcmp+0x18>
  dc:	0f b6 d0             	movzbl %al,%edx
  df:	0f b6 c3             	movzbl %bl,%eax
  e2:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e4:	89 d0                	mov    %edx,%eax
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f0:	0f b6 19             	movzbl (%ecx),%ebx
  f3:	31 d2                	xor    %edx,%edx
  f5:	0f b6 c3             	movzbl %bl,%eax
  f8:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  fa:	89 d0                	mov    %edx,%eax
  fc:	5b                   	pop    %ebx
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop    

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 101:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 103:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 105:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 107:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 10a:	80 3a 00             	cmpb   $0x0,(%edx)
 10d:	74 0c                	je     11b <strlen+0x1b>
 10f:	90                   	nop    
 110:	83 c0 01             	add    $0x1,%eax
 113:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 117:	75 f7                	jne    110 <strlen+0x10>
 119:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
 11b:	89 c8                	mov    %ecx,%eax
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret    
 11f:	90                   	nop    

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 10             	mov    0x10(%ebp),%eax
 126:	53                   	push   %ebx
 127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
 12a:	85 c0                	test   %eax,%eax
 12c:	74 14                	je     142 <memset+0x22>
 12e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 132:	31 d2                	xor    %edx,%edx
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 138:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
 13b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 13e:	39 c2                	cmp    %eax,%edx
 140:	75 f6                	jne    138 <memset+0x18>
    *d++ = c;
  return dst;
}
 142:	89 d8                	mov    %ebx,%eax
 144:	5b                   	pop    %ebx
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 11                	jne    172 <strchr+0x22>
 161:	eb 25                	jmp    188 <strchr+0x38>
 163:	90                   	nop    
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 168:	83 c0 01             	add    $0x1,%eax
 16b:	0f b6 10             	movzbl (%eax),%edx
 16e:	84 d2                	test   %dl,%dl
 170:	74 16                	je     188 <strchr+0x38>
    if(*s == c)
 172:	38 ca                	cmp    %cl,%dl
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 178:	75 ee                	jne    168 <strchr+0x18>
      return (char*) s;
  return 0;
}
 17a:	5d                   	pop    %ebp
 17b:	90                   	nop    
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	c3                   	ret    
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 188:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 18a:	5d                   	pop    %ebp
 18b:	90                   	nop    
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	c3                   	ret    
 191:	eb 0d                	jmp    1a0 <atoi>
 193:	90                   	nop    
 194:	90                   	nop    
 195:	90                   	nop    
 196:	90                   	nop    
 197:	90                   	nop    
 198:	90                   	nop    
 199:	90                   	nop    
 19a:	90                   	nop    
 19b:	90                   	nop    
 19c:	90                   	nop    
 19d:	90                   	nop    
 19e:	90                   	nop    
 19f:	90                   	nop    

000001a0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1a0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a1:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	53                   	push   %ebx
 1a6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a9:	0f b6 13             	movzbl (%ebx),%edx
 1ac:	8d 42 d0             	lea    -0x30(%edx),%eax
 1af:	3c 09                	cmp    $0x9,%al
 1b1:	77 1c                	ja     1cf <atoi+0x2f>
 1b3:	90                   	nop    
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 1b8:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 1bb:	0f be d2             	movsbl %dl,%edx
 1be:	83 c3 01             	add    $0x1,%ebx
 1c1:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c5:	0f b6 13             	movzbl (%ebx),%edx
 1c8:	8d 42 d0             	lea    -0x30(%edx),%eax
 1cb:	3c 09                	cmp    $0x9,%al
 1cd:	76 e9                	jbe    1b8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1cf:	89 c8                	mov    %ecx,%eax
 1d1:	5b                   	pop    %ebx
 1d2:	5d                   	pop    %ebp
 1d3:	c3                   	ret    
 1d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1e6:	56                   	push   %esi
 1e7:	8b 75 08             	mov    0x8(%ebp),%esi
 1ea:	53                   	push   %ebx
 1eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ee:	85 c9                	test   %ecx,%ecx
 1f0:	7e 14                	jle    206 <memmove+0x26>
 1f2:	31 d2                	xor    %edx,%edx
 1f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 1f8:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 1fc:	88 04 16             	mov    %al,(%esi,%edx,1)
 1ff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 202:	39 ca                	cmp    %ecx,%edx
 204:	75 f2                	jne    1f8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 206:	89 f0                	mov    %esi,%eax
 208:	5b                   	pop    %ebx
 209:	5e                   	pop    %esi
 20a:	5d                   	pop    %ebp
 20b:	c3                   	ret    
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 216:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 219:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 21c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 21f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 224:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 22b:	00 
 22c:	89 04 24             	mov    %eax,(%esp)
 22f:	e8 d4 00 00 00       	call   308 <open>
  if(fd < 0)
 234:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 236:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 238:	78 19                	js     253 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 1c 24             	mov    %ebx,(%esp)
 240:	89 44 24 04          	mov    %eax,0x4(%esp)
 244:	e8 d7 00 00 00       	call   320 <fstat>
  close(fd);
 249:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 24c:	89 c6                	mov    %eax,%esi
  close(fd);
 24e:	e8 9d 00 00 00       	call   2f0 <close>
  return r;
}
 253:	89 f0                	mov    %esi,%eax
 255:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 258:	8b 75 fc             	mov    -0x4(%ebp),%esi
 25b:	89 ec                	mov    %ebp,%esp
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret    
 25f:	90                   	nop    

00000260 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
 265:	31 f6                	xor    %esi,%esi
 267:	53                   	push   %ebx
 268:	83 ec 1c             	sub    $0x1c,%esp
 26b:	8b 7d 08             	mov    0x8(%ebp),%edi
 26e:	eb 06                	jmp    276 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 270:	3c 0d                	cmp    $0xd,%al
 272:	74 39                	je     2ad <gets+0x4d>
 274:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 276:	8d 5e 01             	lea    0x1(%esi),%ebx
 279:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 27c:	7d 31                	jge    2af <gets+0x4f>
    cc = read(0, &c, 1);
 27e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 281:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 288:	00 
 289:	89 44 24 04          	mov    %eax,0x4(%esp)
 28d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 294:	e8 47 00 00 00       	call   2e0 <read>
    if(cc < 1)
 299:	85 c0                	test   %eax,%eax
 29b:	7e 12                	jle    2af <gets+0x4f>
      break;
    buf[i++] = c;
 29d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2a1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 2a5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 2a9:	3c 0a                	cmp    $0xa,%al
 2ab:	75 c3                	jne    270 <gets+0x10>
 2ad:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 2af:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2b3:	89 f8                	mov    %edi,%eax
 2b5:	83 c4 1c             	add    $0x1c,%esp
 2b8:	5b                   	pop    %ebx
 2b9:	5e                   	pop    %esi
 2ba:	5f                   	pop    %edi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	90                   	nop    
 2be:	90                   	nop    
 2bf:	90                   	nop    

000002c0 <fork>:
 2c0:	b8 01 00 00 00       	mov    $0x1,%eax
 2c5:	cd 30                	int    $0x30
 2c7:	c3                   	ret    

000002c8 <exit>:
 2c8:	b8 02 00 00 00       	mov    $0x2,%eax
 2cd:	cd 30                	int    $0x30
 2cf:	c3                   	ret    

000002d0 <wait>:
 2d0:	b8 03 00 00 00       	mov    $0x3,%eax
 2d5:	cd 30                	int    $0x30
 2d7:	c3                   	ret    

000002d8 <pipe>:
 2d8:	b8 04 00 00 00       	mov    $0x4,%eax
 2dd:	cd 30                	int    $0x30
 2df:	c3                   	ret    

000002e0 <read>:
 2e0:	b8 06 00 00 00       	mov    $0x6,%eax
 2e5:	cd 30                	int    $0x30
 2e7:	c3                   	ret    

000002e8 <write>:
 2e8:	b8 05 00 00 00       	mov    $0x5,%eax
 2ed:	cd 30                	int    $0x30
 2ef:	c3                   	ret    

000002f0 <close>:
 2f0:	b8 07 00 00 00       	mov    $0x7,%eax
 2f5:	cd 30                	int    $0x30
 2f7:	c3                   	ret    

000002f8 <kill>:
 2f8:	b8 08 00 00 00       	mov    $0x8,%eax
 2fd:	cd 30                	int    $0x30
 2ff:	c3                   	ret    

00000300 <exec>:
 300:	b8 09 00 00 00       	mov    $0x9,%eax
 305:	cd 30                	int    $0x30
 307:	c3                   	ret    

00000308 <open>:
 308:	b8 0a 00 00 00       	mov    $0xa,%eax
 30d:	cd 30                	int    $0x30
 30f:	c3                   	ret    

00000310 <mknod>:
 310:	b8 0b 00 00 00       	mov    $0xb,%eax
 315:	cd 30                	int    $0x30
 317:	c3                   	ret    

00000318 <unlink>:
 318:	b8 0c 00 00 00       	mov    $0xc,%eax
 31d:	cd 30                	int    $0x30
 31f:	c3                   	ret    

00000320 <fstat>:
 320:	b8 0d 00 00 00       	mov    $0xd,%eax
 325:	cd 30                	int    $0x30
 327:	c3                   	ret    

00000328 <link>:
 328:	b8 0e 00 00 00       	mov    $0xe,%eax
 32d:	cd 30                	int    $0x30
 32f:	c3                   	ret    

00000330 <mkdir>:
 330:	b8 0f 00 00 00       	mov    $0xf,%eax
 335:	cd 30                	int    $0x30
 337:	c3                   	ret    

00000338 <chdir>:
 338:	b8 10 00 00 00       	mov    $0x10,%eax
 33d:	cd 30                	int    $0x30
 33f:	c3                   	ret    

00000340 <dup>:
 340:	b8 11 00 00 00       	mov    $0x11,%eax
 345:	cd 30                	int    $0x30
 347:	c3                   	ret    

00000348 <getpid>:
 348:	b8 12 00 00 00       	mov    $0x12,%eax
 34d:	cd 30                	int    $0x30
 34f:	c3                   	ret    

00000350 <sbrk>:
 350:	b8 13 00 00 00       	mov    $0x13,%eax
 355:	cd 30                	int    $0x30
 357:	c3                   	ret    

00000358 <sleep>:
 358:	b8 14 00 00 00       	mov    $0x14,%eax
 35d:	cd 30                	int    $0x30
 35f:	c3                   	ret    

00000360 <mytime>:
 360:	b8 15 00 00 00       	mov    $0x15,%eax
 365:	cd 30                	int    $0x30
 367:	c3                   	ret    

00000368 <settickets>:
 368:	b8 16 00 00 00       	mov    $0x16,%eax
 36d:	cd 30                	int    $0x30
 36f:	c3                   	ret    

00000370 <getruntime>:
 370:	b8 17 00 00 00       	mov    $0x17,%eax
 375:	cd 30                	int    $0x30
 377:	c3                   	ret    
 378:	90                   	nop    
 379:	90                   	nop    
 37a:	90                   	nop    
 37b:	90                   	nop    
 37c:	90                   	nop    
 37d:	90                   	nop    
 37e:	90                   	nop    
 37f:	90                   	nop    

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	89 ce                	mov    %ecx,%esi
 387:	53                   	push   %ebx
 388:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 38b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 38e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 391:	85 c9                	test   %ecx,%ecx
 393:	74 04                	je     399 <printint+0x19>
 395:	85 d2                	test   %edx,%edx
 397:	78 77                	js     410 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 399:	89 d0                	mov    %edx,%eax
 39b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 3a2:	31 db                	xor    %ebx,%ebx
 3a4:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 3a7:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3a8:	31 d2                	xor    %edx,%edx
 3aa:	f7 f6                	div    %esi
 3ac:	89 c1                	mov    %eax,%ecx
 3ae:	0f b6 82 05 08 00 00 	movzbl 0x805(%edx),%eax
 3b5:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 3b8:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 3bb:	85 c9                	test   %ecx,%ecx
 3bd:	89 c8                	mov    %ecx,%eax
 3bf:	75 e7                	jne    3a8 <printint+0x28>
  if(neg)
 3c1:	8b 45 d0             	mov    -0x30(%ebp),%eax
 3c4:	85 c0                	test   %eax,%eax
 3c6:	74 08                	je     3d0 <printint+0x50>
    buf[i++] = '-';
 3c8:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 3cd:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 3d0:	8d 73 ff             	lea    -0x1(%ebx),%esi
 3d3:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 3d6:	8d 7d f3             	lea    -0xd(%ebp),%edi
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 3e0:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3e3:	83 ee 01             	sub    $0x1,%esi
 3e6:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3e9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f0:	00 
 3f1:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 3f5:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f8:	8b 45 cc             	mov    -0x34(%ebp),%eax
 3fb:	89 04 24             	mov    %eax,(%esp)
 3fe:	e8 e5 fe ff ff       	call   2e8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 403:	83 fe ff             	cmp    $0xffffffff,%esi
 406:	75 d8                	jne    3e0 <printint+0x60>
    putc(fd, buf[i]);
}
 408:	83 c4 3c             	add    $0x3c,%esp
 40b:	5b                   	pop    %ebx
 40c:	5e                   	pop    %esi
 40d:	5f                   	pop    %edi
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 410:	89 d0                	mov    %edx,%eax
 412:	f7 d8                	neg    %eax
 414:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 41b:	eb 85                	jmp    3a2 <printint+0x22>
 41d:	8d 76 00             	lea    0x0(%esi),%esi

00000420 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 55 0c             	mov    0xc(%ebp),%edx
 42c:	0f b6 02             	movzbl (%edx),%eax
 42f:	84 c0                	test   %al,%al
 431:	0f 84 e9 00 00 00    	je     520 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 437:	8d 4d 10             	lea    0x10(%ebp),%ecx
 43a:	89 d7                	mov    %edx,%edi
 43c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 43f:	31 f6                	xor    %esi,%esi
 441:	eb 21                	jmp    464 <printf+0x44>
 443:	90                   	nop    
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 fb 25             	cmp    $0x25,%ebx
 44b:	0f 85 d7 00 00 00    	jne    528 <printf+0x108>
 451:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 455:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 459:	83 c7 01             	add    $0x1,%edi
 45c:	84 c0                	test   %al,%al
 45e:	0f 84 bc 00 00 00    	je     520 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 464:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 466:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 469:	74 dd                	je     448 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 46b:	83 fe 25             	cmp    $0x25,%esi
 46e:	75 e5                	jne    455 <printf+0x35>
      if(c == 'd'){
 470:	83 fb 64             	cmp    $0x64,%ebx
 473:	90                   	nop    
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 478:	0f 84 4a 01 00 00    	je     5c8 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 47e:	83 fb 78             	cmp    $0x78,%ebx
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 488:	0f 84 c2 00 00 00    	je     550 <printf+0x130>
 48e:	83 fb 70             	cmp    $0x70,%ebx
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 498:	0f 84 b2 00 00 00    	je     550 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 49e:	83 fb 73             	cmp    $0x73,%ebx
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	0f 84 ca 00 00 00    	je     578 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4ae:	83 fb 63             	cmp    $0x63,%ebx
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	0f 84 5a 01 00 00    	je     618 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4be:	83 fb 25             	cmp    $0x25,%ebx
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c8:	0f 84 22 01 00 00    	je     5f0 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ce:	8b 55 08             	mov    0x8(%ebp),%edx
 4d1:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4d4:	31 f6                	xor    %esi,%esi
 4d6:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e1:	00 
 4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e6:	89 14 24             	mov    %edx,(%esp)
 4e9:	e8 fa fd ff ff       	call   2e8 <write>
 4ee:	8b 45 08             	mov    0x8(%ebp),%eax
 4f1:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4f4:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4fe:	00 
 4ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 503:	89 04 24             	mov    %eax,(%esp)
 506:	e8 dd fd ff ff       	call   2e8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 50f:	83 c7 01             	add    $0x1,%edi
 512:	84 c0                	test   %al,%al
 514:	0f 85 4a ff ff ff    	jne    464 <printf+0x44>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 520:	83 c4 2c             	add    $0x2c,%esp
 523:	5b                   	pop    %ebx
 524:	5e                   	pop    %esi
 525:	5f                   	pop    %edi
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 528:	8b 55 08             	mov    0x8(%ebp),%edx
 52b:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 52e:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 531:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 538:	00 
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	89 14 24             	mov    %edx,(%esp)
 540:	e8 a3 fd ff ff       	call   2e8 <write>
 545:	e9 0b ff ff ff       	jmp    455 <printf+0x35>
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 550:	8b 45 e0             	mov    -0x20(%ebp),%eax
 553:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 558:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 55a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 561:	8b 10                	mov    (%eax),%edx
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	e8 15 fe ff ff       	call   380 <printint>
        ap++;
 56b:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 56f:	e9 e1 fe ff ff       	jmp    455 <printf+0x35>
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 578:	8b 55 e0             	mov    -0x20(%ebp),%edx
 57b:	8b 1a                	mov    (%edx),%ebx
        ap++;
 57d:	83 c2 04             	add    $0x4,%edx
 580:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 583:	85 db                	test   %ebx,%ebx
 585:	0f 84 ba 00 00 00    	je     645 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 58b:	0f b6 03             	movzbl (%ebx),%eax
 58e:	84 c0                	test   %al,%al
 590:	74 2d                	je     5bf <printf+0x19f>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 598:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59b:	8b 45 08             	mov    0x8(%ebp),%eax
 59e:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5a1:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ab:	00 
 5ac:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 5b0:	89 04 24             	mov    %eax,(%esp)
 5b3:	e8 30 fd ff ff       	call   2e8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b8:	0f b6 03             	movzbl (%ebx),%eax
 5bb:	84 c0                	test   %al,%al
 5bd:	75 d9                	jne    598 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5bf:	31 f6                	xor    %esi,%esi
 5c1:	e9 8f fe ff ff       	jmp    455 <printf+0x35>
 5c6:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 5d0:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5da:	8b 10                	mov    (%eax),%edx
 5dc:	8b 45 08             	mov    0x8(%ebp),%eax
 5df:	e8 9c fd ff ff       	call   380 <printint>
        ap++;
 5e4:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 5e8:	e9 68 fe ff ff       	jmp    455 <printf+0x35>
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5f3:	8d 55 f3             	lea    -0xd(%ebp),%edx
 5f6:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5f8:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 603:	00 
 604:	89 54 24 04          	mov    %edx,0x4(%esp)
 608:	89 0c 24             	mov    %ecx,(%esp)
 60b:	e8 d8 fc ff ff       	call   2e8 <write>
 610:	e9 40 fe ff ff       	jmp    455 <printf+0x35>
 615:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 618:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 61b:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 61e:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 620:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 622:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 629:	00 
 62a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 62e:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 631:	8b 45 08             	mov    0x8(%ebp),%eax
 634:	89 04 24             	mov    %eax,(%esp)
 637:	e8 ac fc ff ff       	call   2e8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 63c:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 640:	e9 10 fe ff ff       	jmp    455 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 645:	bb fe 07 00 00       	mov    $0x7fe,%ebx
 64a:	e9 3c ff ff ff       	jmp    58b <printf+0x16b>
 64f:	90                   	nop    

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	8b 0d 20 08 00 00    	mov    0x820,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 657:	89 e5                	mov    %esp,%ebp
 659:	57                   	push   %edi
 65a:	56                   	push   %esi
 65b:	53                   	push   %ebx
 65c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 65f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 662:	39 d9                	cmp    %ebx,%ecx
 664:	73 24                	jae    68a <free+0x3a>
 666:	66 90                	xchg   %ax,%ax
 668:	8b 11                	mov    (%ecx),%edx
 66a:	39 d3                	cmp    %edx,%ebx
 66c:	72 2a                	jb     698 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66e:	39 d1                	cmp    %edx,%ecx
 670:	72 10                	jb     682 <free+0x32>
 672:	39 d9                	cmp    %ebx,%ecx
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 678:	72 1e                	jb     698 <free+0x48>
 67a:	39 d3                	cmp    %edx,%ebx
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 680:	72 16                	jb     698 <free+0x48>
 682:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 684:	39 d9                	cmp    %ebx,%ecx
 686:	66 90                	xchg   %ax,%ax
 688:	72 de                	jb     668 <free+0x18>
 68a:	8b 11                	mov    (%ecx),%edx
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 690:	eb dc                	jmp    66e <free+0x1e>
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 698:	8b 73 04             	mov    0x4(%ebx),%esi
 69b:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 69e:	39 d0                	cmp    %edx,%eax
 6a0:	74 1a                	je     6bc <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6a2:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 6a5:	8b 51 04             	mov    0x4(%ecx),%edx
 6a8:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6ab:	39 d8                	cmp    %ebx,%eax
 6ad:	74 22                	je     6d1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6af:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 6b1:	89 0d 20 08 00 00    	mov    %ecx,0x820
}
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6bc:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 6bf:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6c1:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6c4:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6c7:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6ca:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 6cd:	39 d8                	cmp    %ebx,%eax
 6cf:	75 de                	jne    6af <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6d1:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6d4:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 6d7:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6d9:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6dc:	89 0d 20 08 00 00    	mov    %ecx,0x820
}
 6e2:	5b                   	pop    %ebx
 6e3:	5e                   	pop    %esi
 6e4:	5f                   	pop    %edi
 6e5:	5d                   	pop    %ebp
 6e6:	c3                   	ret    
 6e7:	89 f6                	mov    %esi,%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 35 20 08 00 00    	mov    0x820,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	83 c0 07             	add    $0x7,%eax
 705:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 708:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 70d:	0f 84 95 00 00 00    	je     7a8 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 713:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 715:	8b 41 04             	mov    0x4(%ecx),%eax
 718:	39 c3                	cmp    %eax,%ebx
 71a:	0f 86 b0 00 00 00    	jbe    7d0 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 720:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 727:	90                   	nop    
    }
    if(p == freep)
 728:	3b 0d 20 08 00 00    	cmp    0x820,%ecx
 72e:	89 ca                	mov    %ecx,%edx
 730:	74 34                	je     766 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 732:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 734:	8b 41 04             	mov    0x4(%ecx),%eax
 737:	39 c3                	cmp    %eax,%ebx
 739:	77 ed                	ja     728 <malloc+0x38>
 73b:	89 d6                	mov    %edx,%esi
 73d:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 73f:	39 c3                	cmp    %eax,%ebx
 741:	74 1d                	je     760 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 743:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 745:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 748:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 74b:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 74e:	89 35 20 08 00 00    	mov    %esi,0x820
      return (void*) (p + 1);
 754:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 757:	83 c4 0c             	add    $0xc,%esp
 75a:	5b                   	pop    %ebx
 75b:	5e                   	pop    %esi
 75c:	5f                   	pop    %edi
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret    
 75f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 760:	8b 01                	mov    (%ecx),%eax
 762:	89 06                	mov    %eax,(%esi)
 764:	eb e8                	jmp    74e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 766:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 76c:	bf 00 10 00 00       	mov    $0x1000,%edi
 771:	b8 00 80 00 00       	mov    $0x8000,%eax
 776:	76 04                	jbe    77c <malloc+0x8c>
 778:	89 df                	mov    %ebx,%edi
 77a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 77c:	89 04 24             	mov    %eax,(%esp)
 77f:	e8 cc fb ff ff       	call   350 <sbrk>
  if(p == (char*) -1)
 784:	83 f8 ff             	cmp    $0xffffffff,%eax
 787:	74 18                	je     7a1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 789:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 78c:	83 c0 08             	add    $0x8,%eax
 78f:	89 04 24             	mov    %eax,(%esp)
 792:	e8 b9 fe ff ff       	call   650 <free>
  return freep;
 797:	8b 15 20 08 00 00    	mov    0x820,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 79d:	85 d2                	test   %edx,%edx
 79f:	75 91                	jne    732 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7a1:	31 c0                	xor    %eax,%eax
 7a3:	eb b2                	jmp    757 <malloc+0x67>
 7a5:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7a8:	c7 05 20 08 00 00 18 	movl   $0x818,0x820
 7af:	08 00 00 
    base.s.size = 0;
 7b2:	be 18 08 00 00       	mov    $0x818,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7b7:	c7 05 18 08 00 00 18 	movl   $0x818,0x818
 7be:	08 00 00 
    base.s.size = 0;
 7c1:	c7 05 1c 08 00 00 00 	movl   $0x0,0x81c
 7c8:	00 00 00 
 7cb:	e9 43 ff ff ff       	jmp    713 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7d0:	89 ca                	mov    %ecx,%edx
 7d2:	e9 68 ff ff ff       	jmp    73f <malloc+0x4f>

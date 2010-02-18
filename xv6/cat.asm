
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	8b 5d 08             	mov    0x8(%ebp),%ebx
   a:	eb 1c                	jmp    28 <cat+0x28>
   c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  10:	89 44 24 08          	mov    %eax,0x8(%esp)
  14:	c7 44 24 04 e0 08 00 	movl   $0x8e0,0x4(%esp)
  1b:	00 
  1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  23:	e8 50 03 00 00       	call   378 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  28:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2f:	00 
  30:	c7 44 24 04 e0 08 00 	movl   $0x8e0,0x4(%esp)
  37:	00 
  38:	89 1c 24             	mov    %ebx,(%esp)
  3b:	e8 30 03 00 00       	call   370 <read>
  40:	83 f8 00             	cmp    $0x0,%eax
  43:	7f cb                	jg     10 <cat+0x10>
    write(1, buf, n);
  if(n < 0){
  45:	75 0a                	jne    51 <cat+0x51>
    printf(1, "cat: read error\n");
    exit();
  }
}
  47:	83 c4 14             	add    $0x14,%esp
  4a:	5b                   	pop    %ebx
  4b:	5d                   	pop    %ebp
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	c3                   	ret    
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  if(n < 0){
    printf(1, "cat: read error\n");
  51:	c7 44 24 04 67 08 00 	movl   $0x867,0x4(%esp)
  58:	00 
  59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  60:	e8 4b 04 00 00       	call   4b0 <printf>
    exit();
  65:	e8 ee 02 00 00       	call   358 <exit>
  6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000070 <main>:
  }
}

int
main(int argc, char *argv[])
{
  70:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  74:	83 e4 f0             	and    $0xfffffff0,%esp
  77:	ff 71 fc             	pushl  -0x4(%ecx)
  7a:	55                   	push   %ebp
  7b:	89 e5                	mov    %esp,%ebp
  7d:	57                   	push   %edi
  7e:	56                   	push   %esi
  int fd, i;

  if(argc <= 1){
    cat(0);
    exit();
  7f:	be 01 00 00 00       	mov    $0x1,%esi
  }
}

int
main(int argc, char *argv[])
{
  84:	53                   	push   %ebx
  85:	51                   	push   %ecx
  86:	83 ec 18             	sub    $0x18,%esp
  89:	8b 01                	mov    (%ecx),%eax
  8b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8e:	8b 41 04             	mov    0x4(%ecx),%eax
  int fd, i;

  if(argc <= 1){
  91:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    cat(0);
    exit();
  95:	8d 78 04             	lea    0x4(%eax),%edi
int
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
  98:	7e 5d                	jle    f7 <main+0x87>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  a0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  a7:	00 
  a8:	8b 07                	mov    (%edi),%eax
  aa:	89 04 24             	mov    %eax,(%esp)
  ad:	e8 e6 02 00 00       	call   398 <open>
  b2:	85 c0                	test   %eax,%eax
  b4:	89 c3                	mov    %eax,%ebx
  b6:	78 20                	js     d8 <main+0x68>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  b8:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  bb:	83 c6 01             	add    $0x1,%esi
  be:	83 c7 04             	add    $0x4,%edi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  c1:	e8 3a ff ff ff       	call   0 <cat>
    close(fd);
  c6:	89 1c 24             	mov    %ebx,(%esp)
  c9:	e8 b2 02 00 00       	call   380 <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  ce:	39 75 ec             	cmp    %esi,-0x14(%ebp)
  d1:	7f cd                	jg     a0 <main+0x30>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  d3:	e8 80 02 00 00       	call   358 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  d8:	8b 07                	mov    (%edi),%eax
  da:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
  e1:	00 
  e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ed:	e8 be 03 00 00       	call   4b0 <printf>
      exit();
  f2:	e8 61 02 00 00       	call   358 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  fe:	e8 fd fe ff ff       	call   0 <cat>
    exit();
 103:	e8 50 02 00 00       	call   358 <exit>
 108:	90                   	nop    
 109:	90                   	nop    
 10a:	90                   	nop    
 10b:	90                   	nop    
 10c:	90                   	nop    
 10d:	90                   	nop    
 10e:	90                   	nop    
 10f:	90                   	nop    

00000110 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
 111:	31 d2                	xor    %edx,%edx
 113:	89 e5                	mov    %esp,%ebp
 115:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 118:	53                   	push   %ebx
 119:	8b 5d 08             	mov    0x8(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 120:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
 124:	88 04 13             	mov    %al,(%ebx,%edx,1)
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 c0                	test   %al,%al
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	89 d8                	mov    %ebx,%eax
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 14                	jne    165 <strcmp+0x25>
 151:	eb 2d                	jmp    180 <strcmp+0x40>
 153:	90                   	nop    
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 158:	83 c2 01             	add    $0x1,%edx
 15b:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15e:	0f b6 02             	movzbl (%edx),%eax
 161:	84 c0                	test   %al,%al
 163:	74 1b                	je     180 <strcmp+0x40>
 165:	0f b6 19             	movzbl (%ecx),%ebx
 168:	38 d8                	cmp    %bl,%al
 16a:	74 ec                	je     158 <strcmp+0x18>
 16c:	0f b6 d0             	movzbl %al,%edx
 16f:	0f b6 c3             	movzbl %bl,%eax
 172:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 174:	89 d0                	mov    %edx,%eax
 176:	5b                   	pop    %ebx
 177:	5d                   	pop    %ebp
 178:	c3                   	ret    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 180:	0f b6 19             	movzbl (%ecx),%ebx
 183:	31 d2                	xor    %edx,%edx
 185:	0f b6 c3             	movzbl %bl,%eax
 188:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 18a:	89 d0                	mov    %edx,%eax
 18c:	5b                   	pop    %ebx
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
 18f:	90                   	nop    

00000190 <strlen>:

uint
strlen(char *s)
{
 190:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 191:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 193:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 195:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 197:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 19a:	80 3a 00             	cmpb   $0x0,(%edx)
 19d:	74 0c                	je     1ab <strlen+0x1b>
 19f:	90                   	nop    
 1a0:	83 c0 01             	add    $0x1,%eax
 1a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1a7:	75 f7                	jne    1a0 <strlen+0x10>
 1a9:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
 1ab:	89 c8                	mov    %ecx,%eax
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop    

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 10             	mov    0x10(%ebp),%eax
 1b6:	53                   	push   %ebx
 1b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
 1ba:	85 c0                	test   %eax,%eax
 1bc:	74 14                	je     1d2 <memset+0x22>
 1be:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 1c2:	31 d2                	xor    %edx,%edx
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 1c8:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
 1cb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 1ce:	39 c2                	cmp    %eax,%edx
 1d0:	75 f6                	jne    1c8 <memset+0x18>
    *d++ = c;
  return dst;
}
 1d2:	89 d8                	mov    %ebx,%eax
 1d4:	5b                   	pop    %ebx
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 11                	jne    202 <strchr+0x22>
 1f1:	eb 25                	jmp    218 <strchr+0x38>
 1f3:	90                   	nop    
 1f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f8:	83 c0 01             	add    $0x1,%eax
 1fb:	0f b6 10             	movzbl (%eax),%edx
 1fe:	84 d2                	test   %dl,%dl
 200:	74 16                	je     218 <strchr+0x38>
    if(*s == c)
 202:	38 ca                	cmp    %cl,%dl
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 208:	75 ee                	jne    1f8 <strchr+0x18>
      return (char*) s;
  return 0;
}
 20a:	5d                   	pop    %ebp
 20b:	90                   	nop    
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	c3                   	ret    
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 218:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 21a:	5d                   	pop    %ebp
 21b:	90                   	nop    
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <atoi>
 223:	90                   	nop    
 224:	90                   	nop    
 225:	90                   	nop    
 226:	90                   	nop    
 227:	90                   	nop    
 228:	90                   	nop    
 229:	90                   	nop    
 22a:	90                   	nop    
 22b:	90                   	nop    
 22c:	90                   	nop    
 22d:	90                   	nop    
 22e:	90                   	nop    
 22f:	90                   	nop    

00000230 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 231:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 233:	89 e5                	mov    %esp,%ebp
 235:	53                   	push   %ebx
 236:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 239:	0f b6 13             	movzbl (%ebx),%edx
 23c:	8d 42 d0             	lea    -0x30(%edx),%eax
 23f:	3c 09                	cmp    $0x9,%al
 241:	77 1c                	ja     25f <atoi+0x2f>
 243:	90                   	nop    
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 248:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 24b:	0f be d2             	movsbl %dl,%edx
 24e:	83 c3 01             	add    $0x1,%ebx
 251:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 255:	0f b6 13             	movzbl (%ebx),%edx
 258:	8d 42 d0             	lea    -0x30(%edx),%eax
 25b:	3c 09                	cmp    $0x9,%al
 25d:	76 e9                	jbe    248 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 25f:	89 c8                	mov    %ecx,%eax
 261:	5b                   	pop    %ebx
 262:	5d                   	pop    %ebp
 263:	c3                   	ret    
 264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 26a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 10             	mov    0x10(%ebp),%ecx
 276:	56                   	push   %esi
 277:	8b 75 08             	mov    0x8(%ebp),%esi
 27a:	53                   	push   %ebx
 27b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 c9                	test   %ecx,%ecx
 280:	7e 14                	jle    296 <memmove+0x26>
 282:	31 d2                	xor    %edx,%edx
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 288:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 28c:	88 04 16             	mov    %al,(%esi,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	39 ca                	cmp    %ecx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 296:	89 f0                	mov    %esi,%eax
 298:	5b                   	pop    %ebx
 299:	5e                   	pop    %esi
 29a:	5d                   	pop    %ebp
 29b:	c3                   	ret    
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2af:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2bb:	00 
 2bc:	89 04 24             	mov    %eax,(%esp)
 2bf:	e8 d4 00 00 00       	call   398 <open>
  if(fd < 0)
 2c4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2c8:	78 19                	js     2e3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cd:	89 1c 24             	mov    %ebx,(%esp)
 2d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d4:	e8 d7 00 00 00       	call   3b0 <fstat>
  close(fd);
 2d9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2dc:	89 c6                	mov    %eax,%esi
  close(fd);
 2de:	e8 9d 00 00 00       	call   380 <close>
  return r;
}
 2e3:	89 f0                	mov    %esi,%eax
 2e5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2e8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2eb:	89 ec                	mov    %ebp,%esp
 2ed:	5d                   	pop    %ebp
 2ee:	c3                   	ret    
 2ef:	90                   	nop    

000002f0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
 2f5:	31 f6                	xor    %esi,%esi
 2f7:	53                   	push   %ebx
 2f8:	83 ec 1c             	sub    $0x1c,%esp
 2fb:	8b 7d 08             	mov    0x8(%ebp),%edi
 2fe:	eb 06                	jmp    306 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 300:	3c 0d                	cmp    $0xd,%al
 302:	74 39                	je     33d <gets+0x4d>
 304:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 306:	8d 5e 01             	lea    0x1(%esi),%ebx
 309:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 30c:	7d 31                	jge    33f <gets+0x4f>
    cc = read(0, &c, 1);
 30e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 311:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 318:	00 
 319:	89 44 24 04          	mov    %eax,0x4(%esp)
 31d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 324:	e8 47 00 00 00       	call   370 <read>
    if(cc < 1)
 329:	85 c0                	test   %eax,%eax
 32b:	7e 12                	jle    33f <gets+0x4f>
      break;
    buf[i++] = c;
 32d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 331:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 335:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 339:	3c 0a                	cmp    $0xa,%al
 33b:	75 c3                	jne    300 <gets+0x10>
 33d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 33f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 343:	89 f8                	mov    %edi,%eax
 345:	83 c4 1c             	add    $0x1c,%esp
 348:	5b                   	pop    %ebx
 349:	5e                   	pop    %esi
 34a:	5f                   	pop    %edi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	90                   	nop    
 34e:	90                   	nop    
 34f:	90                   	nop    

00000350 <fork>:
 350:	b8 01 00 00 00       	mov    $0x1,%eax
 355:	cd 30                	int    $0x30
 357:	c3                   	ret    

00000358 <exit>:
 358:	b8 02 00 00 00       	mov    $0x2,%eax
 35d:	cd 30                	int    $0x30
 35f:	c3                   	ret    

00000360 <wait>:
 360:	b8 03 00 00 00       	mov    $0x3,%eax
 365:	cd 30                	int    $0x30
 367:	c3                   	ret    

00000368 <pipe>:
 368:	b8 04 00 00 00       	mov    $0x4,%eax
 36d:	cd 30                	int    $0x30
 36f:	c3                   	ret    

00000370 <read>:
 370:	b8 06 00 00 00       	mov    $0x6,%eax
 375:	cd 30                	int    $0x30
 377:	c3                   	ret    

00000378 <write>:
 378:	b8 05 00 00 00       	mov    $0x5,%eax
 37d:	cd 30                	int    $0x30
 37f:	c3                   	ret    

00000380 <close>:
 380:	b8 07 00 00 00       	mov    $0x7,%eax
 385:	cd 30                	int    $0x30
 387:	c3                   	ret    

00000388 <kill>:
 388:	b8 08 00 00 00       	mov    $0x8,%eax
 38d:	cd 30                	int    $0x30
 38f:	c3                   	ret    

00000390 <exec>:
 390:	b8 09 00 00 00       	mov    $0x9,%eax
 395:	cd 30                	int    $0x30
 397:	c3                   	ret    

00000398 <open>:
 398:	b8 0a 00 00 00       	mov    $0xa,%eax
 39d:	cd 30                	int    $0x30
 39f:	c3                   	ret    

000003a0 <mknod>:
 3a0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a5:	cd 30                	int    $0x30
 3a7:	c3                   	ret    

000003a8 <unlink>:
 3a8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ad:	cd 30                	int    $0x30
 3af:	c3                   	ret    

000003b0 <fstat>:
 3b0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b5:	cd 30                	int    $0x30
 3b7:	c3                   	ret    

000003b8 <link>:
 3b8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3bd:	cd 30                	int    $0x30
 3bf:	c3                   	ret    

000003c0 <mkdir>:
 3c0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c5:	cd 30                	int    $0x30
 3c7:	c3                   	ret    

000003c8 <chdir>:
 3c8:	b8 10 00 00 00       	mov    $0x10,%eax
 3cd:	cd 30                	int    $0x30
 3cf:	c3                   	ret    

000003d0 <dup>:
 3d0:	b8 11 00 00 00       	mov    $0x11,%eax
 3d5:	cd 30                	int    $0x30
 3d7:	c3                   	ret    

000003d8 <getpid>:
 3d8:	b8 12 00 00 00       	mov    $0x12,%eax
 3dd:	cd 30                	int    $0x30
 3df:	c3                   	ret    

000003e0 <sbrk>:
 3e0:	b8 13 00 00 00       	mov    $0x13,%eax
 3e5:	cd 30                	int    $0x30
 3e7:	c3                   	ret    

000003e8 <sleep>:
 3e8:	b8 14 00 00 00       	mov    $0x14,%eax
 3ed:	cd 30                	int    $0x30
 3ef:	c3                   	ret    

000003f0 <mytime>:
 3f0:	b8 15 00 00 00       	mov    $0x15,%eax
 3f5:	cd 30                	int    $0x30
 3f7:	c3                   	ret    

000003f8 <settickets>:
 3f8:	b8 16 00 00 00       	mov    $0x16,%eax
 3fd:	cd 30                	int    $0x30
 3ff:	c3                   	ret    

00000400 <getruntime>:
 400:	b8 17 00 00 00       	mov    $0x17,%eax
 405:	cd 30                	int    $0x30
 407:	c3                   	ret    
 408:	90                   	nop    
 409:	90                   	nop    
 40a:	90                   	nop    
 40b:	90                   	nop    
 40c:	90                   	nop    
 40d:	90                   	nop    
 40e:	90                   	nop    
 40f:	90                   	nop    

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	89 ce                	mov    %ecx,%esi
 417:	53                   	push   %ebx
 418:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 41b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 41e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 421:	85 c9                	test   %ecx,%ecx
 423:	74 04                	je     429 <printint+0x19>
 425:	85 d2                	test   %edx,%edx
 427:	78 77                	js     4a0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 429:	89 d0                	mov    %edx,%eax
 42b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 432:	31 db                	xor    %ebx,%ebx
 434:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 437:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 438:	31 d2                	xor    %edx,%edx
 43a:	f7 f6                	div    %esi
 43c:	89 c1                	mov    %eax,%ecx
 43e:	0f b6 82 94 08 00 00 	movzbl 0x894(%edx),%eax
 445:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 448:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 44b:	85 c9                	test   %ecx,%ecx
 44d:	89 c8                	mov    %ecx,%eax
 44f:	75 e7                	jne    438 <printint+0x28>
  if(neg)
 451:	8b 45 d0             	mov    -0x30(%ebp),%eax
 454:	85 c0                	test   %eax,%eax
 456:	74 08                	je     460 <printint+0x50>
    buf[i++] = '-';
 458:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 45d:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 460:	8d 73 ff             	lea    -0x1(%ebx),%esi
 463:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 466:	8d 7d f3             	lea    -0xd(%ebp),%edi
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 470:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 473:	83 ee 01             	sub    $0x1,%esi
 476:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 479:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 480:	00 
 481:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 485:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 488:	8b 45 cc             	mov    -0x34(%ebp),%eax
 48b:	89 04 24             	mov    %eax,(%esp)
 48e:	e8 e5 fe ff ff       	call   378 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 493:	83 fe ff             	cmp    $0xffffffff,%esi
 496:	75 d8                	jne    470 <printint+0x60>
    putc(fd, buf[i]);
}
 498:	83 c4 3c             	add    $0x3c,%esp
 49b:	5b                   	pop    %ebx
 49c:	5e                   	pop    %esi
 49d:	5f                   	pop    %edi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4a0:	89 d0                	mov    %edx,%eax
 4a2:	f7 d8                	neg    %eax
 4a4:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 4ab:	eb 85                	jmp    432 <printint+0x22>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi

000004b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4bc:	0f b6 02             	movzbl (%edx),%eax
 4bf:	84 c0                	test   %al,%al
 4c1:	0f 84 e9 00 00 00    	je     5b0 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4c7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4ca:	89 d7                	mov    %edx,%edi
 4cc:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 4cf:	31 f6                	xor    %esi,%esi
 4d1:	eb 21                	jmp    4f4 <printf+0x44>
 4d3:	90                   	nop    
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d8:	83 fb 25             	cmp    $0x25,%ebx
 4db:	0f 85 d7 00 00 00    	jne    5b8 <printf+0x108>
 4e1:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e5:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 4e9:	83 c7 01             	add    $0x1,%edi
 4ec:	84 c0                	test   %al,%al
 4ee:	0f 84 bc 00 00 00    	je     5b0 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 4f4:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4f6:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 4f9:	74 dd                	je     4d8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4fb:	83 fe 25             	cmp    $0x25,%esi
 4fe:	75 e5                	jne    4e5 <printf+0x35>
      if(c == 'd'){
 500:	83 fb 64             	cmp    $0x64,%ebx
 503:	90                   	nop    
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 508:	0f 84 4a 01 00 00    	je     658 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 50e:	83 fb 78             	cmp    $0x78,%ebx
 511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 518:	0f 84 c2 00 00 00    	je     5e0 <printf+0x130>
 51e:	83 fb 70             	cmp    $0x70,%ebx
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 528:	0f 84 b2 00 00 00    	je     5e0 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 52e:	83 fb 73             	cmp    $0x73,%ebx
 531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 538:	0f 84 ca 00 00 00    	je     608 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53e:	83 fb 63             	cmp    $0x63,%ebx
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 548:	0f 84 5a 01 00 00    	je     6a8 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 54e:	83 fb 25             	cmp    $0x25,%ebx
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 558:	0f 84 22 01 00 00    	je     680 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55e:	8b 55 08             	mov    0x8(%ebp),%edx
 561:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 564:	31 f6                	xor    %esi,%esi
 566:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 571:	00 
 572:	89 44 24 04          	mov    %eax,0x4(%esp)
 576:	89 14 24             	mov    %edx,(%esp)
 579:	e8 fa fd ff ff       	call   378 <write>
 57e:	8b 45 08             	mov    0x8(%ebp),%eax
 581:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 584:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 587:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 58e:	00 
 58f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 593:	89 04 24             	mov    %eax,(%esp)
 596:	e8 dd fd ff ff       	call   378 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 59f:	83 c7 01             	add    $0x1,%edi
 5a2:	84 c0                	test   %al,%al
 5a4:	0f 85 4a ff ff ff    	jne    4f4 <printf+0x44>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b0:	83 c4 2c             	add    $0x2c,%esp
 5b3:	5b                   	pop    %ebx
 5b4:	5e                   	pop    %esi
 5b5:	5f                   	pop    %edi
 5b6:	5d                   	pop    %ebp
 5b7:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b8:	8b 55 08             	mov    0x8(%ebp),%edx
 5bb:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5be:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c8:	00 
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	89 14 24             	mov    %edx,(%esp)
 5d0:	e8 a3 fd ff ff       	call   378 <write>
 5d5:	e9 0b ff ff ff       	jmp    4e5 <printf+0x35>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5e3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5e8:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5f1:	8b 10                	mov    (%eax),%edx
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	e8 15 fe ff ff       	call   410 <printint>
        ap++;
 5fb:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 5ff:	e9 e1 fe ff ff       	jmp    4e5 <printf+0x35>
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 608:	8b 55 e0             	mov    -0x20(%ebp),%edx
 60b:	8b 1a                	mov    (%edx),%ebx
        ap++;
 60d:	83 c2 04             	add    $0x4,%edx
 610:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 613:	85 db                	test   %ebx,%ebx
 615:	0f 84 ba 00 00 00    	je     6d5 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 61b:	0f b6 03             	movzbl (%ebx),%eax
 61e:	84 c0                	test   %al,%al
 620:	74 2d                	je     64f <printf+0x19f>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 628:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62b:	8b 45 08             	mov    0x8(%ebp),%eax
 62e:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 631:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 634:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 63b:	00 
 63c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 640:	89 04 24             	mov    %eax,(%esp)
 643:	e8 30 fd ff ff       	call   378 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 648:	0f b6 03             	movzbl (%ebx),%eax
 64b:	84 c0                	test   %al,%al
 64d:	75 d9                	jne    628 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64f:	31 f6                	xor    %esi,%esi
 651:	e9 8f fe ff ff       	jmp    4e5 <printf+0x35>
 656:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 658:	8b 45 e0             	mov    -0x20(%ebp),%eax
 65b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 660:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 663:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 66a:	8b 10                	mov    (%eax),%edx
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	e8 9c fd ff ff       	call   410 <printint>
        ap++;
 674:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 678:	e9 68 fe ff ff       	jmp    4e5 <printf+0x35>
 67d:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 680:	8b 4d 08             	mov    0x8(%ebp),%ecx
 683:	8d 55 f3             	lea    -0xd(%ebp),%edx
 686:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 688:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 68c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 693:	00 
 694:	89 54 24 04          	mov    %edx,0x4(%esp)
 698:	89 0c 24             	mov    %ecx,(%esp)
 69b:	e8 d8 fc ff ff       	call   378 <write>
 6a0:	e9 40 fe ff ff       	jmp    4e5 <printf+0x35>
 6a5:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ab:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6ae:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6b0:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6b2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b9:	00 
 6ba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6be:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6c1:	8b 45 08             	mov    0x8(%ebp),%eax
 6c4:	89 04 24             	mov    %eax,(%esp)
 6c7:	e8 ac fc ff ff       	call   378 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6cc:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 6d0:	e9 10 fe ff ff       	jmp    4e5 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 6d5:	bb 8d 08 00 00       	mov    $0x88d,%ebx
 6da:	e9 3c ff ff ff       	jmp    61b <printf+0x16b>
 6df:	90                   	nop    

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	8b 0d c8 08 00 00    	mov    0x8c8,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e7:	89 e5                	mov    %esp,%ebp
 6e9:	57                   	push   %edi
 6ea:	56                   	push   %esi
 6eb:	53                   	push   %ebx
 6ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6ef:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f2:	39 d9                	cmp    %ebx,%ecx
 6f4:	73 24                	jae    71a <free+0x3a>
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	8b 11                	mov    (%ecx),%edx
 6fa:	39 d3                	cmp    %edx,%ebx
 6fc:	72 2a                	jb     728 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fe:	39 d1                	cmp    %edx,%ecx
 700:	72 10                	jb     712 <free+0x32>
 702:	39 d9                	cmp    %ebx,%ecx
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 708:	72 1e                	jb     728 <free+0x48>
 70a:	39 d3                	cmp    %edx,%ebx
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 710:	72 16                	jb     728 <free+0x48>
 712:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 714:	39 d9                	cmp    %ebx,%ecx
 716:	66 90                	xchg   %ax,%ax
 718:	72 de                	jb     6f8 <free+0x18>
 71a:	8b 11                	mov    (%ecx),%edx
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 720:	eb dc                	jmp    6fe <free+0x1e>
 722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 728:	8b 73 04             	mov    0x4(%ebx),%esi
 72b:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 72e:	39 d0                	cmp    %edx,%eax
 730:	74 1a                	je     74c <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 732:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 735:	8b 51 04             	mov    0x4(%ecx),%edx
 738:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 73b:	39 d8                	cmp    %ebx,%eax
 73d:	74 22                	je     761 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 73f:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 741:	89 0d c8 08 00 00    	mov    %ecx,0x8c8
}
 747:	5b                   	pop    %ebx
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 74c:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 74f:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 751:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 754:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 757:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 75a:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 75d:	39 d8                	cmp    %ebx,%eax
 75f:	75 de                	jne    73f <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 761:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 764:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 767:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 769:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 76c:	89 0d c8 08 00 00    	mov    %ecx,0x8c8
}
 772:	5b                   	pop    %ebx
 773:	5e                   	pop    %esi
 774:	5f                   	pop    %edi
 775:	5d                   	pop    %ebp
 776:	c3                   	ret    
 777:	89 f6                	mov    %esi,%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 35 c8 08 00 00    	mov    0x8c8,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	83 c0 07             	add    $0x7,%eax
 795:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 798:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 79d:	0f 84 95 00 00 00    	je     838 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a3:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 7a5:	8b 41 04             	mov    0x4(%ecx),%eax
 7a8:	39 c3                	cmp    %eax,%ebx
 7aa:	0f 86 b0 00 00 00    	jbe    860 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 7b0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7b7:	90                   	nop    
    }
    if(p == freep)
 7b8:	3b 0d c8 08 00 00    	cmp    0x8c8,%ecx
 7be:	89 ca                	mov    %ecx,%edx
 7c0:	74 34                	je     7f6 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 7c4:	8b 41 04             	mov    0x4(%ecx),%eax
 7c7:	39 c3                	cmp    %eax,%ebx
 7c9:	77 ed                	ja     7b8 <malloc+0x38>
 7cb:	89 d6                	mov    %edx,%esi
 7cd:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 7cf:	39 c3                	cmp    %eax,%ebx
 7d1:	74 1d                	je     7f0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7d3:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 7d5:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7d8:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 7db:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 7de:	89 35 c8 08 00 00    	mov    %esi,0x8c8
      return (void*) (p + 1);
 7e4:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7e7:	83 c4 0c             	add    $0xc,%esp
 7ea:	5b                   	pop    %ebx
 7eb:	5e                   	pop    %esi
 7ec:	5f                   	pop    %edi
 7ed:	5d                   	pop    %ebp
 7ee:	c3                   	ret    
 7ef:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 01                	mov    (%ecx),%eax
 7f2:	89 06                	mov    %eax,(%esi)
 7f4:	eb e8                	jmp    7de <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 7f6:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7fc:	bf 00 10 00 00       	mov    $0x1000,%edi
 801:	b8 00 80 00 00       	mov    $0x8000,%eax
 806:	76 04                	jbe    80c <malloc+0x8c>
 808:	89 df                	mov    %ebx,%edi
 80a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 80c:	89 04 24             	mov    %eax,(%esp)
 80f:	e8 cc fb ff ff       	call   3e0 <sbrk>
  if(p == (char*) -1)
 814:	83 f8 ff             	cmp    $0xffffffff,%eax
 817:	74 18                	je     831 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 819:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 81c:	83 c0 08             	add    $0x8,%eax
 81f:	89 04 24             	mov    %eax,(%esp)
 822:	e8 b9 fe ff ff       	call   6e0 <free>
  return freep;
 827:	8b 15 c8 08 00 00    	mov    0x8c8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 82d:	85 d2                	test   %edx,%edx
 82f:	75 91                	jne    7c2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 831:	31 c0                	xor    %eax,%eax
 833:	eb b2                	jmp    7e7 <malloc+0x67>
 835:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 838:	c7 05 c8 08 00 00 c0 	movl   $0x8c0,0x8c8
 83f:	08 00 00 
    base.s.size = 0;
 842:	be c0 08 00 00       	mov    $0x8c0,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 847:	c7 05 c0 08 00 00 c0 	movl   $0x8c0,0x8c0
 84e:	08 00 00 
    base.s.size = 0;
 851:	c7 05 c4 08 00 00 00 	movl   $0x0,0x8c4
 858:	00 00 00 
 85b:	e9 43 ff ff ff       	jmp    7a3 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 860:	89 ca                	mov    %ecx,%edx
 862:	e9 68 ff ff ff       	jmp    7cf <malloc+0x4f>

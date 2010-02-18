
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	31 f6                	xor    %esi,%esi
   7:	53                   	push   %ebx
   8:	83 ec 2c             	sub    $0x2c,%esp
   b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  12:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	8b 45 08             	mov    0x8(%ebp),%eax
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 80 09 00 	movl   $0x980,0x4(%esp)
  32:	00 
  33:	89 04 24             	mov    %eax,(%esp)
  36:	e8 c5 03 00 00       	call   400 <read>
  3b:	83 f8 00             	cmp    $0x0,%eax
  3e:	89 c7                	mov    %eax,%edi
  40:	7e 56                	jle    98 <wc+0x98>
  42:	31 db                	xor    %ebx,%ebx
  44:	eb 10                	jmp    56 <wc+0x56>
  46:	66 90                	xchg   %ax,%ax
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  48:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  4f:	83 c3 01             	add    $0x1,%ebx
  52:	39 df                	cmp    %ebx,%edi
  54:	7e 3d                	jle    93 <wc+0x93>
      c++;
      if(buf[i] == '\n')
  56:	0f be 83 80 09 00 00 	movsbl 0x980(%ebx),%eax
        l++;
  5d:	31 d2                	xor    %edx,%edx
      if(strchr(" \r\t\n\v", buf[i]))
  5f:	c7 04 24 f7 08 00 00 	movl   $0x8f7,(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
  66:	3c 0a                	cmp    $0xa,%al
  68:	0f 94 c2             	sete   %dl
  6b:	01 d6                	add    %edx,%esi
      if(strchr(" \r\t\n\v", buf[i]))
  6d:	89 44 24 04          	mov    %eax,0x4(%esp)
  71:	e8 fa 01 00 00       	call   270 <strchr>
  76:	85 c0                	test   %eax,%eax
  78:	75 ce                	jne    48 <wc+0x48>
        inword = 0;
      else if(!inword){
  7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  7d:	85 c0                	test   %eax,%eax
  7f:	75 ce                	jne    4f <wc+0x4f>
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  81:	83 c3 01             	add    $0x1,%ebx
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
  84:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  88:	39 df                	cmp    %ebx,%edi
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
  8a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  91:	7f c3                	jg     56 <wc+0x56>
  93:	01 7d ec             	add    %edi,-0x14(%ebp)
  96:	eb 88                	jmp    20 <wc+0x20>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  98:	75 35                	jne    cf <wc+0xcf>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	89 74 24 08          	mov    %esi,0x8(%esp)
  a1:	c7 44 24 04 0d 09 00 	movl   $0x90d,0x4(%esp)
  a8:	00 
  a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b0:	89 44 24 14          	mov    %eax,0x14(%esp)
  b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  b7:	89 44 24 10          	mov    %eax,0x10(%esp)
  bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  be:	89 44 24 0c          	mov    %eax,0xc(%esp)
  c2:	e8 79 04 00 00       	call   540 <printf>
}
  c7:	83 c4 2c             	add    $0x2c,%esp
  ca:	5b                   	pop    %ebx
  cb:	5e                   	pop    %esi
  cc:	5f                   	pop    %edi
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
  cf:	c7 44 24 04 fd 08 00 	movl   $0x8fd,0x4(%esp)
  d6:	00 
  d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  de:	e8 5d 04 00 00       	call   540 <printf>
    exit();
  e3:	e8 00 03 00 00       	call   3e8 <exit>
  e8:	90                   	nop    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
  f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f4:	83 e4 f0             	and    $0xfffffff0,%esp
  f7:	ff 71 fc             	pushl  -0x4(%ecx)
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	57                   	push   %edi
  int fd, i;

  if(argc <= 1){
    wc(0, "");
    exit();
  fe:	bf 01 00 00 00       	mov    $0x1,%edi
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
 103:	56                   	push   %esi
 104:	53                   	push   %ebx
 105:	51                   	push   %ecx
 106:	83 ec 18             	sub    $0x18,%esp
 109:	8b 01                	mov    (%ecx),%eax
 10b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 10e:	8b 41 04             	mov    0x4(%ecx),%eax
  int fd, i;

  if(argc <= 1){
 111:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    wc(0, "");
    exit();
 115:	8d 70 04             	lea    0x4(%eax),%esi
int
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
 118:	7e 63                	jle    17d <main+0x8d>
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 120:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 127:	00 
 128:	8b 06                	mov    (%esi),%eax
 12a:	89 04 24             	mov    %eax,(%esp)
 12d:	e8 f6 02 00 00       	call   428 <open>
 132:	85 c0                	test   %eax,%eax
 134:	89 c3                	mov    %eax,%ebx
 136:	78 26                	js     15e <main+0x6e>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 138:	8b 06                	mov    (%esi),%eax
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 13a:	83 c7 01             	add    $0x1,%edi
 13d:	83 c6 04             	add    $0x4,%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 140:	89 1c 24             	mov    %ebx,(%esp)
 143:	89 44 24 04          	mov    %eax,0x4(%esp)
 147:	e8 b4 fe ff ff       	call   0 <wc>
    close(fd);
 14c:	89 1c 24             	mov    %ebx,(%esp)
 14f:	e8 bc 02 00 00       	call   410 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 154:	39 7d ec             	cmp    %edi,-0x14(%ebp)
 157:	7f c7                	jg     120 <main+0x30>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 159:	e8 8a 02 00 00       	call   3e8 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
 15e:	8b 06                	mov    (%esi),%eax
 160:	c7 44 24 04 1a 09 00 	movl   $0x91a,0x4(%esp)
 167:	00 
 168:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 16f:	89 44 24 08          	mov    %eax,0x8(%esp)
 173:	e8 c8 03 00 00       	call   540 <printf>
      exit();
 178:	e8 6b 02 00 00       	call   3e8 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
 17d:	c7 44 24 04 0c 09 00 	movl   $0x90c,0x4(%esp)
 184:	00 
 185:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 18c:	e8 6f fe ff ff       	call   0 <wc>
    exit();
 191:	e8 52 02 00 00       	call   3e8 <exit>
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

000001a0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 1a0:	55                   	push   %ebp
 1a1:	31 d2                	xor    %edx,%edx
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1a8:	53                   	push   %ebx
 1a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
 1b4:	88 04 13             	mov    %al,(%ebx,%edx,1)
 1b7:	83 c2 01             	add    $0x1,%edx
 1ba:	84 c0                	test   %al,%al
 1bc:	75 f2                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1be:	89 d8                	mov    %ebx,%eax
 1c0:	5b                   	pop    %ebx
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
 1c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
 1d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1da:	0f b6 02             	movzbl (%edx),%eax
 1dd:	84 c0                	test   %al,%al
 1df:	75 14                	jne    1f5 <strcmp+0x25>
 1e1:	eb 2d                	jmp    210 <strcmp+0x40>
 1e3:	90                   	nop    
 1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 1e8:	83 c2 01             	add    $0x1,%edx
 1eb:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1ee:	0f b6 02             	movzbl (%edx),%eax
 1f1:	84 c0                	test   %al,%al
 1f3:	74 1b                	je     210 <strcmp+0x40>
 1f5:	0f b6 19             	movzbl (%ecx),%ebx
 1f8:	38 d8                	cmp    %bl,%al
 1fa:	74 ec                	je     1e8 <strcmp+0x18>
 1fc:	0f b6 d0             	movzbl %al,%edx
 1ff:	0f b6 c3             	movzbl %bl,%eax
 202:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 204:	89 d0                	mov    %edx,%eax
 206:	5b                   	pop    %ebx
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 210:	0f b6 19             	movzbl (%ecx),%ebx
 213:	31 d2                	xor    %edx,%edx
 215:	0f b6 c3             	movzbl %bl,%eax
 218:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 21a:	89 d0                	mov    %edx,%eax
 21c:	5b                   	pop    %ebx
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop    

00000220 <strlen>:

uint
strlen(char *s)
{
 220:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 221:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 223:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 225:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 227:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 22a:	80 3a 00             	cmpb   $0x0,(%edx)
 22d:	74 0c                	je     23b <strlen+0x1b>
 22f:	90                   	nop    
 230:	83 c0 01             	add    $0x1,%eax
 233:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 237:	75 f7                	jne    230 <strlen+0x10>
 239:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
 23b:	89 c8                	mov    %ecx,%eax
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret    
 23f:	90                   	nop    

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 10             	mov    0x10(%ebp),%eax
 246:	53                   	push   %ebx
 247:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
 24a:	85 c0                	test   %eax,%eax
 24c:	74 14                	je     262 <memset+0x22>
 24e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 252:	31 d2                	xor    %edx,%edx
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 258:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
 25b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 25e:	39 c2                	cmp    %eax,%edx
 260:	75 f6                	jne    258 <memset+0x18>
    *d++ = c;
  return dst;
}
 262:	89 d8                	mov    %ebx,%eax
 264:	5b                   	pop    %ebx
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 11                	jne    292 <strchr+0x22>
 281:	eb 25                	jmp    2a8 <strchr+0x38>
 283:	90                   	nop    
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 288:	83 c0 01             	add    $0x1,%eax
 28b:	0f b6 10             	movzbl (%eax),%edx
 28e:	84 d2                	test   %dl,%dl
 290:	74 16                	je     2a8 <strchr+0x38>
    if(*s == c)
 292:	38 ca                	cmp    %cl,%dl
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 298:	75 ee                	jne    288 <strchr+0x18>
      return (char*) s;
  return 0;
}
 29a:	5d                   	pop    %ebp
 29b:	90                   	nop    
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a0:	c3                   	ret    
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2a8:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 2aa:	5d                   	pop    %ebp
 2ab:	90                   	nop    
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	c3                   	ret    
 2b1:	eb 0d                	jmp    2c0 <atoi>
 2b3:	90                   	nop    
 2b4:	90                   	nop    
 2b5:	90                   	nop    
 2b6:	90                   	nop    
 2b7:	90                   	nop    
 2b8:	90                   	nop    
 2b9:	90                   	nop    
 2ba:	90                   	nop    
 2bb:	90                   	nop    
 2bc:	90                   	nop    
 2bd:	90                   	nop    
 2be:	90                   	nop    
 2bf:	90                   	nop    

000002c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c1:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	53                   	push   %ebx
 2c6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c9:	0f b6 13             	movzbl (%ebx),%edx
 2cc:	8d 42 d0             	lea    -0x30(%edx),%eax
 2cf:	3c 09                	cmp    $0x9,%al
 2d1:	77 1c                	ja     2ef <atoi+0x2f>
 2d3:	90                   	nop    
 2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2d8:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 2db:	0f be d2             	movsbl %dl,%edx
 2de:	83 c3 01             	add    $0x1,%ebx
 2e1:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e5:	0f b6 13             	movzbl (%ebx),%edx
 2e8:	8d 42 d0             	lea    -0x30(%edx),%eax
 2eb:	3c 09                	cmp    $0x9,%al
 2ed:	76 e9                	jbe    2d8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2ef:	89 c8                	mov    %ecx,%eax
 2f1:	5b                   	pop    %ebx
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000300 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 10             	mov    0x10(%ebp),%ecx
 306:	56                   	push   %esi
 307:	8b 75 08             	mov    0x8(%ebp),%esi
 30a:	53                   	push   %ebx
 30b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30e:	85 c9                	test   %ecx,%ecx
 310:	7e 14                	jle    326 <memmove+0x26>
 312:	31 d2                	xor    %edx,%edx
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 318:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 31c:	88 04 16             	mov    %al,(%esi,%edx,1)
 31f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 322:	39 ca                	cmp    %ecx,%edx
 324:	75 f2                	jne    318 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 326:	89 f0                	mov    %esi,%eax
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5d                   	pop    %ebp
 32b:	c3                   	ret    
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 336:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 339:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 33c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 33f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 344:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 34b:	00 
 34c:	89 04 24             	mov    %eax,(%esp)
 34f:	e8 d4 00 00 00       	call   428 <open>
  if(fd < 0)
 354:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 356:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 358:	78 19                	js     373 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 1c 24             	mov    %ebx,(%esp)
 360:	89 44 24 04          	mov    %eax,0x4(%esp)
 364:	e8 d7 00 00 00       	call   440 <fstat>
  close(fd);
 369:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 36c:	89 c6                	mov    %eax,%esi
  close(fd);
 36e:	e8 9d 00 00 00       	call   410 <close>
  return r;
}
 373:	89 f0                	mov    %esi,%eax
 375:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 378:	8b 75 fc             	mov    -0x4(%ebp),%esi
 37b:	89 ec                	mov    %ebp,%esp
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret    
 37f:	90                   	nop    

00000380 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	31 f6                	xor    %esi,%esi
 387:	53                   	push   %ebx
 388:	83 ec 1c             	sub    $0x1c,%esp
 38b:	8b 7d 08             	mov    0x8(%ebp),%edi
 38e:	eb 06                	jmp    396 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 390:	3c 0d                	cmp    $0xd,%al
 392:	74 39                	je     3cd <gets+0x4d>
 394:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 396:	8d 5e 01             	lea    0x1(%esi),%ebx
 399:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 39c:	7d 31                	jge    3cf <gets+0x4f>
    cc = read(0, &c, 1);
 39e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 3a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a8:	00 
 3a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3b4:	e8 47 00 00 00       	call   400 <read>
    if(cc < 1)
 3b9:	85 c0                	test   %eax,%eax
 3bb:	7e 12                	jle    3cf <gets+0x4f>
      break;
    buf[i++] = c;
 3bd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3c1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 3c5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 3c9:	3c 0a                	cmp    $0xa,%al
 3cb:	75 c3                	jne    390 <gets+0x10>
 3cd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3cf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3d3:	89 f8                	mov    %edi,%eax
 3d5:	83 c4 1c             	add    $0x1c,%esp
 3d8:	5b                   	pop    %ebx
 3d9:	5e                   	pop    %esi
 3da:	5f                   	pop    %edi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	90                   	nop    
 3de:	90                   	nop    
 3df:	90                   	nop    

000003e0 <fork>:
 3e0:	b8 01 00 00 00       	mov    $0x1,%eax
 3e5:	cd 30                	int    $0x30
 3e7:	c3                   	ret    

000003e8 <exit>:
 3e8:	b8 02 00 00 00       	mov    $0x2,%eax
 3ed:	cd 30                	int    $0x30
 3ef:	c3                   	ret    

000003f0 <wait>:
 3f0:	b8 03 00 00 00       	mov    $0x3,%eax
 3f5:	cd 30                	int    $0x30
 3f7:	c3                   	ret    

000003f8 <pipe>:
 3f8:	b8 04 00 00 00       	mov    $0x4,%eax
 3fd:	cd 30                	int    $0x30
 3ff:	c3                   	ret    

00000400 <read>:
 400:	b8 06 00 00 00       	mov    $0x6,%eax
 405:	cd 30                	int    $0x30
 407:	c3                   	ret    

00000408 <write>:
 408:	b8 05 00 00 00       	mov    $0x5,%eax
 40d:	cd 30                	int    $0x30
 40f:	c3                   	ret    

00000410 <close>:
 410:	b8 07 00 00 00       	mov    $0x7,%eax
 415:	cd 30                	int    $0x30
 417:	c3                   	ret    

00000418 <kill>:
 418:	b8 08 00 00 00       	mov    $0x8,%eax
 41d:	cd 30                	int    $0x30
 41f:	c3                   	ret    

00000420 <exec>:
 420:	b8 09 00 00 00       	mov    $0x9,%eax
 425:	cd 30                	int    $0x30
 427:	c3                   	ret    

00000428 <open>:
 428:	b8 0a 00 00 00       	mov    $0xa,%eax
 42d:	cd 30                	int    $0x30
 42f:	c3                   	ret    

00000430 <mknod>:
 430:	b8 0b 00 00 00       	mov    $0xb,%eax
 435:	cd 30                	int    $0x30
 437:	c3                   	ret    

00000438 <unlink>:
 438:	b8 0c 00 00 00       	mov    $0xc,%eax
 43d:	cd 30                	int    $0x30
 43f:	c3                   	ret    

00000440 <fstat>:
 440:	b8 0d 00 00 00       	mov    $0xd,%eax
 445:	cd 30                	int    $0x30
 447:	c3                   	ret    

00000448 <link>:
 448:	b8 0e 00 00 00       	mov    $0xe,%eax
 44d:	cd 30                	int    $0x30
 44f:	c3                   	ret    

00000450 <mkdir>:
 450:	b8 0f 00 00 00       	mov    $0xf,%eax
 455:	cd 30                	int    $0x30
 457:	c3                   	ret    

00000458 <chdir>:
 458:	b8 10 00 00 00       	mov    $0x10,%eax
 45d:	cd 30                	int    $0x30
 45f:	c3                   	ret    

00000460 <dup>:
 460:	b8 11 00 00 00       	mov    $0x11,%eax
 465:	cd 30                	int    $0x30
 467:	c3                   	ret    

00000468 <getpid>:
 468:	b8 12 00 00 00       	mov    $0x12,%eax
 46d:	cd 30                	int    $0x30
 46f:	c3                   	ret    

00000470 <sbrk>:
 470:	b8 13 00 00 00       	mov    $0x13,%eax
 475:	cd 30                	int    $0x30
 477:	c3                   	ret    

00000478 <sleep>:
 478:	b8 14 00 00 00       	mov    $0x14,%eax
 47d:	cd 30                	int    $0x30
 47f:	c3                   	ret    

00000480 <mytime>:
 480:	b8 15 00 00 00       	mov    $0x15,%eax
 485:	cd 30                	int    $0x30
 487:	c3                   	ret    

00000488 <settickets>:
 488:	b8 16 00 00 00       	mov    $0x16,%eax
 48d:	cd 30                	int    $0x30
 48f:	c3                   	ret    

00000490 <getruntime>:
 490:	b8 17 00 00 00       	mov    $0x17,%eax
 495:	cd 30                	int    $0x30
 497:	c3                   	ret    
 498:	90                   	nop    
 499:	90                   	nop    
 49a:	90                   	nop    
 49b:	90                   	nop    
 49c:	90                   	nop    
 49d:	90                   	nop    
 49e:	90                   	nop    
 49f:	90                   	nop    

000004a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	89 ce                	mov    %ecx,%esi
 4a7:	53                   	push   %ebx
 4a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ae:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b1:	85 c9                	test   %ecx,%ecx
 4b3:	74 04                	je     4b9 <printint+0x19>
 4b5:	85 d2                	test   %edx,%edx
 4b7:	78 77                	js     530 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b9:	89 d0                	mov    %edx,%eax
 4bb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 4c2:	31 db                	xor    %ebx,%ebx
 4c4:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 4c7:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4c8:	31 d2                	xor    %edx,%edx
 4ca:	f7 f6                	div    %esi
 4cc:	89 c1                	mov    %eax,%ecx
 4ce:	0f b6 82 36 09 00 00 	movzbl 0x936(%edx),%eax
 4d5:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 4d8:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 4db:	85 c9                	test   %ecx,%ecx
 4dd:	89 c8                	mov    %ecx,%eax
 4df:	75 e7                	jne    4c8 <printint+0x28>
  if(neg)
 4e1:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4e4:	85 c0                	test   %eax,%eax
 4e6:	74 08                	je     4f0 <printint+0x50>
    buf[i++] = '-';
 4e8:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 4ed:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 4f0:	8d 73 ff             	lea    -0x1(%ebx),%esi
 4f3:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 4f6:	8d 7d f3             	lea    -0xd(%ebp),%edi
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 500:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 503:	83 ee 01             	sub    $0x1,%esi
 506:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 509:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 510:	00 
 511:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 515:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 518:	8b 45 cc             	mov    -0x34(%ebp),%eax
 51b:	89 04 24             	mov    %eax,(%esp)
 51e:	e8 e5 fe ff ff       	call   408 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 523:	83 fe ff             	cmp    $0xffffffff,%esi
 526:	75 d8                	jne    500 <printint+0x60>
    putc(fd, buf[i]);
}
 528:	83 c4 3c             	add    $0x3c,%esp
 52b:	5b                   	pop    %ebx
 52c:	5e                   	pop    %esi
 52d:	5f                   	pop    %edi
 52e:	5d                   	pop    %ebp
 52f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 530:	89 d0                	mov    %edx,%eax
 532:	f7 d8                	neg    %eax
 534:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 53b:	eb 85                	jmp    4c2 <printint+0x22>
 53d:	8d 76 00             	lea    0x0(%esi),%esi

00000540 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 55 0c             	mov    0xc(%ebp),%edx
 54c:	0f b6 02             	movzbl (%edx),%eax
 54f:	84 c0                	test   %al,%al
 551:	0f 84 e9 00 00 00    	je     640 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 557:	8d 4d 10             	lea    0x10(%ebp),%ecx
 55a:	89 d7                	mov    %edx,%edi
 55c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 55f:	31 f6                	xor    %esi,%esi
 561:	eb 21                	jmp    584 <printf+0x44>
 563:	90                   	nop    
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 568:	83 fb 25             	cmp    $0x25,%ebx
 56b:	0f 85 d7 00 00 00    	jne    648 <printf+0x108>
 571:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 575:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 579:	83 c7 01             	add    $0x1,%edi
 57c:	84 c0                	test   %al,%al
 57e:	0f 84 bc 00 00 00    	je     640 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 584:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 586:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 589:	74 dd                	je     568 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 58b:	83 fe 25             	cmp    $0x25,%esi
 58e:	75 e5                	jne    575 <printf+0x35>
      if(c == 'd'){
 590:	83 fb 64             	cmp    $0x64,%ebx
 593:	90                   	nop    
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 598:	0f 84 4a 01 00 00    	je     6e8 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 59e:	83 fb 78             	cmp    $0x78,%ebx
 5a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a8:	0f 84 c2 00 00 00    	je     670 <printf+0x130>
 5ae:	83 fb 70             	cmp    $0x70,%ebx
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5b8:	0f 84 b2 00 00 00    	je     670 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5be:	83 fb 73             	cmp    $0x73,%ebx
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c8:	0f 84 ca 00 00 00    	je     698 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ce:	83 fb 63             	cmp    $0x63,%ebx
 5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d8:	0f 84 5a 01 00 00    	je     738 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5de:	83 fb 25             	cmp    $0x25,%ebx
 5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5e8:	0f 84 22 01 00 00    	je     710 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ee:	8b 55 08             	mov    0x8(%ebp),%edx
 5f1:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f4:	31 f6                	xor    %esi,%esi
 5f6:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 601:	00 
 602:	89 44 24 04          	mov    %eax,0x4(%esp)
 606:	89 14 24             	mov    %edx,(%esp)
 609:	e8 fa fd ff ff       	call   408 <write>
 60e:	8b 45 08             	mov    0x8(%ebp),%eax
 611:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 614:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 617:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 61e:	00 
 61f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 623:	89 04 24             	mov    %eax,(%esp)
 626:	e8 dd fd ff ff       	call   408 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 62b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 62f:	83 c7 01             	add    $0x1,%edi
 632:	84 c0                	test   %al,%al
 634:	0f 85 4a ff ff ff    	jne    584 <printf+0x44>
 63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 640:	83 c4 2c             	add    $0x2c,%esp
 643:	5b                   	pop    %ebx
 644:	5e                   	pop    %esi
 645:	5f                   	pop    %edi
 646:	5d                   	pop    %ebp
 647:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 648:	8b 55 08             	mov    0x8(%ebp),%edx
 64b:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 64e:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 651:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 658:	00 
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	89 14 24             	mov    %edx,(%esp)
 660:	e8 a3 fd ff ff       	call   408 <write>
 665:	e9 0b ff ff ff       	jmp    575 <printf+0x35>
 66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 670:	8b 45 e0             	mov    -0x20(%ebp),%eax
 673:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 678:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 67a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 681:	8b 10                	mov    (%eax),%edx
 683:	8b 45 08             	mov    0x8(%ebp),%eax
 686:	e8 15 fe ff ff       	call   4a0 <printint>
        ap++;
 68b:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 68f:	e9 e1 fe ff ff       	jmp    575 <printf+0x35>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 698:	8b 55 e0             	mov    -0x20(%ebp),%edx
 69b:	8b 1a                	mov    (%edx),%ebx
        ap++;
 69d:	83 c2 04             	add    $0x4,%edx
 6a0:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 6a3:	85 db                	test   %ebx,%ebx
 6a5:	0f 84 ba 00 00 00    	je     765 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 6ab:	0f b6 03             	movzbl (%ebx),%eax
 6ae:	84 c0                	test   %al,%al
 6b0:	74 2d                	je     6df <printf+0x19f>
 6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 6b8:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6c1:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6cb:	00 
 6cc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 6d0:	89 04 24             	mov    %eax,(%esp)
 6d3:	e8 30 fd ff ff       	call   408 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6d8:	0f b6 03             	movzbl (%ebx),%eax
 6db:	84 c0                	test   %al,%al
 6dd:	75 d9                	jne    6b8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6df:	31 f6                	xor    %esi,%esi
 6e1:	e9 8f fe ff ff       	jmp    575 <printf+0x35>
 6e6:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 6eb:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 6f0:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6fa:	8b 10                	mov    (%eax),%edx
 6fc:	8b 45 08             	mov    0x8(%ebp),%eax
 6ff:	e8 9c fd ff ff       	call   4a0 <printint>
        ap++;
 704:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 708:	e9 68 fe ff ff       	jmp    575 <printf+0x35>
 70d:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 710:	8b 4d 08             	mov    0x8(%ebp),%ecx
 713:	8d 55 f3             	lea    -0xd(%ebp),%edx
 716:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 718:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 71c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 723:	00 
 724:	89 54 24 04          	mov    %edx,0x4(%esp)
 728:	89 0c 24             	mov    %ecx,(%esp)
 72b:	e8 d8 fc ff ff       	call   408 <write>
 730:	e9 40 fe ff ff       	jmp    575 <printf+0x35>
 735:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 738:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73b:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 73e:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 740:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 742:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 749:	00 
 74a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 74e:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 751:	8b 45 08             	mov    0x8(%ebp),%eax
 754:	89 04 24             	mov    %eax,(%esp)
 757:	e8 ac fc ff ff       	call   408 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 75c:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 760:	e9 10 fe ff ff       	jmp    575 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 765:	bb 2f 09 00 00       	mov    $0x92f,%ebx
 76a:	e9 3c ff ff ff       	jmp    6ab <printf+0x16b>
 76f:	90                   	nop    

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	8b 0d 68 09 00 00    	mov    0x968,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 777:	89 e5                	mov    %esp,%ebp
 779:	57                   	push   %edi
 77a:	56                   	push   %esi
 77b:	53                   	push   %ebx
 77c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 77f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 782:	39 d9                	cmp    %ebx,%ecx
 784:	73 24                	jae    7aa <free+0x3a>
 786:	66 90                	xchg   %ax,%ax
 788:	8b 11                	mov    (%ecx),%edx
 78a:	39 d3                	cmp    %edx,%ebx
 78c:	72 2a                	jb     7b8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	39 d1                	cmp    %edx,%ecx
 790:	72 10                	jb     7a2 <free+0x32>
 792:	39 d9                	cmp    %ebx,%ecx
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 798:	72 1e                	jb     7b8 <free+0x48>
 79a:	39 d3                	cmp    %edx,%ebx
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a0:	72 16                	jb     7b8 <free+0x48>
 7a2:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a4:	39 d9                	cmp    %ebx,%ecx
 7a6:	66 90                	xchg   %ax,%ax
 7a8:	72 de                	jb     788 <free+0x18>
 7aa:	8b 11                	mov    (%ecx),%edx
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7b0:	eb dc                	jmp    78e <free+0x1e>
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b8:	8b 73 04             	mov    0x4(%ebx),%esi
 7bb:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 7be:	39 d0                	cmp    %edx,%eax
 7c0:	74 1a                	je     7dc <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7c2:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 7c5:	8b 51 04             	mov    0x4(%ecx),%edx
 7c8:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7cb:	39 d8                	cmp    %ebx,%eax
 7cd:	74 22                	je     7f1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7cf:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 7d1:	89 0d 68 09 00 00    	mov    %ecx,0x968
}
 7d7:	5b                   	pop    %ebx
 7d8:	5e                   	pop    %esi
 7d9:	5f                   	pop    %edi
 7da:	5d                   	pop    %ebp
 7db:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7dc:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 7df:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e1:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7e4:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7e7:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7ea:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 7ed:	39 d8                	cmp    %ebx,%eax
 7ef:	75 de                	jne    7cf <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7f1:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f4:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 7f7:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f9:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7fc:	89 0d 68 09 00 00    	mov    %ecx,0x968
}
 802:	5b                   	pop    %ebx
 803:	5e                   	pop    %esi
 804:	5f                   	pop    %edi
 805:	5d                   	pop    %ebp
 806:	c3                   	ret    
 807:	89 f6                	mov    %esi,%esi
 809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 35 68 09 00 00    	mov    0x968,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	83 c0 07             	add    $0x7,%eax
 825:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 828:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 82d:	0f 84 95 00 00 00    	je     8c8 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 833:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 835:	8b 41 04             	mov    0x4(%ecx),%eax
 838:	39 c3                	cmp    %eax,%ebx
 83a:	0f 86 b0 00 00 00    	jbe    8f0 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 840:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 847:	90                   	nop    
    }
    if(p == freep)
 848:	3b 0d 68 09 00 00    	cmp    0x968,%ecx
 84e:	89 ca                	mov    %ecx,%edx
 850:	74 34                	je     886 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 854:	8b 41 04             	mov    0x4(%ecx),%eax
 857:	39 c3                	cmp    %eax,%ebx
 859:	77 ed                	ja     848 <malloc+0x38>
 85b:	89 d6                	mov    %edx,%esi
 85d:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 85f:	39 c3                	cmp    %eax,%ebx
 861:	74 1d                	je     880 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 863:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 865:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 868:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 86b:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 86e:	89 35 68 09 00 00    	mov    %esi,0x968
      return (void*) (p + 1);
 874:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 877:	83 c4 0c             	add    $0xc,%esp
 87a:	5b                   	pop    %ebx
 87b:	5e                   	pop    %esi
 87c:	5f                   	pop    %edi
 87d:	5d                   	pop    %ebp
 87e:	c3                   	ret    
 87f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 880:	8b 01                	mov    (%ecx),%eax
 882:	89 06                	mov    %eax,(%esi)
 884:	eb e8                	jmp    86e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 886:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 88c:	bf 00 10 00 00       	mov    $0x1000,%edi
 891:	b8 00 80 00 00       	mov    $0x8000,%eax
 896:	76 04                	jbe    89c <malloc+0x8c>
 898:	89 df                	mov    %ebx,%edi
 89a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 89c:	89 04 24             	mov    %eax,(%esp)
 89f:	e8 cc fb ff ff       	call   470 <sbrk>
  if(p == (char*) -1)
 8a4:	83 f8 ff             	cmp    $0xffffffff,%eax
 8a7:	74 18                	je     8c1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8a9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8ac:	83 c0 08             	add    $0x8,%eax
 8af:	89 04 24             	mov    %eax,(%esp)
 8b2:	e8 b9 fe ff ff       	call   770 <free>
  return freep;
 8b7:	8b 15 68 09 00 00    	mov    0x968,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8bd:	85 d2                	test   %edx,%edx
 8bf:	75 91                	jne    852 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c1:	31 c0                	xor    %eax,%eax
 8c3:	eb b2                	jmp    877 <malloc+0x67>
 8c5:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8c8:	c7 05 68 09 00 00 60 	movl   $0x960,0x968
 8cf:	09 00 00 
    base.s.size = 0;
 8d2:	be 60 09 00 00       	mov    $0x960,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8d7:	c7 05 60 09 00 00 60 	movl   $0x960,0x960
 8de:	09 00 00 
    base.s.size = 0;
 8e1:	c7 05 64 09 00 00 00 	movl   $0x0,0x964
 8e8:	00 00 00 
 8eb:	e9 43 ff ff ff       	jmp    833 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8f0:	89 ca                	mov    %ecx,%edx
 8f2:	e9 68 ff ff ff       	jmp    85f <malloc+0x4f>

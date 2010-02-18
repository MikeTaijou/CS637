
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   b:	89 1c 24             	mov    %ebx,(%esp)
   e:	e8 ed 03 00 00       	call   400 <strlen>
  13:	01 d8                	add    %ebx,%eax
  15:	73 13                	jae    2a <fmtname+0x2a>
  17:	eb 19                	jmp    32 <fmtname+0x32>
  19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  20:	83 e8 01             	sub    $0x1,%eax
  23:	39 c3                	cmp    %eax,%ebx
  25:	8d 76 00             	lea    0x0(%esi),%esi
  28:	77 08                	ja     32 <fmtname+0x32>
  2a:	80 38 2f             	cmpb   $0x2f,(%eax)
  2d:	8d 76 00             	lea    0x0(%esi),%esi
  30:	75 ee                	jne    20 <fmtname+0x20>
    ;
  p++;
  32:	8d 70 01             	lea    0x1(%eax),%esi
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  35:	89 34 24             	mov    %esi,(%esp)
  38:	e8 c3 03 00 00       	call   400 <strlen>
  3d:	83 f8 0d             	cmp    $0xd,%eax
  40:	77 53                	ja     95 <fmtname+0x95>
    return p;
  memmove(buf, p, strlen(p));
  42:	89 34 24             	mov    %esi,(%esp)
  45:	e8 b6 03 00 00       	call   400 <strlen>
  4a:	89 74 24 04          	mov    %esi,0x4(%esp)
  4e:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
  55:	89 44 24 08          	mov    %eax,0x8(%esp)
  59:	e8 82 04 00 00       	call   4e0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  5e:	89 34 24             	mov    %esi,(%esp)
  61:	e8 9a 03 00 00       	call   400 <strlen>
  66:	89 34 24             	mov    %esi,(%esp)
  69:	be 48 0b 00 00       	mov    $0xb48,%esi
  6e:	89 c3                	mov    %eax,%ebx
  70:	e8 8b 03 00 00       	call   400 <strlen>
  75:	ba 0e 00 00 00       	mov    $0xe,%edx
  7a:	29 da                	sub    %ebx,%edx
  7c:	89 54 24 08          	mov    %edx,0x8(%esp)
  80:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  87:	00 
  88:	05 48 0b 00 00       	add    $0xb48,%eax
  8d:	89 04 24             	mov    %eax,(%esp)
  90:	e8 8b 03 00 00       	call   420 <memset>
  return buf;
}
  95:	83 c4 10             	add    $0x10,%esp
  98:	89 f0                	mov    %esi,%eax
  9a:	5b                   	pop    %ebx
  9b:	5e                   	pop    %esi
  9c:	5d                   	pop    %ebp
  9d:	c3                   	ret    
  9e:	66 90                	xchg   %ax,%ax

000000a0 <ls>:

void
ls(char *path)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	81 ec 4c 02 00 00    	sub    $0x24c,%esp
  ac:	8b 75 08             	mov    0x8(%ebp),%esi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  b6:	00 
  b7:	89 34 24             	mov    %esi,(%esp)
  ba:	e8 49 05 00 00       	call   608 <open>
  bf:	85 c0                	test   %eax,%eax
  c1:	89 c7                	mov    %eax,%edi
  c3:	0f 88 8f 01 00 00    	js     258 <ls+0x1b8>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
  c9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  d0:	89 3c 24             	mov    %edi,(%esp)
  d3:	e8 48 05 00 00       	call   620 <fstat>
  d8:	85 c0                	test   %eax,%eax
  da:	0f 88 c0 01 00 00    	js     2a0 <ls+0x200>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  
  switch(st.type){
  e0:	0f b7 45 dc          	movzwl -0x24(%ebp),%eax
  e4:	66 83 f8 01          	cmp    $0x1,%ax
  e8:	74 5e                	je     148 <ls+0xa8>
  ea:	66 83 f8 02          	cmp    $0x2,%ax
  ee:	66 90                	xchg   %ax,%ax
  f0:	75 42                	jne    134 <ls+0x94>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  f2:	8b 55 d8             	mov    -0x28(%ebp),%edx
  f5:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  f8:	89 95 c8 fd ff ff    	mov    %edx,-0x238(%ebp)
  fe:	89 34 24             	mov    %esi,(%esp)
 101:	e8 fa fe ff ff       	call   0 <fmtname>
 106:	89 5c 24 14          	mov    %ebx,0x14(%esp)
 10a:	8b 95 c8 fd ff ff    	mov    -0x238(%ebp),%edx
 110:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 117:	00 
 118:	c7 44 24 04 ff 0a 00 	movl   $0xaff,0x4(%esp)
 11f:	00 
 120:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 127:	89 54 24 10          	mov    %edx,0x10(%esp)
 12b:	89 44 24 08          	mov    %eax,0x8(%esp)
 12f:	e8 ec 05 00 00       	call   720 <printf>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	89 3c 24             	mov    %edi,(%esp)
 137:	e8 b4 04 00 00       	call   5f0 <close>
}
 13c:	81 c4 4c 02 00 00    	add    $0x24c,%esp
 142:	5b                   	pop    %ebx
 143:	5e                   	pop    %esi
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	90                   	nop    
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 148:	89 34 24             	mov    %esi,(%esp)
 14b:	e8 b0 02 00 00       	call   400 <strlen>
 150:	83 c0 10             	add    $0x10,%eax
 153:	3d 00 02 00 00       	cmp    $0x200,%eax
 158:	0f 87 22 01 00 00    	ja     280 <ls+0x1e0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 15e:	8d 85 d4 fd ff ff    	lea    -0x22c(%ebp),%eax
 164:	89 74 24 04          	mov    %esi,0x4(%esp)
 168:	89 04 24             	mov    %eax,(%esp)
 16b:	e8 10 02 00 00       	call   380 <strcpy>
    p = buf+strlen(buf);
 170:	8d 95 d4 fd ff ff    	lea    -0x22c(%ebp),%edx
 176:	89 14 24             	mov    %edx,(%esp)
 179:	e8 82 02 00 00       	call   400 <strlen>
 17e:	8d 95 d4 fd ff ff    	lea    -0x22c(%ebp),%edx
 184:	8d 04 02             	lea    (%edx,%eax,1),%eax
    *p++ = '/';
 187:	c6 00 2f             	movb   $0x2f,(%eax)
 18a:	83 c0 01             	add    $0x1,%eax
 18d:	89 85 cc fd ff ff    	mov    %eax,-0x234(%ebp)
 193:	90                   	nop    
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 198:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 19b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1a2:	00 
 1a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a7:	89 3c 24             	mov    %edi,(%esp)
 1aa:	e8 31 04 00 00       	call   5e0 <read>
 1af:	83 f8 10             	cmp    $0x10,%eax
 1b2:	75 80                	jne    134 <ls+0x94>
      if(de.inum == 0)
 1b4:	66 83 7d e4 00       	cmpw   $0x0,-0x1c(%ebp)
 1b9:	74 dd                	je     198 <ls+0xf8>
        continue;
      memmove(p, de.name, DIRSIZ);
 1bb:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 1be:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 1c5:	00 
 1c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ca:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
 1d0:	89 14 24             	mov    %edx,(%esp)
 1d3:	e8 08 03 00 00       	call   4e0 <memmove>
      p[DIRSIZ] = 0;
 1d8:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
      if(stat(buf, &st) < 0){
 1de:	8d 55 d4             	lea    -0x2c(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
 1e1:	c6 40 0e 00          	movb   $0x0,0xe(%eax)
      if(stat(buf, &st) < 0){
 1e5:	8d 85 d4 fd ff ff    	lea    -0x22c(%ebp),%eax
 1eb:	89 54 24 04          	mov    %edx,0x4(%esp)
 1ef:	89 04 24             	mov    %eax,(%esp)
 1f2:	e8 19 03 00 00       	call   510 <stat>
 1f7:	85 c0                	test   %eax,%eax
 1f9:	0f 88 d1 00 00 00    	js     2d0 <ls+0x230>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1ff:	8b 45 d8             	mov    -0x28(%ebp),%eax
 202:	0f bf 55 dc          	movswl -0x24(%ebp),%edx
 206:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 209:	89 85 d0 fd ff ff    	mov    %eax,-0x230(%ebp)
 20f:	8d 85 d4 fd ff ff    	lea    -0x22c(%ebp),%eax
 215:	89 95 c4 fd ff ff    	mov    %edx,-0x23c(%ebp)
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	e8 dd fd ff ff       	call   0 <fmtname>
 223:	89 5c 24 14          	mov    %ebx,0x14(%esp)
 227:	8b 95 d0 fd ff ff    	mov    -0x230(%ebp),%edx
 22d:	89 54 24 10          	mov    %edx,0x10(%esp)
 231:	8b 95 c4 fd ff ff    	mov    -0x23c(%ebp),%edx
 237:	89 44 24 08          	mov    %eax,0x8(%esp)
 23b:	c7 44 24 04 ff 0a 00 	movl   $0xaff,0x4(%esp)
 242:	00 
 243:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 24a:	89 54 24 0c          	mov    %edx,0xc(%esp)
 24e:	e8 cd 04 00 00       	call   720 <printf>
 253:	e9 40 ff ff ff       	jmp    198 <ls+0xf8>
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 258:	89 74 24 08          	mov    %esi,0x8(%esp)
 25c:	c7 44 24 04 d7 0a 00 	movl   $0xad7,0x4(%esp)
 263:	00 
 264:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 26b:	e8 b0 04 00 00       	call   720 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 270:	81 c4 4c 02 00 00    	add    $0x24c,%esp
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop    
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 280:	c7 44 24 04 0c 0b 00 	movl   $0xb0c,0x4(%esp)
 287:	00 
 288:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 28f:	e8 8c 04 00 00       	call   720 <printf>
 294:	e9 9b fe ff ff       	jmp    134 <ls+0x94>
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2a0:	89 74 24 08          	mov    %esi,0x8(%esp)
 2a4:	c7 44 24 04 eb 0a 00 	movl   $0xaeb,0x4(%esp)
 2ab:	00 
 2ac:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2b3:	e8 68 04 00 00       	call   720 <printf>
    close(fd);
 2b8:	89 3c 24             	mov    %edi,(%esp)
 2bb:	e8 30 03 00 00       	call   5f0 <close>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2c0:	81 c4 4c 02 00 00    	add    $0x24c,%esp
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret    
 2cb:	90                   	nop    
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2d0:	8d 95 d4 fd ff ff    	lea    -0x22c(%ebp),%edx
 2d6:	89 54 24 08          	mov    %edx,0x8(%esp)
 2da:	c7 44 24 04 eb 0a 00 	movl   $0xaeb,0x4(%esp)
 2e1:	00 
 2e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2e9:	e8 32 04 00 00       	call   720 <printf>
 2ee:	e9 a5 fe ff ff       	jmp    198 <ls+0xf8>
 2f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
 300:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 304:	83 e4 f0             	and    $0xfffffff0,%esp
 307:	ff 71 fc             	pushl  -0x4(%ecx)
 30a:	55                   	push   %ebp
 30b:	89 e5                	mov    %esp,%ebp
 30d:	83 ec 28             	sub    $0x28,%esp
 310:	89 4d f0             	mov    %ecx,-0x10(%ebp)
 313:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 316:	8b 19                	mov    (%ecx),%ebx
 318:	89 75 f8             	mov    %esi,-0x8(%ebp)
 31b:	89 7d fc             	mov    %edi,-0x4(%ebp)
 31e:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;
   printf(2, "ticks == %d\n", mytime());
 321:	e8 3a 03 00 00       	call   660 <mytime>
 326:	c7 44 24 04 1f 0b 00 	movl   $0xb1f,0x4(%esp)
 32d:	00 
 32e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 335:	89 44 24 08          	mov    %eax,0x8(%esp)
 339:	e8 e2 03 00 00       	call   720 <printf>
  
  if(argc < 2){
 33e:	83 fb 01             	cmp    $0x1,%ebx
 341:	7f 11                	jg     354 <main+0x54>
    ls(".");
 343:	c7 04 24 2c 0b 00 00 	movl   $0xb2c,(%esp)
 34a:	e8 51 fd ff ff       	call   a0 <ls>
    exit();
 34f:	e8 74 02 00 00       	call   5c8 <exit>
 354:	be 01 00 00 00       	mov    $0x1,%esi
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 360:	8b 04 b7             	mov    (%edi,%esi,4),%eax
  
  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 363:	83 c6 01             	add    $0x1,%esi
    ls(argv[i]);
 366:	89 04 24             	mov    %eax,(%esp)
 369:	e8 32 fd ff ff       	call   a0 <ls>
  
  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 36e:	39 f3                	cmp    %esi,%ebx
 370:	7f ee                	jg     360 <main+0x60>
    ls(argv[i]);
  exit();
 372:	e8 51 02 00 00       	call   5c8 <exit>
 377:	90                   	nop    
 378:	90                   	nop    
 379:	90                   	nop    
 37a:	90                   	nop    
 37b:	90                   	nop    
 37c:	90                   	nop    
 37d:	90                   	nop    
 37e:	90                   	nop    
 37f:	90                   	nop    

00000380 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 380:	55                   	push   %ebp
 381:	31 d2                	xor    %edx,%edx
 383:	89 e5                	mov    %esp,%ebp
 385:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 388:	53                   	push   %ebx
 389:	8b 5d 08             	mov    0x8(%ebp),%ebx
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 390:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
 394:	88 04 13             	mov    %al,(%ebx,%edx,1)
 397:	83 c2 01             	add    $0x1,%edx
 39a:	84 c0                	test   %al,%al
 39c:	75 f2                	jne    390 <strcpy+0x10>
    ;
  return os;
}
 39e:	89 d8                	mov    %ebx,%eax
 3a0:	5b                   	pop    %ebx
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
 3b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3ba:	0f b6 02             	movzbl (%edx),%eax
 3bd:	84 c0                	test   %al,%al
 3bf:	75 14                	jne    3d5 <strcmp+0x25>
 3c1:	eb 2d                	jmp    3f0 <strcmp+0x40>
 3c3:	90                   	nop    
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 3c8:	83 c2 01             	add    $0x1,%edx
 3cb:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3ce:	0f b6 02             	movzbl (%edx),%eax
 3d1:	84 c0                	test   %al,%al
 3d3:	74 1b                	je     3f0 <strcmp+0x40>
 3d5:	0f b6 19             	movzbl (%ecx),%ebx
 3d8:	38 d8                	cmp    %bl,%al
 3da:	74 ec                	je     3c8 <strcmp+0x18>
 3dc:	0f b6 d0             	movzbl %al,%edx
 3df:	0f b6 c3             	movzbl %bl,%eax
 3e2:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3e4:	89 d0                	mov    %edx,%eax
 3e6:	5b                   	pop    %ebx
 3e7:	5d                   	pop    %ebp
 3e8:	c3                   	ret    
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3f0:	0f b6 19             	movzbl (%ecx),%ebx
 3f3:	31 d2                	xor    %edx,%edx
 3f5:	0f b6 c3             	movzbl %bl,%eax
 3f8:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3fa:	89 d0                	mov    %edx,%eax
 3fc:	5b                   	pop    %ebx
 3fd:	5d                   	pop    %ebp
 3fe:	c3                   	ret    
 3ff:	90                   	nop    

00000400 <strlen>:

uint
strlen(char *s)
{
 400:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 401:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 403:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 405:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 407:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 40a:	80 3a 00             	cmpb   $0x0,(%edx)
 40d:	74 0c                	je     41b <strlen+0x1b>
 40f:	90                   	nop    
 410:	83 c0 01             	add    $0x1,%eax
 413:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 417:	75 f7                	jne    410 <strlen+0x10>
 419:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
 41b:	89 c8                	mov    %ecx,%eax
 41d:	5d                   	pop    %ebp
 41e:	c3                   	ret    
 41f:	90                   	nop    

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 45 10             	mov    0x10(%ebp),%eax
 426:	53                   	push   %ebx
 427:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
 42a:	85 c0                	test   %eax,%eax
 42c:	74 14                	je     442 <memset+0x22>
 42e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 432:	31 d2                	xor    %edx,%edx
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 438:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
 43b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 43e:	39 c2                	cmp    %eax,%edx
 440:	75 f6                	jne    438 <memset+0x18>
    *d++ = c;
  return dst;
}
 442:	89 d8                	mov    %ebx,%eax
 444:	5b                   	pop    %ebx
 445:	5d                   	pop    %ebp
 446:	c3                   	ret    
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <strchr>:

char*
strchr(const char *s, char c)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 45 08             	mov    0x8(%ebp),%eax
 456:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 45a:	0f b6 10             	movzbl (%eax),%edx
 45d:	84 d2                	test   %dl,%dl
 45f:	75 11                	jne    472 <strchr+0x22>
 461:	eb 25                	jmp    488 <strchr+0x38>
 463:	90                   	nop    
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 468:	83 c0 01             	add    $0x1,%eax
 46b:	0f b6 10             	movzbl (%eax),%edx
 46e:	84 d2                	test   %dl,%dl
 470:	74 16                	je     488 <strchr+0x38>
    if(*s == c)
 472:	38 ca                	cmp    %cl,%dl
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 478:	75 ee                	jne    468 <strchr+0x18>
      return (char*) s;
  return 0;
}
 47a:	5d                   	pop    %ebp
 47b:	90                   	nop    
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 480:	c3                   	ret    
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 488:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 48a:	5d                   	pop    %ebp
 48b:	90                   	nop    
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 490:	c3                   	ret    
 491:	eb 0d                	jmp    4a0 <atoi>
 493:	90                   	nop    
 494:	90                   	nop    
 495:	90                   	nop    
 496:	90                   	nop    
 497:	90                   	nop    
 498:	90                   	nop    
 499:	90                   	nop    
 49a:	90                   	nop    
 49b:	90                   	nop    
 49c:	90                   	nop    
 49d:	90                   	nop    
 49e:	90                   	nop    
 49f:	90                   	nop    

000004a0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4a0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a1:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
 4a3:	89 e5                	mov    %esp,%ebp
 4a5:	53                   	push   %ebx
 4a6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a9:	0f b6 13             	movzbl (%ebx),%edx
 4ac:	8d 42 d0             	lea    -0x30(%edx),%eax
 4af:	3c 09                	cmp    $0x9,%al
 4b1:	77 1c                	ja     4cf <atoi+0x2f>
 4b3:	90                   	nop    
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 4b8:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
 4bb:	0f be d2             	movsbl %dl,%edx
 4be:	83 c3 01             	add    $0x1,%ebx
 4c1:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c5:	0f b6 13             	movzbl (%ebx),%edx
 4c8:	8d 42 d0             	lea    -0x30(%edx),%eax
 4cb:	3c 09                	cmp    $0x9,%al
 4cd:	76 e9                	jbe    4b8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 4cf:	89 c8                	mov    %ecx,%eax
 4d1:	5b                   	pop    %ebx
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4e6:	56                   	push   %esi
 4e7:	8b 75 08             	mov    0x8(%ebp),%esi
 4ea:	53                   	push   %ebx
 4eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ee:	85 c9                	test   %ecx,%ecx
 4f0:	7e 14                	jle    506 <memmove+0x26>
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4f8:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
 4fc:	88 04 16             	mov    %al,(%esi,%edx,1)
 4ff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 502:	39 ca                	cmp    %ecx,%edx
 504:	75 f2                	jne    4f8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 506:	89 f0                	mov    %esi,%eax
 508:	5b                   	pop    %ebx
 509:	5e                   	pop    %esi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000510 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 516:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 519:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 51c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 51f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 524:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 52b:	00 
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 d4 00 00 00       	call   608 <open>
  if(fd < 0)
 534:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 536:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 538:	78 19                	js     553 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 53a:	8b 45 0c             	mov    0xc(%ebp),%eax
 53d:	89 1c 24             	mov    %ebx,(%esp)
 540:	89 44 24 04          	mov    %eax,0x4(%esp)
 544:	e8 d7 00 00 00       	call   620 <fstat>
  close(fd);
 549:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 54c:	89 c6                	mov    %eax,%esi
  close(fd);
 54e:	e8 9d 00 00 00       	call   5f0 <close>
  return r;
}
 553:	89 f0                	mov    %esi,%eax
 555:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 558:	8b 75 fc             	mov    -0x4(%ebp),%esi
 55b:	89 ec                	mov    %ebp,%esp
 55d:	5d                   	pop    %ebp
 55e:	c3                   	ret    
 55f:	90                   	nop    

00000560 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	31 f6                	xor    %esi,%esi
 567:	53                   	push   %ebx
 568:	83 ec 1c             	sub    $0x1c,%esp
 56b:	8b 7d 08             	mov    0x8(%ebp),%edi
 56e:	eb 06                	jmp    576 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 570:	3c 0d                	cmp    $0xd,%al
 572:	74 39                	je     5ad <gets+0x4d>
 574:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 576:	8d 5e 01             	lea    0x1(%esi),%ebx
 579:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 57c:	7d 31                	jge    5af <gets+0x4f>
    cc = read(0, &c, 1);
 57e:	8d 45 f3             	lea    -0xd(%ebp),%eax
 581:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 588:	00 
 589:	89 44 24 04          	mov    %eax,0x4(%esp)
 58d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 594:	e8 47 00 00 00       	call   5e0 <read>
    if(cc < 1)
 599:	85 c0                	test   %eax,%eax
 59b:	7e 12                	jle    5af <gets+0x4f>
      break;
    buf[i++] = c;
 59d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 5a1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 5a5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
 5a9:	3c 0a                	cmp    $0xa,%al
 5ab:	75 c3                	jne    570 <gets+0x10>
 5ad:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 5af:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 5b3:	89 f8                	mov    %edi,%eax
 5b5:	83 c4 1c             	add    $0x1c,%esp
 5b8:	5b                   	pop    %ebx
 5b9:	5e                   	pop    %esi
 5ba:	5f                   	pop    %edi
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret    
 5bd:	90                   	nop    
 5be:	90                   	nop    
 5bf:	90                   	nop    

000005c0 <fork>:
 5c0:	b8 01 00 00 00       	mov    $0x1,%eax
 5c5:	cd 30                	int    $0x30
 5c7:	c3                   	ret    

000005c8 <exit>:
 5c8:	b8 02 00 00 00       	mov    $0x2,%eax
 5cd:	cd 30                	int    $0x30
 5cf:	c3                   	ret    

000005d0 <wait>:
 5d0:	b8 03 00 00 00       	mov    $0x3,%eax
 5d5:	cd 30                	int    $0x30
 5d7:	c3                   	ret    

000005d8 <pipe>:
 5d8:	b8 04 00 00 00       	mov    $0x4,%eax
 5dd:	cd 30                	int    $0x30
 5df:	c3                   	ret    

000005e0 <read>:
 5e0:	b8 06 00 00 00       	mov    $0x6,%eax
 5e5:	cd 30                	int    $0x30
 5e7:	c3                   	ret    

000005e8 <write>:
 5e8:	b8 05 00 00 00       	mov    $0x5,%eax
 5ed:	cd 30                	int    $0x30
 5ef:	c3                   	ret    

000005f0 <close>:
 5f0:	b8 07 00 00 00       	mov    $0x7,%eax
 5f5:	cd 30                	int    $0x30
 5f7:	c3                   	ret    

000005f8 <kill>:
 5f8:	b8 08 00 00 00       	mov    $0x8,%eax
 5fd:	cd 30                	int    $0x30
 5ff:	c3                   	ret    

00000600 <exec>:
 600:	b8 09 00 00 00       	mov    $0x9,%eax
 605:	cd 30                	int    $0x30
 607:	c3                   	ret    

00000608 <open>:
 608:	b8 0a 00 00 00       	mov    $0xa,%eax
 60d:	cd 30                	int    $0x30
 60f:	c3                   	ret    

00000610 <mknod>:
 610:	b8 0b 00 00 00       	mov    $0xb,%eax
 615:	cd 30                	int    $0x30
 617:	c3                   	ret    

00000618 <unlink>:
 618:	b8 0c 00 00 00       	mov    $0xc,%eax
 61d:	cd 30                	int    $0x30
 61f:	c3                   	ret    

00000620 <fstat>:
 620:	b8 0d 00 00 00       	mov    $0xd,%eax
 625:	cd 30                	int    $0x30
 627:	c3                   	ret    

00000628 <link>:
 628:	b8 0e 00 00 00       	mov    $0xe,%eax
 62d:	cd 30                	int    $0x30
 62f:	c3                   	ret    

00000630 <mkdir>:
 630:	b8 0f 00 00 00       	mov    $0xf,%eax
 635:	cd 30                	int    $0x30
 637:	c3                   	ret    

00000638 <chdir>:
 638:	b8 10 00 00 00       	mov    $0x10,%eax
 63d:	cd 30                	int    $0x30
 63f:	c3                   	ret    

00000640 <dup>:
 640:	b8 11 00 00 00       	mov    $0x11,%eax
 645:	cd 30                	int    $0x30
 647:	c3                   	ret    

00000648 <getpid>:
 648:	b8 12 00 00 00       	mov    $0x12,%eax
 64d:	cd 30                	int    $0x30
 64f:	c3                   	ret    

00000650 <sbrk>:
 650:	b8 13 00 00 00       	mov    $0x13,%eax
 655:	cd 30                	int    $0x30
 657:	c3                   	ret    

00000658 <sleep>:
 658:	b8 14 00 00 00       	mov    $0x14,%eax
 65d:	cd 30                	int    $0x30
 65f:	c3                   	ret    

00000660 <mytime>:
 660:	b8 15 00 00 00       	mov    $0x15,%eax
 665:	cd 30                	int    $0x30
 667:	c3                   	ret    

00000668 <settickets>:
 668:	b8 16 00 00 00       	mov    $0x16,%eax
 66d:	cd 30                	int    $0x30
 66f:	c3                   	ret    

00000670 <getruntime>:
 670:	b8 17 00 00 00       	mov    $0x17,%eax
 675:	cd 30                	int    $0x30
 677:	c3                   	ret    
 678:	90                   	nop    
 679:	90                   	nop    
 67a:	90                   	nop    
 67b:	90                   	nop    
 67c:	90                   	nop    
 67d:	90                   	nop    
 67e:	90                   	nop    
 67f:	90                   	nop    

00000680 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	89 ce                	mov    %ecx,%esi
 687:	53                   	push   %ebx
 688:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 68e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 691:	85 c9                	test   %ecx,%ecx
 693:	74 04                	je     699 <printint+0x19>
 695:	85 d2                	test   %edx,%edx
 697:	78 77                	js     710 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 699:	89 d0                	mov    %edx,%eax
 69b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
 6a2:	31 db                	xor    %ebx,%ebx
 6a4:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 6a7:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 6a8:	31 d2                	xor    %edx,%edx
 6aa:	f7 f6                	div    %esi
 6ac:	89 c1                	mov    %eax,%ecx
 6ae:	0f b6 82 35 0b 00 00 	movzbl 0xb35(%edx),%eax
 6b5:	88 04 1f             	mov    %al,(%edi,%ebx,1)
 6b8:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
 6bb:	85 c9                	test   %ecx,%ecx
 6bd:	89 c8                	mov    %ecx,%eax
 6bf:	75 e7                	jne    6a8 <printint+0x28>
  if(neg)
 6c1:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6c4:	85 c0                	test   %eax,%eax
 6c6:	74 08                	je     6d0 <printint+0x50>
    buf[i++] = '-';
 6c8:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
 6cd:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
 6d0:	8d 73 ff             	lea    -0x1(%ebx),%esi
 6d3:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
 6d6:	8d 7d f3             	lea    -0xd(%ebp),%edi
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 6e0:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6e3:	83 ee 01             	sub    $0x1,%esi
 6e6:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6f0:	00 
 6f1:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
 6f5:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6f8:	8b 45 cc             	mov    -0x34(%ebp),%eax
 6fb:	89 04 24             	mov    %eax,(%esp)
 6fe:	e8 e5 fe ff ff       	call   5e8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 703:	83 fe ff             	cmp    $0xffffffff,%esi
 706:	75 d8                	jne    6e0 <printint+0x60>
    putc(fd, buf[i]);
}
 708:	83 c4 3c             	add    $0x3c,%esp
 70b:	5b                   	pop    %ebx
 70c:	5e                   	pop    %esi
 70d:	5f                   	pop    %edi
 70e:	5d                   	pop    %ebp
 70f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 710:	89 d0                	mov    %edx,%eax
 712:	f7 d8                	neg    %eax
 714:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
 71b:	eb 85                	jmp    6a2 <printint+0x22>
 71d:	8d 76 00             	lea    0x0(%esi),%esi

00000720 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 729:	8b 55 0c             	mov    0xc(%ebp),%edx
 72c:	0f b6 02             	movzbl (%edx),%eax
 72f:	84 c0                	test   %al,%al
 731:	0f 84 e9 00 00 00    	je     820 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 737:	8d 4d 10             	lea    0x10(%ebp),%ecx
 73a:	89 d7                	mov    %edx,%edi
 73c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 73f:	31 f6                	xor    %esi,%esi
 741:	eb 21                	jmp    764 <printf+0x44>
 743:	90                   	nop    
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 748:	83 fb 25             	cmp    $0x25,%ebx
 74b:	0f 85 d7 00 00 00    	jne    828 <printf+0x108>
 751:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 755:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 759:	83 c7 01             	add    $0x1,%edi
 75c:	84 c0                	test   %al,%al
 75e:	0f 84 bc 00 00 00    	je     820 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
 764:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 766:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
 769:	74 dd                	je     748 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 76b:	83 fe 25             	cmp    $0x25,%esi
 76e:	75 e5                	jne    755 <printf+0x35>
      if(c == 'd'){
 770:	83 fb 64             	cmp    $0x64,%ebx
 773:	90                   	nop    
 774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 778:	0f 84 4a 01 00 00    	je     8c8 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 77e:	83 fb 78             	cmp    $0x78,%ebx
 781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 788:	0f 84 c2 00 00 00    	je     850 <printf+0x130>
 78e:	83 fb 70             	cmp    $0x70,%ebx
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 798:	0f 84 b2 00 00 00    	je     850 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 79e:	83 fb 73             	cmp    $0x73,%ebx
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7a8:	0f 84 ca 00 00 00    	je     878 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ae:	83 fb 63             	cmp    $0x63,%ebx
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7b8:	0f 84 5a 01 00 00    	je     918 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7be:	83 fb 25             	cmp    $0x25,%ebx
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7c8:	0f 84 22 01 00 00    	je     8f0 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ce:	8b 55 08             	mov    0x8(%ebp),%edx
 7d1:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7d4:	31 f6                	xor    %esi,%esi
 7d6:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7e1:	00 
 7e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e6:	89 14 24             	mov    %edx,(%esp)
 7e9:	e8 fa fd ff ff       	call   5e8 <write>
 7ee:	8b 45 08             	mov    0x8(%ebp),%eax
 7f1:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7f4:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7f7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7fe:	00 
 7ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 803:	89 04 24             	mov    %eax,(%esp)
 806:	e8 dd fd ff ff       	call   5e8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 80b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
 80f:	83 c7 01             	add    $0x1,%edi
 812:	84 c0                	test   %al,%al
 814:	0f 85 4a ff ff ff    	jne    764 <printf+0x44>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 820:	83 c4 2c             	add    $0x2c,%esp
 823:	5b                   	pop    %ebx
 824:	5e                   	pop    %esi
 825:	5f                   	pop    %edi
 826:	5d                   	pop    %ebp
 827:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 828:	8b 55 08             	mov    0x8(%ebp),%edx
 82b:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 82e:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 831:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 838:	00 
 839:	89 44 24 04          	mov    %eax,0x4(%esp)
 83d:	89 14 24             	mov    %edx,(%esp)
 840:	e8 a3 fd ff ff       	call   5e8 <write>
 845:	e9 0b ff ff ff       	jmp    755 <printf+0x35>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 850:	8b 45 e0             	mov    -0x20(%ebp),%eax
 853:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 858:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 85a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 861:	8b 10                	mov    (%eax),%edx
 863:	8b 45 08             	mov    0x8(%ebp),%eax
 866:	e8 15 fe ff ff       	call   680 <printint>
        ap++;
 86b:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 86f:	e9 e1 fe ff ff       	jmp    755 <printf+0x35>
 874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 878:	8b 55 e0             	mov    -0x20(%ebp),%edx
 87b:	8b 1a                	mov    (%edx),%ebx
        ap++;
 87d:	83 c2 04             	add    $0x4,%edx
 880:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
 883:	85 db                	test   %ebx,%ebx
 885:	0f 84 ba 00 00 00    	je     945 <printf+0x225>
          s = "(null)";
        while(*s != 0){
 88b:	0f b6 03             	movzbl (%ebx),%eax
 88e:	84 c0                	test   %al,%al
 890:	74 2d                	je     8bf <printf+0x19f>
 892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 898:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 89b:	8b 45 08             	mov    0x8(%ebp),%eax
 89e:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 8a1:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8ab:	00 
 8ac:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 8b0:	89 04 24             	mov    %eax,(%esp)
 8b3:	e8 30 fd ff ff       	call   5e8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8b8:	0f b6 03             	movzbl (%ebx),%eax
 8bb:	84 c0                	test   %al,%al
 8bd:	75 d9                	jne    898 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8bf:	31 f6                	xor    %esi,%esi
 8c1:	e9 8f fe ff ff       	jmp    755 <printf+0x35>
 8c6:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 8c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 8cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 8d0:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 8d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	8b 45 08             	mov    0x8(%ebp),%eax
 8df:	e8 9c fd ff ff       	call   680 <printint>
        ap++;
 8e4:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 8e8:	e9 68 fe ff ff       	jmp    755 <printf+0x35>
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8f3:	8d 55 f3             	lea    -0xd(%ebp),%edx
 8f6:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 8f8:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 903:	00 
 904:	89 54 24 04          	mov    %edx,0x4(%esp)
 908:	89 0c 24             	mov    %ecx,(%esp)
 90b:	e8 d8 fc ff ff       	call   5e8 <write>
 910:	e9 40 fe ff ff       	jmp    755 <printf+0x35>
 915:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 918:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 91b:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 91e:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 920:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 922:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 929:	00 
 92a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 92e:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 931:	8b 45 08             	mov    0x8(%ebp),%eax
 934:	89 04 24             	mov    %eax,(%esp)
 937:	e8 ac fc ff ff       	call   5e8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 93c:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
 940:	e9 10 fe ff ff       	jmp    755 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 945:	bb 2e 0b 00 00       	mov    $0xb2e,%ebx
 94a:	e9 3c ff ff ff       	jmp    88b <printf+0x16b>
 94f:	90                   	nop    

00000950 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 950:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	8b 0d 60 0b 00 00    	mov    0xb60,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
 957:	89 e5                	mov    %esp,%ebp
 959:	57                   	push   %edi
 95a:	56                   	push   %esi
 95b:	53                   	push   %ebx
 95c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
 95f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 962:	39 d9                	cmp    %ebx,%ecx
 964:	73 24                	jae    98a <free+0x3a>
 966:	66 90                	xchg   %ax,%ax
 968:	8b 11                	mov    (%ecx),%edx
 96a:	39 d3                	cmp    %edx,%ebx
 96c:	72 2a                	jb     998 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96e:	39 d1                	cmp    %edx,%ecx
 970:	72 10                	jb     982 <free+0x32>
 972:	39 d9                	cmp    %ebx,%ecx
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 978:	72 1e                	jb     998 <free+0x48>
 97a:	39 d3                	cmp    %edx,%ebx
 97c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 980:	72 16                	jb     998 <free+0x48>
 982:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 984:	39 d9                	cmp    %ebx,%ecx
 986:	66 90                	xchg   %ax,%ax
 988:	72 de                	jb     968 <free+0x18>
 98a:	8b 11                	mov    (%ecx),%edx
 98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 990:	eb dc                	jmp    96e <free+0x1e>
 992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 998:	8b 73 04             	mov    0x4(%ebx),%esi
 99b:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
 99e:	39 d0                	cmp    %edx,%eax
 9a0:	74 1a                	je     9bc <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9a2:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
 9a5:	8b 51 04             	mov    0x4(%ecx),%edx
 9a8:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 9ab:	39 d8                	cmp    %ebx,%eax
 9ad:	74 22                	je     9d1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9af:	89 19                	mov    %ebx,(%ecx)
  freep = p;
 9b1:	89 0d 60 0b 00 00    	mov    %ecx,0xb60
}
 9b7:	5b                   	pop    %ebx
 9b8:	5e                   	pop    %esi
 9b9:	5f                   	pop    %edi
 9ba:	5d                   	pop    %ebp
 9bb:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9bc:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 9bf:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9c1:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9c4:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9c7:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9ca:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
 9cd:	39 d8                	cmp    %ebx,%eax
 9cf:	75 de                	jne    9af <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9d1:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9d4:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
 9d7:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9d9:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 9dc:	89 0d 60 0b 00 00    	mov    %ecx,0xb60
}
 9e2:	5b                   	pop    %ebx
 9e3:	5e                   	pop    %esi
 9e4:	5f                   	pop    %edi
 9e5:	5d                   	pop    %ebp
 9e6:	c3                   	ret    
 9e7:	89 f6                	mov    %esi,%esi
 9e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	57                   	push   %edi
 9f4:	56                   	push   %esi
 9f5:	53                   	push   %ebx
 9f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9fc:	8b 35 60 0b 00 00    	mov    0xb60,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a02:	83 c0 07             	add    $0x7,%eax
 a05:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
 a08:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
 a0d:	0f 84 95 00 00 00    	je     aa8 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a13:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
 a15:	8b 41 04             	mov    0x4(%ecx),%eax
 a18:	39 c3                	cmp    %eax,%ebx
 a1a:	0f 86 b0 00 00 00    	jbe    ad0 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 a20:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a27:	90                   	nop    
    }
    if(p == freep)
 a28:	3b 0d 60 0b 00 00    	cmp    0xb60,%ecx
 a2e:	89 ca                	mov    %ecx,%edx
 a30:	74 34                	je     a66 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a32:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
 a34:	8b 41 04             	mov    0x4(%ecx),%eax
 a37:	39 c3                	cmp    %eax,%ebx
 a39:	77 ed                	ja     a28 <malloc+0x38>
 a3b:	89 d6                	mov    %edx,%esi
 a3d:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
 a3f:	39 c3                	cmp    %eax,%ebx
 a41:	74 1d                	je     a60 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a43:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
 a45:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a48:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
 a4b:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
 a4e:	89 35 60 0b 00 00    	mov    %esi,0xb60
      return (void*) (p + 1);
 a54:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a57:	83 c4 0c             	add    $0xc,%esp
 a5a:	5b                   	pop    %ebx
 a5b:	5e                   	pop    %esi
 a5c:	5f                   	pop    %edi
 a5d:	5d                   	pop    %ebp
 a5e:	c3                   	ret    
 a5f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a60:	8b 01                	mov    (%ecx),%eax
 a62:	89 06                	mov    %eax,(%esi)
 a64:	eb e8                	jmp    a4e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 a66:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 a6c:	bf 00 10 00 00       	mov    $0x1000,%edi
 a71:	b8 00 80 00 00       	mov    $0x8000,%eax
 a76:	76 04                	jbe    a7c <malloc+0x8c>
 a78:	89 df                	mov    %ebx,%edi
 a7a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 a7c:	89 04 24             	mov    %eax,(%esp)
 a7f:	e8 cc fb ff ff       	call   650 <sbrk>
  if(p == (char*) -1)
 a84:	83 f8 ff             	cmp    $0xffffffff,%eax
 a87:	74 18                	je     aa1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a89:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 a8c:	83 c0 08             	add    $0x8,%eax
 a8f:	89 04 24             	mov    %eax,(%esp)
 a92:	e8 b9 fe ff ff       	call   950 <free>
  return freep;
 a97:	8b 15 60 0b 00 00    	mov    0xb60,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a9d:	85 d2                	test   %edx,%edx
 a9f:	75 91                	jne    a32 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 aa1:	31 c0                	xor    %eax,%eax
 aa3:	eb b2                	jmp    a57 <malloc+0x67>
 aa5:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 aa8:	c7 05 60 0b 00 00 58 	movl   $0xb58,0xb60
 aaf:	0b 00 00 
    base.s.size = 0;
 ab2:	be 58 0b 00 00       	mov    $0xb58,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 ab7:	c7 05 58 0b 00 00 58 	movl   $0xb58,0xb58
 abe:	0b 00 00 
    base.s.size = 0;
 ac1:	c7 05 5c 0b 00 00 00 	movl   $0x0,0xb5c
 ac8:	00 00 00 
 acb:	e9 43 ff ff ff       	jmp    a13 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ad0:	89 ca                	mov    %ecx,%edx
 ad2:	e9 68 ff ff ff       	jmp    a3f <malloc+0x4f>

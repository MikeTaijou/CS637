
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 04             	sub    $0x4,%esp
       7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       a:	85 db                	test   %ebx,%ebx
       c:	74 05                	je     13 <nulterminate+0x13>
    return 0;
  
  switch(cmd->type){
       e:	83 3b 05             	cmpl   $0x5,(%ebx)
      11:	76 0d                	jbe    20 <nulterminate+0x20>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      13:	89 d8                	mov    %ebx,%eax
      15:	83 c4 04             	add    $0x4,%esp
      18:	5b                   	pop    %ebx
      19:	5d                   	pop    %ebp
      1a:	c3                   	ret    
      1b:	90                   	nop    
      1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
  
  switch(cmd->type){
      20:	8b 03                	mov    (%ebx),%eax
      22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      28:	ff 24 85 f8 13 00 00 	jmp    *0x13f8(,%eax,4)
      2f:	90                   	nop    
    nulterminate(pcmd->right);
    break;
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
      30:	8b 43 04             	mov    0x4(%ebx),%eax
      33:	89 04 24             	mov    %eax,(%esp)
      36:	e8 c5 ff ff ff       	call   0 <nulterminate>
    nulterminate(lcmd->right);
      3b:	8b 43 08             	mov    0x8(%ebx),%eax
      3e:	89 04 24             	mov    %eax,(%esp)
      41:	e8 ba ff ff ff       	call   0 <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      46:	89 d8                	mov    %ebx,%eax
      48:	83 c4 04             	add    $0x4,%esp
      4b:	5b                   	pop    %ebx
      4c:	5d                   	pop    %ebp
      4d:	c3                   	ret    
      4e:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
      50:	8b 43 04             	mov    0x4(%ebx),%eax
      53:	89 04 24             	mov    %eax,(%esp)
      56:	e8 a5 ff ff ff       	call   0 <nulterminate>
    break;
  }
  return cmd;
}
      5b:	89 d8                	mov    %ebx,%eax
      5d:	83 c4 04             	add    $0x4,%esp
      60:	5b                   	pop    %ebx
      61:	5d                   	pop    %ebp
      62:	c3                   	ret    
      63:	90                   	nop    
      64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
      68:	8b 43 04             	mov    0x4(%ebx),%eax
      6b:	89 04 24             	mov    %eax,(%esp)
      6e:	e8 8d ff ff ff       	call   0 <nulterminate>
    *rcmd->efile = 0;
      73:	8b 43 0c             	mov    0xc(%ebx),%eax
      76:	c6 00 00             	movb   $0x0,(%eax)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      79:	89 d8                	mov    %ebx,%eax
      7b:	83 c4 04             	add    $0x4,%esp
      7e:	5b                   	pop    %ebx
      7f:	5d                   	pop    %ebp
      80:	c3                   	ret    
      81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      88:	8b 43 04             	mov    0x4(%ebx),%eax
      8b:	85 c0                	test   %eax,%eax
      8d:	74 84                	je     13 <nulterminate+0x13>
      8f:	89 da                	mov    %ebx,%edx
      91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
      98:	8b 42 2c             	mov    0x2c(%edx),%eax
      9b:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      9e:	8b 42 08             	mov    0x8(%edx),%eax
      a1:	83 c2 04             	add    $0x4,%edx
      a4:	85 c0                	test   %eax,%eax
      a6:	75 f0                	jne    98 <nulterminate+0x98>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      a8:	89 d8                	mov    %ebx,%eax
      aa:	83 c4 04             	add    $0x4,%esp
      ad:	5b                   	pop    %ebx
      ae:	5d                   	pop    %ebp
      af:	c3                   	ret    

000000b0 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	57                   	push   %edi
      b4:	56                   	push   %esi
      b5:	53                   	push   %ebx
      b6:	83 ec 0c             	sub    $0xc,%esp
      b9:	8b 7d 08             	mov    0x8(%ebp),%edi
      bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;
  
  s = *ps;
      bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
      c1:	39 f3                	cmp    %esi,%ebx
      c3:	72 0a                	jb     cf <peek+0x1f>
      c5:	eb 1f                	jmp    e6 <peek+0x36>
      c7:	90                   	nop    
    s++;
      c8:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
      cb:	39 de                	cmp    %ebx,%esi
      cd:	76 17                	jbe    e6 <peek+0x36>
      cf:	0f be 03             	movsbl (%ebx),%eax
      d2:	c7 04 24 f8 14 00 00 	movl   $0x14f8,(%esp)
      d9:	89 44 24 04          	mov    %eax,0x4(%esp)
      dd:	e8 8e 0c 00 00       	call   d70 <strchr>
      e2:	85 c0                	test   %eax,%eax
      e4:	75 e2                	jne    c8 <peek+0x18>
    s++;
  *ps = s;
      e6:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
      e8:	0f b6 03             	movzbl (%ebx),%eax
      eb:	31 d2                	xor    %edx,%edx
      ed:	84 c0                	test   %al,%al
      ef:	75 0f                	jne    100 <peek+0x50>
}
      f1:	83 c4 0c             	add    $0xc,%esp
      f4:	89 d0                	mov    %edx,%eax
      f6:	5b                   	pop    %ebx
      f7:	5e                   	pop    %esi
      f8:	5f                   	pop    %edi
      f9:	5d                   	pop    %ebp
      fa:	c3                   	ret    
      fb:	90                   	nop    
      fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     100:	0f be c0             	movsbl %al,%eax
     103:	89 44 24 04          	mov    %eax,0x4(%esp)
     107:	8b 45 10             	mov    0x10(%ebp),%eax
     10a:	89 04 24             	mov    %eax,(%esp)
     10d:	e8 5e 0c 00 00       	call   d70 <strchr>
     112:	31 d2                	xor    %edx,%edx
     114:	85 c0                	test   %eax,%eax
     116:	0f 95 c2             	setne  %dl
}
     119:	83 c4 0c             	add    $0xc,%esp
     11c:	89 d0                	mov    %edx,%eax
     11e:	5b                   	pop    %ebx
     11f:	5e                   	pop    %esi
     120:	5f                   	pop    %edi
     121:	5d                   	pop    %ebp
     122:	c3                   	ret    
     123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	57                   	push   %edi
     134:	56                   	push   %esi
     135:	53                   	push   %ebx
     136:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;
  
  s = *ps;
     139:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     13c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *s;
  int ret;
  
  s = *ps;
     13f:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     141:	39 fe                	cmp    %edi,%esi
     143:	72 0a                	jb     14f <gettoken+0x1f>
     145:	eb 1f                	jmp    166 <gettoken+0x36>
     147:	90                   	nop    
    s++;
     148:	83 c6 01             	add    $0x1,%esi
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     14b:	39 f7                	cmp    %esi,%edi
     14d:	76 17                	jbe    166 <gettoken+0x36>
     14f:	0f be 06             	movsbl (%esi),%eax
     152:	c7 04 24 f8 14 00 00 	movl   $0x14f8,(%esp)
     159:	89 44 24 04          	mov    %eax,0x4(%esp)
     15d:	e8 0e 0c 00 00       	call   d70 <strchr>
     162:	85 c0                	test   %eax,%eax
     164:	75 e2                	jne    148 <gettoken+0x18>
    s++;
  if(q)
     166:	8b 4d 10             	mov    0x10(%ebp),%ecx
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     169:	89 f3                	mov    %esi,%ebx
    s++;
  if(q)
     16b:	85 c9                	test   %ecx,%ecx
     16d:	74 05                	je     174 <gettoken+0x44>
    *q = s;
     16f:	8b 55 10             	mov    0x10(%ebp),%edx
     172:	89 32                	mov    %esi,(%edx)
  ret = *s;
     174:	0f b6 06             	movzbl (%esi),%eax
     177:	0f be d0             	movsbl %al,%edx
  switch(*s){
     17a:	3c 3c                	cmp    $0x3c,%al
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
     17c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  switch(*s){
     17f:	7f 4f                	jg     1d0 <gettoken+0xa0>
     181:	3c 3b                	cmp    $0x3b,%al
     183:	0f 8c af 00 00 00    	jl     238 <gettoken+0x108>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     189:	8d 5e 01             	lea    0x1(%esi),%ebx
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     18c:	8b 55 14             	mov    0x14(%ebp),%edx
     18f:	85 d2                	test   %edx,%edx
     191:	74 05                	je     198 <gettoken+0x68>
    *eq = s;
     193:	8b 45 14             	mov    0x14(%ebp),%eax
     196:	89 18                	mov    %ebx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     198:	39 fb                	cmp    %edi,%ebx
     19a:	72 0b                	jb     1a7 <gettoken+0x77>
     19c:	eb 20                	jmp    1be <gettoken+0x8e>
     19e:	66 90                	xchg   %ax,%ax
    s++;
     1a0:	83 c3 01             	add    $0x1,%ebx
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     1a3:	39 df                	cmp    %ebx,%edi
     1a5:	76 17                	jbe    1be <gettoken+0x8e>
     1a7:	0f be 03             	movsbl (%ebx),%eax
     1aa:	c7 04 24 f8 14 00 00 	movl   $0x14f8,(%esp)
     1b1:	89 44 24 04          	mov    %eax,0x4(%esp)
     1b5:	e8 b6 0b 00 00       	call   d70 <strchr>
     1ba:	85 c0                	test   %eax,%eax
     1bc:	75 e2                	jne    1a0 <gettoken+0x70>
    s++;
  *ps = s;
     1be:	8b 55 08             	mov    0x8(%ebp),%edx
  return ret;
}
     1c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
     1c4:	89 1a                	mov    %ebx,(%edx)
  return ret;
}
     1c6:	83 c4 0c             	add    $0xc,%esp
     1c9:	5b                   	pop    %ebx
     1ca:	5e                   	pop    %esi
     1cb:	5f                   	pop    %edi
     1cc:	5d                   	pop    %ebp
     1cd:	c3                   	ret    
     1ce:	66 90                	xchg   %ax,%ax
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     1d0:	3c 3e                	cmp    $0x3e,%al
     1d2:	0f 84 90 00 00 00    	je     268 <gettoken+0x138>
     1d8:	3c 7c                	cmp    $0x7c,%al
     1da:	74 ad                	je     189 <gettoken+0x59>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     1dc:	39 f7                	cmp    %esi,%edi
     1de:	66 90                	xchg   %ax,%ax
     1e0:	77 2f                	ja     211 <gettoken+0xe1>
     1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1e8:	eb 3b                	jmp    225 <gettoken+0xf5>
     1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1f0:	0f be 03             	movsbl (%ebx),%eax
     1f3:	c7 04 24 fe 14 00 00 	movl   $0x14fe,(%esp)
     1fa:	89 44 24 04          	mov    %eax,0x4(%esp)
     1fe:	e8 6d 0b 00 00       	call   d70 <strchr>
     203:	85 c0                	test   %eax,%eax
     205:	75 1e                	jne    225 <gettoken+0xf5>
      s++;
     207:	83 c3 01             	add    $0x1,%ebx
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     20a:	39 df                	cmp    %ebx,%edi
     20c:	76 17                	jbe    225 <gettoken+0xf5>
     20e:	0f be 13             	movsbl (%ebx),%edx
     211:	89 54 24 04          	mov    %edx,0x4(%esp)
     215:	c7 04 24 f8 14 00 00 	movl   $0x14f8,(%esp)
     21c:	e8 4f 0b 00 00       	call   d70 <strchr>
     221:	85 c0                	test   %eax,%eax
     223:	74 cb                	je     1f0 <gettoken+0xc0>
     225:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
     22c:	e9 5b ff ff ff       	jmp    18c <gettoken+0x5c>
     231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     238:	3c 29                	cmp    $0x29,%al
     23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     240:	7f 9a                	jg     1dc <gettoken+0xac>
     242:	3c 28                	cmp    $0x28,%al
     244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     248:	0f 8d 3b ff ff ff    	jge    189 <gettoken+0x59>
     24e:	84 c0                	test   %al,%al
     250:	0f 84 36 ff ff ff    	je     18c <gettoken+0x5c>
     256:	3c 26                	cmp    $0x26,%al
     258:	75 82                	jne    1dc <gettoken+0xac>
     25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     260:	e9 24 ff ff ff       	jmp    189 <gettoken+0x59>
     265:	8d 76 00             	lea    0x0(%esi),%esi
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
     268:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     26c:	8d 5e 01             	lea    0x1(%esi),%ebx
     26f:	90                   	nop    
    if(*s == '>'){
     270:	0f 85 16 ff ff ff    	jne    18c <gettoken+0x5c>
      ret = '+';
      s++;
     276:	8d 5e 02             	lea    0x2(%esi),%ebx
     279:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
     280:	e9 07 ff ff ff       	jmp    18c <gettoken+0x5c>
     285:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <backcmd>:
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	53                   	push   %ebx
     294:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     297:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     29e:	e8 6d 10 00 00       	call   1310 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2a3:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     2aa:	00 
     2ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2b2:	00 
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2b5:	89 04 24             	mov    %eax,(%esp)
     2b8:	e8 83 0a 00 00       	call   d40 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     2c0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     2c6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     2c9:	89 d8                	mov    %ebx,%eax
     2cb:	83 c4 14             	add    $0x14,%esp
     2ce:	5b                   	pop    %ebx
     2cf:	5d                   	pop    %ebp
     2d0:	c3                   	ret    
     2d1:	eb 0d                	jmp    2e0 <listcmd>
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

000002e0 <listcmd>:
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     2e0:	55                   	push   %ebp
     2e1:	89 e5                	mov    %esp,%ebp
     2e3:	53                   	push   %ebx
     2e4:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2e7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     2ee:	e8 1d 10 00 00       	call   1310 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2f3:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     2fa:	00 
     2fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     302:	00 
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     303:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     305:	89 04 24             	mov    %eax,(%esp)
     308:	e8 33 0a 00 00       	call   d40 <memset>
  cmd->type = LIST;
  cmd->left = left;
     30d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     310:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     316:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     319:	8b 45 0c             	mov    0xc(%ebp),%eax
     31c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     31f:	89 d8                	mov    %ebx,%eax
     321:	83 c4 14             	add    $0x14,%esp
     324:	5b                   	pop    %ebx
     325:	5d                   	pop    %ebp
     326:	c3                   	ret    
     327:	89 f6                	mov    %esi,%esi
     329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <pipecmd>:
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	53                   	push   %ebx
     334:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     337:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     33e:	e8 cd 0f 00 00       	call   1310 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     343:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     34a:	00 
     34b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     352:	00 
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     353:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     355:	89 04 24             	mov    %eax,(%esp)
     358:	e8 e3 09 00 00       	call   d40 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     35d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     360:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     366:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     369:	8b 45 0c             	mov    0xc(%ebp),%eax
     36c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     36f:	89 d8                	mov    %ebx,%eax
     371:	83 c4 14             	add    $0x14,%esp
     374:	5b                   	pop    %ebx
     375:	5d                   	pop    %ebp
     376:	c3                   	ret    
     377:	89 f6                	mov    %esi,%esi
     379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <redircmd>:
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	53                   	push   %ebx
     384:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     387:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     38e:	e8 7d 0f 00 00       	call   1310 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     393:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     39a:	00 
     39b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3a2:	00 
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3a5:	89 04 24             	mov    %eax,(%esp)
     3a8:	e8 93 09 00 00       	call   d40 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3ad:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     3b0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3b6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bc:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3bf:	8b 45 10             	mov    0x10(%ebp),%eax
     3c2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3c5:	8b 45 14             	mov    0x14(%ebp),%eax
     3c8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3cb:	8b 45 18             	mov    0x18(%ebp),%eax
     3ce:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3d1:	89 d8                	mov    %ebx,%eax
     3d3:	83 c4 14             	add    $0x14,%esp
     3d6:	5b                   	pop    %ebx
     3d7:	5d                   	pop    %ebp
     3d8:	c3                   	ret    
     3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003e0 <execcmd>:

// Constructors

struct cmd*
execcmd(void)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	53                   	push   %ebx
     3e4:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3ee:	e8 1d 0f 00 00       	call   1310 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3f3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3fa:	00 
     3fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     402:	00 
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     403:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     405:	89 04 24             	mov    %eax,(%esp)
     408:	e8 33 09 00 00       	call   d40 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     40d:	89 d8                	mov    %ebx,%eax
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
     40f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     415:	83 c4 14             	add    $0x14,%esp
     418:	5b                   	pop    %ebx
     419:	5d                   	pop    %ebp
     41a:	c3                   	ret    
     41b:	90                   	nop    
     41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <panic>:
  exit();
}

void
panic(char *s)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     426:	8b 45 08             	mov    0x8(%ebp),%eax
     429:	c7 44 24 04 91 14 00 	movl   $0x1491,0x4(%esp)
     430:	00 
     431:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     438:	89 44 24 08          	mov    %eax,0x8(%esp)
     43c:	e8 ff 0b 00 00       	call   1040 <printf>
  exit();
     441:	e8 a2 0a 00 00       	call   ee8 <exit>
     446:	8d 76 00             	lea    0x0(%esi),%esi
     449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	57                   	push   %edi
     454:	56                   	push   %esi
     455:	53                   	push   %ebx
     456:	83 ec 2c             	sub    $0x2c,%esp
     459:	8b 75 08             	mov    0x8(%ebp),%esi
     45c:	8b 7d 10             	mov    0x10(%ebp),%edi
     45f:	90                   	nop    
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     460:	8b 45 0c             	mov    0xc(%ebp),%eax
     463:	c7 44 24 08 45 14 00 	movl   $0x1445,0x8(%esp)
     46a:	00 
     46b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     46f:	89 04 24             	mov    %eax,(%esp)
     472:	e8 39 fc ff ff       	call   b0 <peek>
     477:	85 c0                	test   %eax,%eax
     479:	0f 84 b1 00 00 00    	je     530 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     47f:	8b 45 0c             	mov    0xc(%ebp),%eax
     482:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     489:	00 
     48a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     491:	00 
     492:	89 7c 24 04          	mov    %edi,0x4(%esp)
     496:	89 04 24             	mov    %eax,(%esp)
     499:	e8 92 fc ff ff       	call   130 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     49e:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
     4a2:	89 c3                	mov    %eax,%ebx
    if(gettoken(ps, es, &q, &eq) != 'a')
     4a4:	8d 45 ec             	lea    -0x14(%ebp),%eax
     4a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
     4ab:	8d 45 f0             	lea    -0x10(%ebp),%eax
     4ae:	89 44 24 08          	mov    %eax,0x8(%esp)
     4b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b5:	89 04 24             	mov    %eax,(%esp)
     4b8:	e8 73 fc ff ff       	call   130 <gettoken>
     4bd:	83 f8 61             	cmp    $0x61,%eax
     4c0:	74 0c                	je     4ce <parseredirs+0x7e>
      panic("missing file for redirection");
     4c2:	c7 04 24 28 14 00 00 	movl   $0x1428,(%esp)
     4c9:	e8 52 ff ff ff       	call   420 <panic>
    switch(tok){
     4ce:	83 fb 3c             	cmp    $0x3c,%ebx
     4d1:	74 45                	je     518 <parseredirs+0xc8>
     4d3:	83 fb 3e             	cmp    $0x3e,%ebx
     4d6:	74 0e                	je     4e6 <parseredirs+0x96>
     4d8:	83 fb 2b             	cmp    $0x2b,%ebx
     4db:	90                   	nop    
     4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4e0:	0f 85 7a ff ff ff    	jne    460 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     4e6:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     4ed:	00 
     4ee:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     4f5:	00 
     4f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4f9:	89 34 24             	mov    %esi,(%esp)
     4fc:	89 44 24 08          	mov    %eax,0x8(%esp)
     500:	8b 45 f0             	mov    -0x10(%ebp),%eax
     503:	89 44 24 04          	mov    %eax,0x4(%esp)
     507:	e8 74 fe ff ff       	call   380 <redircmd>
     50c:	89 c6                	mov    %eax,%esi
     50e:	e9 4d ff ff ff       	jmp    460 <parseredirs+0x10>
     513:	90                   	nop    
     514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     518:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     51f:	00 
     520:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     527:	00 
     528:	eb cc                	jmp    4f6 <parseredirs+0xa6>
     52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     530:	83 c4 2c             	add    $0x2c,%esp
     533:	89 f0                	mov    %esi,%eax
     535:	5b                   	pop    %ebx
     536:	5e                   	pop    %esi
     537:	5f                   	pop    %edi
     538:	5d                   	pop    %ebp
     539:	c3                   	ret    
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000540 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	57                   	push   %edi
     544:	56                   	push   %esi
     545:	53                   	push   %ebx
     546:	83 ec 2c             	sub    $0x2c,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     549:	c7 44 24 08 48 14 00 	movl   $0x1448,0x8(%esp)
     550:	00 
     551:	8b 45 0c             	mov    0xc(%ebp),%eax
     554:	89 44 24 04          	mov    %eax,0x4(%esp)
     558:	8b 45 08             	mov    0x8(%ebp),%eax
     55b:	89 04 24             	mov    %eax,(%esp)
     55e:	e8 4d fb ff ff       	call   b0 <peek>
     563:	85 c0                	test   %eax,%eax
     565:	0f 85 dd 00 00 00    	jne    648 <parseexec+0x108>
    return parseblock(ps, es);

  ret = execcmd();
     56b:	e8 70 fe ff ff       	call   3e0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     570:	31 db                	xor    %ebx,%ebx
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     572:	89 c7                	mov    %eax,%edi
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     574:	8b 45 0c             	mov    0xc(%ebp),%eax
     577:	89 44 24 08          	mov    %eax,0x8(%esp)
     57b:	8b 45 08             	mov    0x8(%ebp),%eax
     57e:	89 3c 24             	mov    %edi,(%esp)
     581:	89 44 24 04          	mov    %eax,0x4(%esp)
     585:	e8 c6 fe ff ff       	call   450 <parseredirs>
     58a:	89 c6                	mov    %eax,%esi
     58c:	eb 1a                	jmp    5a8 <parseexec+0x68>
     58e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     590:	8b 45 0c             	mov    0xc(%ebp),%eax
     593:	89 44 24 08          	mov    %eax,0x8(%esp)
     597:	8b 45 08             	mov    0x8(%ebp),%eax
     59a:	89 34 24             	mov    %esi,(%esp)
     59d:	89 44 24 04          	mov    %eax,0x4(%esp)
     5a1:	e8 aa fe ff ff       	call   450 <parseredirs>
     5a6:	89 c6                	mov    %eax,%esi
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     5a8:	c7 44 24 08 5f 14 00 	movl   $0x145f,0x8(%esp)
     5af:	00 
     5b0:	8b 45 0c             	mov    0xc(%ebp),%eax
     5b3:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b7:	8b 45 08             	mov    0x8(%ebp),%eax
     5ba:	89 04 24             	mov    %eax,(%esp)
     5bd:	e8 ee fa ff ff       	call   b0 <peek>
     5c2:	85 c0                	test   %eax,%eax
     5c4:	75 62                	jne    628 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     5c6:	8d 45 ec             	lea    -0x14(%ebp),%eax
     5c9:	89 44 24 0c          	mov    %eax,0xc(%esp)
     5cd:	8d 45 f0             	lea    -0x10(%ebp),%eax
     5d0:	89 44 24 08          	mov    %eax,0x8(%esp)
     5d4:	8b 45 0c             	mov    0xc(%ebp),%eax
     5d7:	89 44 24 04          	mov    %eax,0x4(%esp)
     5db:	8b 45 08             	mov    0x8(%ebp),%eax
     5de:	89 04 24             	mov    %eax,(%esp)
     5e1:	e8 4a fb ff ff       	call   130 <gettoken>
     5e6:	85 c0                	test   %eax,%eax
     5e8:	74 3e                	je     628 <parseexec+0xe8>
      break;
    if(tok != 'a')
     5ea:	83 f8 61             	cmp    $0x61,%eax
     5ed:	74 0c                	je     5fb <parseexec+0xbb>
      panic("syntax");
     5ef:	c7 04 24 4a 14 00 00 	movl   $0x144a,(%esp)
     5f6:	e8 25 fe ff ff       	call   420 <panic>
    cmd->argv[argc] = q;
     5fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5fe:	89 44 9f 04          	mov    %eax,0x4(%edi,%ebx,4)
    cmd->eargv[argc] = eq;
     602:	8b 45 ec             	mov    -0x14(%ebp),%eax
     605:	89 44 9f 2c          	mov    %eax,0x2c(%edi,%ebx,4)
    argc++;
     609:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     60c:	83 fb 09             	cmp    $0x9,%ebx
     60f:	0f 8e 7b ff ff ff    	jle    590 <parseexec+0x50>
      panic("too many args");
     615:	c7 04 24 51 14 00 00 	movl   $0x1451,(%esp)
     61c:	e8 ff fd ff ff       	call   420 <panic>
     621:	e9 6a ff ff ff       	jmp    590 <parseexec+0x50>
     626:	66 90                	xchg   %ax,%ax
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     628:	c7 44 9f 04 00 00 00 	movl   $0x0,0x4(%edi,%ebx,4)
     62f:	00 
  cmd->eargv[argc] = 0;
  return ret;
}
     630:	89 f0                	mov    %esi,%eax
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
     632:	c7 44 9f 2c 00 00 00 	movl   $0x0,0x2c(%edi,%ebx,4)
     639:	00 
  return ret;
}
     63a:	83 c4 2c             	add    $0x2c,%esp
     63d:	5b                   	pop    %ebx
     63e:	5e                   	pop    %esi
     63f:	5f                   	pop    %edi
     640:	5d                   	pop    %ebp
     641:	c3                   	ret    
     642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);
     648:	8b 45 0c             	mov    0xc(%ebp),%eax
     64b:	89 44 24 04          	mov    %eax,0x4(%esp)
     64f:	8b 45 08             	mov    0x8(%ebp),%eax
     652:	89 04 24             	mov    %eax,(%esp)
     655:	e8 66 01 00 00       	call   7c0 <parseblock>
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     65a:	83 c4 2c             	add    $0x2c,%esp
     65d:	5b                   	pop    %ebx
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);
     65e:	89 c6                	mov    %eax,%esi
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     660:	89 f0                	mov    %esi,%eax
     662:	5e                   	pop    %esi
     663:	5f                   	pop    %edi
     664:	5d                   	pop    %ebp
     665:	c3                   	ret    
     666:	8d 76 00             	lea    0x0(%esi),%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	83 ec 28             	sub    $0x28,%esp
     676:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     679:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     67c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     67f:	8b 75 08             	mov    0x8(%ebp),%esi
     682:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     685:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     689:	89 34 24             	mov    %esi,(%esp)
     68c:	e8 af fe ff ff       	call   540 <parseexec>
  if(peek(ps, es, "|")){
     691:	c7 44 24 08 64 14 00 	movl   $0x1464,0x8(%esp)
     698:	00 
     699:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     69d:	89 34 24             	mov    %esi,(%esp)
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     6a0:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     6a2:	e8 09 fa ff ff       	call   b0 <peek>
     6a7:	85 c0                	test   %eax,%eax
     6a9:	75 15                	jne    6c0 <parsepipe+0x50>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     6ab:	89 f8                	mov    %edi,%eax
     6ad:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     6b0:	8b 75 f8             	mov    -0x8(%ebp),%esi
     6b3:	8b 7d fc             	mov    -0x4(%ebp),%edi
     6b6:	89 ec                	mov    %ebp,%esp
     6b8:	5d                   	pop    %ebp
     6b9:	c3                   	ret    
     6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     6c0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6c4:	89 34 24             	mov    %esi,(%esp)
     6c7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6ce:	00 
     6cf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     6d6:	00 
     6d7:	e8 54 fa ff ff       	call   130 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6dc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6e0:	89 34 24             	mov    %esi,(%esp)
     6e3:	e8 88 ff ff ff       	call   670 <parsepipe>
  }
  return cmd;
}
     6e8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6eb:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
     6ee:	8b 75 f8             	mov    -0x8(%ebp),%esi
     6f1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6f4:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     6f7:	89 ec                	mov    %ebp,%esp
     6f9:	5d                   	pop    %ebp
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6fa:	e9 31 fc ff ff       	jmp    330 <pipecmd>
     6ff:	90                   	nop    

00000700 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 1c             	sub    $0x1c,%esp
     709:	8b 75 08             	mov    0x8(%ebp),%esi
     70c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     70f:	89 34 24             	mov    %esi,(%esp)
     712:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     716:	e8 55 ff ff ff       	call   670 <parsepipe>
     71b:	89 c7                	mov    %eax,%edi
     71d:	eb 27                	jmp    746 <parseline+0x46>
     71f:	90                   	nop    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
     720:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     727:	00 
     728:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     72f:	00 
     730:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     734:	89 34 24             	mov    %esi,(%esp)
     737:	e8 f4 f9 ff ff       	call   130 <gettoken>
    cmd = backcmd(cmd);
     73c:	89 3c 24             	mov    %edi,(%esp)
     73f:	e8 4c fb ff ff       	call   290 <backcmd>
     744:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     746:	c7 44 24 08 66 14 00 	movl   $0x1466,0x8(%esp)
     74d:	00 
     74e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     752:	89 34 24             	mov    %esi,(%esp)
     755:	e8 56 f9 ff ff       	call   b0 <peek>
     75a:	85 c0                	test   %eax,%eax
     75c:	75 c2                	jne    720 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     75e:	c7 44 24 08 62 14 00 	movl   $0x1462,0x8(%esp)
     765:	00 
     766:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     76a:	89 34 24             	mov    %esi,(%esp)
     76d:	e8 3e f9 ff ff       	call   b0 <peek>
     772:	85 c0                	test   %eax,%eax
     774:	75 0a                	jne    780 <parseline+0x80>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     776:	83 c4 1c             	add    $0x1c,%esp
     779:	89 f8                	mov    %edi,%eax
     77b:	5b                   	pop    %ebx
     77c:	5e                   	pop    %esi
     77d:	5f                   	pop    %edi
     77e:	5d                   	pop    %ebp
     77f:	c3                   	ret    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     780:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     784:	89 34 24             	mov    %esi,(%esp)
     787:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     78e:	00 
     78f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     796:	00 
     797:	e8 94 f9 ff ff       	call   130 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     79c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     7a0:	89 34 24             	mov    %esi,(%esp)
     7a3:	e8 58 ff ff ff       	call   700 <parseline>
     7a8:	89 7d 08             	mov    %edi,0x8(%ebp)
     7ab:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     7ae:	83 c4 1c             	add    $0x1c,%esp
     7b1:	5b                   	pop    %ebx
     7b2:	5e                   	pop    %esi
     7b3:	5f                   	pop    %edi
     7b4:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     7b5:	e9 26 fb ff ff       	jmp    2e0 <listcmd>
     7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007c0 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	83 ec 28             	sub    $0x28,%esp
     7c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     7c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     7cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
     7cf:	8b 75 08             	mov    0x8(%ebp),%esi
     7d2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     7d5:	c7 44 24 08 48 14 00 	movl   $0x1448,0x8(%esp)
     7dc:	00 
     7dd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     7e1:	89 34 24             	mov    %esi,(%esp)
     7e4:	e8 c7 f8 ff ff       	call   b0 <peek>
     7e9:	85 c0                	test   %eax,%eax
     7eb:	0f 84 87 00 00 00    	je     878 <parseblock+0xb8>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     7f1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     7f8:	00 
     7f9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     800:	00 
     801:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     805:	89 34 24             	mov    %esi,(%esp)
     808:	e8 23 f9 ff ff       	call   130 <gettoken>
  cmd = parseline(ps, es);
     80d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     811:	89 34 24             	mov    %esi,(%esp)
     814:	e8 e7 fe ff ff       	call   700 <parseline>
  if(!peek(ps, es, ")"))
     819:	c7 44 24 08 84 14 00 	movl   $0x1484,0x8(%esp)
     820:	00 
     821:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     825:	89 34 24             	mov    %esi,(%esp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     828:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     82a:	e8 81 f8 ff ff       	call   b0 <peek>
     82f:	85 c0                	test   %eax,%eax
     831:	75 0c                	jne    83f <parseblock+0x7f>
    panic("syntax - missing )");
     833:	c7 04 24 73 14 00 00 	movl   $0x1473,(%esp)
     83a:	e8 e1 fb ff ff       	call   420 <panic>
  gettoken(ps, es, 0, 0);
     83f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     843:	89 34 24             	mov    %esi,(%esp)
     846:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     84d:	00 
     84e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     855:	00 
     856:	e8 d5 f8 ff ff       	call   130 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     85b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     85f:	89 74 24 04          	mov    %esi,0x4(%esp)
     863:	89 3c 24             	mov    %edi,(%esp)
     866:	e8 e5 fb ff ff       	call   450 <parseredirs>
  return cmd;
}
     86b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     86e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     871:	8b 7d fc             	mov    -0x4(%ebp),%edi
     874:	89 ec                	mov    %ebp,%esp
     876:	5d                   	pop    %ebp
     877:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     878:	c7 04 24 68 14 00 00 	movl   $0x1468,(%esp)
     87f:	e8 9c fb ff ff       	call   420 <panic>
     884:	e9 68 ff ff ff       	jmp    7f1 <parseblock+0x31>
     889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000890 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	56                   	push   %esi
     894:	53                   	push   %ebx
     895:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
     898:	8b 5d 08             	mov    0x8(%ebp),%ebx
     89b:	89 1c 24             	mov    %ebx,(%esp)
     89e:	e8 7d 04 00 00       	call   d20 <strlen>
     8a3:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     8a5:	8d 45 08             	lea    0x8(%ebp),%eax
     8a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     8ac:	89 04 24             	mov    %eax,(%esp)
     8af:	e8 4c fe ff ff       	call   700 <parseline>
  peek(&s, es, "");
     8b4:	c7 44 24 08 b3 14 00 	movl   $0x14b3,0x8(%esp)
     8bb:	00 
     8bc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
  cmd = parseline(&s, es);
     8c0:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     8c2:	8d 45 08             	lea    0x8(%ebp),%eax
     8c5:	89 04 24             	mov    %eax,(%esp)
     8c8:	e8 e3 f7 ff ff       	call   b0 <peek>
  if(s != es){
     8cd:	8b 45 08             	mov    0x8(%ebp),%eax
     8d0:	39 d8                	cmp    %ebx,%eax
     8d2:	74 24                	je     8f8 <parsecmd+0x68>
    printf(2, "leftovers: %s\n", s);
     8d4:	89 44 24 08          	mov    %eax,0x8(%esp)
     8d8:	c7 44 24 04 86 14 00 	movl   $0x1486,0x4(%esp)
     8df:	00 
     8e0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     8e7:	e8 54 07 00 00       	call   1040 <printf>
    panic("syntax");
     8ec:	c7 04 24 4a 14 00 00 	movl   $0x144a,(%esp)
     8f3:	e8 28 fb ff ff       	call   420 <panic>
  }
  nulterminate(cmd);
     8f8:	89 34 24             	mov    %esi,(%esp)
     8fb:	e8 00 f7 ff ff       	call   0 <nulterminate>
  return cmd;
}
     900:	83 c4 10             	add    $0x10,%esp
     903:	89 f0                	mov    %esi,%eax
     905:	5b                   	pop    %ebx
     906:	5e                   	pop    %esi
     907:	5d                   	pop    %ebp
     908:	c3                   	ret    
     909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <fork1>:
  exit();
}

int
fork1(void)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	53                   	push   %ebx
     914:	83 ec 04             	sub    $0x4,%esp
  int pid;
  
  pid = fork();
     917:	e8 c4 05 00 00       	call   ee0 <fork>
  if(pid == -1)
     91c:	83 f8 ff             	cmp    $0xffffffff,%eax
int
fork1(void)
{
  int pid;
  
  pid = fork();
     91f:	89 c3                	mov    %eax,%ebx
  if(pid == -1)
     921:	74 0d                	je     930 <fork1+0x20>
    panic("fork");
  return pid;
}
     923:	89 d8                	mov    %ebx,%eax
     925:	83 c4 04             	add    $0x4,%esp
     928:	5b                   	pop    %ebx
     929:	5d                   	pop    %ebp
     92a:	c3                   	ret    
     92b:	90                   	nop    
     92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int pid;
  
  pid = fork();
  if(pid == -1)
    panic("fork");
     930:	c7 04 24 95 14 00 00 	movl   $0x1495,(%esp)
     937:	e8 e4 fa ff ff       	call   420 <panic>
  return pid;
}
     93c:	89 d8                	mov    %ebx,%eax
     93e:	83 c4 04             	add    $0x4,%esp
     941:	5b                   	pop    %ebx
     942:	5d                   	pop    %ebp
     943:	c3                   	ret    
     944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     94a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000950 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	83 ec 18             	sub    $0x18,%esp
     956:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     959:	8b 5d 08             	mov    0x8(%ebp),%ebx
     95c:	89 75 fc             	mov    %esi,-0x4(%ebp)
     95f:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     962:	c7 44 24 04 9a 14 00 	movl   $0x149a,0x4(%esp)
     969:	00 
     96a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     971:	e8 ca 06 00 00       	call   1040 <printf>
  memset(buf, 0, nbuf);
     976:	89 74 24 08          	mov    %esi,0x8(%esp)
     97a:	89 1c 24             	mov    %ebx,(%esp)
     97d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     984:	00 
     985:	e8 b6 03 00 00       	call   d40 <memset>
  gets(buf, nbuf);
     98a:	89 74 24 04          	mov    %esi,0x4(%esp)
     98e:	89 1c 24             	mov    %ebx,(%esp)
     991:	e8 ea 04 00 00       	call   e80 <gets>
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
     996:	8b 75 fc             	mov    -0x4(%ebp),%esi
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
     999:	80 3b 01             	cmpb   $0x1,(%ebx)
    return -1;
  return 0;
}
     99c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
     99f:	19 c0                	sbb    %eax,%eax
    return -1;
  return 0;
}
     9a1:	89 ec                	mov    %ebp,%esp
     9a3:	5d                   	pop    %ebp
     9a4:	c3                   	ret    
     9a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	53                   	push   %ebx
     9b4:	83 ec 24             	sub    $0x24,%esp
     9b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9ba:	85 db                	test   %ebx,%ebx
     9bc:	74 42                	je     a00 <runcmd+0x50>
    exit();
  
  switch(cmd->type){
     9be:	83 3b 05             	cmpl   $0x5,(%ebx)
     9c1:	76 45                	jbe    a08 <runcmd+0x58>
  default:
    panic("runcmd");
     9c3:	c7 04 24 9d 14 00 00 	movl   $0x149d,(%esp)
     9ca:	e8 51 fa ff ff       	call   420 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     9cf:	8b 53 04             	mov    0x4(%ebx),%edx
     9d2:	85 d2                	test   %edx,%edx
     9d4:	74 2a                	je     a00 <runcmd+0x50>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
     9d6:	8d 43 04             	lea    0x4(%ebx),%eax
     9d9:	89 44 24 04          	mov    %eax,0x4(%esp)
     9dd:	89 14 24             	mov    %edx,(%esp)
     9e0:	e8 3b 05 00 00       	call   f20 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     9e5:	8b 43 04             	mov    0x4(%ebx),%eax
     9e8:	c7 44 24 04 a4 14 00 	movl   $0x14a4,0x4(%esp)
     9ef:	00 
     9f0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     9f7:	89 44 24 08          	mov    %eax,0x8(%esp)
     9fb:	e8 40 06 00 00       	call   1040 <printf>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     a00:	e8 e3 04 00 00       	call   ee8 <exit>
     a05:	8d 76 00             	lea    0x0(%esi),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
  
  switch(cmd->type){
     a08:	8b 03                	mov    (%ebx),%eax
     a0a:	ff 24 85 10 14 00 00 	jmp    *0x1410(,%eax,4)
     a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wait();
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     a18:	e8 f3 fe ff ff       	call   910 <fork1>
     a1d:	85 c0                	test   %eax,%eax
     a1f:	90                   	nop    
     a20:	75 de                	jne    a00 <runcmd+0x50>
      runcmd(bcmd->cmd);
     a22:	8b 43 04             	mov    0x4(%ebx),%eax
     a25:	89 04 24             	mov    %eax,(%esp)
     a28:	e8 83 ff ff ff       	call   9b0 <runcmd>
    break;
  }
  exit();
     a2d:	e8 b6 04 00 00       	call   ee8 <exit>
     a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     a38:	e8 d3 fe ff ff       	call   910 <fork1>
     a3d:	85 c0                	test   %eax,%eax
     a3f:	90                   	nop    
     a40:	0f 84 c2 00 00 00    	je     b08 <runcmd+0x158>
     a46:	66 90                	xchg   %ax,%ax
      runcmd(lcmd->left);
    wait();
     a48:	e8 a3 04 00 00       	call   ef0 <wait>
    runcmd(lcmd->right);
     a4d:	8b 43 08             	mov    0x8(%ebx),%eax
     a50:	89 04 24             	mov    %eax,(%esp)
     a53:	e8 58 ff ff ff       	call   9b0 <runcmd>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     a58:	e8 8b 04 00 00       	call   ee8 <exit>
     a5d:	8d 76 00             	lea    0x0(%esi),%esi
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     a60:	8d 45 f4             	lea    -0xc(%ebp),%eax
     a63:	89 04 24             	mov    %eax,(%esp)
     a66:	e8 8d 04 00 00       	call   ef8 <pipe>
     a6b:	85 c0                	test   %eax,%eax
     a6d:	0f 88 25 01 00 00    	js     b98 <runcmd+0x1e8>
      panic("pipe");
    if(fork1() == 0){
     a73:	e8 98 fe ff ff       	call   910 <fork1>
     a78:	85 c0                	test   %eax,%eax
     a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a80:	0f 84 d2 00 00 00    	je     b58 <runcmd+0x1a8>
     a86:	66 90                	xchg   %ax,%ax
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     a88:	e8 83 fe ff ff       	call   910 <fork1>
     a8d:	85 c0                	test   %eax,%eax
     a8f:	90                   	nop    
     a90:	0f 84 82 00 00 00    	je     b18 <runcmd+0x168>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     a96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a99:	89 04 24             	mov    %eax,(%esp)
     a9c:	e8 6f 04 00 00       	call   f10 <close>
    close(p[1]);
     aa1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     aa4:	89 04 24             	mov    %eax,(%esp)
     aa7:	e8 64 04 00 00       	call   f10 <close>
    wait();
     aac:	e8 3f 04 00 00       	call   ef0 <wait>
    wait();
     ab1:	e8 3a 04 00 00       	call   ef0 <wait>
     ab6:	66 90                	xchg   %ax,%ax
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     ab8:	e8 2b 04 00 00       	call   ee8 <exit>
     abd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     ac0:	8b 43 14             	mov    0x14(%ebx),%eax
     ac3:	89 04 24             	mov    %eax,(%esp)
     ac6:	e8 45 04 00 00       	call   f10 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     acb:	8b 43 10             	mov    0x10(%ebx),%eax
     ace:	89 44 24 04          	mov    %eax,0x4(%esp)
     ad2:	8b 43 08             	mov    0x8(%ebx),%eax
     ad5:	89 04 24             	mov    %eax,(%esp)
     ad8:	e8 4b 04 00 00       	call   f28 <open>
     add:	85 c0                	test   %eax,%eax
     adf:	0f 89 3d ff ff ff    	jns    a22 <runcmd+0x72>
      printf(2, "open %s failed\n", rcmd->file);
     ae5:	8b 43 08             	mov    0x8(%ebx),%eax
     ae8:	c7 44 24 04 b4 14 00 	movl   $0x14b4,0x4(%esp)
     aef:	00 
     af0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     af7:	89 44 24 08          	mov    %eax,0x8(%esp)
     afb:	e8 40 05 00 00       	call   1040 <printf>
      exit();
     b00:	e8 e3 03 00 00       	call   ee8 <exit>
     b05:	8d 76 00             	lea    0x0(%esi),%esi
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
     b08:	8b 43 04             	mov    0x4(%ebx),%eax
     b0b:	89 04 24             	mov    %eax,(%esp)
     b0e:	e8 9d fe ff ff       	call   9b0 <runcmd>
     b13:	e9 2e ff ff ff       	jmp    a46 <runcmd+0x96>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
     b18:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b1f:	e8 ec 03 00 00       	call   f10 <close>
      dup(p[0]);
     b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b27:	89 04 24             	mov    %eax,(%esp)
     b2a:	e8 31 04 00 00       	call   f60 <dup>
      close(p[0]);
     b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b32:	89 04 24             	mov    %eax,(%esp)
     b35:	e8 d6 03 00 00       	call   f10 <close>
      close(p[1]);
     b3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b3d:	89 04 24             	mov    %eax,(%esp)
     b40:	e8 cb 03 00 00       	call   f10 <close>
      runcmd(pcmd->right);
     b45:	8b 43 08             	mov    0x8(%ebx),%eax
     b48:	89 04 24             	mov    %eax,(%esp)
     b4b:	e8 60 fe ff ff       	call   9b0 <runcmd>
     b50:	e9 41 ff ff ff       	jmp    a96 <runcmd+0xe6>
     b55:	8d 76 00             	lea    0x0(%esi),%esi
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
     b58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b5f:	e8 ac 03 00 00       	call   f10 <close>
      dup(p[1]);
     b64:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b67:	89 04 24             	mov    %eax,(%esp)
     b6a:	e8 f1 03 00 00       	call   f60 <dup>
      close(p[0]);
     b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b72:	89 04 24             	mov    %eax,(%esp)
     b75:	e8 96 03 00 00       	call   f10 <close>
      close(p[1]);
     b7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b7d:	89 04 24             	mov    %eax,(%esp)
     b80:	e8 8b 03 00 00       	call   f10 <close>
      runcmd(pcmd->left);
     b85:	8b 43 04             	mov    0x4(%ebx),%eax
     b88:	89 04 24             	mov    %eax,(%esp)
     b8b:	e8 20 fe ff ff       	call   9b0 <runcmd>
     b90:	e9 f1 fe ff ff       	jmp    a86 <runcmd+0xd6>
     b95:	8d 76 00             	lea    0x0(%esi),%esi
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     b98:	c7 04 24 c4 14 00 00 	movl   $0x14c4,(%esp)
     b9f:	e8 7c f8 ff ff       	call   420 <panic>
     ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ba8:	e9 c6 fe ff ff       	jmp    a73 <runcmd+0xc3>
     bad:	8d 76 00             	lea    0x0(%esi),%esi

00000bb0 <main>:
  return 0;
}

int
main(void)
{
     bb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     bb4:	83 e4 f0             	and    $0xfffffff0,%esp
     bb7:	ff 71 fc             	pushl  -0x4(%ecx)
     bba:	55                   	push   %ebp
     bbb:	89 e5                	mov    %esp,%ebp
     bbd:	51                   	push   %ecx
     bbe:	83 ec 14             	sub    $0x14,%esp
     bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     bc8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     bcf:	00 
     bd0:	c7 04 24 c9 14 00 00 	movl   $0x14c9,(%esp)
     bd7:	e8 4c 03 00 00       	call   f28 <open>
     bdc:	85 c0                	test   %eax,%eax
     bde:	78 2b                	js     c0b <main+0x5b>
    if(fd >= 3){
     be0:	83 f8 02             	cmp    $0x2,%eax
     be3:	7e e3                	jle    bc8 <main+0x18>
      close(fd);
     be5:	89 04 24             	mov    %eax,(%esp)
     be8:	e8 23 03 00 00       	call   f10 <close>
     bed:	8d 76 00             	lea    0x0(%esi),%esi
     bf0:	eb 19                	jmp    c0b <main+0x5b>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
     bf2:	c7 04 24 20 15 00 00 	movl   $0x1520,(%esp)
     bf9:	e8 92 fc ff ff       	call   890 <parsecmd>
     bfe:	89 04 24             	mov    %eax,(%esp)
     c01:	e8 aa fd ff ff       	call   9b0 <runcmd>
    wait();
     c06:	e8 e5 02 00 00       	call   ef0 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     c0b:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     c12:	00 
     c13:	c7 04 24 20 15 00 00 	movl   $0x1520,(%esp)
     c1a:	e8 31 fd ff ff       	call   950 <getcmd>
     c1f:	85 c0                	test   %eax,%eax
     c21:	78 75                	js     c98 <main+0xe8>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     c23:	80 3d 20 15 00 00 63 	cmpb   $0x63,0x1520
     c2a:	75 09                	jne    c35 <main+0x85>
     c2c:	80 3d 21 15 00 00 64 	cmpb   $0x64,0x1521
     c33:	74 13                	je     c48 <main+0x98>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
     c35:	e8 d6 fc ff ff       	call   910 <fork1>
     c3a:	85 c0                	test   %eax,%eax
     c3c:	75 c8                	jne    c06 <main+0x56>
     c3e:	66 90                	xchg   %ax,%ax
     c40:	eb b0                	jmp    bf2 <main+0x42>
     c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     c48:	80 3d 22 15 00 00 20 	cmpb   $0x20,0x1522
     c4f:	90                   	nop    
     c50:	75 e3                	jne    c35 <main+0x85>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     c52:	c7 04 24 20 15 00 00 	movl   $0x1520,(%esp)
     c59:	e8 c2 00 00 00       	call   d20 <strlen>
      if(chdir(buf+3) < 0)
     c5e:	c7 04 24 23 15 00 00 	movl   $0x1523,(%esp)
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     c65:	c6 80 1f 15 00 00 00 	movb   $0x0,0x151f(%eax)
      if(chdir(buf+3) < 0)
     c6c:	e8 e7 02 00 00       	call   f58 <chdir>
     c71:	85 c0                	test   %eax,%eax
     c73:	79 96                	jns    c0b <main+0x5b>
        printf(2, "cannot cd %s\n", buf+3);
     c75:	c7 44 24 08 23 15 00 	movl   $0x1523,0x8(%esp)
     c7c:	00 
     c7d:	c7 44 24 04 d1 14 00 	movl   $0x14d1,0x4(%esp)
     c84:	00 
     c85:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c8c:	e8 af 03 00 00       	call   1040 <printf>
     c91:	e9 75 ff ff ff       	jmp    c0b <main+0x5b>
     c96:	66 90                	xchg   %ax,%ax
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     c98:	e8 4b 02 00 00       	call   ee8 <exit>
     c9d:	90                   	nop    
     c9e:	90                   	nop    
     c9f:	90                   	nop    

00000ca0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     ca0:	55                   	push   %ebp
     ca1:	31 d2                	xor    %edx,%edx
     ca3:	89 e5                	mov    %esp,%ebp
     ca5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     ca8:	53                   	push   %ebx
     ca9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     cb0:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
     cb4:	88 04 13             	mov    %al,(%ebx,%edx,1)
     cb7:	83 c2 01             	add    $0x1,%edx
     cba:	84 c0                	test   %al,%al
     cbc:	75 f2                	jne    cb0 <strcpy+0x10>
    ;
  return os;
}
     cbe:	89 d8                	mov    %ebx,%eax
     cc0:	5b                   	pop    %ebx
     cc1:	5d                   	pop    %ebp
     cc2:	c3                   	ret    
     cc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cd0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	53                   	push   %ebx
     cd4:	8b 55 08             	mov    0x8(%ebp),%edx
     cd7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     cda:	0f b6 02             	movzbl (%edx),%eax
     cdd:	84 c0                	test   %al,%al
     cdf:	75 14                	jne    cf5 <strcmp+0x25>
     ce1:	eb 2d                	jmp    d10 <strcmp+0x40>
     ce3:	90                   	nop    
     ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
     ce8:	83 c2 01             	add    $0x1,%edx
     ceb:	83 c1 01             	add    $0x1,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     cee:	0f b6 02             	movzbl (%edx),%eax
     cf1:	84 c0                	test   %al,%al
     cf3:	74 1b                	je     d10 <strcmp+0x40>
     cf5:	0f b6 19             	movzbl (%ecx),%ebx
     cf8:	38 d8                	cmp    %bl,%al
     cfa:	74 ec                	je     ce8 <strcmp+0x18>
     cfc:	0f b6 d0             	movzbl %al,%edx
     cff:	0f b6 c3             	movzbl %bl,%eax
     d02:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     d04:	89 d0                	mov    %edx,%eax
     d06:	5b                   	pop    %ebx
     d07:	5d                   	pop    %ebp
     d08:	c3                   	ret    
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     d10:	0f b6 19             	movzbl (%ecx),%ebx
     d13:	31 d2                	xor    %edx,%edx
     d15:	0f b6 c3             	movzbl %bl,%eax
     d18:	29 c2                	sub    %eax,%edx
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     d1a:	89 d0                	mov    %edx,%eax
     d1c:	5b                   	pop    %ebx
     d1d:	5d                   	pop    %ebp
     d1e:	c3                   	ret    
     d1f:	90                   	nop    

00000d20 <strlen>:

uint
strlen(char *s)
{
     d20:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
     d21:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
     d23:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
     d25:	31 c9                	xor    %ecx,%ecx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
     d27:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     d2a:	80 3a 00             	cmpb   $0x0,(%edx)
     d2d:	74 0c                	je     d3b <strlen+0x1b>
     d2f:	90                   	nop    
     d30:	83 c0 01             	add    $0x1,%eax
     d33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     d37:	75 f7                	jne    d30 <strlen+0x10>
     d39:	89 c1                	mov    %eax,%ecx
    ;
  return n;
}
     d3b:	89 c8                	mov    %ecx,%eax
     d3d:	5d                   	pop    %ebp
     d3e:	c3                   	ret    
     d3f:	90                   	nop    

00000d40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	8b 45 10             	mov    0x10(%ebp),%eax
     d46:	53                   	push   %ebx
     d47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;
  
  d = dst;
  while(n-- > 0)
     d4a:	85 c0                	test   %eax,%eax
     d4c:	74 14                	je     d62 <memset+0x22>
     d4e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
     d52:	31 d2                	xor    %edx,%edx
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
     d58:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
     d5b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
     d5e:	39 c2                	cmp    %eax,%edx
     d60:	75 f6                	jne    d58 <memset+0x18>
    *d++ = c;
  return dst;
}
     d62:	89 d8                	mov    %ebx,%eax
     d64:	5b                   	pop    %ebx
     d65:	5d                   	pop    %ebp
     d66:	c3                   	ret    
     d67:	89 f6                	mov    %esi,%esi
     d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d70 <strchr>:

char*
strchr(const char *s, char c)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d7a:	0f b6 10             	movzbl (%eax),%edx
     d7d:	84 d2                	test   %dl,%dl
     d7f:	75 11                	jne    d92 <strchr+0x22>
     d81:	eb 25                	jmp    da8 <strchr+0x38>
     d83:	90                   	nop    
     d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d88:	83 c0 01             	add    $0x1,%eax
     d8b:	0f b6 10             	movzbl (%eax),%edx
     d8e:	84 d2                	test   %dl,%dl
     d90:	74 16                	je     da8 <strchr+0x38>
    if(*s == c)
     d92:	38 ca                	cmp    %cl,%dl
     d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d98:	75 ee                	jne    d88 <strchr+0x18>
      return (char*) s;
  return 0;
}
     d9a:	5d                   	pop    %ebp
     d9b:	90                   	nop    
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     da0:	c3                   	ret    
     da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     da8:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
     daa:	5d                   	pop    %ebp
     dab:	90                   	nop    
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     db0:	c3                   	ret    
     db1:	eb 0d                	jmp    dc0 <atoi>
     db3:	90                   	nop    
     db4:	90                   	nop    
     db5:	90                   	nop    
     db6:	90                   	nop    
     db7:	90                   	nop    
     db8:	90                   	nop    
     db9:	90                   	nop    
     dba:	90                   	nop    
     dbb:	90                   	nop    
     dbc:	90                   	nop    
     dbd:	90                   	nop    
     dbe:	90                   	nop    
     dbf:	90                   	nop    

00000dc0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     dc0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dc1:	31 c9                	xor    %ecx,%ecx
  return r;
}

int
atoi(const char *s)
{
     dc3:	89 e5                	mov    %esp,%ebp
     dc5:	53                   	push   %ebx
     dc6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dc9:	0f b6 13             	movzbl (%ebx),%edx
     dcc:	8d 42 d0             	lea    -0x30(%edx),%eax
     dcf:	3c 09                	cmp    $0x9,%al
     dd1:	77 1c                	ja     def <atoi+0x2f>
     dd3:	90                   	nop    
     dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     dd8:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
     ddb:	0f be d2             	movsbl %dl,%edx
     dde:	83 c3 01             	add    $0x1,%ebx
     de1:	8d 4c 42 d0          	lea    -0x30(%edx,%eax,2),%ecx
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     de5:	0f b6 13             	movzbl (%ebx),%edx
     de8:	8d 42 d0             	lea    -0x30(%edx),%eax
     deb:	3c 09                	cmp    $0x9,%al
     ded:	76 e9                	jbe    dd8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
     def:	89 c8                	mov    %ecx,%eax
     df1:	5b                   	pop    %ebx
     df2:	5d                   	pop    %ebp
     df3:	c3                   	ret    
     df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e00 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e06:	56                   	push   %esi
     e07:	8b 75 08             	mov    0x8(%ebp),%esi
     e0a:	53                   	push   %ebx
     e0b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e0e:	85 c9                	test   %ecx,%ecx
     e10:	7e 14                	jle    e26 <memmove+0x26>
     e12:	31 d2                	xor    %edx,%edx
     e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     e18:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
     e1c:	88 04 16             	mov    %al,(%esi,%edx,1)
     e1f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e22:	39 ca                	cmp    %ecx,%edx
     e24:	75 f2                	jne    e18 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     e26:	89 f0                	mov    %esi,%eax
     e28:	5b                   	pop    %ebx
     e29:	5e                   	pop    %esi
     e2a:	5d                   	pop    %ebp
     e2b:	c3                   	ret    
     e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e30 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e36:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
     e39:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     e3c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
     e3f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e44:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e4b:	00 
     e4c:	89 04 24             	mov    %eax,(%esp)
     e4f:	e8 d4 00 00 00       	call   f28 <open>
  if(fd < 0)
     e54:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e56:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     e58:	78 19                	js     e73 <stat+0x43>
    return -1;
  r = fstat(fd, st);
     e5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5d:	89 1c 24             	mov    %ebx,(%esp)
     e60:	89 44 24 04          	mov    %eax,0x4(%esp)
     e64:	e8 d7 00 00 00       	call   f40 <fstat>
  close(fd);
     e69:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
     e6c:	89 c6                	mov    %eax,%esi
  close(fd);
     e6e:	e8 9d 00 00 00       	call   f10 <close>
  return r;
}
     e73:	89 f0                	mov    %esi,%eax
     e75:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     e78:	8b 75 fc             	mov    -0x4(%ebp),%esi
     e7b:	89 ec                	mov    %ebp,%esp
     e7d:	5d                   	pop    %ebp
     e7e:	c3                   	ret    
     e7f:	90                   	nop    

00000e80 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
     e80:	55                   	push   %ebp
     e81:	89 e5                	mov    %esp,%ebp
     e83:	57                   	push   %edi
     e84:	56                   	push   %esi
     e85:	31 f6                	xor    %esi,%esi
     e87:	53                   	push   %ebx
     e88:	83 ec 1c             	sub    $0x1c,%esp
     e8b:	8b 7d 08             	mov    0x8(%ebp),%edi
     e8e:	eb 06                	jmp    e96 <gets+0x16>
  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     e90:	3c 0d                	cmp    $0xd,%al
     e92:	74 39                	je     ecd <gets+0x4d>
     e94:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e96:	8d 5e 01             	lea    0x1(%esi),%ebx
     e99:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     e9c:	7d 31                	jge    ecf <gets+0x4f>
    cc = read(0, &c, 1);
     e9e:	8d 45 f3             	lea    -0xd(%ebp),%eax
     ea1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ea8:	00 
     ea9:	89 44 24 04          	mov    %eax,0x4(%esp)
     ead:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eb4:	e8 47 00 00 00       	call   f00 <read>
    if(cc < 1)
     eb9:	85 c0                	test   %eax,%eax
     ebb:	7e 12                	jle    ecf <gets+0x4f>
      break;
    buf[i++] = c;
     ebd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
     ec1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
     ec5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
     ec9:	3c 0a                	cmp    $0xa,%al
     ecb:	75 c3                	jne    e90 <gets+0x10>
     ecd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
     ecf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
     ed3:	89 f8                	mov    %edi,%eax
     ed5:	83 c4 1c             	add    $0x1c,%esp
     ed8:	5b                   	pop    %ebx
     ed9:	5e                   	pop    %esi
     eda:	5f                   	pop    %edi
     edb:	5d                   	pop    %ebp
     edc:	c3                   	ret    
     edd:	90                   	nop    
     ede:	90                   	nop    
     edf:	90                   	nop    

00000ee0 <fork>:
     ee0:	b8 01 00 00 00       	mov    $0x1,%eax
     ee5:	cd 30                	int    $0x30
     ee7:	c3                   	ret    

00000ee8 <exit>:
     ee8:	b8 02 00 00 00       	mov    $0x2,%eax
     eed:	cd 30                	int    $0x30
     eef:	c3                   	ret    

00000ef0 <wait>:
     ef0:	b8 03 00 00 00       	mov    $0x3,%eax
     ef5:	cd 30                	int    $0x30
     ef7:	c3                   	ret    

00000ef8 <pipe>:
     ef8:	b8 04 00 00 00       	mov    $0x4,%eax
     efd:	cd 30                	int    $0x30
     eff:	c3                   	ret    

00000f00 <read>:
     f00:	b8 06 00 00 00       	mov    $0x6,%eax
     f05:	cd 30                	int    $0x30
     f07:	c3                   	ret    

00000f08 <write>:
     f08:	b8 05 00 00 00       	mov    $0x5,%eax
     f0d:	cd 30                	int    $0x30
     f0f:	c3                   	ret    

00000f10 <close>:
     f10:	b8 07 00 00 00       	mov    $0x7,%eax
     f15:	cd 30                	int    $0x30
     f17:	c3                   	ret    

00000f18 <kill>:
     f18:	b8 08 00 00 00       	mov    $0x8,%eax
     f1d:	cd 30                	int    $0x30
     f1f:	c3                   	ret    

00000f20 <exec>:
     f20:	b8 09 00 00 00       	mov    $0x9,%eax
     f25:	cd 30                	int    $0x30
     f27:	c3                   	ret    

00000f28 <open>:
     f28:	b8 0a 00 00 00       	mov    $0xa,%eax
     f2d:	cd 30                	int    $0x30
     f2f:	c3                   	ret    

00000f30 <mknod>:
     f30:	b8 0b 00 00 00       	mov    $0xb,%eax
     f35:	cd 30                	int    $0x30
     f37:	c3                   	ret    

00000f38 <unlink>:
     f38:	b8 0c 00 00 00       	mov    $0xc,%eax
     f3d:	cd 30                	int    $0x30
     f3f:	c3                   	ret    

00000f40 <fstat>:
     f40:	b8 0d 00 00 00       	mov    $0xd,%eax
     f45:	cd 30                	int    $0x30
     f47:	c3                   	ret    

00000f48 <link>:
     f48:	b8 0e 00 00 00       	mov    $0xe,%eax
     f4d:	cd 30                	int    $0x30
     f4f:	c3                   	ret    

00000f50 <mkdir>:
     f50:	b8 0f 00 00 00       	mov    $0xf,%eax
     f55:	cd 30                	int    $0x30
     f57:	c3                   	ret    

00000f58 <chdir>:
     f58:	b8 10 00 00 00       	mov    $0x10,%eax
     f5d:	cd 30                	int    $0x30
     f5f:	c3                   	ret    

00000f60 <dup>:
     f60:	b8 11 00 00 00       	mov    $0x11,%eax
     f65:	cd 30                	int    $0x30
     f67:	c3                   	ret    

00000f68 <getpid>:
     f68:	b8 12 00 00 00       	mov    $0x12,%eax
     f6d:	cd 30                	int    $0x30
     f6f:	c3                   	ret    

00000f70 <sbrk>:
     f70:	b8 13 00 00 00       	mov    $0x13,%eax
     f75:	cd 30                	int    $0x30
     f77:	c3                   	ret    

00000f78 <sleep>:
     f78:	b8 14 00 00 00       	mov    $0x14,%eax
     f7d:	cd 30                	int    $0x30
     f7f:	c3                   	ret    

00000f80 <mytime>:
     f80:	b8 15 00 00 00       	mov    $0x15,%eax
     f85:	cd 30                	int    $0x30
     f87:	c3                   	ret    

00000f88 <settickets>:
     f88:	b8 16 00 00 00       	mov    $0x16,%eax
     f8d:	cd 30                	int    $0x30
     f8f:	c3                   	ret    

00000f90 <getruntime>:
     f90:	b8 17 00 00 00       	mov    $0x17,%eax
     f95:	cd 30                	int    $0x30
     f97:	c3                   	ret    
     f98:	90                   	nop    
     f99:	90                   	nop    
     f9a:	90                   	nop    
     f9b:	90                   	nop    
     f9c:	90                   	nop    
     f9d:	90                   	nop    
     f9e:	90                   	nop    
     f9f:	90                   	nop    

00000fa0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	56                   	push   %esi
     fa5:	89 ce                	mov    %ecx,%esi
     fa7:	53                   	push   %ebx
     fa8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     fab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     fae:	89 45 cc             	mov    %eax,-0x34(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     fb1:	85 c9                	test   %ecx,%ecx
     fb3:	74 04                	je     fb9 <printint+0x19>
     fb5:	85 d2                	test   %edx,%edx
     fb7:	78 77                	js     1030 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     fb9:	89 d0                	mov    %edx,%eax
     fbb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
     fc2:	31 db                	xor    %ebx,%ebx
     fc4:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     fc7:	90                   	nop    
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     fc8:	31 d2                	xor    %edx,%edx
     fca:	f7 f6                	div    %esi
     fcc:	89 c1                	mov    %eax,%ecx
     fce:	0f b6 82 e6 14 00 00 	movzbl 0x14e6(%edx),%eax
     fd5:	88 04 1f             	mov    %al,(%edi,%ebx,1)
     fd8:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
     fdb:	85 c9                	test   %ecx,%ecx
     fdd:	89 c8                	mov    %ecx,%eax
     fdf:	75 e7                	jne    fc8 <printint+0x28>
  if(neg)
     fe1:	8b 45 d0             	mov    -0x30(%ebp),%eax
     fe4:	85 c0                	test   %eax,%eax
     fe6:	74 08                	je     ff0 <printint+0x50>
    buf[i++] = '-';
     fe8:	c6 44 1d e3 2d       	movb   $0x2d,-0x1d(%ebp,%ebx,1)
     fed:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
     ff0:	8d 73 ff             	lea    -0x1(%ebx),%esi
     ff3:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
     ff6:	8d 7d f3             	lea    -0xd(%ebp),%edi
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    1000:	0f b6 03             	movzbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1003:	83 ee 01             	sub    $0x1,%esi
    1006:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1009:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1010:	00 
    1011:	89 7c 24 04          	mov    %edi,0x4(%esp)
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
    1015:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1018:	8b 45 cc             	mov    -0x34(%ebp),%eax
    101b:	89 04 24             	mov    %eax,(%esp)
    101e:	e8 e5 fe ff ff       	call   f08 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1023:	83 fe ff             	cmp    $0xffffffff,%esi
    1026:	75 d8                	jne    1000 <printint+0x60>
    putc(fd, buf[i]);
}
    1028:	83 c4 3c             	add    $0x3c,%esp
    102b:	5b                   	pop    %ebx
    102c:	5e                   	pop    %esi
    102d:	5f                   	pop    %edi
    102e:	5d                   	pop    %ebp
    102f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1030:	89 d0                	mov    %edx,%eax
    1032:	f7 d8                	neg    %eax
    1034:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    103b:	eb 85                	jmp    fc2 <printint+0x22>
    103d:	8d 76 00             	lea    0x0(%esi),%esi

00001040 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	57                   	push   %edi
    1044:	56                   	push   %esi
    1045:	53                   	push   %ebx
    1046:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1049:	8b 55 0c             	mov    0xc(%ebp),%edx
    104c:	0f b6 02             	movzbl (%edx),%eax
    104f:	84 c0                	test   %al,%al
    1051:	0f 84 e9 00 00 00    	je     1140 <printf+0x100>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1057:	8d 4d 10             	lea    0x10(%ebp),%ecx
    105a:	89 d7                	mov    %edx,%edi
    105c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    105f:	31 f6                	xor    %esi,%esi
    1061:	eb 21                	jmp    1084 <printf+0x44>
    1063:	90                   	nop    
    1064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1068:	83 fb 25             	cmp    $0x25,%ebx
    106b:	0f 85 d7 00 00 00    	jne    1148 <printf+0x108>
    1071:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1075:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    1079:	83 c7 01             	add    $0x1,%edi
    107c:	84 c0                	test   %al,%al
    107e:	0f 84 bc 00 00 00    	je     1140 <printf+0x100>
    c = fmt[i] & 0xff;
    if(state == 0){
    1084:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1086:	0f b6 d8             	movzbl %al,%ebx
    if(state == 0){
    1089:	74 dd                	je     1068 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    108b:	83 fe 25             	cmp    $0x25,%esi
    108e:	75 e5                	jne    1075 <printf+0x35>
      if(c == 'd'){
    1090:	83 fb 64             	cmp    $0x64,%ebx
    1093:	90                   	nop    
    1094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1098:	0f 84 4a 01 00 00    	je     11e8 <printf+0x1a8>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    109e:	83 fb 78             	cmp    $0x78,%ebx
    10a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10a8:	0f 84 c2 00 00 00    	je     1170 <printf+0x130>
    10ae:	83 fb 70             	cmp    $0x70,%ebx
    10b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10b8:	0f 84 b2 00 00 00    	je     1170 <printf+0x130>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    10be:	83 fb 73             	cmp    $0x73,%ebx
    10c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10c8:	0f 84 ca 00 00 00    	je     1198 <printf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    10ce:	83 fb 63             	cmp    $0x63,%ebx
    10d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10d8:	0f 84 5a 01 00 00    	je     1238 <printf+0x1f8>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    10de:	83 fb 25             	cmp    $0x25,%ebx
    10e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10e8:	0f 84 22 01 00 00    	je     1210 <printf+0x1d0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10ee:	8b 55 08             	mov    0x8(%ebp),%edx
    10f1:	8d 45 f3             	lea    -0xd(%ebp),%eax
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    10f4:	31 f6                	xor    %esi,%esi
    10f6:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1101:	00 
    1102:	89 44 24 04          	mov    %eax,0x4(%esp)
    1106:	89 14 24             	mov    %edx,(%esp)
    1109:	e8 fa fd ff ff       	call   f08 <write>
    110e:	8b 45 08             	mov    0x8(%ebp),%eax
    1111:	8d 4d f3             	lea    -0xd(%ebp),%ecx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    1114:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1117:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    111e:	00 
    111f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1123:	89 04 24             	mov    %eax,(%esp)
    1126:	e8 dd fd ff ff       	call   f08 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    112b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    112f:	83 c7 01             	add    $0x1,%edi
    1132:	84 c0                	test   %al,%al
    1134:	0f 85 4a ff ff ff    	jne    1084 <printf+0x44>
    113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1140:	83 c4 2c             	add    $0x2c,%esp
    1143:	5b                   	pop    %ebx
    1144:	5e                   	pop    %esi
    1145:	5f                   	pop    %edi
    1146:	5d                   	pop    %ebp
    1147:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1148:	8b 55 08             	mov    0x8(%ebp),%edx
    114b:	8d 45 f3             	lea    -0xd(%ebp),%eax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    114e:	88 5d f3             	mov    %bl,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1151:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1158:	00 
    1159:	89 44 24 04          	mov    %eax,0x4(%esp)
    115d:	89 14 24             	mov    %edx,(%esp)
    1160:	e8 a3 fd ff ff       	call   f08 <write>
    1165:	e9 0b ff ff ff       	jmp    1075 <printf+0x35>
    116a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1170:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1173:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1178:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    117a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1181:	8b 10                	mov    (%eax),%edx
    1183:	8b 45 08             	mov    0x8(%ebp),%eax
    1186:	e8 15 fe ff ff       	call   fa0 <printint>
        ap++;
    118b:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
    118f:	e9 e1 fe ff ff       	jmp    1075 <printf+0x35>
    1194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1198:	8b 55 e0             	mov    -0x20(%ebp),%edx
    119b:	8b 1a                	mov    (%edx),%ebx
        ap++;
    119d:	83 c2 04             	add    $0x4,%edx
    11a0:	89 55 e0             	mov    %edx,-0x20(%ebp)
        if(s == 0)
    11a3:	85 db                	test   %ebx,%ebx
    11a5:	0f 84 ba 00 00 00    	je     1265 <printf+0x225>
          s = "(null)";
        while(*s != 0){
    11ab:	0f b6 03             	movzbl (%ebx),%eax
    11ae:	84 c0                	test   %al,%al
    11b0:	74 2d                	je     11df <printf+0x19f>
    11b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
    11b8:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
    11be:	8d 4d f3             	lea    -0xd(%ebp),%ecx
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    11c1:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    11c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11cb:	00 
    11cc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    11d0:	89 04 24             	mov    %eax,(%esp)
    11d3:	e8 30 fd ff ff       	call   f08 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    11d8:	0f b6 03             	movzbl (%ebx),%eax
    11db:	84 c0                	test   %al,%al
    11dd:	75 d9                	jne    11b8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    11df:	31 f6                	xor    %esi,%esi
    11e1:	e9 8f fe ff ff       	jmp    1075 <printf+0x35>
    11e6:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    11e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11eb:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    11f0:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    11f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11fa:	8b 10                	mov    (%eax),%edx
    11fc:	8b 45 08             	mov    0x8(%ebp),%eax
    11ff:	e8 9c fd ff ff       	call   fa0 <printint>
        ap++;
    1204:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
    1208:	e9 68 fe ff ff       	jmp    1075 <printf+0x35>
    120d:	8d 76 00             	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1210:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1213:	8d 55 f3             	lea    -0xd(%ebp),%edx
    1216:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    1218:	c6 45 f3 25          	movb   $0x25,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    121c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1223:	00 
    1224:	89 54 24 04          	mov    %edx,0x4(%esp)
    1228:	89 0c 24             	mov    %ecx,(%esp)
    122b:	e8 d8 fc ff ff       	call   f08 <write>
    1230:	e9 40 fe ff ff       	jmp    1075 <printf+0x35>
    1235:	8d 76 00             	lea    0x0(%esi),%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1238:	8b 55 e0             	mov    -0x20(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    123b:	8d 4d f3             	lea    -0xd(%ebp),%ecx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    123e:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1240:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1242:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1249:	00 
    124a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    124e:	88 45 f3             	mov    %al,-0xd(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1251:	8b 45 08             	mov    0x8(%ebp),%eax
    1254:	89 04 24             	mov    %eax,(%esp)
    1257:	e8 ac fc ff ff       	call   f08 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    125c:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
    1260:	e9 10 fe ff ff       	jmp    1075 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
    1265:	bb df 14 00 00       	mov    $0x14df,%ebx
    126a:	e9 3c ff ff ff       	jmp    11ab <printf+0x16b>
    126f:	90                   	nop    

00001270 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1270:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1271:	8b 0d 8c 15 00 00    	mov    0x158c,%ecx
static Header base;
static Header *freep;

void
free(void *ap)
{
    1277:	89 e5                	mov    %esp,%ebp
    1279:	57                   	push   %edi
    127a:	56                   	push   %esi
    127b:	53                   	push   %ebx
    127c:	8b 7d 08             	mov    0x8(%ebp),%edi
  Header *bp, *p;

  bp = (Header*) ap - 1;
    127f:	8d 5f f8             	lea    -0x8(%edi),%ebx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1282:	39 d9                	cmp    %ebx,%ecx
    1284:	73 24                	jae    12aa <free+0x3a>
    1286:	66 90                	xchg   %ax,%ax
    1288:	8b 11                	mov    (%ecx),%edx
    128a:	39 d3                	cmp    %edx,%ebx
    128c:	72 2a                	jb     12b8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    128e:	39 d1                	cmp    %edx,%ecx
    1290:	72 10                	jb     12a2 <free+0x32>
    1292:	39 d9                	cmp    %ebx,%ecx
    1294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1298:	72 1e                	jb     12b8 <free+0x48>
    129a:	39 d3                	cmp    %edx,%ebx
    129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12a0:	72 16                	jb     12b8 <free+0x48>
    12a2:	89 d1                	mov    %edx,%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12a4:	39 d9                	cmp    %ebx,%ecx
    12a6:	66 90                	xchg   %ax,%ax
    12a8:	72 de                	jb     1288 <free+0x18>
    12aa:	8b 11                	mov    (%ecx),%edx
    12ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12b0:	eb dc                	jmp    128e <free+0x1e>
    12b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    12b8:	8b 73 04             	mov    0x4(%ebx),%esi
    12bb:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
    12be:	39 d0                	cmp    %edx,%eax
    12c0:	74 1a                	je     12dc <free+0x6c>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    12c2:	89 57 f8             	mov    %edx,-0x8(%edi)
  if(p + p->s.size == bp){
    12c5:	8b 51 04             	mov    0x4(%ecx),%edx
    12c8:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
    12cb:	39 d8                	cmp    %ebx,%eax
    12cd:	74 22                	je     12f1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    12cf:	89 19                	mov    %ebx,(%ecx)
  freep = p;
    12d1:	89 0d 8c 15 00 00    	mov    %ecx,0x158c
}
    12d7:	5b                   	pop    %ebx
    12d8:	5e                   	pop    %esi
    12d9:	5f                   	pop    %edi
    12da:	5d                   	pop    %ebp
    12db:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12dc:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
    12df:	8b 02                	mov    (%edx),%eax
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12e1:	89 73 04             	mov    %esi,0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    12e4:	8b 51 04             	mov    0x4(%ecx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    12e7:	89 47 f8             	mov    %eax,-0x8(%edi)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    12ea:	8d 04 d1             	lea    (%ecx,%edx,8),%eax
    12ed:	39 d8                	cmp    %ebx,%eax
    12ef:	75 de                	jne    12cf <free+0x5f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    12f1:	8b 47 f8             	mov    -0x8(%edi),%eax
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12f4:	03 53 04             	add    0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
    12f7:	89 01                	mov    %eax,(%ecx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12f9:	89 51 04             	mov    %edx,0x4(%ecx)
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    12fc:	89 0d 8c 15 00 00    	mov    %ecx,0x158c
}
    1302:	5b                   	pop    %ebx
    1303:	5e                   	pop    %esi
    1304:	5f                   	pop    %edi
    1305:	5d                   	pop    %ebp
    1306:	c3                   	ret    
    1307:	89 f6                	mov    %esi,%esi
    1309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001310 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	56                   	push   %esi
    1315:	53                   	push   %ebx
    1316:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1319:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    131c:	8b 35 8c 15 00 00    	mov    0x158c,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1322:	83 c0 07             	add    $0x7,%eax
    1325:	c1 e8 03             	shr    $0x3,%eax
  if((prevp = freep) == 0){
    1328:	85 f6                	test   %esi,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    132a:	8d 58 01             	lea    0x1(%eax),%ebx
  if((prevp = freep) == 0){
    132d:	0f 84 95 00 00 00    	je     13c8 <malloc+0xb8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1333:	8b 0e                	mov    (%esi),%ecx
    if(p->s.size >= nunits){
    1335:	8b 41 04             	mov    0x4(%ecx),%eax
    1338:	39 c3                	cmp    %eax,%ebx
    133a:	0f 86 b0 00 00 00    	jbe    13f0 <malloc+0xe0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    1340:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1347:	90                   	nop    
    }
    if(p == freep)
    1348:	3b 0d 8c 15 00 00    	cmp    0x158c,%ecx
    134e:	89 ca                	mov    %ecx,%edx
    1350:	74 34                	je     1386 <malloc+0x76>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1352:	8b 0a                	mov    (%edx),%ecx
    if(p->s.size >= nunits){
    1354:	8b 41 04             	mov    0x4(%ecx),%eax
    1357:	39 c3                	cmp    %eax,%ebx
    1359:	77 ed                	ja     1348 <malloc+0x38>
    135b:	89 d6                	mov    %edx,%esi
    135d:	89 ca                	mov    %ecx,%edx
      if(p->s.size == nunits)
    135f:	39 c3                	cmp    %eax,%ebx
    1361:	74 1d                	je     1380 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1363:	29 d8                	sub    %ebx,%eax
        p += p->s.size;
    1365:	8d 14 c1             	lea    (%ecx,%eax,8),%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1368:	89 41 04             	mov    %eax,0x4(%ecx)
        p += p->s.size;
        p->s.size = nunits;
    136b:	89 5a 04             	mov    %ebx,0x4(%edx)
      }
      freep = prevp;
    136e:	89 35 8c 15 00 00    	mov    %esi,0x158c
      return (void*) (p + 1);
    1374:	8d 42 08             	lea    0x8(%edx),%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1377:	83 c4 0c             	add    $0xc,%esp
    137a:	5b                   	pop    %ebx
    137b:	5e                   	pop    %esi
    137c:	5f                   	pop    %edi
    137d:	5d                   	pop    %ebp
    137e:	c3                   	ret    
    137f:	90                   	nop    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1380:	8b 01                	mov    (%ecx),%eax
    1382:	89 06                	mov    %eax,(%esi)
    1384:	eb e8                	jmp    136e <malloc+0x5e>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    1386:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    138c:	bf 00 10 00 00       	mov    $0x1000,%edi
    1391:	b8 00 80 00 00       	mov    $0x8000,%eax
    1396:	76 04                	jbe    139c <malloc+0x8c>
    1398:	89 df                	mov    %ebx,%edi
    139a:	89 f0                	mov    %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
    139c:	89 04 24             	mov    %eax,(%esp)
    139f:	e8 cc fb ff ff       	call   f70 <sbrk>
  if(p == (char*) -1)
    13a4:	83 f8 ff             	cmp    $0xffffffff,%eax
    13a7:	74 18                	je     13c1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    13a9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    13ac:	83 c0 08             	add    $0x8,%eax
    13af:	89 04 24             	mov    %eax,(%esp)
    13b2:	e8 b9 fe ff ff       	call   1270 <free>
  return freep;
    13b7:	8b 15 8c 15 00 00    	mov    0x158c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    13bd:	85 d2                	test   %edx,%edx
    13bf:	75 91                	jne    1352 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    13c1:	31 c0                	xor    %eax,%eax
    13c3:	eb b2                	jmp    1377 <malloc+0x67>
    13c5:	8d 76 00             	lea    0x0(%esi),%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    13c8:	c7 05 8c 15 00 00 84 	movl   $0x1584,0x158c
    13cf:	15 00 00 
    base.s.size = 0;
    13d2:	be 84 15 00 00       	mov    $0x1584,%esi
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    13d7:	c7 05 84 15 00 00 84 	movl   $0x1584,0x1584
    13de:	15 00 00 
    base.s.size = 0;
    13e1:	c7 05 88 15 00 00 00 	movl   $0x0,0x1588
    13e8:	00 00 00 
    13eb:	e9 43 ff ff ff       	jmp    1333 <malloc+0x23>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    13f0:	89 ca                	mov    %ecx,%edx
    13f2:	e9 68 ff ff ff       	jmp    135f <malloc+0x4f>

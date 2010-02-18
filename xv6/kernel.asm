
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <brelse>:
}

// Release the buffer buf.
void
brelse(struct buf *b)
{
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 04             	sub    $0x4,%esp
  100007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
  10000a:	f6 03 01             	testb  $0x1,(%ebx)
  10000d:	74 58                	je     100067 <brelse+0x67>
    panic("brelse");

  acquire(&buf_table_lock);
  10000f:	c7 04 24 80 98 10 00 	movl   $0x109880,(%esp)
  100016:	e8 25 41 00 00       	call   104140 <acquire>

  b->next->prev = b->prev;
  10001b:	8b 53 10             	mov    0x10(%ebx),%edx
  10001e:	8b 43 0c             	mov    0xc(%ebx),%eax
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  100021:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  if((b->flags & B_BUSY) == 0)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  100024:	89 42 0c             	mov    %eax,0xc(%edx)
  b->prev->next = b->next;
  100027:	8b 43 0c             	mov    0xc(%ebx),%eax
  b->next = bufhead.next;
  b->prev = &bufhead;
  10002a:	c7 43 0c 60 81 10 00 	movl   $0x108160,0xc(%ebx)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  100031:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bufhead.next;
  100034:	a1 70 81 10 00       	mov    0x108170,%eax
  100039:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bufhead;
  bufhead.next->prev = b;
  10003c:	a1 70 81 10 00       	mov    0x108170,%eax
  bufhead.next = b;
  100041:	89 1d 70 81 10 00    	mov    %ebx,0x108170

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  100047:	89 58 0c             	mov    %ebx,0xc(%eax)
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);
  10004a:	c7 04 24 80 83 10 00 	movl   $0x108380,(%esp)
  100051:	e8 ea 33 00 00       	call   103440 <wakeup>

  release(&buf_table_lock);
  100056:	c7 45 08 80 98 10 00 	movl   $0x109880,0x8(%ebp)
}
  10005d:	83 c4 04             	add    $0x4,%esp
  100060:	5b                   	pop    %ebx
  100061:	5d                   	pop    %ebp
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);

  release(&buf_table_lock);
  100062:	e9 99 40 00 00       	jmp    104100 <release>
// Release the buffer buf.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100067:	c7 04 24 a0 61 10 00 	movl   $0x1061a0,(%esp)
  10006e:	e8 fd 08 00 00       	call   100970 <panic>
  100073:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100080 <bwrite>:
}

// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  100080:	55                   	push   %ebp
  100081:	89 e5                	mov    %esp,%ebp
  100083:	83 ec 08             	sub    $0x8,%esp
  100086:	8b 55 08             	mov    0x8(%ebp),%edx
  if((b->flags & B_BUSY) == 0)
  100089:	8b 02                	mov    (%edx),%eax
  10008b:	a8 01                	test   $0x1,%al
  10008d:	74 0e                	je     10009d <bwrite+0x1d>
    panic("bwrite");
  b->flags |= B_DIRTY;
  10008f:	83 c8 04             	or     $0x4,%eax
  100092:	89 02                	mov    %eax,(%edx)
  ide_rw(b);
  100094:	89 55 08             	mov    %edx,0x8(%ebp)
}
  100097:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  ide_rw(b);
  100098:	e9 03 20 00 00       	jmp    1020a0 <ide_rw>
// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  10009d:	c7 04 24 a7 61 10 00 	movl   $0x1061a7,(%esp)
  1000a4:	e8 c7 08 00 00       	call   100970 <panic>
  1000a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001000b0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1000b0:	55                   	push   %ebp
  1000b1:	89 e5                	mov    %esp,%ebp
  1000b3:	57                   	push   %edi
  1000b4:	56                   	push   %esi
  1000b5:	53                   	push   %ebx
  1000b6:	83 ec 0c             	sub    $0xc,%esp
  1000b9:	8b 75 08             	mov    0x8(%ebp),%esi
  1000bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&buf_table_lock);
  1000bf:	c7 04 24 80 98 10 00 	movl   $0x109880,(%esp)
  1000c6:	e8 75 40 00 00       	call   104140 <acquire>

 loop:
  // Try for cached block.
  for(b = bufhead.next; b != &bufhead; b = b->next){
  1000cb:	8b 1d 70 81 10 00    	mov    0x108170,%ebx
  1000d1:	81 fb 60 81 10 00    	cmp    $0x108160,%ebx
  1000d7:	75 12                	jne    1000eb <bread+0x3b>
  1000d9:	eb 45                	jmp    100120 <bread+0x70>
  1000db:	90                   	nop    
  1000dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1000e0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1000e3:	81 fb 60 81 10 00    	cmp    $0x108160,%ebx
  1000e9:	74 35                	je     100120 <bread+0x70>
    if((b->flags & (B_BUSY|B_VALID)) &&
  1000eb:	8b 03                	mov    (%ebx),%eax
  1000ed:	a8 03                	test   $0x3,%al
  1000ef:	74 ef                	je     1000e0 <bread+0x30>
  1000f1:	3b 73 04             	cmp    0x4(%ebx),%esi
  1000f4:	75 ea                	jne    1000e0 <bread+0x30>
  1000f6:	3b 7b 08             	cmp    0x8(%ebx),%edi
  1000f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100100:	75 de                	jne    1000e0 <bread+0x30>
       b->dev == dev && b->sector == sector){
      if(b->flags & B_BUSY){
  100102:	a8 01                	test   $0x1,%al
  100104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100108:	74 75                	je     10017f <bread+0xcf>
        sleep(buf, &buf_table_lock);
  10010a:	c7 44 24 04 80 98 10 	movl   $0x109880,0x4(%esp)
  100111:	00 
  100112:	c7 04 24 80 83 10 00 	movl   $0x108380,(%esp)
  100119:	e8 02 36 00 00       	call   103720 <sleep>
  10011e:	eb ab                	jmp    1000cb <bread+0x1b>
      return b;
    }
  }

  // Allocate fresh block.
  for(b = bufhead.prev; b != &bufhead; b = b->prev){
  100120:	a1 6c 81 10 00       	mov    0x10816c,%eax
  100125:	3d 60 81 10 00       	cmp    $0x108160,%eax
  10012a:	75 0e                	jne    10013a <bread+0x8a>
  10012c:	eb 45                	jmp    100173 <bread+0xc3>
  10012e:	66 90                	xchg   %ax,%ax
  100130:	8b 40 0c             	mov    0xc(%eax),%eax
  100133:	3d 60 81 10 00       	cmp    $0x108160,%eax
  100138:	74 39                	je     100173 <bread+0xc3>
    if((b->flags & B_BUSY) == 0){
  10013a:	f6 00 01             	testb  $0x1,(%eax)
  10013d:	8d 76 00             	lea    0x0(%esi),%esi
  100140:	75 ee                	jne    100130 <bread+0x80>
      b->flags = B_BUSY;
  100142:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    }
  }

  // Allocate fresh block.
  for(b = bufhead.prev; b != &bufhead; b = b->prev){
    if((b->flags & B_BUSY) == 0){
  100148:	89 c3                	mov    %eax,%ebx
      b->flags = B_BUSY;
      b->dev = dev;
  10014a:	89 70 04             	mov    %esi,0x4(%eax)
      b->sector = sector;
  10014d:	89 78 08             	mov    %edi,0x8(%eax)
      release(&buf_table_lock);
  100150:	c7 04 24 80 98 10 00 	movl   $0x109880,(%esp)
  100157:	e8 a4 3f 00 00       	call   104100 <release>
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  10015c:	f6 03 02             	testb  $0x2,(%ebx)
  10015f:	75 08                	jne    100169 <bread+0xb9>
    ide_rw(b);
  100161:	89 1c 24             	mov    %ebx,(%esp)
  100164:	e8 37 1f 00 00       	call   1020a0 <ide_rw>
  return b;
}
  100169:	83 c4 0c             	add    $0xc,%esp
  10016c:	89 d8                	mov    %ebx,%eax
  10016e:	5b                   	pop    %ebx
  10016f:	5e                   	pop    %esi
  100170:	5f                   	pop    %edi
  100171:	5d                   	pop    %ebp
  100172:	c3                   	ret    
      b->sector = sector;
      release(&buf_table_lock);
      return b;
    }
  }
  panic("bget: no buffers");
  100173:	c7 04 24 ae 61 10 00 	movl   $0x1061ae,(%esp)
  10017a:	e8 f1 07 00 00       	call   100970 <panic>
       b->dev == dev && b->sector == sector){
      if(b->flags & B_BUSY){
        sleep(buf, &buf_table_lock);
        goto loop;
      }
      b->flags |= B_BUSY;
  10017f:	83 c8 01             	or     $0x1,%eax
  100182:	89 03                	mov    %eax,(%ebx)
      release(&buf_table_lock);
  100184:	c7 04 24 80 98 10 00 	movl   $0x109880,(%esp)
  10018b:	e8 70 3f 00 00       	call   104100 <release>
  100190:	eb ca                	jmp    10015c <bread+0xac>
  100192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001001a0 <binit>:
// bufhead->tail is least recently used.
struct buf bufhead;

void
binit(void)
{
  1001a0:	55                   	push   %ebp
  1001a1:	89 e5                	mov    %esp,%ebp
  1001a3:	83 ec 08             	sub    $0x8,%esp
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");
  1001a6:	c7 44 24 04 bf 61 10 	movl   $0x1061bf,0x4(%esp)
  1001ad:	00 
  1001ae:	c7 04 24 80 98 10 00 	movl   $0x109880,(%esp)
  1001b5:	e8 b6 3d 00 00       	call   103f70 <initlock>

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  1001ba:	b8 70 98 10 00       	mov    $0x109870,%eax
  1001bf:	3d 80 83 10 00       	cmp    $0x108380,%eax
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  1001c4:	c7 05 6c 81 10 00 60 	movl   $0x108160,0x10816c
  1001cb:	81 10 00 
  bufhead.next = &bufhead;
  1001ce:	c7 05 70 81 10 00 60 	movl   $0x108160,0x108170
  1001d5:	81 10 00 
  for(b = buf; b < buf+NBUF; b++){
  1001d8:	76 37                	jbe    100211 <binit+0x71>
  1001da:	b8 80 83 10 00       	mov    $0x108380,%eax
  1001df:	ba 60 81 10 00       	mov    $0x108160,%edx
  1001e4:	eb 06                	jmp    1001ec <binit+0x4c>
  1001e6:	66 90                	xchg   %ax,%ax
  1001e8:	89 c2                	mov    %eax,%edx
  1001ea:	89 c8                	mov    %ecx,%eax
  1001ec:	8d 88 18 02 00 00    	lea    0x218(%eax),%ecx
  1001f2:	81 f9 70 98 10 00    	cmp    $0x109870,%ecx
    b->next = bufhead.next;
    b->prev = &bufhead;
  1001f8:	c7 40 0c 60 81 10 00 	movl   $0x108160,0xc(%eax)

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
    b->next = bufhead.next;
  1001ff:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bufhead;
    bufhead.next->prev = b;
  100202:	89 42 0c             	mov    %eax,0xc(%edx)
  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  100205:	75 e1                	jne    1001e8 <binit+0x48>
  100207:	c7 05 70 81 10 00 58 	movl   $0x109658,0x108170
  10020e:	96 10 00 
    b->next = bufhead.next;
    b->prev = &bufhead;
    bufhead.next->prev = b;
    bufhead.next = b;
  }
}
  100211:	c9                   	leave  
  100212:	c3                   	ret    
  100213:	90                   	nop    
  100214:	90                   	nop    
  100215:	90                   	nop    
  100216:	90                   	nop    
  100217:	90                   	nop    
  100218:	90                   	nop    
  100219:	90                   	nop    
  10021a:	90                   	nop    
  10021b:	90                   	nop    
  10021c:	90                   	nop    
  10021d:	90                   	nop    
  10021e:	90                   	nop    
  10021f:	90                   	nop    

00100220 <console_init>:
  return target - n;
}

void
console_init(void)
{
  100220:	55                   	push   %ebp
  100221:	89 e5                	mov    %esp,%ebp
  100223:	83 ec 08             	sub    $0x8,%esp
  initlock(&console_lock, "console");
  100226:	c7 44 24 04 c9 61 10 	movl   $0x1061c9,0x4(%esp)
  10022d:	00 
  10022e:	c7 04 24 c0 80 10 00 	movl   $0x1080c0,(%esp)
  100235:	e8 36 3d 00 00       	call   103f70 <initlock>
  initlock(&input.lock, "console input");
  10023a:	c7 44 24 04 d1 61 10 	movl   $0x1061d1,0x4(%esp)
  100241:	00 
  100242:	c7 04 24 c0 98 10 00 	movl   $0x1098c0,(%esp)
  100249:	e8 22 3d 00 00       	call   103f70 <initlock>

  devsw[CONSOLE].write = console_write;
  devsw[CONSOLE].read = console_read;
  use_console_lock = 1;

  pic_enable(IRQ_KBD);
  10024e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
console_init(void)
{
  initlock(&console_lock, "console");
  initlock(&input.lock, "console input");

  devsw[CONSOLE].write = console_write;
  100255:	c7 05 2c a3 10 00 a0 	movl   $0x1006a0,0x10a32c
  10025c:	06 10 00 
  devsw[CONSOLE].read = console_read;
  10025f:	c7 05 28 a3 10 00 90 	movl   $0x100290,0x10a328
  100266:	02 10 00 
  use_console_lock = 1;
  100269:	c7 05 a4 80 10 00 01 	movl   $0x1,0x1080a4
  100270:	00 00 00 

  pic_enable(IRQ_KBD);
  100273:	e8 58 2b 00 00       	call   102dd0 <pic_enable>
  ioapic_enable(IRQ_KBD, 0);
  100278:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10027f:	00 
  100280:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100287:	e8 14 20 00 00       	call   1022a0 <ioapic_enable>
}
  10028c:	c9                   	leave  
  10028d:	c3                   	ret    
  10028e:	66 90                	xchg   %ax,%ax

00100290 <console_read>:
  release(&input.lock);
}

int
console_read(struct inode *ip, char *dst, int n)
{
  100290:	55                   	push   %ebp
  100291:	89 e5                	mov    %esp,%ebp
  100293:	57                   	push   %edi
  100294:	56                   	push   %esi
  100295:	53                   	push   %ebx
  100296:	83 ec 0c             	sub    $0xc,%esp
  100299:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
  10029c:	8b 45 08             	mov    0x8(%ebp),%eax
  release(&input.lock);
}

int
console_read(struct inode *ip, char *dst, int n)
{
  10029f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint target;
  int c;

  iunlock(ip);
  1002a2:	89 04 24             	mov    %eax,(%esp)
  1002a5:	e8 d6 19 00 00       	call   101c80 <iunlock>
  target = n;
  1002aa:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  acquire(&input.lock);
  1002ad:	c7 04 24 c0 98 10 00 	movl   $0x1098c0,(%esp)
  1002b4:	e8 87 3e 00 00       	call   104140 <acquire>
  while(n > 0){
  1002b9:	85 db                	test   %ebx,%ebx
  1002bb:	7f 39                	jg     1002f6 <console_read+0x66>
  1002bd:	e9 cf 00 00 00       	jmp    100391 <console_read+0x101>
  1002c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1002c8:	90                   	nop    
  1002c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(cp->killed){
  1002d0:	e8 eb 31 00 00       	call   1034c0 <curproc>
  1002d5:	8b 40 1c             	mov    0x1c(%eax),%eax
  1002d8:	85 c0                	test   %eax,%eax
  1002da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1002e0:	75 56                	jne    100338 <console_read+0xa8>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  1002e2:	c7 44 24 04 c0 98 10 	movl   $0x1098c0,0x4(%esp)
  1002e9:	00 
  1002ea:	c7 04 24 74 99 10 00 	movl   $0x109974,(%esp)
  1002f1:	e8 2a 34 00 00       	call   103720 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  1002f6:	8b 15 74 99 10 00    	mov    0x109974,%edx
  1002fc:	3b 15 78 99 10 00    	cmp    0x109978,%edx
  100302:	74 c4                	je     1002c8 <console_read+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  100304:	89 d0                	mov    %edx,%eax
  100306:	83 e0 7f             	and    $0x7f,%eax
  100309:	0f b6 88 f4 98 10 00 	movzbl 0x1098f4(%eax),%ecx
  100310:	8d 42 01             	lea    0x1(%edx),%eax
  100313:	a3 74 99 10 00       	mov    %eax,0x109974
  100318:	0f be f1             	movsbl %cl,%esi
    if(c == C('D')){  // EOF
  10031b:	83 fe 04             	cmp    $0x4,%esi
  10031e:	74 3e                	je     10035e <console_read+0xce>
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
  100320:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
  100323:	83 fe 0a             	cmp    $0xa,%esi
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100326:	88 0f                	mov    %cl,(%edi)
    --n;
    if(c == '\n')
  100328:	74 3f                	je     100369 <console_read+0xd9>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  10032a:	85 db                	test   %ebx,%ebx
  10032c:	7e 3b                	jle    100369 <console_read+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  10032e:	83 c7 01             	add    $0x1,%edi
  100331:	eb c3                	jmp    1002f6 <console_read+0x66>
  100333:	90                   	nop    
  100334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
  100338:	c7 04 24 c0 98 10 00 	movl   $0x1098c0,(%esp)
        ilock(ip);
  10033f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
  100344:	e8 b7 3d 00 00       	call   104100 <release>
        ilock(ip);
  100349:	8b 45 08             	mov    0x8(%ebp),%eax
  10034c:	89 04 24             	mov    %eax,(%esp)
  10034f:	e8 ac 19 00 00       	call   101d00 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  100354:	83 c4 0c             	add    $0xc,%esp
  100357:	89 d8                	mov    %ebx,%eax
  100359:	5b                   	pop    %ebx
  10035a:	5e                   	pop    %esi
  10035b:	5f                   	pop    %edi
  10035c:	5d                   	pop    %ebp
  10035d:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  10035e:	39 5d f0             	cmp    %ebx,-0x10(%ebp)
  100361:	76 06                	jbe    100369 <console_read+0xd9>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  100363:	89 15 74 99 10 00    	mov    %edx,0x109974
  100369:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10036c:	29 d8                	sub    %ebx,%eax
  10036e:	89 c3                	mov    %eax,%ebx
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  100370:	c7 04 24 c0 98 10 00 	movl   $0x1098c0,(%esp)
  100377:	e8 84 3d 00 00       	call   104100 <release>
  ilock(ip);
  10037c:	8b 45 08             	mov    0x8(%ebp),%eax
  10037f:	89 04 24             	mov    %eax,(%esp)
  100382:	e8 79 19 00 00       	call   101d00 <ilock>

  return target - n;
}
  100387:	83 c4 0c             	add    $0xc,%esp
  10038a:	89 d8                	mov    %ebx,%eax
  10038c:	5b                   	pop    %ebx
  10038d:	5e                   	pop    %esi
  10038e:	5f                   	pop    %edi
  10038f:	5d                   	pop    %ebp
  100390:	c3                   	ret    

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  100391:	31 db                	xor    %ebx,%ebx
  100393:	eb db                	jmp    100370 <console_read+0xe0>
  100395:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001003a0 <cons_putc>:
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  1003a0:	55                   	push   %ebp
  1003a1:	89 e5                	mov    %esp,%ebp
  1003a3:	57                   	push   %edi
  1003a4:	56                   	push   %esi
  1003a5:	53                   	push   %ebx
  1003a6:	83 ec 0c             	sub    $0xc,%esp
  if(panicked){
  1003a9:	8b 15 a0 80 10 00    	mov    0x1080a0,%edx
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  1003af:	8b 75 08             	mov    0x8(%ebp),%esi
  if(panicked){
  1003b2:	85 d2                	test   %edx,%edx
  1003b4:	0f 85 e6 00 00 00    	jne    1004a0 <cons_putc+0x100>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003ba:	ba 79 03 00 00       	mov    $0x379,%edx
  1003bf:	ec                   	in     (%dx),%al
}

static inline void
cli(void)
{
  asm volatile("cli");
  1003c0:	31 db                	xor    %ebx,%ebx
static void
lpt_putc(int c)
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
  1003c2:	84 c0                	test   %al,%al
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003c4:	b9 79 03 00 00       	mov    $0x379,%ecx
  1003c9:	79 10                	jns    1003db <cons_putc+0x3b>
  1003cb:	eb 15                	jmp    1003e2 <cons_putc+0x42>
  1003cd:	8d 76 00             	lea    0x0(%esi),%esi
  1003d0:	83 c3 01             	add    $0x1,%ebx
  1003d3:	81 fb 00 32 00 00    	cmp    $0x3200,%ebx
  1003d9:	74 07                	je     1003e2 <cons_putc+0x42>
  1003db:	89 ca                	mov    %ecx,%edx
  1003dd:	ec                   	in     (%dx),%al
  1003de:	84 c0                	test   %al,%al
  1003e0:	79 ee                	jns    1003d0 <cons_putc+0x30>
    ;
  if(c == BACKSPACE)
  1003e2:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  1003e8:	89 f0                	mov    %esi,%eax
  1003ea:	0f 84 b3 00 00 00    	je     1004a3 <cons_putc+0x103>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1003f0:	ba 78 03 00 00       	mov    $0x378,%edx
  1003f5:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003f6:	b8 0d 00 00 00       	mov    $0xd,%eax
  1003fb:	b2 7a                	mov    $0x7a,%dl
  1003fd:	ee                   	out    %al,(%dx)
  1003fe:	b8 08 00 00 00       	mov    $0x8,%eax
  100403:	ee                   	out    %al,(%dx)
  100404:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  100409:	b8 0e 00 00 00       	mov    $0xe,%eax
  10040e:	89 ca                	mov    %ecx,%edx
  100410:	ee                   	out    %al,(%dx)
  100411:	bf d5 03 00 00       	mov    $0x3d5,%edi
  100416:	89 fa                	mov    %edi,%edx
  100418:	ec                   	in     (%dx),%al
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  100419:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10041c:	89 ca                	mov    %ecx,%edx
  10041e:	c1 e3 08             	shl    $0x8,%ebx
  100421:	b8 0f 00 00 00       	mov    $0xf,%eax
  100426:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100427:	89 fa                	mov    %edi,%edx
  100429:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  10042a:	0f b6 c0             	movzbl %al,%eax
  10042d:	09 c3                	or     %eax,%ebx

  if(c == '\n')
  10042f:	83 fe 0a             	cmp    $0xa,%esi
  100432:	0f 84 d9 00 00 00    	je     100511 <cons_putc+0x171>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  100438:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  10043e:	0f 84 b3 00 00 00    	je     1004f7 <cons_putc+0x157>
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  100444:	89 f0                	mov    %esi,%eax
  100446:	66 25 ff 00          	and    $0xff,%ax
  10044a:	80 cc 07             	or     $0x7,%ah
  10044d:	66 89 84 1b 00 80 0b 	mov    %ax,0xb8000(%ebx,%ebx,1)
  100454:	00 
  100455:	83 c3 01             	add    $0x1,%ebx
  
  if((pos/80) >= 24){  // Scroll up.
  100458:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  10045e:	7f 4d                	jg     1004ad <cons_putc+0x10d>
  100460:	8d 34 1b             	lea    (%ebx,%ebx,1),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100463:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  100468:	b8 0e 00 00 00       	mov    $0xe,%eax
  10046d:	89 ca                	mov    %ecx,%edx
  10046f:	ee                   	out    %al,(%dx)
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  100470:	bf d5 03 00 00       	mov    $0x3d5,%edi
  100475:	89 d8                	mov    %ebx,%eax
  100477:	c1 f8 08             	sar    $0x8,%eax
  10047a:	89 fa                	mov    %edi,%edx
  10047c:	ee                   	out    %al,(%dx)
  10047d:	b8 0f 00 00 00       	mov    $0xf,%eax
  100482:	89 ca                	mov    %ecx,%edx
  100484:	ee                   	out    %al,(%dx)
  100485:	89 d8                	mov    %ebx,%eax
  100487:	89 fa                	mov    %edi,%edx
  100489:	ee                   	out    %al,(%dx)
  10048a:	66 c7 86 00 80 0b 00 	movw   $0x720,0xb8000(%esi)
  100491:	20 07 
      ;
  }

  lpt_putc(c);
  cga_putc(c);
}
  100493:	83 c4 0c             	add    $0xc,%esp
  100496:	5b                   	pop    %ebx
  100497:	5e                   	pop    %esi
  100498:	5f                   	pop    %edi
  100499:	5d                   	pop    %ebp
  10049a:	c3                   	ret    
  10049b:	90                   	nop    
  10049c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
cli(void)
{
  asm volatile("cli");
  1004a0:	fa                   	cli    
  1004a1:	eb fe                	jmp    1004a1 <cons_putc+0x101>
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
    ;
  if(c == BACKSPACE)
  1004a3:	b8 08 00 00 00       	mov    $0x8,%eax
  1004a8:	e9 43 ff ff ff       	jmp    1003f0 <cons_putc+0x50>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
  1004ad:	83 eb 50             	sub    $0x50,%ebx
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  1004b0:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
  1004b7:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  1004b8:	8d 34 1b             	lea    (%ebx,%ebx,1),%esi
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  1004bb:	c7 44 24 04 a0 80 0b 	movl   $0xb80a0,0x4(%esp)
  1004c2:	00 
  1004c3:	c7 04 24 00 80 0b 00 	movl   $0xb8000,(%esp)
  1004ca:	e8 71 3d 00 00       	call   104240 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  1004cf:	b8 80 07 00 00       	mov    $0x780,%eax
  1004d4:	29 d8                	sub    %ebx,%eax
  1004d6:	01 c0                	add    %eax,%eax
  1004d8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1004dc:	8d 86 00 80 0b 00    	lea    0xb8000(%esi),%eax
  1004e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1004e9:	00 
  1004ea:	89 04 24             	mov    %eax,(%esp)
  1004ed:	e8 be 3c 00 00       	call   1041b0 <memset>
  1004f2:	e9 6c ff ff ff       	jmp    100463 <cons_putc+0xc3>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
  1004f7:	85 db                	test   %ebx,%ebx
  1004f9:	0f 8e 61 ff ff ff    	jle    100460 <cons_putc+0xc0>
      crt[--pos] = ' ' | 0x0700;
  1004ff:	83 eb 01             	sub    $0x1,%ebx
  100502:	66 c7 84 1b 00 80 0b 	movw   $0x720,0xb8000(%ebx,%ebx,1)
  100509:	00 20 07 
  10050c:	e9 47 ff ff ff       	jmp    100458 <cons_putc+0xb8>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  100511:	89 d8                	mov    %ebx,%eax
  100513:	ba 67 66 66 66       	mov    $0x66666667,%edx
  100518:	f7 ea                	imul   %edx
  10051a:	c1 ea 05             	shr    $0x5,%edx
  10051d:	8d 14 92             	lea    (%edx,%edx,4),%edx
  100520:	c1 e2 04             	shl    $0x4,%edx
  100523:	8d 5a 50             	lea    0x50(%edx),%ebx
  100526:	e9 2d ff ff ff       	jmp    100458 <cons_putc+0xb8>
  10052b:	90                   	nop    
  10052c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100530 <console_intr>:

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  100530:	55                   	push   %ebp
  100531:	89 e5                	mov    %esp,%ebp
  100533:	57                   	push   %edi
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  100534:	bf f0 98 10 00       	mov    $0x1098f0,%edi

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  100539:	56                   	push   %esi
  10053a:	53                   	push   %ebx
  10053b:	83 ec 0c             	sub    $0xc,%esp
  10053e:	8b 75 08             	mov    0x8(%ebp),%esi
  int c;

  acquire(&input.lock);
  100541:	c7 04 24 c0 98 10 00 	movl   $0x1098c0,(%esp)
  100548:	e8 f3 3b 00 00       	call   104140 <acquire>
  10054d:	8d 76 00             	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
  100550:	ff d6                	call   *%esi
  100552:	85 c0                	test   %eax,%eax
  100554:	89 c3                	mov    %eax,%ebx
  100556:	0f 88 a4 00 00 00    	js     100600 <console_intr+0xd0>
    switch(c){
  10055c:	83 fb 10             	cmp    $0x10,%ebx
  10055f:	90                   	nop    
  100560:	0f 84 f2 00 00 00    	je     100658 <console_intr+0x128>
  100566:	83 fb 15             	cmp    $0x15,%ebx
  100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100570:	0f 84 c9 00 00 00    	je     10063f <console_intr+0x10f>
  100576:	83 fb 08             	cmp    $0x8,%ebx
  100579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100580:	0f 84 e2 00 00 00    	je     100668 <console_intr+0x138>
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  100586:	85 db                	test   %ebx,%ebx
  100588:	74 c6                	je     100550 <console_intr+0x20>
  10058a:	8b 15 7c 99 10 00    	mov    0x10997c,%edx
  100590:	89 d0                	mov    %edx,%eax
  100592:	2b 05 74 99 10 00    	sub    0x109974,%eax
  100598:	83 f8 7f             	cmp    $0x7f,%eax
  10059b:	77 b3                	ja     100550 <console_intr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
  10059d:	89 d0                	mov    %edx,%eax
  10059f:	83 e0 7f             	and    $0x7f,%eax
  1005a2:	88 5c 07 04          	mov    %bl,0x4(%edi,%eax,1)
  1005a6:	8d 42 01             	lea    0x1(%edx),%eax
  1005a9:	a3 7c 99 10 00       	mov    %eax,0x10997c
        cons_putc(c);
  1005ae:	89 1c 24             	mov    %ebx,(%esp)
  1005b1:	e8 ea fd ff ff       	call   1003a0 <cons_putc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  1005b6:	83 fb 0a             	cmp    $0xa,%ebx
  1005b9:	0f 84 d3 00 00 00    	je     100692 <console_intr+0x162>
  1005bf:	83 fb 04             	cmp    $0x4,%ebx
  1005c2:	0f 84 ca 00 00 00    	je     100692 <console_intr+0x162>
  1005c8:	a1 74 99 10 00       	mov    0x109974,%eax
  1005cd:	8b 15 7c 99 10 00    	mov    0x10997c,%edx
  1005d3:	83 e8 80             	sub    $0xffffff80,%eax
  1005d6:	39 c2                	cmp    %eax,%edx
  1005d8:	0f 85 72 ff ff ff    	jne    100550 <console_intr+0x20>
          input.w = input.e;
  1005de:	89 15 78 99 10 00    	mov    %edx,0x109978
          wakeup(&input.r);
  1005e4:	c7 04 24 74 99 10 00 	movl   $0x109974,(%esp)
  1005eb:	e8 50 2e 00 00       	call   103440 <wakeup>
console_intr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  1005f0:	ff d6                	call   *%esi
  1005f2:	85 c0                	test   %eax,%eax
  1005f4:	89 c3                	mov    %eax,%ebx
  1005f6:	0f 89 60 ff ff ff    	jns    10055c <console_intr+0x2c>
  1005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&input.lock);
  100600:	c7 45 08 c0 98 10 00 	movl   $0x1098c0,0x8(%ebp)
}
  100607:	83 c4 0c             	add    $0xc,%esp
  10060a:	5b                   	pop    %ebx
  10060b:	5e                   	pop    %esi
  10060c:	5f                   	pop    %edi
  10060d:	5d                   	pop    %ebp
        }
      }
      break;
    }
  }
  release(&input.lock);
  10060e:	e9 ed 3a 00 00       	jmp    104100 <release>
  100613:	90                   	nop    
  100614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  100618:	8d 50 ff             	lea    -0x1(%eax),%edx
  10061b:	89 d0                	mov    %edx,%eax
  10061d:	83 e0 7f             	and    $0x7f,%eax
  100620:	80 b8 f4 98 10 00 0a 	cmpb   $0xa,0x1098f4(%eax)
  100627:	0f 84 23 ff ff ff    	je     100550 <console_intr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  10062d:	89 15 7c 99 10 00    	mov    %edx,0x10997c
        cons_putc(BACKSPACE);
  100633:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  10063a:	e8 61 fd ff ff       	call   1003a0 <cons_putc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  10063f:	a1 7c 99 10 00       	mov    0x10997c,%eax
  100644:	3b 05 78 99 10 00    	cmp    0x109978,%eax
  10064a:	75 cc                	jne    100618 <console_intr+0xe8>
  10064c:	e9 ff fe ff ff       	jmp    100550 <console_intr+0x20>
  100651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  100658:	e8 83 2c 00 00       	call   1032e0 <procdump>
  10065d:	8d 76 00             	lea    0x0(%esi),%esi
  100660:	e9 eb fe ff ff       	jmp    100550 <console_intr+0x20>
  100665:	8d 76 00             	lea    0x0(%esi),%esi
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e != input.w){
  100668:	a1 7c 99 10 00       	mov    0x10997c,%eax
  10066d:	3b 05 78 99 10 00    	cmp    0x109978,%eax
  100673:	0f 84 d7 fe ff ff    	je     100550 <console_intr+0x20>
        input.e--;
  100679:	83 e8 01             	sub    $0x1,%eax
  10067c:	a3 7c 99 10 00       	mov    %eax,0x10997c
        cons_putc(BACKSPACE);
  100681:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  100688:	e8 13 fd ff ff       	call   1003a0 <cons_putc>
  10068d:	e9 be fe ff ff       	jmp    100550 <console_intr+0x20>
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        cons_putc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100692:	8b 15 7c 99 10 00    	mov    0x10997c,%edx
  100698:	e9 41 ff ff ff       	jmp    1005de <console_intr+0xae>
  10069d:	8d 76 00             	lea    0x0(%esi),%esi

001006a0 <console_write>:
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  1006a0:	55                   	push   %ebp
  1006a1:	89 e5                	mov    %esp,%ebp
  1006a3:	57                   	push   %edi
  1006a4:	56                   	push   %esi
  1006a5:	53                   	push   %ebx
  1006a6:	83 ec 0c             	sub    $0xc,%esp
  int i;

  iunlock(ip);
  1006a9:	8b 45 08             	mov    0x8(%ebp),%eax
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  1006ac:	8b 75 10             	mov    0x10(%ebp),%esi
  1006af:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
  1006b2:	89 04 24             	mov    %eax,(%esp)
  1006b5:	e8 c6 15 00 00       	call   101c80 <iunlock>
  acquire(&console_lock);
  1006ba:	c7 04 24 c0 80 10 00 	movl   $0x1080c0,(%esp)
  1006c1:	e8 7a 3a 00 00       	call   104140 <acquire>
  for(i = 0; i < n; i++)
  1006c6:	85 f6                	test   %esi,%esi
  1006c8:	7e 19                	jle    1006e3 <console_write+0x43>
  1006ca:	31 db                	xor    %ebx,%ebx
  1006cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cons_putc(buf[i] & 0xff);
  1006d0:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  1006d4:	83 c3 01             	add    $0x1,%ebx
    cons_putc(buf[i] & 0xff);
  1006d7:	89 04 24             	mov    %eax,(%esp)
  1006da:	e8 c1 fc ff ff       	call   1003a0 <cons_putc>
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  1006df:	39 de                	cmp    %ebx,%esi
  1006e1:	7f ed                	jg     1006d0 <console_write+0x30>
    cons_putc(buf[i] & 0xff);
  release(&console_lock);
  1006e3:	c7 04 24 c0 80 10 00 	movl   $0x1080c0,(%esp)
  1006ea:	e8 11 3a 00 00       	call   104100 <release>
  ilock(ip);
  1006ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1006f2:	89 04 24             	mov    %eax,(%esp)
  1006f5:	e8 06 16 00 00       	call   101d00 <ilock>

  return n;
}
  1006fa:	83 c4 0c             	add    $0xc,%esp
  1006fd:	89 f0                	mov    %esi,%eax
  1006ff:	5b                   	pop    %ebx
  100700:	5e                   	pop    %esi
  100701:	5f                   	pop    %edi
  100702:	5d                   	pop    %ebp
  100703:	c3                   	ret    
  100704:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10070a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100710 <printint>:
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  100710:	55                   	push   %ebp
  100711:	89 e5                	mov    %esp,%ebp
  100713:	57                   	push   %edi
  100714:	56                   	push   %esi
  100715:	53                   	push   %ebx
  100716:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  100719:	8b 5d 10             	mov    0x10(%ebp),%ebx
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  10071c:	8b 45 08             	mov    0x8(%ebp),%eax
  10071f:	8b 75 0c             	mov    0xc(%ebp),%esi
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  100722:	85 db                	test   %ebx,%ebx
  100724:	74 04                	je     10072a <printint+0x1a>
  100726:	85 c0                	test   %eax,%eax
  100728:	78 5c                	js     100786 <printint+0x76>
    neg = 1;
    x = 0 - xx;
  } else {
    x = xx;
  10072a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  100731:	31 db                	xor    %ebx,%ebx
  100733:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  100736:	66 90                	xchg   %ax,%ax
  }

  do{
    buf[i++] = digits[x % base];
  100738:	31 d2                	xor    %edx,%edx
  10073a:	f7 f6                	div    %esi
  10073c:	89 c1                	mov    %eax,%ecx
  10073e:	0f b6 82 f9 61 10 00 	movzbl 0x1061f9(%edx),%eax
  100745:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  100748:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
  10074b:	85 c9                	test   %ecx,%ecx
  10074d:	89 c8                	mov    %ecx,%eax
  10074f:	75 e7                	jne    100738 <printint+0x28>
  if(neg)
  100751:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  100754:	85 c9                	test   %ecx,%ecx
  100756:	74 08                	je     100760 <printint+0x50>
    buf[i++] = '-';
  100758:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
  10075d:	83 c3 01             	add    $0x1,%ebx

  while(--i >= 0)
  100760:	8d 73 ff             	lea    -0x1(%ebx),%esi
  100763:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
  100766:	66 90                	xchg   %ax,%ax
    cons_putc(buf[i]);
  100768:	0f be 03             	movsbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  10076b:	83 ee 01             	sub    $0x1,%esi
  10076e:	83 eb 01             	sub    $0x1,%ebx
    cons_putc(buf[i]);
  100771:	89 04 24             	mov    %eax,(%esp)
  100774:	e8 27 fc ff ff       	call   1003a0 <cons_putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  100779:	83 fe ff             	cmp    $0xffffffff,%esi
  10077c:	75 ea                	jne    100768 <printint+0x58>
    cons_putc(buf[i]);
}
  10077e:	83 c4 1c             	add    $0x1c,%esp
  100781:	5b                   	pop    %ebx
  100782:	5e                   	pop    %esi
  100783:	5f                   	pop    %edi
  100784:	5d                   	pop    %ebp
  100785:	c3                   	ret    
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = 0 - xx;
  100786:	f7 d8                	neg    %eax
  100788:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
  10078f:	eb a0                	jmp    100731 <printint+0x21>
  100791:	eb 0d                	jmp    1007a0 <cprintf>
  100793:	90                   	nop    
  100794:	90                   	nop    
  100795:	90                   	nop    
  100796:	90                   	nop    
  100797:	90                   	nop    
  100798:	90                   	nop    
  100799:	90                   	nop    
  10079a:	90                   	nop    
  10079b:	90                   	nop    
  10079c:	90                   	nop    
  10079d:	90                   	nop    
  10079e:	90                   	nop    
  10079f:	90                   	nop    

001007a0 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  1007a0:	55                   	push   %ebp
  1007a1:	89 e5                	mov    %esp,%ebp
  1007a3:	57                   	push   %edi
  1007a4:	56                   	push   %esi
  1007a5:	53                   	push   %ebx
  1007a6:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  1007a9:	a1 a4 80 10 00       	mov    0x1080a4,%eax
  if(locking)
  1007ae:	85 c0                	test   %eax,%eax
{
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  1007b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(locking)
  1007b3:	0f 85 8f 01 00 00    	jne    100948 <cprintf+0x1a8>
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1007b9:	8b 55 08             	mov    0x8(%ebp),%edx
  1007bc:	0f b6 02             	movzbl (%edx),%eax
  1007bf:	84 c0                	test   %al,%al
  1007c1:	0f 84 89 00 00 00    	je     100850 <cprintf+0xb0>

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  1007c7:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1007ca:	89 d7                	mov    %edx,%edi
  1007cc:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  1007cf:	31 f6                	xor    %esi,%esi
  1007d1:	eb 20                	jmp    1007f3 <cprintf+0x53>
  1007d3:	90                   	nop    
  1007d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  1007d8:	83 fb 25             	cmp    $0x25,%ebx
  1007db:	0f 85 8f 00 00 00    	jne    100870 <cprintf+0xd0>
  1007e1:	be 25 00 00 00       	mov    $0x25,%esi
  1007e6:	66 90                	xchg   %ax,%ax
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1007e8:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  1007ec:	83 c7 01             	add    $0x1,%edi
  1007ef:	84 c0                	test   %al,%al
  1007f1:	74 5d                	je     100850 <cprintf+0xb0>
    c = fmt[i] & 0xff;
    switch(state){
  1007f3:	85 f6                	test   %esi,%esi
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
  1007f5:	0f b6 d8             	movzbl %al,%ebx
    switch(state){
  1007f8:	74 de                	je     1007d8 <cprintf+0x38>
  1007fa:	83 fe 25             	cmp    $0x25,%esi
  1007fd:	75 e9                	jne    1007e8 <cprintf+0x48>
      else
        cons_putc(c);
      break;
    
    case '%':
      switch(c){
  1007ff:	83 fb 70             	cmp    $0x70,%ebx
  100802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100808:	0f 84 84 00 00 00    	je     100892 <cprintf+0xf2>
  10080e:	66 90                	xchg   %ax,%ax
  100810:	7f 6e                	jg     100880 <cprintf+0xe0>
  100812:	83 fb 25             	cmp    $0x25,%ebx
  100815:	8d 76 00             	lea    0x0(%esi),%esi
  100818:	0f 84 12 01 00 00    	je     100930 <cprintf+0x190>
  10081e:	83 fb 64             	cmp    $0x64,%ebx
  100821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100828:	0f 84 d2 00 00 00    	je     100900 <cprintf+0x160>
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  10082e:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
        cons_putc(c);
  100835:	31 f6                	xor    %esi,%esi
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  100837:	e8 64 fb ff ff       	call   1003a0 <cons_putc>
        cons_putc(c);
  10083c:	89 1c 24             	mov    %ebx,(%esp)
  10083f:	e8 5c fb ff ff       	call   1003a0 <cons_putc>
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100844:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  100848:	83 c7 01             	add    $0x1,%edi
  10084b:	84 c0                	test   %al,%al
  10084d:	75 a4                	jne    1007f3 <cprintf+0x53>
  10084f:	90                   	nop    
      state = 0;
      break;
    }
  }

  if(locking)
  100850:	8b 75 ec             	mov    -0x14(%ebp),%esi
  100853:	85 f6                	test   %esi,%esi
  100855:	74 0c                	je     100863 <cprintf+0xc3>
    release(&console_lock);
  100857:	c7 04 24 c0 80 10 00 	movl   $0x1080c0,(%esp)
  10085e:	e8 9d 38 00 00       	call   104100 <release>
}
  100863:	83 c4 1c             	add    $0x1c,%esp
  100866:	5b                   	pop    %ebx
  100867:	5e                   	pop    %esi
  100868:	5f                   	pop    %edi
  100869:	5d                   	pop    %ebp
  10086a:	c3                   	ret    
  10086b:	90                   	nop    
  10086c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(state){
    case 0:
      if(c == '%')
        state = '%';
      else
        cons_putc(c);
  100870:	89 1c 24             	mov    %ebx,(%esp)
  100873:	e8 28 fb ff ff       	call   1003a0 <cons_putc>
  100878:	e9 6b ff ff ff       	jmp    1007e8 <cprintf+0x48>
  10087d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    
    case '%':
      switch(c){
  100880:	83 fb 73             	cmp    $0x73,%ebx
  100883:	90                   	nop    
  100884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100888:	74 36                	je     1008c0 <cprintf+0x120>
  10088a:	83 fb 78             	cmp    $0x78,%ebx
  10088d:	8d 76 00             	lea    0x0(%esi),%esi
  100890:	75 9c                	jne    10082e <cprintf+0x8e>
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  100892:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100895:	31 f6                	xor    %esi,%esi
  100897:	8b 01                	mov    (%ecx),%eax
  100899:	83 c1 04             	add    $0x4,%ecx
  10089c:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  10089f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1008a6:	00 
  1008a7:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  1008ae:	00 
  1008af:	89 04 24             	mov    %eax,(%esp)
  1008b2:	e8 59 fe ff ff       	call   100710 <printint>
  1008b7:	e9 2c ff ff ff       	jmp    1007e8 <cprintf+0x48>
  1008bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        break;
      case 's':
        s = (char*)*argp++;
  1008c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1008c3:	8b 18                	mov    (%eax),%ebx
  1008c5:	83 c0 04             	add    $0x4,%eax
  1008c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if(s == 0)
  1008cb:	85 db                	test   %ebx,%ebx
  1008cd:	0f 84 8a 00 00 00    	je     10095d <cprintf+0x1bd>
          s = "(null)";
        for(; *s; s++)
  1008d3:	0f b6 03             	movzbl (%ebx),%eax
  1008d6:	84 c0                	test   %al,%al
  1008d8:	74 1b                	je     1008f5 <cprintf+0x155>
  1008da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          cons_putc(*s);
  1008e0:	0f be c0             	movsbl %al,%eax
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  1008e3:	83 c3 01             	add    $0x1,%ebx
          cons_putc(*s);
  1008e6:	89 04 24             	mov    %eax,(%esp)
  1008e9:	e8 b2 fa ff ff       	call   1003a0 <cons_putc>
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  1008ee:	0f b6 03             	movzbl (%ebx),%eax
  1008f1:	84 c0                	test   %al,%al
  1008f3:	75 eb                	jne    1008e0 <cprintf+0x140>
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
  1008f5:	31 f6                	xor    %esi,%esi
  1008f7:	e9 ec fe ff ff       	jmp    1007e8 <cprintf+0x48>
  1008fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    
    case '%':
      switch(c){
      case 'd':
        printint(*argp++, 10, 1);
  100900:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100903:	31 f6                	xor    %esi,%esi
  100905:	8b 02                	mov    (%edx),%eax
  100907:	83 c2 04             	add    $0x4,%edx
  10090a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10090d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  100914:	00 
  100915:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  10091c:	00 
  10091d:	89 04 24             	mov    %eax,(%esp)
  100920:	e8 eb fd ff ff       	call   100710 <printint>
  100925:	e9 be fe ff ff       	jmp    1007e8 <cprintf+0x48>
  10092a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
  100930:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  100937:	31 f6                	xor    %esi,%esi
  100939:	e8 62 fa ff ff       	call   1003a0 <cons_putc>
  10093e:	66 90                	xchg   %ax,%ax
  100940:	e9 a3 fe ff ff       	jmp    1007e8 <cprintf+0x48>
  100945:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);
  100948:	c7 04 24 c0 80 10 00 	movl   $0x1080c0,(%esp)
  10094f:	e8 ec 37 00 00       	call   104140 <acquire>
  100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100958:	e9 5c fe ff ff       	jmp    1007b9 <cprintf+0x19>
      case 'p':
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
  10095d:	bb df 61 10 00       	mov    $0x1061df,%ebx
  100962:	e9 6c ff ff ff       	jmp    1008d3 <cprintf+0x133>
  100967:	89 f6                	mov    %esi,%esi
  100969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100970 <panic>:
  ioapic_enable(IRQ_KBD, 0);
}

void
panic(char *s)
{
  100970:	55                   	push   %ebp
  100971:	89 e5                	mov    %esp,%ebp
  100973:	53                   	push   %ebx
  100974:	83 ec 44             	sub    $0x44,%esp
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  100977:	fa                   	cli    
  use_console_lock = 0;
  100978:	c7 05 a4 80 10 00 00 	movl   $0x0,0x1080a4
  10097f:	00 00 00 
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  100982:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  100985:	e8 a6 1f 00 00       	call   102930 <cpu>
  10098a:	c7 04 24 e6 61 10 00 	movl   $0x1061e6,(%esp)
  100991:	89 44 24 04          	mov    %eax,0x4(%esp)
  100995:	e8 06 fe ff ff       	call   1007a0 <cprintf>
  cprintf(s);
  10099a:	8b 45 08             	mov    0x8(%ebp),%eax
  10099d:	89 04 24             	mov    %eax,(%esp)
  1009a0:	e8 fb fd ff ff       	call   1007a0 <cprintf>
  cprintf("\n");
  1009a5:	c7 04 24 33 66 10 00 	movl   $0x106633,(%esp)
  1009ac:	e8 ef fd ff ff       	call   1007a0 <cprintf>
  getcallerpcs(&s, pcs);
  1009b1:	8d 45 08             	lea    0x8(%ebp),%eax
  1009b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1009b8:	89 04 24             	mov    %eax,(%esp)
  1009bb:	e8 d0 35 00 00       	call   103f90 <getcallerpcs>
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  1009c0:	8b 03                	mov    (%ebx),%eax
  1009c2:	83 c3 04             	add    $0x4,%ebx
  1009c5:	c7 04 24 f5 61 10 00 	movl   $0x1061f5,(%esp)
  1009cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d0:	e8 cb fd ff ff       	call   1007a0 <cprintf>
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  1009d5:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1009d8:	39 c3                	cmp    %eax,%ebx
  1009da:	75 e4                	jne    1009c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  1009dc:	c7 05 a0 80 10 00 01 	movl   $0x1,0x1080a0
  1009e3:	00 00 00 
  1009e6:	eb fe                	jmp    1009e6 <panic+0x76>
  1009e8:	90                   	nop    
  1009e9:	90                   	nop    
  1009ea:	90                   	nop    
  1009eb:	90                   	nop    
  1009ec:	90                   	nop    
  1009ed:	90                   	nop    
  1009ee:	90                   	nop    
  1009ef:	90                   	nop    

001009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  1009f0:	55                   	push   %ebp
  1009f1:	89 e5                	mov    %esp,%ebp
  1009f3:	57                   	push   %edi
  1009f4:	56                   	push   %esi
  1009f5:	53                   	push   %ebx
  1009f6:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
  uint sz, sp, argp;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
  1009fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1009ff:	89 04 24             	mov    %eax,(%esp)
  100a02:	e8 a9 15 00 00       	call   101fb0 <namei>
  100a07:	89 c6                	mov    %eax,%esi
  100a09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100a0e:	85 f6                	test   %esi,%esi
  100a10:	74 48                	je     100a5a <exec+0x6a>
    return -1;
  ilock(ip);
  100a12:	89 34 24             	mov    %esi,(%esp)
  100a15:	e8 e6 12 00 00       	call   101d00 <ilock>
  // Compute memory size of new process.
  mem = 0;
  sz = 0;

  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  100a1a:	8d 45 a0             	lea    -0x60(%ebp),%eax
  100a1d:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  100a24:	00 
  100a25:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100a2c:	00 
  100a2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a31:	89 34 24             	mov    %esi,(%esp)
  100a34:	e8 47 0a 00 00       	call   101480 <readi>
  100a39:	83 f8 33             	cmp    $0x33,%eax
  100a3c:	76 09                	jbe    100a47 <exec+0x57>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  100a3e:	81 7d a0 7f 45 4c 46 	cmpl   $0x464c457f,-0x60(%ebp)
  100a45:	74 21                	je     100a68 <exec+0x78>
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  100a47:	89 34 24             	mov    %esi,(%esp)
  100a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100a50:	e8 8b 12 00 00       	call   101ce0 <iunlockput>
  100a55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  100a5a:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  100a60:	5b                   	pop    %ebx
  100a61:	5e                   	pop    %esi
  100a62:	5f                   	pop    %edi
  100a63:	5d                   	pop    %ebp
  100a64:	c3                   	ret    
  100a65:	8d 76 00             	lea    0x0(%esi),%esi
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a68:	66 83 7d cc 00       	cmpw   $0x0,-0x34(%ebp)
  100a6d:	8b 7d bc             	mov    -0x44(%ebp),%edi
  100a70:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
  100a77:	74 67                	je     100ae0 <exec+0xf0>
  100a79:	31 db                	xor    %ebx,%ebx
  100a7b:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
  100a82:	eb 0f                	jmp    100a93 <exec+0xa3>
  100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100a88:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
  100a8c:	83 c3 01             	add    $0x1,%ebx
  100a8f:	39 d8                	cmp    %ebx,%eax
  100a91:	7e 4d                	jle    100ae0 <exec+0xf0>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100a93:	89 d8                	mov    %ebx,%eax
  100a95:	c1 e0 05             	shl    $0x5,%eax
  100a98:	01 f8                	add    %edi,%eax
  100a9a:	8d 55 d4             	lea    -0x2c(%ebp),%edx
  100a9d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  100aa4:	00 
  100aa5:	89 44 24 08          	mov    %eax,0x8(%esp)
  100aa9:	89 54 24 04          	mov    %edx,0x4(%esp)
  100aad:	89 34 24             	mov    %esi,(%esp)
  100ab0:	e8 cb 09 00 00       	call   101480 <readi>
  100ab5:	83 f8 20             	cmp    $0x20,%eax
  100ab8:	75 8d                	jne    100a47 <exec+0x57>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100aba:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
  100abe:	75 c8                	jne    100a88 <exec+0x98>
      continue;
    if(ph.memsz < ph.filesz)
  100ac0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ac3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  100ac6:	66 90                	xchg   %ax,%ax
  100ac8:	0f 82 79 ff ff ff    	jb     100a47 <exec+0x57>
      goto bad;
    sz += ph.memsz;
  100ace:	01 45 80             	add    %eax,-0x80(%ebp)
  100ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100ad8:	eb ae                	jmp    100a88 <exec+0x98>
  100ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ae0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100ae3:	31 db                	xor    %ebx,%ebx
  100ae5:	b8 04 00 00 00       	mov    $0x4,%eax
  100aea:	c7 85 7c ff ff ff 00 	movl   $0x0,-0x84(%ebp)
  100af1:	00 00 00 
  100af4:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%ebp)
  100afb:	8b 11                	mov    (%ecx),%edx
  100afd:	85 d2                	test   %edx,%edx
  100aff:	74 38                	je     100b39 <exec+0x149>
  100b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    arglen += strlen(argv[argc]) + 1;
  100b08:	89 14 24             	mov    %edx,(%esp)
  100b0b:	e8 80 38 00 00       	call   104390 <strlen>
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b10:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100b13:	83 85 7c ff ff ff 01 	addl   $0x1,-0x84(%ebp)
  100b1a:	8b bd 7c ff ff ff    	mov    -0x84(%ebp),%edi
  100b20:	8b 14 b9             	mov    (%ecx,%edi,4),%edx
    arglen += strlen(argv[argc]) + 1;
  100b23:	01 d8                	add    %ebx,%eax
  100b25:	8d 58 01             	lea    0x1(%eax),%ebx
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b28:	85 d2                	test   %edx,%edx
  100b2a:	75 dc                	jne    100b08 <exec+0x118>
  100b2c:	83 c0 04             	add    $0x4,%eax
  100b2f:	83 e0 fc             	and    $0xfffffffc,%eax
  100b32:	89 45 88             	mov    %eax,-0x78(%ebp)
  100b35:	8d 44 b8 04          	lea    0x4(%eax,%edi,4),%eax

  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100b39:	8b 7d 80             	mov    -0x80(%ebp),%edi
  100b3c:	8d 84 38 ff 1f 00 00 	lea    0x1fff(%eax,%edi,1),%eax
  100b43:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  100b48:	89 45 8c             	mov    %eax,-0x74(%ebp)
  mem = kalloc(sz);
  100b4b:	89 04 24             	mov    %eax,(%esp)
  100b4e:	e8 2d 18 00 00       	call   102380 <kalloc>
  if(mem == 0)
  100b53:	85 c0                	test   %eax,%eax
  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  mem = kalloc(sz);
  100b55:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  if(mem == 0)
  100b5b:	0f 84 e6 fe ff ff    	je     100a47 <exec+0x57>
    goto bad;
  memset(mem, 0, sz);
  100b61:	8b 45 8c             	mov    -0x74(%ebp),%eax
  100b64:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  100b6a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100b71:	00 
  100b72:	89 44 24 08          	mov    %eax,0x8(%esp)
  100b76:	89 14 24             	mov    %edx,(%esp)
  100b79:	e8 32 36 00 00       	call   1041b0 <memset>

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100b7e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  100b81:	66 83 7d cc 00       	cmpw   $0x0,-0x34(%ebp)
  100b86:	0f 84 be 00 00 00    	je     100c4a <exec+0x25a>
  100b8c:	89 c7                	mov    %eax,%edi
  100b8e:	31 db                	xor    %ebx,%ebx
  100b90:	eb 18                	jmp    100baa <exec+0x1ba>
  100b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100b98:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
  100b9c:	83 c3 01             	add    $0x1,%ebx
  100b9f:	39 d8                	cmp    %ebx,%eax
  100ba1:	0f 8e a3 00 00 00    	jle    100c4a <exec+0x25a>
  100ba7:	83 c7 20             	add    $0x20,%edi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100baa:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
  100bad:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  100bb4:	00 
  100bb5:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100bb9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100bbd:	89 34 24             	mov    %esi,(%esp)
  100bc0:	e8 bb 08 00 00       	call   101480 <readi>
  100bc5:	83 f8 20             	cmp    $0x20,%eax
  100bc8:	75 66                	jne    100c30 <exec+0x240>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100bca:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
  100bce:	75 c8                	jne    100b98 <exec+0x1a8>
      continue;
    if(ph.va + ph.memsz > sz)
  100bd0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100bd3:	89 d0                	mov    %edx,%eax
  100bd5:	03 45 e8             	add    -0x18(%ebp),%eax
  100bd8:	39 45 8c             	cmp    %eax,-0x74(%ebp)
  100bdb:	72 53                	jb     100c30 <exec+0x240>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
  100bdd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100be0:	89 34 24             	mov    %esi,(%esp)
  100be3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100be7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100bea:	89 44 24 08          	mov    %eax,0x8(%esp)
  100bee:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  100bf4:	01 d0                	add    %edx,%eax
  100bf6:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bfa:	e8 81 08 00 00       	call   101480 <readi>
  100bff:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  100c02:	89 c2                	mov    %eax,%edx
  100c04:	75 2a                	jne    100c30 <exec+0x240>
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100c06:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c09:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100c10:	00 
  100c11:	29 d0                	sub    %edx,%eax
  100c13:	89 44 24 08          	mov    %eax,0x8(%esp)
  100c17:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  100c1d:	03 55 dc             	add    -0x24(%ebp),%edx
  100c20:	01 d0                	add    %edx,%eax
  100c22:	89 04 24             	mov    %eax,(%esp)
  100c25:	e8 86 35 00 00       	call   1041b0 <memset>
  100c2a:	e9 69 ff ff ff       	jmp    100b98 <exec+0x1a8>
  100c2f:	90                   	nop    
  setupsegs(cp);
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  100c30:	8b 4d 8c             	mov    -0x74(%ebp),%ecx
  100c33:	8b bd 78 ff ff ff    	mov    -0x88(%ebp),%edi
  100c39:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c3d:	89 3c 24             	mov    %edi,(%esp)
  100c40:	e8 fb 17 00 00       	call   102440 <kfree>
  100c45:	e9 fd fd ff ff       	jmp    100a47 <exec+0x57>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  }
  iunlockput(ip);
  100c4a:	89 34 24             	mov    %esi,(%esp)
  100c4d:	e8 8e 10 00 00       	call   101ce0 <iunlockput>
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c52:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  100c58:	8b 45 8c             	mov    -0x74(%ebp),%eax
  100c5b:	2b 45 88             	sub    -0x78(%ebp),%eax

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c5e:	8b bd 7c ff ff ff    	mov    -0x84(%ebp),%edi
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c64:	f7 d2                	not    %edx
  100c66:	8d 14 90             	lea    (%eax,%edx,4),%edx
  100c69:	89 55 84             	mov    %edx,-0x7c(%ebp)

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c6c:	8d 04 ba             	lea    (%edx,%edi,4),%eax
  100c6f:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  for(i=argc-1; i>=0; i--){
  100c75:	83 ef 01             	sub    $0x1,%edi
  100c78:	83 ff ff             	cmp    $0xffffffff,%edi
  100c7b:	89 7d 90             	mov    %edi,-0x70(%ebp)
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c7e:	c7 04 10 00 00 00 00 	movl   $0x0,(%eax,%edx,1)
  for(i=argc-1; i>=0; i--){
  100c85:	74 54                	je     100cdb <exec+0x2eb>
  100c87:	8b 75 0c             	mov    0xc(%ebp),%esi
  100c8a:	89 f8                	mov    %edi,%eax
  100c8c:	89 d7                	mov    %edx,%edi
  100c8e:	c1 e0 02             	shl    $0x2,%eax
  100c91:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  100c94:	01 c6                	add    %eax,%esi
  100c96:	03 45 84             	add    -0x7c(%ebp),%eax
  100c99:	01 c7                	add    %eax,%edi
  100c9b:	90                   	nop    
  100c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    len = strlen(argv[i]) + 1;
  100ca0:	8b 06                	mov    (%esi),%eax
  100ca2:	89 04 24             	mov    %eax,(%esp)
  100ca5:	e8 e6 36 00 00       	call   104390 <strlen>
    sp -= len;
  100caa:	83 c0 01             	add    $0x1,%eax
  100cad:	29 c3                	sub    %eax,%ebx
    memmove(mem+sp, argv[i], len);
  100caf:	89 44 24 08          	mov    %eax,0x8(%esp)
  100cb3:	8b 06                	mov    (%esi),%eax
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100cb5:	83 ee 04             	sub    $0x4,%esi
    len = strlen(argv[i]) + 1;
    sp -= len;
    memmove(mem+sp, argv[i], len);
  100cb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cbc:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  100cc2:	01 d8                	add    %ebx,%eax
  100cc4:	89 04 24             	mov    %eax,(%esp)
  100cc7:	e8 74 35 00 00       	call   104240 <memmove>
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100ccc:	83 6d 90 01          	subl   $0x1,-0x70(%ebp)
    len = strlen(argv[i]) + 1;
    sp -= len;
    memmove(mem+sp, argv[i], len);
    *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
  100cd0:	89 1f                	mov    %ebx,(%edi)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100cd2:	83 ef 04             	sub    $0x4,%edi
  100cd5:	83 7d 90 ff          	cmpl   $0xffffffff,-0x70(%ebp)
  100cd9:	75 c5                	jne    100ca0 <exec+0x2b0>
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100cdb:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
  100cde:	8b bd 78 ff ff ff    	mov    -0x88(%ebp),%edi
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100ce4:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  sp -= 4;
  100cea:	89 ce                	mov    %ecx,%esi
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100cec:	89 4c 0f fc          	mov    %ecx,-0x4(%edi,%ecx,1)
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  100cf0:	83 ee 0c             	sub    $0xc,%esi
  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100cf3:	89 44 0f f8          	mov    %eax,-0x8(%edi,%ecx,1)
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
  100cf7:	c7 44 0f f4 ff ff ff 	movl   $0xffffffff,-0xc(%edi,%ecx,1)
  100cfe:	ff 

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100cff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100d02:	0f b6 11             	movzbl (%ecx),%edx
  100d05:	89 cb                	mov    %ecx,%ebx
  100d07:	84 d2                	test   %dl,%dl
  100d09:	74 20                	je     100d2b <exec+0x33b>
  100d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  100d0e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100d11:	83 c0 01             	add    $0x1,%eax
  100d14:	eb 0c                	jmp    100d22 <exec+0x332>
  100d16:	66 90                	xchg   %ax,%ax
  100d18:	0f b6 10             	movzbl (%eax),%edx
  100d1b:	83 c0 01             	add    $0x1,%eax
  100d1e:	84 d2                	test   %dl,%dl
  100d20:	74 09                	je     100d2b <exec+0x33b>
    if(*s == '/')
  100d22:	80 fa 2f             	cmp    $0x2f,%dl
  100d25:	75 f1                	jne    100d18 <exec+0x328>
  100d27:	89 c3                	mov    %eax,%ebx
  100d29:	eb ed                	jmp    100d18 <exec+0x328>
  100d2b:	90                   	nop    
  100d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      last = s+1;
  safestrcpy(cp->name, last, sizeof(cp->name));
  100d30:	e8 8b 27 00 00       	call   1034c0 <curproc>
  100d35:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  100d39:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  100d40:	00 
  100d41:	05 88 00 00 00       	add    $0x88,%eax
  100d46:	89 04 24             	mov    %eax,(%esp)
  100d49:	e8 02 36 00 00       	call   104350 <safestrcpy>

  // Commit to the new image.
  kfree(cp->mem, cp->sz);
  100d4e:	e8 6d 27 00 00       	call   1034c0 <curproc>
  100d53:	8b 58 04             	mov    0x4(%eax),%ebx
  100d56:	e8 65 27 00 00       	call   1034c0 <curproc>
  100d5b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  100d5f:	8b 00                	mov    (%eax),%eax
  100d61:	89 04 24             	mov    %eax,(%esp)
  100d64:	e8 d7 16 00 00       	call   102440 <kfree>
  cp->mem = mem;
  100d69:	e8 52 27 00 00       	call   1034c0 <curproc>
  100d6e:	8b bd 78 ff ff ff    	mov    -0x88(%ebp),%edi
  100d74:	89 38                	mov    %edi,(%eax)
  cp->sz = sz;
  100d76:	e8 45 27 00 00       	call   1034c0 <curproc>
  100d7b:	8b 55 8c             	mov    -0x74(%ebp),%edx
  100d7e:	89 50 04             	mov    %edx,0x4(%eax)
  cp->tf->eip = elf.entry;  // main
  100d81:	e8 3a 27 00 00       	call   1034c0 <curproc>
  100d86:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
  100d8c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  100d8f:	89 42 30             	mov    %eax,0x30(%edx)
  cp->tf->esp = sp;
  100d92:	e8 29 27 00 00       	call   1034c0 <curproc>
  100d97:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  100d9d:	89 70 3c             	mov    %esi,0x3c(%eax)
  setupsegs(cp);
  100da0:	e8 1b 27 00 00       	call   1034c0 <curproc>
  100da5:	89 04 24             	mov    %eax,(%esp)
  100da8:	e8 93 2b 00 00       	call   103940 <setupsegs>
  100dad:	31 c0                	xor    %eax,%eax
  100daf:	e9 a6 fc ff ff       	jmp    100a5a <exec+0x6a>
  100db4:	90                   	nop    
  100db5:	90                   	nop    
  100db6:	90                   	nop    
  100db7:	90                   	nop    
  100db8:	90                   	nop    
  100db9:	90                   	nop    
  100dba:	90                   	nop    
  100dbb:	90                   	nop    
  100dbc:	90                   	nop    
  100dbd:	90                   	nop    
  100dbe:	90                   	nop    
  100dbf:	90                   	nop    

00100dc0 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  100dc0:	55                   	push   %ebp
  100dc1:	89 e5                	mov    %esp,%ebp
  100dc3:	83 ec 28             	sub    $0x28,%esp
  100dc6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100dc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100dcc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100dcf:	8b 75 10             	mov    0x10(%ebp),%esi
  100dd2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100dd5:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int r;

  if(f->writable == 0)
  100dd8:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  100ddc:	74 5a                	je     100e38 <filewrite+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100dde:	8b 03                	mov    (%ebx),%eax
  100de0:	83 f8 02             	cmp    $0x2,%eax
  100de3:	74 5b                	je     100e40 <filewrite+0x80>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100de5:	83 f8 03             	cmp    $0x3,%eax
  100de8:	75 6d                	jne    100e57 <filewrite+0x97>
    ilock(f->ip);
  100dea:	8b 43 10             	mov    0x10(%ebx),%eax
  100ded:	89 04 24             	mov    %eax,(%esp)
  100df0:	e8 0b 0f 00 00       	call   101d00 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  100df5:	89 74 24 0c          	mov    %esi,0xc(%esp)
  100df9:	8b 43 14             	mov    0x14(%ebx),%eax
  100dfc:	89 7c 24 04          	mov    %edi,0x4(%esp)
  100e00:	89 44 24 08          	mov    %eax,0x8(%esp)
  100e04:	8b 43 10             	mov    0x10(%ebx),%eax
  100e07:	89 04 24             	mov    %eax,(%esp)
  100e0a:	e8 11 08 00 00       	call   101620 <writei>
  100e0f:	85 c0                	test   %eax,%eax
  100e11:	89 c6                	mov    %eax,%esi
  100e13:	7e 03                	jle    100e18 <filewrite+0x58>
      f->off += r;
  100e15:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100e18:	8b 43 10             	mov    0x10(%ebx),%eax
  100e1b:	89 04 24             	mov    %eax,(%esp)
  100e1e:	e8 5d 0e 00 00       	call   101c80 <iunlock>
    return r;
  }
  panic("filewrite");
}
  100e23:	89 f0                	mov    %esi,%eax
  100e25:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100e28:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100e2b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100e2e:	89 ec                	mov    %ebp,%esp
  100e30:	5d                   	pop    %ebp
  100e31:	c3                   	ret    
  100e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100e38:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100e3d:	eb e4                	jmp    100e23 <filewrite+0x63>
  100e3f:	90                   	nop    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100e40:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100e43:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100e46:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100e49:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100e4c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100e4f:	89 ec                	mov    %ebp,%esp
  100e51:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100e52:	e9 39 21 00 00       	jmp    102f90 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100e57:	c7 04 24 0a 62 10 00 	movl   $0x10620a,(%esp)
  100e5e:	e8 0d fb ff ff       	call   100970 <panic>
  100e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e70 <fileread>:
}

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  100e70:	55                   	push   %ebp
  100e71:	89 e5                	mov    %esp,%ebp
  100e73:	83 ec 28             	sub    $0x28,%esp
  100e76:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100e79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100e7c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100e7f:	8b 75 10             	mov    0x10(%ebp),%esi
  100e82:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100e85:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int r;

  if(f->readable == 0)
  100e88:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  100e8c:	74 5a                	je     100ee8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100e8e:	8b 03                	mov    (%ebx),%eax
  100e90:	83 f8 02             	cmp    $0x2,%eax
  100e93:	74 5b                	je     100ef0 <fileread+0x80>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100e95:	83 f8 03             	cmp    $0x3,%eax
  100e98:	75 6d                	jne    100f07 <fileread+0x97>
    ilock(f->ip);
  100e9a:	8b 43 10             	mov    0x10(%ebx),%eax
  100e9d:	89 04 24             	mov    %eax,(%esp)
  100ea0:	e8 5b 0e 00 00       	call   101d00 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  100ea5:	89 74 24 0c          	mov    %esi,0xc(%esp)
  100ea9:	8b 43 14             	mov    0x14(%ebx),%eax
  100eac:	89 7c 24 04          	mov    %edi,0x4(%esp)
  100eb0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100eb4:	8b 43 10             	mov    0x10(%ebx),%eax
  100eb7:	89 04 24             	mov    %eax,(%esp)
  100eba:	e8 c1 05 00 00       	call   101480 <readi>
  100ebf:	85 c0                	test   %eax,%eax
  100ec1:	89 c6                	mov    %eax,%esi
  100ec3:	7e 03                	jle    100ec8 <fileread+0x58>
      f->off += r;
  100ec5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100ec8:	8b 43 10             	mov    0x10(%ebx),%eax
  100ecb:	89 04 24             	mov    %eax,(%esp)
  100ece:	e8 ad 0d 00 00       	call   101c80 <iunlock>
    return r;
  }
  panic("fileread");
}
  100ed3:	89 f0                	mov    %esi,%eax
  100ed5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100ed8:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100edb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100ede:	89 ec                	mov    %ebp,%esp
  100ee0:	5d                   	pop    %ebp
  100ee1:	c3                   	ret    
  100ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100ee8:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100eed:	eb e4                	jmp    100ed3 <fileread+0x63>
  100eef:	90                   	nop    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100ef0:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100ef3:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100ef6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100ef9:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100efc:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100eff:	89 ec                	mov    %ebp,%esp
  100f01:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100f02:	e9 a9 1f 00 00       	jmp    102eb0 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100f07:	c7 04 24 14 62 10 00 	movl   $0x106214,(%esp)
  100f0e:	e8 5d fa ff ff       	call   100970 <panic>
  100f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f20 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100f20:	55                   	push   %ebp
  if(f->type == FD_INODE){
  100f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100f26:	89 e5                	mov    %esp,%ebp
  100f28:	53                   	push   %ebx
  100f29:	83 ec 14             	sub    $0x14,%esp
  100f2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
  100f2f:	83 3b 03             	cmpl   $0x3,(%ebx)
  100f32:	74 0c                	je     100f40 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
  100f34:	83 c4 14             	add    $0x14,%esp
  100f37:	5b                   	pop    %ebx
  100f38:	5d                   	pop    %ebp
  100f39:	c3                   	ret    
  100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
  100f40:	8b 43 10             	mov    0x10(%ebx),%eax
  100f43:	89 04 24             	mov    %eax,(%esp)
  100f46:	e8 b5 0d 00 00       	call   101d00 <ilock>
    stati(f->ip, st);
  100f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f4e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f52:	8b 43 10             	mov    0x10(%ebx),%eax
  100f55:	89 04 24             	mov    %eax,(%esp)
  100f58:	e8 d3 01 00 00       	call   101130 <stati>
    iunlock(f->ip);
  100f5d:	8b 43 10             	mov    0x10(%ebx),%eax
  100f60:	89 04 24             	mov    %eax,(%esp)
  100f63:	e8 18 0d 00 00       	call   101c80 <iunlock>
    return 0;
  }
  return -1;
}
  100f68:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
  100f6b:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
  100f6d:	5b                   	pop    %ebx
  100f6e:	5d                   	pop    %ebp
  100f6f:	c3                   	ret    

00100f70 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100f70:	55                   	push   %ebp
  100f71:	89 e5                	mov    %esp,%ebp
  100f73:	53                   	push   %ebx
  100f74:	83 ec 04             	sub    $0x4,%esp
  100f77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&file_table_lock);
  100f7a:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  100f81:	e8 ba 31 00 00       	call   104140 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  100f86:	8b 43 04             	mov    0x4(%ebx),%eax
  100f89:	85 c0                	test   %eax,%eax
  100f8b:	7e 06                	jle    100f93 <filedup+0x23>
  100f8d:	8b 13                	mov    (%ebx),%edx
  100f8f:	85 d2                	test   %edx,%edx
  100f91:	75 0d                	jne    100fa0 <filedup+0x30>
    panic("filedup");
  100f93:	c7 04 24 1d 62 10 00 	movl   $0x10621d,(%esp)
  100f9a:	e8 d1 f9 ff ff       	call   100970 <panic>
  100f9f:	90                   	nop    
  f->ref++;
  100fa0:	83 c0 01             	add    $0x1,%eax
  100fa3:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&file_table_lock);
  100fa6:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  100fad:	e8 4e 31 00 00       	call   104100 <release>
  return f;
}
  100fb2:	89 d8                	mov    %ebx,%eax
  100fb4:	83 c4 04             	add    $0x4,%esp
  100fb7:	5b                   	pop    %ebx
  100fb8:	5d                   	pop    %ebp
  100fb9:	c3                   	ret    
  100fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100fc0 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100fc0:	55                   	push   %ebp
  100fc1:	89 e5                	mov    %esp,%ebp
  100fc3:	53                   	push   %ebx
  100fc4:	83 ec 04             	sub    $0x4,%esp
  int i;

  acquire(&file_table_lock);
  100fc7:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  100fce:	e8 6d 31 00 00       	call   104140 <acquire>
  100fd3:	ba 80 99 10 00       	mov    $0x109980,%edx
  100fd8:	31 c0                	xor    %eax,%eax
  100fda:	eb 0f                	jmp    100feb <filealloc+0x2b>
  100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NFILE; i++){
  100fe0:	83 c0 01             	add    $0x1,%eax
  100fe3:	83 c2 18             	add    $0x18,%edx
  100fe6:	83 f8 64             	cmp    $0x64,%eax
  100fe9:	74 3d                	je     101028 <filealloc+0x68>
    if(file[i].type == FD_CLOSED){
  100feb:	8b 0a                	mov    (%edx),%ecx
  100fed:	85 c9                	test   %ecx,%ecx
  100fef:	75 ef                	jne    100fe0 <filealloc+0x20>
      file[i].type = FD_NONE;
  100ff1:	8d 04 40             	lea    (%eax,%eax,2),%eax
  100ff4:	8d 1c c5 00 00 00 00 	lea    0x0(,%eax,8),%ebx
  100ffb:	c7 04 c5 80 99 10 00 	movl   $0x1,0x109980(,%eax,8)
  101002:	01 00 00 00 
      file[i].ref = 1;
  101006:	c7 83 84 99 10 00 01 	movl   $0x1,0x109984(%ebx)
  10100d:	00 00 00 
      release(&file_table_lock);
  101010:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  101017:	e8 e4 30 00 00       	call   104100 <release>
      return file + i;
  10101c:	8d 83 80 99 10 00    	lea    0x109980(%ebx),%eax
    }
  }
  release(&file_table_lock);
  return 0;
}
  101022:	83 c4 04             	add    $0x4,%esp
  101025:	5b                   	pop    %ebx
  101026:	5d                   	pop    %ebp
  101027:	c3                   	ret    
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  101028:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  10102f:	e8 cc 30 00 00       	call   104100 <release>
  return 0;
}
  101034:	83 c4 04             	add    $0x4,%esp
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  101037:	31 c0                	xor    %eax,%eax
  return 0;
}
  101039:	5b                   	pop    %ebx
  10103a:	5d                   	pop    %ebp
  10103b:	c3                   	ret    
  10103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101040 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  101040:	55                   	push   %ebp
  101041:	89 e5                	mov    %esp,%ebp
  101043:	83 ec 28             	sub    $0x28,%esp
  101046:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10104c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10104f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&file_table_lock);
  101052:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  101059:	e8 e2 30 00 00       	call   104140 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  10105e:	8b 43 04             	mov    0x4(%ebx),%eax
  101061:	85 c0                	test   %eax,%eax
  101063:	7e 2b                	jle    101090 <fileclose+0x50>
  101065:	8b 33                	mov    (%ebx),%esi
  101067:	85 f6                	test   %esi,%esi
  101069:	74 25                	je     101090 <fileclose+0x50>
    panic("fileclose");
  if(--f->ref > 0){
  10106b:	83 e8 01             	sub    $0x1,%eax
  10106e:	85 c0                	test   %eax,%eax
  101070:	89 43 04             	mov    %eax,0x4(%ebx)
  101073:	74 2b                	je     1010a0 <fileclose+0x60>
    release(&file_table_lock);
  101075:	c7 45 08 e0 a2 10 00 	movl   $0x10a2e0,0x8(%ebp)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  10107c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10107f:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101082:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101085:	89 ec                	mov    %ebp,%esp
  101087:	5d                   	pop    %ebp

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  101088:	e9 73 30 00 00       	jmp    104100 <release>
  10108d:	8d 76 00             	lea    0x0(%esi),%esi
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
  101090:	c7 04 24 25 62 10 00 	movl   $0x106225,(%esp)
  101097:	e8 d4 f8 ff ff       	call   100970 <panic>
  10109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
    return;
  }
  ff = *f;
  1010a0:	8b 43 0c             	mov    0xc(%ebx),%eax
  1010a3:	8b 33                	mov    (%ebx),%esi
  1010a5:	8b 7b 10             	mov    0x10(%ebx),%edi
  f->ref = 0;
  1010a8:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
    return;
  }
  ff = *f;
  1010af:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1010b2:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_CLOSED;
  1010b6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
    return;
  }
  ff = *f;
  1010bc:	88 45 f3             	mov    %al,-0xd(%ebp)
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  1010bf:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  1010c6:	e8 35 30 00 00       	call   104100 <release>
  
  if(ff.type == FD_PIPE)
  1010cb:	83 fe 02             	cmp    $0x2,%esi
  1010ce:	74 20                	je     1010f0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  1010d0:	83 fe 03             	cmp    $0x3,%esi
  1010d3:	75 bb                	jne    101090 <fileclose+0x50>
    iput(ff.ip);
  1010d5:	89 7d 08             	mov    %edi,0x8(%ebp)
  else
    panic("fileclose");
}
  1010d8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1010db:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1010de:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1010e1:	89 ec                	mov    %ebp,%esp
  1010e3:	5d                   	pop    %ebp
  release(&file_table_lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  1010e4:	e9 47 09 00 00       	jmp    101a30 <iput>
  1010e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  1010f0:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  1010f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1010f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1010fb:	89 04 24             	mov    %eax,(%esp)
  1010fe:	e8 8d 1f 00 00       	call   103090 <pipeclose>
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  101103:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101106:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101109:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10110c:	89 ec                	mov    %ebp,%esp
  10110e:	5d                   	pop    %ebp
  10110f:	c3                   	ret    

00101110 <fileinit>:
struct spinlock file_table_lock;
struct file file[NFILE];

void
fileinit(void)
{
  101110:	55                   	push   %ebp
  101111:	89 e5                	mov    %esp,%ebp
  101113:	83 ec 08             	sub    $0x8,%esp
  initlock(&file_table_lock, "file_table");
  101116:	c7 44 24 04 2f 62 10 	movl   $0x10622f,0x4(%esp)
  10111d:	00 
  10111e:	c7 04 24 e0 a2 10 00 	movl   $0x10a2e0,(%esp)
  101125:	e8 46 2e 00 00       	call   103f70 <initlock>
}
  10112a:	c9                   	leave  
  10112b:	c3                   	ret    
  10112c:	90                   	nop    
  10112d:	90                   	nop    
  10112e:	90                   	nop    
  10112f:	90                   	nop    

00101130 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  101130:	55                   	push   %ebp
  101131:	89 e5                	mov    %esp,%ebp
  101133:	8b 55 08             	mov    0x8(%ebp),%edx
  101136:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  st->dev = ip->dev;
  101139:	8b 02                	mov    (%edx),%eax
  10113b:	89 01                	mov    %eax,(%ecx)
  st->ino = ip->inum;
  10113d:	8b 42 04             	mov    0x4(%edx),%eax
  101140:	89 41 04             	mov    %eax,0x4(%ecx)
  st->type = ip->type;
  101143:	0f b7 42 10          	movzwl 0x10(%edx),%eax
  101147:	66 89 41 08          	mov    %ax,0x8(%ecx)
  st->nlink = ip->nlink;
  10114b:	0f b7 42 16          	movzwl 0x16(%edx),%eax
  10114f:	66 89 41 0a          	mov    %ax,0xa(%ecx)
  st->size = ip->size;
  101153:	8b 42 18             	mov    0x18(%edx),%eax
  101156:	89 41 0c             	mov    %eax,0xc(%ecx)
}
  101159:	5d                   	pop    %ebp
  10115a:	c3                   	ret    
  10115b:	90                   	nop    
  10115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101160 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  101160:	55                   	push   %ebp
  101161:	89 e5                	mov    %esp,%ebp
  101163:	53                   	push   %ebx
  101164:	83 ec 04             	sub    $0x4,%esp
  101167:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
  10116a:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101171:	e8 ca 2f 00 00       	call   104140 <acquire>
  ip->ref++;
  101176:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  10117a:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101181:	e8 7a 2f 00 00       	call   104100 <release>
  return ip;
}
  101186:	89 d8                	mov    %ebx,%eax
  101188:	83 c4 04             	add    $0x4,%esp
  10118b:	5b                   	pop    %ebx
  10118c:	5d                   	pop    %ebp
  10118d:	c3                   	ret    
  10118e:	66 90                	xchg   %ax,%ax

00101190 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101190:	55                   	push   %ebp
  101191:	89 e5                	mov    %esp,%ebp
  101193:	57                   	push   %edi
  101194:	89 c7                	mov    %eax,%edi
  101196:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);
  101197:	31 f6                	xor    %esi,%esi

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101199:	53                   	push   %ebx
  struct inode *ip, *empty;

  acquire(&icache.lock);
  10119a:	bb b4 a3 10 00       	mov    $0x10a3b4,%ebx

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  10119f:	83 ec 0c             	sub    $0xc,%esp
  1011a2:	89 55 f0             	mov    %edx,-0x10(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
  1011a5:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  1011ac:	e8 8f 2f 00 00       	call   104140 <acquire>
  1011b1:	eb 17                	jmp    1011ca <iget+0x3a>
  1011b3:	90                   	nop    
  1011b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  1011b8:	85 f6                	test   %esi,%esi
  1011ba:	74 44                	je     101200 <iget+0x70>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  1011bc:	83 c3 50             	add    $0x50,%ebx
  1011bf:	81 fb 54 b3 10 00    	cmp    $0x10b354,%ebx
  1011c5:	8d 76 00             	lea    0x0(%esi),%esi
  1011c8:	74 4e                	je     101218 <iget+0x88>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  1011ca:	8b 43 08             	mov    0x8(%ebx),%eax
  1011cd:	85 c0                	test   %eax,%eax
  1011cf:	7e e7                	jle    1011b8 <iget+0x28>
  1011d1:	39 3b                	cmp    %edi,(%ebx)
  1011d3:	75 e3                	jne    1011b8 <iget+0x28>
  1011d5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1011d8:	39 53 04             	cmp    %edx,0x4(%ebx)
  1011db:	75 db                	jne    1011b8 <iget+0x28>
      ip->ref++;
  1011dd:	83 c0 01             	add    $0x1,%eax
  1011e0:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
  1011e3:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  1011ea:	e8 11 2f 00 00       	call   104100 <release>
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  1011ef:	83 c4 0c             	add    $0xc,%esp
  1011f2:	89 d8                	mov    %ebx,%eax
  1011f4:	5b                   	pop    %ebx
  1011f5:	5e                   	pop    %esi
  1011f6:	5f                   	pop    %edi
  1011f7:	5d                   	pop    %ebp
  1011f8:	c3                   	ret    
  1011f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101200:	85 c0                	test   %eax,%eax
  101202:	75 b8                	jne    1011bc <iget+0x2c>
  101204:	89 de                	mov    %ebx,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  101206:	83 c3 50             	add    $0x50,%ebx
  101209:	81 fb 54 b3 10 00    	cmp    $0x10b354,%ebx
  10120f:	75 b9                	jne    1011ca <iget+0x3a>
  101211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  101218:	85 f6                	test   %esi,%esi
  10121a:	74 2e                	je     10124a <iget+0xba>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  10121c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  10121f:	89 f3                	mov    %esi,%ebx
  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  101221:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
  ip->ref = 1;
  101223:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  10122a:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  101231:	89 46 04             	mov    %eax,0x4(%esi)
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  101234:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  10123b:	e8 c0 2e 00 00       	call   104100 <release>

  return ip;
}
  101240:	83 c4 0c             	add    $0xc,%esp
  101243:	89 d8                	mov    %ebx,%eax
  101245:	5b                   	pop    %ebx
  101246:	5e                   	pop    %esi
  101247:	5f                   	pop    %edi
  101248:	5d                   	pop    %ebp
  101249:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  10124a:	c7 04 24 3a 62 10 00 	movl   $0x10623a,(%esp)
  101251:	e8 1a f7 ff ff       	call   100970 <panic>
  101256:	8d 76 00             	lea    0x0(%esi),%esi
  101259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101260 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  101260:	55                   	push   %ebp
  101261:	89 e5                	mov    %esp,%ebp
  101263:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  101266:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10126d:	00 
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  10126e:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  101271:	89 75 fc             	mov    %esi,-0x4(%ebp)
  101274:	89 d6                	mov    %edx,%esi
  struct buf *bp;
  
  bp = bread(dev, 1);
  101276:	89 04 24             	mov    %eax,(%esp)
  101279:	e8 32 ee ff ff       	call   1000b0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  10127e:	89 34 24             	mov    %esi,(%esp)
  101281:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  101288:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bread(dev, 1);
  101289:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  10128b:	8d 40 18             	lea    0x18(%eax),%eax
  10128e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101292:	e8 a9 2f 00 00       	call   104240 <memmove>
  brelse(bp);
  101297:	89 1c 24             	mov    %ebx,(%esp)
  10129a:	e8 61 ed ff ff       	call   100000 <brelse>
}
  10129f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1012a2:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1012a5:	89 ec                	mov    %ebp,%esp
  1012a7:	5d                   	pop    %ebp
  1012a8:	c3                   	ret    
  1012a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001012b0 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1012b0:	55                   	push   %ebp
  1012b1:	89 e5                	mov    %esp,%ebp
  1012b3:	57                   	push   %edi
  1012b4:	56                   	push   %esi
  1012b5:	53                   	push   %ebx
  1012b6:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1012b9:	8d 55 e8             	lea    -0x18(%ebp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1012bc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1012bf:	e8 9c ff ff ff       	call   101260 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  1012c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1012c7:	85 c0                	test   %eax,%eax
  1012c9:	0f 84 9c 00 00 00    	je     10136b <balloc+0xbb>
  1012cf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  1012d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1012d9:	31 db                	xor    %ebx,%ebx
  1012db:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1012de:	c1 e8 03             	shr    $0x3,%eax
  1012e1:	c1 fa 0c             	sar    $0xc,%edx
  1012e4:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  1012e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1012ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1012ef:	89 04 24             	mov    %eax,(%esp)
  1012f2:	e8 b9 ed ff ff       	call   1000b0 <bread>
  1012f7:	89 c7                	mov    %eax,%edi
  1012f9:	eb 10                	jmp    10130b <balloc+0x5b>
  1012fb:	90                   	nop    
  1012fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(bi = 0; bi < BPB; bi++){
  101300:	83 c3 01             	add    $0x1,%ebx
  101303:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
  101309:	74 45                	je     101350 <balloc+0xa0>
      m = 1 << (bi % 8);
  10130b:	89 d9                	mov    %ebx,%ecx
  10130d:	ba 01 00 00 00       	mov    $0x1,%edx
  101312:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101315:	89 de                	mov    %ebx,%esi
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  101317:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101319:	c1 fe 03             	sar    $0x3,%esi
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  10131c:	89 d1                	mov    %edx,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10131e:	0f b6 54 37 18       	movzbl 0x18(%edi,%esi,1),%edx
  101323:	0f b6 c2             	movzbl %dl,%eax
  101326:	85 c8                	test   %ecx,%eax
  101328:	75 d6                	jne    101300 <balloc+0x50>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  10132a:	09 ca                	or     %ecx,%edx
  10132c:	88 54 37 18          	mov    %dl,0x18(%edi,%esi,1)
        bwrite(bp);
  101330:	89 3c 24             	mov    %edi,(%esp)
  101333:	e8 48 ed ff ff       	call   100080 <bwrite>
        brelse(bp);
  101338:	89 3c 24             	mov    %edi,(%esp)
  10133b:	e8 c0 ec ff ff       	call   100000 <brelse>
  101340:	8b 55 e0             	mov    -0x20(%ebp),%edx
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101343:	83 c4 2c             	add    $0x2c,%esp
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
  101346:	8d 04 13             	lea    (%ebx,%edx,1),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101349:	5b                   	pop    %ebx
  10134a:	5e                   	pop    %esi
  10134b:	5f                   	pop    %edi
  10134c:	5d                   	pop    %ebp
  10134d:	c3                   	ret    
  10134e:	66 90                	xchg   %ax,%ax
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  101350:	89 3c 24             	mov    %edi,(%esp)
  101353:	e8 a8 ec ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  101358:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  10135f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  101362:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  101365:	0f 87 6b ff ff ff    	ja     1012d6 <balloc+0x26>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  10136b:	c7 04 24 4a 62 10 00 	movl   $0x10624a,(%esp)
  101372:	e8 f9 f5 ff ff       	call   100970 <panic>
  101377:	89 f6                	mov    %esi,%esi
  101379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101380 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  101380:	55                   	push   %ebp
  101381:	89 e5                	mov    %esp,%ebp
  101383:	83 ec 28             	sub    $0x28,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101386:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  101389:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10138c:	89 c6                	mov    %eax,%esi
  10138e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101391:	89 cf                	mov    %ecx,%edi
  101393:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101396:	77 38                	ja     1013d0 <bmap+0x50>
    if((addr = ip->addrs[bn]) == 0){
  101398:	83 c2 04             	add    $0x4,%edx
  10139b:	8b 5c 90 0c          	mov    0xc(%eax,%edx,4),%ebx
  10139f:	89 55 e8             	mov    %edx,-0x18(%ebp)
  1013a2:	85 db                	test   %ebx,%ebx
  1013a4:	75 1a                	jne    1013c0 <bmap+0x40>
      if(!alloc)
  1013a6:	85 c9                	test   %ecx,%ecx
  1013a8:	74 3d                	je     1013e7 <bmap+0x67>
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
  1013aa:	8b 00                	mov    (%eax),%eax
  1013ac:	e8 ff fe ff ff       	call   1012b0 <balloc>
  1013b1:	89 c3                	mov    %eax,%ebx
  1013b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1013b6:	89 5c 86 0c          	mov    %ebx,0xc(%esi,%eax,4)
  1013ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1013c0:	89 d8                	mov    %ebx,%eax
  1013c2:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1013c5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1013c8:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1013cb:	89 ec                	mov    %ebp,%esp
  1013cd:	5d                   	pop    %ebp
  1013ce:	c3                   	ret    
  1013cf:	90                   	nop    
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
    }
    return addr;
  }
  bn -= NDIRECT;
  1013d0:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
  1013d3:	83 fb 7f             	cmp    $0x7f,%ebx
  1013d6:	0f 87 8d 00 00 00    	ja     101469 <bmap+0xe9>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
  1013dc:	8b 40 4c             	mov    0x4c(%eax),%eax
  1013df:	85 c0                	test   %eax,%eax
  1013e1:	75 25                	jne    101408 <bmap+0x88>
      if(!alloc)
  1013e3:	85 c9                	test   %ecx,%ecx
  1013e5:	75 11                	jne    1013f8 <bmap+0x78>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  1013e7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1013f0:	eb ce                	jmp    1013c0 <bmap+0x40>
  1013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
  1013f8:	8b 06                	mov    (%esi),%eax
  1013fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101400:	e8 ab fe ff ff       	call   1012b0 <balloc>
  101405:	89 46 4c             	mov    %eax,0x4c(%esi)
    }
    bp = bread(ip->dev, addr);
  101408:	89 44 24 04          	mov    %eax,0x4(%esp)
  10140c:	8b 06                	mov    (%esi),%eax
  10140e:	89 04 24             	mov    %eax,(%esp)
  101411:	e8 9a ec ff ff       	call   1000b0 <bread>
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  101416:	8d 5c 98 18          	lea    0x18(%eax,%ebx,4),%ebx
  10141a:	89 5d ec             	mov    %ebx,-0x14(%ebp)
  10141d:	8b 1b                	mov    (%ebx),%ebx
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
    }
    bp = bread(ip->dev, addr);
  10141f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  101422:	85 db                	test   %ebx,%ebx
  101424:	75 33                	jne    101459 <bmap+0xd9>
      if(!alloc){
  101426:	85 ff                	test   %edi,%edi
  101428:	75 16                	jne    101440 <bmap+0xc0>
        brelse(bp);
  10142a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10142d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  101432:	89 04 24             	mov    %eax,(%esp)
  101435:	e8 c6 eb ff ff       	call   100000 <brelse>
  10143a:	eb 84                	jmp    1013c0 <bmap+0x40>
  10143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      a[bn] = addr = balloc(ip->dev);
  101440:	8b 06                	mov    (%esi),%eax
  101442:	e8 69 fe ff ff       	call   1012b0 <balloc>
  101447:	89 c3                	mov    %eax,%ebx
  101449:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10144c:	89 18                	mov    %ebx,(%eax)
      bwrite(bp);
  10144e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101451:	89 04 24             	mov    %eax,(%esp)
  101454:	e8 27 ec ff ff       	call   100080 <bwrite>
    }
    brelse(bp);
  101459:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10145c:	89 04 24             	mov    %eax,(%esp)
  10145f:	e8 9c eb ff ff       	call   100000 <brelse>
  101464:	e9 57 ff ff ff       	jmp    1013c0 <bmap+0x40>
    return addr;
  }

  panic("bmap: out of range");
  101469:	c7 04 24 60 62 10 00 	movl   $0x106260,(%esp)
  101470:	e8 fb f4 ff ff       	call   100970 <panic>
  101475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101480 <readi>:
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101480:	55                   	push   %ebp
  101481:	89 e5                	mov    %esp,%ebp
  101483:	83 ec 28             	sub    $0x28,%esp
  101486:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101489:	8b 7d 08             	mov    0x8(%ebp),%edi
  10148c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10148f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101492:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101495:	8b 5d 10             	mov    0x10(%ebp),%ebx
  101498:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10149b:	66 83 7f 10 03       	cmpw   $0x3,0x10(%edi)
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  1014a0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1014a3:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  1014a6:	74 20                	je     1014c8 <readi+0x48>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  1014a8:	8b 47 18             	mov    0x18(%edi),%eax
  1014ab:	39 d8                	cmp    %ebx,%eax
  1014ad:	73 49                	jae    1014f8 <readi+0x78>
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  1014af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1014b4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1014b7:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1014ba:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1014bd:	89 ec                	mov    %ebp,%esp
  1014bf:	5d                   	pop    %ebp
  1014c0:	c3                   	ret    
  1014c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  1014c8:	0f b7 47 12          	movzwl 0x12(%edi),%eax
  1014cc:	66 83 f8 09          	cmp    $0x9,%ax
  1014d0:	77 dd                	ja     1014af <readi+0x2f>
  1014d2:	98                   	cwtl   
  1014d3:	8b 0c c5 20 a3 10 00 	mov    0x10a320(,%eax,8),%ecx
  1014da:	85 c9                	test   %ecx,%ecx
  1014dc:	74 d1                	je     1014af <readi+0x2f>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1014e4:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1014e7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014ea:	89 45 10             	mov    %eax,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014ed:	89 ec                	mov    %ebp,%esp
  1014ef:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014f0:	ff e1                	jmp    *%ecx
  1014f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  if(off > ip->size || off + n < off)
  1014f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1014fb:	01 da                	add    %ebx,%edx
  1014fd:	72 b0                	jb     1014af <readi+0x2f>
    return -1;
  if(off + n > ip->size)
  1014ff:	39 d0                	cmp    %edx,%eax
  101501:	73 05                	jae    101508 <readi+0x88>
    n = ip->size - off;
  101503:	29 d8                	sub    %ebx,%eax
  101505:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101508:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10150b:	85 d2                	test   %edx,%edx
  10150d:	74 78                	je     101587 <readi+0x107>
  10150f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  101516:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  101518:	89 da                	mov    %ebx,%edx
  10151a:	31 c9                	xor    %ecx,%ecx
  10151c:	c1 ea 09             	shr    $0x9,%edx
  10151f:	89 f8                	mov    %edi,%eax
  101521:	e8 5a fe ff ff       	call   101380 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  101526:	be 00 02 00 00       	mov    $0x200,%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  10152b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10152f:	8b 07                	mov    (%edi),%eax
  101531:	89 04 24             	mov    %eax,(%esp)
  101534:	e8 77 eb ff ff       	call   1000b0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101539:	89 da                	mov    %ebx,%edx
  10153b:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  101541:	29 d6                	sub    %edx,%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  101543:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  101546:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101549:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10154c:	39 c6                	cmp    %eax,%esi
  10154e:	76 02                	jbe    101552 <readi+0xd2>
  101550:	89 c6                	mov    %eax,%esi
    memmove(dst, bp->data + off%BSIZE, m);
  101552:	89 74 24 08          	mov    %esi,0x8(%esp)
  101556:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101559:	01 f3                	add    %esi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  10155b:	8d 44 11 18          	lea    0x18(%ecx,%edx,1),%eax
  10155f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101563:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101566:	89 04 24             	mov    %eax,(%esp)
  101569:	e8 d2 2c 00 00       	call   104240 <memmove>
    brelse(bp);
  10156e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  101571:	89 0c 24             	mov    %ecx,(%esp)
  101574:	e8 87 ea ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101579:	01 75 ec             	add    %esi,-0x14(%ebp)
  10157c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10157f:	01 75 e8             	add    %esi,-0x18(%ebp)
  101582:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  101585:	77 91                	ja     101518 <readi+0x98>
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  101587:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10158a:	e9 25 ff ff ff       	jmp    1014b4 <readi+0x34>
  10158f:	90                   	nop    

00101590 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101590:	55                   	push   %ebp
  101591:	89 e5                	mov    %esp,%ebp
  101593:	56                   	push   %esi
  101594:	53                   	push   %ebx
  101595:	83 ec 10             	sub    $0x10,%esp
  101598:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10159b:	8b 43 04             	mov    0x4(%ebx),%eax
  10159e:	c1 e8 03             	shr    $0x3,%eax
  1015a1:	83 c0 02             	add    $0x2,%eax
  1015a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1015a8:	8b 03                	mov    (%ebx),%eax
  1015aa:	89 04 24             	mov    %eax,(%esp)
  1015ad:	e8 fe ea ff ff       	call   1000b0 <bread>
  1015b2:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  1015b4:	8b 43 04             	mov    0x4(%ebx),%eax
  1015b7:	83 e0 07             	and    $0x7,%eax
  1015ba:	c1 e0 06             	shl    $0x6,%eax
  1015bd:	8d 54 06 18          	lea    0x18(%esi,%eax,1),%edx
  dip->type = ip->type;
  1015c1:	0f b7 43 10          	movzwl 0x10(%ebx),%eax
  1015c5:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
  1015c8:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  1015cc:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
  1015d0:	0f b7 43 14          	movzwl 0x14(%ebx),%eax
  1015d4:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
  1015d8:	0f b7 43 16          	movzwl 0x16(%ebx),%eax
  1015dc:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
  1015e0:	8b 43 18             	mov    0x18(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1015e3:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  1015e6:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1015e9:	83 c2 0c             	add    $0xc,%edx
  1015ec:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1015f0:	89 14 24             	mov    %edx,(%esp)
  1015f3:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  1015fa:	00 
  1015fb:	e8 40 2c 00 00       	call   104240 <memmove>
  bwrite(bp);
  101600:	89 34 24             	mov    %esi,(%esp)
  101603:	e8 78 ea ff ff       	call   100080 <bwrite>
  brelse(bp);
  101608:	89 75 08             	mov    %esi,0x8(%ebp)
}
  10160b:	83 c4 10             	add    $0x10,%esp
  10160e:	5b                   	pop    %ebx
  10160f:	5e                   	pop    %esi
  101610:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  101611:	e9 ea e9 ff ff       	jmp    100000 <brelse>
  101616:	8d 76 00             	lea    0x0(%esi),%esi
  101619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101620 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101620:	55                   	push   %ebp
  101621:	89 e5                	mov    %esp,%ebp
  101623:	57                   	push   %edi
  101624:	56                   	push   %esi
  101625:	53                   	push   %ebx
  101626:	83 ec 1c             	sub    $0x1c,%esp
  101629:	8b 45 08             	mov    0x8(%ebp),%eax
  10162c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10162f:	8b 7d 10             	mov    0x10(%ebp),%edi
  101632:	89 45 ec             	mov    %eax,-0x14(%ebp)
  101635:	8b 45 14             	mov    0x14(%ebp),%eax
  101638:	89 55 e8             	mov    %edx,-0x18(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10163b:	8b 55 ec             	mov    -0x14(%ebp),%edx
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  10163e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101641:	66 83 7a 10 03       	cmpw   $0x3,0x10(%edx)
  101646:	0f 84 bc 00 00 00    	je     101708 <writei+0xe8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off + n < off)
  10164c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10164f:	01 f8                	add    %edi,%eax
  101651:	0f 82 bb 00 00 00    	jb     101712 <writei+0xf2>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  101657:	3d 00 18 01 00       	cmp    $0x11800,%eax
  10165c:	0f 87 be 00 00 00    	ja     101720 <writei+0x100>
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101662:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  101665:	85 c9                	test   %ecx,%ecx
  101667:	0f 84 8a 00 00 00    	je     1016f7 <writei+0xd7>
  10166d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  101674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  101678:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10167b:	89 fa                	mov    %edi,%edx
  10167d:	b9 01 00 00 00       	mov    $0x1,%ecx
  101682:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  101685:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  10168a:	e8 f1 fc ff ff       	call   101380 <bmap>
  10168f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101693:	8b 55 ec             	mov    -0x14(%ebp),%edx
  101696:	8b 02                	mov    (%edx),%eax
  101698:	89 04 24             	mov    %eax,(%esp)
  10169b:	e8 10 ea ff ff       	call   1000b0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  1016a0:	89 fa                	mov    %edi,%edx
  1016a2:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  1016a8:	29 d3                	sub    %edx,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  1016aa:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
  1016ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1016af:	2b 45 f0             	sub    -0x10(%ebp),%eax
  1016b2:	39 c3                	cmp    %eax,%ebx
  1016b4:	76 02                	jbe    1016b8 <writei+0x98>
  1016b6:	89 c3                	mov    %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
  1016b8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1016bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1016bf:	01 df                	add    %ebx,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  1016c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1016c5:	8d 44 16 18          	lea    0x18(%esi,%edx,1),%eax
  1016c9:	89 04 24             	mov    %eax,(%esp)
  1016cc:	e8 6f 2b 00 00       	call   104240 <memmove>
    bwrite(bp);
  1016d1:	89 34 24             	mov    %esi,(%esp)
  1016d4:	e8 a7 e9 ff ff       	call   100080 <bwrite>
    brelse(bp);
  1016d9:	89 34 24             	mov    %esi,(%esp)
  1016dc:	e8 1f e9 ff ff       	call   100000 <brelse>
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1016e1:	01 5d f0             	add    %ebx,-0x10(%ebp)
  1016e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1016e7:	01 5d e8             	add    %ebx,-0x18(%ebp)
  1016ea:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
  1016ed:	77 89                	ja     101678 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  1016ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1016f2:	3b 78 18             	cmp    0x18(%eax),%edi
  1016f5:	77 39                	ja     101730 <writei+0x110>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  1016f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
  1016fa:	83 c4 1c             	add    $0x1c,%esp
  1016fd:	5b                   	pop    %ebx
  1016fe:	5e                   	pop    %esi
  1016ff:	5f                   	pop    %edi
  101700:	5d                   	pop    %ebp
  101701:	c3                   	ret    
  101702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101708:	0f b7 42 12          	movzwl 0x12(%edx),%eax
  10170c:	66 83 f8 09          	cmp    $0x9,%ax
  101710:	76 2b                	jbe    10173d <writei+0x11d>
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  101712:	83 c4 1c             	add    $0x1c,%esp

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
  101715:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10171a:	5b                   	pop    %ebx
  10171b:	5e                   	pop    %esi
  10171c:	5f                   	pop    %edi
  10171d:	5d                   	pop    %ebp
  10171e:	c3                   	ret    
  10171f:	90                   	nop    
  }

  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;
  101720:	c7 45 e4 00 18 01 00 	movl   $0x11800,-0x1c(%ebp)
  101727:	29 7d e4             	sub    %edi,-0x1c(%ebp)
  10172a:	e9 33 ff ff ff       	jmp    101662 <writei+0x42>
  10172f:	90                   	nop    
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  101730:	89 78 18             	mov    %edi,0x18(%eax)
    iupdate(ip);
  101733:	89 04 24             	mov    %eax,(%esp)
  101736:	e8 55 fe ff ff       	call   101590 <iupdate>
  10173b:	eb ba                	jmp    1016f7 <writei+0xd7>
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  10173d:	98                   	cwtl   
  10173e:	8b 0c c5 24 a3 10 00 	mov    0x10a324(,%eax,8),%ecx
  101745:	85 c9                	test   %ecx,%ecx
  101747:	74 c9                	je     101712 <writei+0xf2>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101749:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10174c:	89 45 10             	mov    %eax,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  10174f:	83 c4 1c             	add    $0x1c,%esp
  101752:	5b                   	pop    %ebx
  101753:	5e                   	pop    %esi
  101754:	5f                   	pop    %edi
  101755:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101756:	ff e1                	jmp    *%ecx
  101758:	90                   	nop    
  101759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101760 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101760:	55                   	push   %ebp
  101761:	89 e5                	mov    %esp,%ebp
  101763:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
  101766:	8b 45 0c             	mov    0xc(%ebp),%eax
  101769:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101770:	00 
  101771:	89 44 24 04          	mov    %eax,0x4(%esp)
  101775:	8b 45 08             	mov    0x8(%ebp),%eax
  101778:	89 04 24             	mov    %eax,(%esp)
  10177b:	e8 30 2b 00 00       	call   1042b0 <strncmp>
}
  101780:	c9                   	leave  
  101781:	c3                   	ret    
  101782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101790 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101790:	55                   	push   %ebp
  101791:	89 e5                	mov    %esp,%ebp
  101793:	57                   	push   %edi
  101794:	56                   	push   %esi
  101795:	53                   	push   %ebx
  101796:	83 ec 2c             	sub    $0x2c,%esp
  101799:	8b 45 08             	mov    0x8(%ebp),%eax
  10179c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10179f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  1017a2:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  1017a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1017aa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1017ad:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  1017b0:	0f 85 d2 00 00 00    	jne    101888 <dirlookup+0xf8>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  1017b6:	8b 78 18             	mov    0x18(%eax),%edi
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  1017b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  for(off = 0; off < dp->size; off += BSIZE){
  1017c0:	85 ff                	test   %edi,%edi
  1017c2:	0f 84 b6 00 00 00    	je     10187e <dirlookup+0xee>
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
  1017c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1017cb:	31 c9                	xor    %ecx,%ecx
  1017cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1017d0:	c1 ea 09             	shr    $0x9,%edx
  1017d3:	e8 a8 fb ff ff       	call   101380 <bmap>
  1017d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1017dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1017df:	8b 02                	mov    (%edx),%eax
  1017e1:	89 04 24             	mov    %eax,(%esp)
  1017e4:	e8 c7 e8 ff ff       	call   1000b0 <bread>
    for(de = (struct dirent*)bp->data;
  1017e9:	8d 48 18             	lea    0x18(%eax),%ecx

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
  1017ec:	89 c7                	mov    %eax,%edi
    for(de = (struct dirent*)bp->data;
  1017ee:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1017f1:	89 cb                	mov    %ecx,%ebx
        de < (struct dirent*)(bp->data + BSIZE);
  1017f3:	8d b0 18 02 00 00    	lea    0x218(%eax),%esi
  1017f9:	eb 0c                	jmp    101807 <dirlookup+0x77>
  1017fb:	90                   	nop    
  1017fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        de++){
  101800:	83 c3 10             	add    $0x10,%ebx
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
  101803:	39 f3                	cmp    %esi,%ebx
  101805:	74 59                	je     101860 <dirlookup+0xd0>
        de++){
      if(de->inum == 0)
  101807:	66 83 3b 00          	cmpw   $0x0,(%ebx)
  10180b:	74 f3                	je     101800 <dirlookup+0x70>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
  10180d:	8d 43 02             	lea    0x2(%ebx),%eax
  101810:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101817:	00 
  101818:	89 44 24 04          	mov    %eax,0x4(%esp)
  10181c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10181f:	89 04 24             	mov    %eax,(%esp)
  101822:	e8 89 2a 00 00       	call   1042b0 <strncmp>
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
        continue;
      if(namecmp(name, de->name) == 0){
  101827:	85 c0                	test   %eax,%eax
  101829:	75 d5                	jne    101800 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  10182b:	8b 75 e0             	mov    -0x20(%ebp),%esi
  10182e:	85 f6                	test   %esi,%esi
  101830:	74 0e                	je     101840 <dirlookup+0xb0>
          *poff = off + (uchar*)de - bp->data;
  101832:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101835:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101838:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  10183b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10183e:	89 01                	mov    %eax,(%ecx)
        inum = de->inum;
  101840:	0f b7 1b             	movzwl (%ebx),%ebx
        brelse(bp);
  101843:	89 3c 24             	mov    %edi,(%esp)
  101846:	e8 b5 e7 ff ff       	call   100000 <brelse>
        return iget(dp->dev, inum);
  10184b:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10184e:	89 da                	mov    %ebx,%edx
  101850:	8b 01                	mov    (%ecx),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  101852:	83 c4 2c             	add    $0x2c,%esp
  101855:	5b                   	pop    %ebx
  101856:	5e                   	pop    %esi
  101857:	5f                   	pop    %edi
  101858:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101859:	e9 32 f9 ff ff       	jmp    101190 <iget>
  10185e:	66 90                	xchg   %ax,%ax
      }
    }
    brelse(bp);
  101860:	89 3c 24             	mov    %edi,(%esp)
  101863:	e8 98 e7 ff ff       	call   100000 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101868:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10186b:	81 45 f0 00 02 00 00 	addl   $0x200,-0x10(%ebp)
  101872:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101875:	39 50 18             	cmp    %edx,0x18(%eax)
  101878:	0f 87 4a ff ff ff    	ja     1017c8 <dirlookup+0x38>
      }
    }
    brelse(bp);
  }
  return 0;
}
  10187e:	83 c4 2c             	add    $0x2c,%esp
  101881:	31 c0                	xor    %eax,%eax
  101883:	5b                   	pop    %ebx
  101884:	5e                   	pop    %esi
  101885:	5f                   	pop    %edi
  101886:	5d                   	pop    %ebp
  101887:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101888:	c7 04 24 73 62 10 00 	movl   $0x106273,(%esp)
  10188f:	e8 dc f0 ff ff       	call   100970 <panic>
  101894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10189a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001018a0 <ialloc>:
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  1018a0:	55                   	push   %ebp
  1018a1:	89 e5                	mov    %esp,%ebp
  1018a3:	57                   	push   %edi
  1018a4:	56                   	push   %esi
  1018a5:	53                   	push   %ebx
  1018a6:	83 ec 2c             	sub    $0x2c,%esp
  1018a9:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  1018ad:	8d 55 e8             	lea    -0x18(%ebp),%edx
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  1018b0:	66 89 45 de          	mov    %ax,-0x22(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  1018b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1018b7:	e8 a4 f9 ff ff       	call   101260 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1018bc:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  1018c0:	0f 86 9a 00 00 00    	jbe    101960 <ialloc+0xc0>
  1018c6:	bf 01 00 00 00       	mov    $0x1,%edi
  1018cb:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
  1018d2:	eb 17                	jmp    1018eb <ialloc+0x4b>
  1018d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1018d8:	83 c7 01             	add    $0x1,%edi
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  1018db:	89 34 24             	mov    %esi,(%esp)
  1018de:	e8 1d e7 ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1018e3:	3b 7d f0             	cmp    -0x10(%ebp),%edi
  1018e6:	89 7d e0             	mov    %edi,-0x20(%ebp)
  1018e9:	73 75                	jae    101960 <ialloc+0xc0>
    bp = bread(dev, IBLOCK(inum));
  1018eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1018ee:	c1 e8 03             	shr    $0x3,%eax
  1018f1:	83 c0 02             	add    $0x2,%eax
  1018f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1018f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1018fb:	89 04 24             	mov    %eax,(%esp)
  1018fe:	e8 ad e7 ff ff       	call   1000b0 <bread>
  101903:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
  101905:	8b 45 e0             	mov    -0x20(%ebp),%eax
  101908:	83 e0 07             	and    $0x7,%eax
  10190b:	c1 e0 06             	shl    $0x6,%eax
  10190e:	8d 5c 06 18          	lea    0x18(%esi,%eax,1),%ebx
    if(dip->type == 0){  // a free inode
  101912:	66 83 3b 00          	cmpw   $0x0,(%ebx)
  101916:	75 c0                	jne    1018d8 <ialloc+0x38>
      memset(dip, 0, sizeof(*dip));
  101918:	89 1c 24             	mov    %ebx,(%esp)
  10191b:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  101922:	00 
  101923:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10192a:	00 
  10192b:	e8 80 28 00 00       	call   1041b0 <memset>
      dip->type = type;
  101930:	0f b7 45 de          	movzwl -0x22(%ebp),%eax
  101934:	66 89 03             	mov    %ax,(%ebx)
      bwrite(bp);   // mark it allocated on the disk
  101937:	89 34 24             	mov    %esi,(%esp)
  10193a:	e8 41 e7 ff ff       	call   100080 <bwrite>
      brelse(bp);
  10193f:	89 34 24             	mov    %esi,(%esp)
  101942:	e8 b9 e6 ff ff       	call   100000 <brelse>
      return iget(dev, inum);
  101947:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10194a:	8b 45 08             	mov    0x8(%ebp),%eax
  10194d:	e8 3e f8 ff ff       	call   101190 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  101952:	83 c4 2c             	add    $0x2c,%esp
  101955:	5b                   	pop    %ebx
  101956:	5e                   	pop    %esi
  101957:	5f                   	pop    %edi
  101958:	5d                   	pop    %ebp
  101959:	c3                   	ret    
  10195a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  101960:	c7 04 24 85 62 10 00 	movl   $0x106285,(%esp)
  101967:	e8 04 f0 ff ff       	call   100970 <panic>
  10196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101970 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  101970:	55                   	push   %ebp
  101971:	89 e5                	mov    %esp,%ebp
  101973:	57                   	push   %edi
  101974:	89 c7                	mov    %eax,%edi
  101976:	56                   	push   %esi
  101977:	89 d6                	mov    %edx,%esi
  101979:	53                   	push   %ebx
  10197a:	83 ec 1c             	sub    $0x1c,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  10197d:	89 54 24 04          	mov    %edx,0x4(%esp)
  101981:	89 04 24             	mov    %eax,(%esp)
  101984:	e8 27 e7 ff ff       	call   1000b0 <bread>
  memset(bp->data, 0, BSIZE);
  101989:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  101990:	00 
  101991:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101998:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  101999:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
  10199b:	8d 40 18             	lea    0x18(%eax),%eax
  10199e:	89 04 24             	mov    %eax,(%esp)
  1019a1:	e8 0a 28 00 00       	call   1041b0 <memset>
  bwrite(bp);
  1019a6:	89 1c 24             	mov    %ebx,(%esp)
  1019a9:	e8 d2 e6 ff ff       	call   100080 <bwrite>
  brelse(bp);
  1019ae:	89 1c 24             	mov    %ebx,(%esp)
  1019b1:	e8 4a e6 ff ff       	call   100000 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  1019b6:	89 f8                	mov    %edi,%eax
  1019b8:	8d 55 e8             	lea    -0x18(%ebp),%edx
  1019bb:	e8 a0 f8 ff ff       	call   101260 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1019c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1019c3:	89 f2                	mov    %esi,%edx
  1019c5:	c1 ea 0c             	shr    $0xc,%edx
  1019c8:	89 3c 24             	mov    %edi,(%esp)
  bi = b % BPB;
  1019cb:	89 f7                	mov    %esi,%edi
  m = 1 << (bi % 8);
  1019cd:	83 e6 07             	and    $0x7,%esi

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  1019d0:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1019d6:	c1 e8 03             	shr    $0x3,%eax
  1019d9:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  1019dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  1019e1:	c1 ff 03             	sar    $0x3,%edi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1019e4:	e8 c7 e6 ff ff       	call   1000b0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
  1019e9:	89 f1                	mov    %esi,%ecx
  1019eb:	ba 01 00 00 00       	mov    $0x1,%edx
  1019f0:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
  1019f2:	0f b6 74 38 18       	movzbl 0x18(%eax,%edi,1),%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1019f7:	89 c3                	mov    %eax,%ebx
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  1019f9:	89 f1                	mov    %esi,%ecx
  1019fb:	0f b6 c1             	movzbl %cl,%eax
  1019fe:	85 d0                	test   %edx,%eax
  101a00:	74 22                	je     101a24 <bfree+0xb4>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  101a02:	89 d0                	mov    %edx,%eax
  101a04:	f7 d0                	not    %eax
  101a06:	21 f0                	and    %esi,%eax
  101a08:	88 44 3b 18          	mov    %al,0x18(%ebx,%edi,1)
  bwrite(bp);
  101a0c:	89 1c 24             	mov    %ebx,(%esp)
  101a0f:	e8 6c e6 ff ff       	call   100080 <bwrite>
  brelse(bp);
  101a14:	89 1c 24             	mov    %ebx,(%esp)
  101a17:	e8 e4 e5 ff ff       	call   100000 <brelse>
}
  101a1c:	83 c4 1c             	add    $0x1c,%esp
  101a1f:	5b                   	pop    %ebx
  101a20:	5e                   	pop    %esi
  101a21:	5f                   	pop    %edi
  101a22:	5d                   	pop    %ebp
  101a23:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  101a24:	c7 04 24 97 62 10 00 	movl   $0x106297,(%esp)
  101a2b:	e8 40 ef ff ff       	call   100970 <panic>

00101a30 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  101a30:	55                   	push   %ebp
  101a31:	89 e5                	mov    %esp,%ebp
  101a33:	57                   	push   %edi
  101a34:	56                   	push   %esi
  101a35:	53                   	push   %ebx
  101a36:	83 ec 0c             	sub    $0xc,%esp
  101a39:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
  101a3c:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101a43:	e8 f8 26 00 00       	call   104140 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  101a48:	8b 46 08             	mov    0x8(%esi),%eax
  101a4b:	83 f8 01             	cmp    $0x1,%eax
  101a4e:	0f 85 a4 00 00 00    	jne    101af8 <iput+0xc8>
  101a54:	8b 56 0c             	mov    0xc(%esi),%edx
  101a57:	f6 c2 02             	test   $0x2,%dl
  101a5a:	0f 84 98 00 00 00    	je     101af8 <iput+0xc8>
  101a60:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  101a65:	0f 85 8d 00 00 00    	jne    101af8 <iput+0xc8>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  101a6b:	f6 c2 01             	test   $0x1,%dl
  101a6e:	66 90                	xchg   %ax,%ax
  101a70:	0f 85 07 01 00 00    	jne    101b7d <iput+0x14d>
      panic("iput busy");
    ip->flags |= I_BUSY;
  101a76:	83 ca 01             	or     $0x1,%edx
    release(&icache.lock);
  101a79:	89 f3                	mov    %esi,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  101a7b:	89 56 0c             	mov    %edx,0xc(%esi)
  101a7e:	8d 7e 30             	lea    0x30(%esi),%edi
    release(&icache.lock);
  101a81:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101a88:	e8 73 26 00 00       	call   104100 <release>
  101a8d:	eb 08                	jmp    101a97 <iput+0x67>
  101a8f:	90                   	nop    
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
  101a90:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101a93:	39 fb                	cmp    %edi,%ebx
  101a95:	74 20                	je     101ab7 <iput+0x87>
    if(ip->addrs[i]){
  101a97:	8b 53 1c             	mov    0x1c(%ebx),%edx
  101a9a:	85 d2                	test   %edx,%edx
  101a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101aa0:	74 ee                	je     101a90 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
  101aa2:	8b 06                	mov    (%esi),%eax
  101aa4:	e8 c7 fe ff ff       	call   101970 <bfree>
      ip->addrs[i] = 0;
  101aa9:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  101ab0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101ab3:	39 fb                	cmp    %edi,%ebx
  101ab5:	75 e0                	jne    101a97 <iput+0x67>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
  101ab7:	8b 46 4c             	mov    0x4c(%esi),%eax
  101aba:	85 c0                	test   %eax,%eax
  101abc:	75 5a                	jne    101b18 <iput+0xe8>
    }
    brelse(bp);
    ip->addrs[INDIRECT] = 0;
  }

  ip->size = 0;
  101abe:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  101ac5:	89 34 24             	mov    %esi,(%esp)
  101ac8:	e8 c3 fa ff ff       	call   101590 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  101acd:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  101ad3:	89 34 24             	mov    %esi,(%esp)
  101ad6:	e8 b5 fa ff ff       	call   101590 <iupdate>
    acquire(&icache.lock);
  101adb:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101ae2:	e8 59 26 00 00       	call   104140 <acquire>
    ip->flags &= ~I_BUSY;
  101ae7:	83 66 0c fe          	andl   $0xfffffffe,0xc(%esi)
    wakeup(ip);
  101aeb:	89 34 24             	mov    %esi,(%esp)
  101aee:	e8 4d 19 00 00       	call   103440 <wakeup>
  101af3:	8b 46 08             	mov    0x8(%esi),%eax
  101af6:	66 90                	xchg   %ax,%ax
  }
  ip->ref--;
  101af8:	83 e8 01             	sub    $0x1,%eax
  101afb:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  101afe:	c7 45 08 80 a3 10 00 	movl   $0x10a380,0x8(%ebp)
}
  101b05:	83 c4 0c             	add    $0xc,%esp
  101b08:	5b                   	pop    %ebx
  101b09:	5e                   	pop    %esi
  101b0a:	5f                   	pop    %edi
  101b0b:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags &= ~I_BUSY;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101b0c:	e9 ef 25 00 00       	jmp    104100 <release>
  101b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  101b18:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b1c:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
  101b1e:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  101b20:	89 04 24             	mov    %eax,(%esp)
  101b23:	e8 88 e5 ff ff       	call   1000b0 <bread>
    a = (uint*)bp->data;
  101b28:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  101b2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
  101b2d:	83 c7 18             	add    $0x18,%edi
  101b30:	31 c0                	xor    %eax,%eax
  101b32:	eb 11                	jmp    101b45 <iput+0x115>
  101b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < NINDIRECT; j++){
  101b38:	83 c3 01             	add    $0x1,%ebx
  101b3b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  101b41:	89 d8                	mov    %ebx,%eax
  101b43:	74 1b                	je     101b60 <iput+0x130>
      if(a[j])
  101b45:	8b 14 87             	mov    (%edi,%eax,4),%edx
  101b48:	85 d2                	test   %edx,%edx
  101b4a:	74 ec                	je     101b38 <iput+0x108>
        bfree(ip->dev, a[j]);
  101b4c:	8b 06                	mov    (%esi),%eax
  101b4e:	e8 1d fe ff ff       	call   101970 <bfree>
  101b53:	90                   	nop    
  101b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101b58:	eb de                	jmp    101b38 <iput+0x108>
  101b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
    brelse(bp);
  101b60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101b63:	89 04 24             	mov    %eax,(%esp)
  101b66:	e8 95 e4 ff ff       	call   100000 <brelse>
    ip->addrs[INDIRECT] = 0;
  101b6b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  101b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101b78:	e9 41 ff ff ff       	jmp    101abe <iput+0x8e>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  101b7d:	c7 04 24 aa 62 10 00 	movl   $0x1062aa,(%esp)
  101b84:	e8 e7 ed ff ff       	call   100970 <panic>
  101b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101b90 <dirlink>:
}

// Write a new directory entry (name, ino) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint ino)
{
  101b90:	55                   	push   %ebp
  101b91:	89 e5                	mov    %esp,%ebp
  101b93:	57                   	push   %edi
  101b94:	56                   	push   %esi
  101b95:	53                   	push   %ebx
  101b96:	83 ec 2c             	sub    $0x2c,%esp
  101b99:	8b 7d 08             	mov    0x8(%ebp),%edi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  101b9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101b9f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101ba6:	00 
  101ba7:	89 3c 24             	mov    %edi,(%esp)
  101baa:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bae:	e8 dd fb ff ff       	call   101790 <dirlookup>
  101bb3:	85 c0                	test   %eax,%eax
  101bb5:	0f 85 98 00 00 00    	jne    101c53 <dirlink+0xc3>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101bbb:	8b 47 18             	mov    0x18(%edi),%eax
  101bbe:	85 c0                	test   %eax,%eax
  101bc0:	0f 84 9c 00 00 00    	je     101c62 <dirlink+0xd2>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
  101bc6:	8d 75 e4             	lea    -0x1c(%ebp),%esi
  101bc9:	31 db                	xor    %ebx,%ebx
  101bcb:	eb 0b                	jmp    101bd8 <dirlink+0x48>
  101bcd:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101bd0:	83 c3 10             	add    $0x10,%ebx
  101bd3:	39 5f 18             	cmp    %ebx,0x18(%edi)
  101bd6:	76 24                	jbe    101bfc <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101bd8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101bdf:	00 
  101be0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101be4:	89 74 24 04          	mov    %esi,0x4(%esp)
  101be8:	89 3c 24             	mov    %edi,(%esp)
  101beb:	e8 90 f8 ff ff       	call   101480 <readi>
  101bf0:	83 f8 10             	cmp    $0x10,%eax
  101bf3:	75 52                	jne    101c47 <dirlink+0xb7>
      panic("dirlink read");
    if(de.inum == 0)
  101bf5:	66 83 7d e4 00       	cmpw   $0x0,-0x1c(%ebp)
  101bfa:	75 d4                	jne    101bd0 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  101bff:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101c06:	00 
  101c07:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c0b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  101c0e:	89 04 24             	mov    %eax,(%esp)
  101c11:	e8 ea 26 00 00       	call   104300 <strncpy>
  de.inum = ino;
  101c16:	0f b7 45 10          	movzwl 0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101c1a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101c21:	00 
  101c22:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101c26:	89 74 24 04          	mov    %esi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  101c2a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101c2e:	89 3c 24             	mov    %edi,(%esp)
  101c31:	e8 ea f9 ff ff       	call   101620 <writei>
    panic("dirlink");
  101c36:	31 d2                	xor    %edx,%edx
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101c38:	83 f8 10             	cmp    $0x10,%eax
  101c3b:	75 2c                	jne    101c69 <dirlink+0xd9>
    panic("dirlink");
  
  return 0;
}
  101c3d:	83 c4 2c             	add    $0x2c,%esp
  101c40:	89 d0                	mov    %edx,%eax
  101c42:	5b                   	pop    %ebx
  101c43:	5e                   	pop    %esi
  101c44:	5f                   	pop    %edi
  101c45:	5d                   	pop    %ebp
  101c46:	c3                   	ret    
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101c47:	c7 04 24 b4 62 10 00 	movl   $0x1062b4,(%esp)
  101c4e:	e8 1d ed ff ff       	call   100970 <panic>
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101c53:	89 04 24             	mov    %eax,(%esp)
  101c56:	e8 d5 fd ff ff       	call   101a30 <iput>
  101c5b:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  101c60:	eb db                	jmp    101c3d <dirlink+0xad>
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101c62:	8d 75 e4             	lea    -0x1c(%ebp),%esi
  101c65:	31 db                	xor    %ebx,%ebx
  101c67:	eb 93                	jmp    101bfc <dirlink+0x6c>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101c69:	c7 04 24 c1 62 10 00 	movl   $0x1062c1,(%esp)
  101c70:	e8 fb ec ff ff       	call   100970 <panic>
  101c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101c80 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  101c80:	55                   	push   %ebp
  101c81:	89 e5                	mov    %esp,%ebp
  101c83:	53                   	push   %ebx
  101c84:	83 ec 04             	sub    $0x4,%esp
  101c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  101c8a:	85 db                	test   %ebx,%ebx
  101c8c:	74 3a                	je     101cc8 <iunlock+0x48>
  101c8e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  101c92:	74 34                	je     101cc8 <iunlock+0x48>
  101c94:	8b 43 08             	mov    0x8(%ebx),%eax
  101c97:	85 c0                	test   %eax,%eax
  101c99:	7e 2d                	jle    101cc8 <iunlock+0x48>
    panic("iunlock");

  acquire(&icache.lock);
  101c9b:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101ca2:	e8 99 24 00 00       	call   104140 <acquire>
  ip->flags &= ~I_BUSY;
  101ca7:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  101cab:	89 1c 24             	mov    %ebx,(%esp)
  101cae:	e8 8d 17 00 00       	call   103440 <wakeup>
  release(&icache.lock);
  101cb3:	c7 45 08 80 a3 10 00 	movl   $0x10a380,0x8(%ebp)
}
  101cba:	83 c4 04             	add    $0x4,%esp
  101cbd:	5b                   	pop    %ebx
  101cbe:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  101cbf:	e9 3c 24 00 00       	jmp    104100 <release>
  101cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  101cc8:	c7 04 24 c9 62 10 00 	movl   $0x1062c9,(%esp)
  101ccf:	e8 9c ec ff ff       	call   100970 <panic>
  101cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101ce0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101ce0:	55                   	push   %ebp
  101ce1:	89 e5                	mov    %esp,%ebp
  101ce3:	53                   	push   %ebx
  101ce4:	83 ec 04             	sub    $0x4,%esp
  101ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
  101cea:	89 1c 24             	mov    %ebx,(%esp)
  101ced:	e8 8e ff ff ff       	call   101c80 <iunlock>
  iput(ip);
  101cf2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  101cf5:	83 c4 04             	add    $0x4,%esp
  101cf8:	5b                   	pop    %ebx
  101cf9:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  101cfa:	e9 31 fd ff ff       	jmp    101a30 <iput>
  101cff:	90                   	nop    

00101d00 <ilock>:
}

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101d00:	55                   	push   %ebp
  101d01:	89 e5                	mov    %esp,%ebp
  101d03:	56                   	push   %esi
  101d04:	53                   	push   %ebx
  101d05:	83 ec 10             	sub    $0x10,%esp
  101d08:	8b 75 08             	mov    0x8(%ebp),%esi
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  101d0b:	85 f6                	test   %esi,%esi
  101d0d:	74 59                	je     101d68 <ilock+0x68>
  101d0f:	8b 46 08             	mov    0x8(%esi),%eax
  101d12:	85 c0                	test   %eax,%eax
  101d14:	7e 52                	jle    101d68 <ilock+0x68>
    panic("ilock");

  acquire(&icache.lock);
  101d16:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101d1d:	e8 1e 24 00 00       	call   104140 <acquire>
  while(ip->flags & I_BUSY)
  101d22:	8b 46 0c             	mov    0xc(%esi),%eax
  101d25:	a8 01                	test   $0x1,%al
  101d27:	74 1e                	je     101d47 <ilock+0x47>
  101d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  101d30:	c7 44 24 04 80 a3 10 	movl   $0x10a380,0x4(%esp)
  101d37:	00 
  101d38:	89 34 24             	mov    %esi,(%esp)
  101d3b:	e8 e0 19 00 00       	call   103720 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101d40:	8b 46 0c             	mov    0xc(%esi),%eax
  101d43:	a8 01                	test   $0x1,%al
  101d45:	75 e9                	jne    101d30 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  101d47:	83 c8 01             	or     $0x1,%eax
  101d4a:	89 46 0c             	mov    %eax,0xc(%esi)
  release(&icache.lock);
  101d4d:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101d54:	e8 a7 23 00 00       	call   104100 <release>

  if(!(ip->flags & I_VALID)){
  101d59:	f6 46 0c 02          	testb  $0x2,0xc(%esi)
  101d5d:	74 19                	je     101d78 <ilock+0x78>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  101d5f:	83 c4 10             	add    $0x10,%esp
  101d62:	5b                   	pop    %ebx
  101d63:	5e                   	pop    %esi
  101d64:	5d                   	pop    %ebp
  101d65:	c3                   	ret    
  101d66:	66 90                	xchg   %ax,%ax
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  101d68:	c7 04 24 d1 62 10 00 	movl   $0x1062d1,(%esp)
  101d6f:	e8 fc eb ff ff       	call   100970 <panic>
  101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101d78:	8b 46 04             	mov    0x4(%esi),%eax
  101d7b:	c1 e8 03             	shr    $0x3,%eax
  101d7e:	83 c0 02             	add    $0x2,%eax
  101d81:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d85:	8b 06                	mov    (%esi),%eax
  101d87:	89 04 24             	mov    %eax,(%esp)
  101d8a:	e8 21 e3 ff ff       	call   1000b0 <bread>
  101d8f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101d91:	8b 46 04             	mov    0x4(%esi),%eax
  101d94:	83 e0 07             	and    $0x7,%eax
  101d97:	c1 e0 06             	shl    $0x6,%eax
  101d9a:	8d 44 03 18          	lea    0x18(%ebx,%eax,1),%eax
    ip->type = dip->type;
  101d9e:	0f b7 10             	movzwl (%eax),%edx
  101da1:	66 89 56 10          	mov    %dx,0x10(%esi)
    ip->major = dip->major;
  101da5:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  101da9:	66 89 56 12          	mov    %dx,0x12(%esi)
    ip->minor = dip->minor;
  101dad:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  101db1:	66 89 56 14          	mov    %dx,0x14(%esi)
    ip->nlink = dip->nlink;
  101db5:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  101db9:	66 89 56 16          	mov    %dx,0x16(%esi)
    ip->size = dip->size;
  101dbd:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101dc0:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  101dc3:	89 56 18             	mov    %edx,0x18(%esi)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101dc6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101dca:	8d 46 1c             	lea    0x1c(%esi),%eax
  101dcd:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  101dd4:	00 
  101dd5:	89 04 24             	mov    %eax,(%esp)
  101dd8:	e8 63 24 00 00       	call   104240 <memmove>
    brelse(bp);
  101ddd:	89 1c 24             	mov    %ebx,(%esp)
  101de0:	e8 1b e2 ff ff       	call   100000 <brelse>
    ip->flags |= I_VALID;
  101de5:	83 4e 0c 02          	orl    $0x2,0xc(%esi)
    if(ip->type == 0)
  101de9:	66 83 7e 10 00       	cmpw   $0x0,0x10(%esi)
  101dee:	0f 85 6b ff ff ff    	jne    101d5f <ilock+0x5f>
      panic("ilock: no type");
  101df4:	c7 04 24 d7 62 10 00 	movl   $0x1062d7,(%esp)
  101dfb:	e8 70 eb ff ff       	call   100970 <panic>

00101e00 <_namei>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
_namei(char *path, int parent, char *name)
{
  101e00:	55                   	push   %ebp
  101e01:	89 e5                	mov    %esp,%ebp
  101e03:	57                   	push   %edi
  101e04:	56                   	push   %esi
  101e05:	53                   	push   %ebx
  101e06:	89 c3                	mov    %eax,%ebx
  101e08:	83 ec 1c             	sub    $0x1c,%esp
  101e0b:	89 55 e8             	mov    %edx,-0x18(%ebp)
  101e0e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
  101e11:	80 38 2f             	cmpb   $0x2f,(%eax)
  101e14:	0f 84 30 01 00 00    	je     101f4a <_namei+0x14a>
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);
  101e1a:	e8 a1 16 00 00       	call   1034c0 <curproc>
  101e1f:	8b 40 60             	mov    0x60(%eax),%eax
  101e22:	89 04 24             	mov    %eax,(%esp)
  101e25:	e8 36 f3 ff ff       	call   101160 <idup>
  101e2a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  101e2d:	eb 04                	jmp    101e33 <_namei+0x33>
  101e2f:	90                   	nop    
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101e30:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101e33:	0f b6 03             	movzbl (%ebx),%eax
  101e36:	3c 2f                	cmp    $0x2f,%al
  101e38:	74 f6                	je     101e30 <_namei+0x30>
    path++;
  if(*path == 0)
  101e3a:	84 c0                	test   %al,%al
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101e3c:	89 de                	mov    %ebx,%esi
    path++;
  if(*path == 0)
  101e3e:	75 1e                	jne    101e5e <_namei+0x5e>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
  101e40:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101e43:	85 c0                	test   %eax,%eax
  101e45:	0f 85 2c 01 00 00    	jne    101f77 <_namei+0x177>
    iput(ip);
    return 0;
  }
  return ip;
}
  101e4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101e4e:	83 c4 1c             	add    $0x1c,%esp
  101e51:	5b                   	pop    %ebx
  101e52:	5e                   	pop    %esi
  101e53:	5f                   	pop    %edi
  101e54:	5d                   	pop    %ebp
  101e55:	c3                   	ret    
  101e56:	66 90                	xchg   %ax,%ax
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  101e58:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101e5b:	0f b6 06             	movzbl (%esi),%eax
  101e5e:	3c 2f                	cmp    $0x2f,%al
  101e60:	74 04                	je     101e66 <_namei+0x66>
  101e62:	84 c0                	test   %al,%al
  101e64:	75 f2                	jne    101e58 <_namei+0x58>
    path++;
  len = path - s;
  101e66:	89 f2                	mov    %esi,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101e68:	89 f7                	mov    %esi,%edi
    path++;
  len = path - s;
  101e6a:	29 da                	sub    %ebx,%edx
  if(len >= DIRSIZ)
  101e6c:	83 fa 0d             	cmp    $0xd,%edx
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  len = path - s;
  101e6f:	89 55 f0             	mov    %edx,-0x10(%ebp)
  if(len >= DIRSIZ)
  101e72:	0f 8e 90 00 00 00    	jle    101f08 <_namei+0x108>
    memmove(name, s, DIRSIZ);
  101e78:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101e7f:	00 
  101e80:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101e84:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101e87:	89 04 24             	mov    %eax,(%esp)
  101e8a:	e8 b1 23 00 00       	call   104240 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101e8f:	80 3e 2f             	cmpb   $0x2f,(%esi)
  101e92:	75 0c                	jne    101ea0 <_namei+0xa0>
  101e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
  101e98:	83 c7 01             	add    $0x1,%edi
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101e9b:	80 3f 2f             	cmpb   $0x2f,(%edi)
  101e9e:	74 f8                	je     101e98 <_namei+0x98>
  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
  101ea0:	85 ff                	test   %edi,%edi
  101ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101ea8:	74 96                	je     101e40 <_namei+0x40>
    ilock(ip);
  101eaa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101ead:	89 04 24             	mov    %eax,(%esp)
  101eb0:	e8 4b fe ff ff       	call   101d00 <ilock>
    if(ip->type != T_DIR){
  101eb5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  101eb8:	66 83 7a 10 01       	cmpw   $0x1,0x10(%edx)
  101ebd:	75 71                	jne    101f30 <_namei+0x130>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
  101ebf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101ec2:	85 c0                	test   %eax,%eax
  101ec4:	74 09                	je     101ecf <_namei+0xcf>
  101ec6:	80 3f 00             	cmpb   $0x0,(%edi)
  101ec9:	0f 84 92 00 00 00    	je     101f61 <_namei+0x161>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101ecf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101ed6:	00 
  101ed7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  101eda:	89 54 24 04          	mov    %edx,0x4(%esp)
  101ede:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101ee1:	89 04 24             	mov    %eax,(%esp)
  101ee4:	e8 a7 f8 ff ff       	call   101790 <dirlookup>
  101ee9:	85 c0                	test   %eax,%eax
  101eeb:	89 c3                	mov    %eax,%ebx
  101eed:	74 3e                	je     101f2d <_namei+0x12d>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101eef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101ef2:	89 04 24             	mov    %eax,(%esp)
  101ef5:	e8 e6 fd ff ff       	call   101ce0 <iunlockput>
  101efa:	89 5d ec             	mov    %ebx,-0x14(%ebp)
  101efd:	89 fb                	mov    %edi,%ebx
  101eff:	e9 2f ff ff ff       	jmp    101e33 <_namei+0x33>
  101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101f08:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101f0b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101f0f:	89 54 24 08          	mov    %edx,0x8(%esp)
  101f13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101f16:	89 04 24             	mov    %eax,(%esp)
  101f19:	e8 22 23 00 00       	call   104240 <memmove>
    name[len] = 0;
  101f1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101f21:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101f24:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
  101f28:	e9 62 ff ff ff       	jmp    101e8f <_namei+0x8f>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101f2d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  101f30:	89 14 24             	mov    %edx,(%esp)
  101f33:	e8 a8 fd ff ff       	call   101ce0 <iunlockput>
  101f38:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101f3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101f42:	83 c4 1c             	add    $0x1c,%esp
  101f45:	5b                   	pop    %ebx
  101f46:	5e                   	pop    %esi
  101f47:	5f                   	pop    %edi
  101f48:	5d                   	pop    %ebp
  101f49:	c3                   	ret    
_namei(char *path, int parent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  101f4a:	ba 01 00 00 00       	mov    $0x1,%edx
  101f4f:	b8 01 00 00 00       	mov    $0x1,%eax
  101f54:	e8 37 f2 ff ff       	call   101190 <iget>
  101f59:	89 45 ec             	mov    %eax,-0x14(%ebp)
  101f5c:	e9 d2 fe ff ff       	jmp    101e33 <_namei+0x33>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101f61:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101f64:	89 04 24             	mov    %eax,(%esp)
  101f67:	e8 14 fd ff ff       	call   101c80 <iunlock>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101f6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101f6f:	83 c4 1c             	add    $0x1c,%esp
  101f72:	5b                   	pop    %ebx
  101f73:	5e                   	pop    %esi
  101f74:	5f                   	pop    %edi
  101f75:	5d                   	pop    %ebp
  101f76:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  101f77:	8b 55 ec             	mov    -0x14(%ebp),%edx
  101f7a:	89 14 24             	mov    %edx,(%esp)
  101f7d:	e8 ae fa ff ff       	call   101a30 <iput>
  101f82:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  101f89:	e9 bd fe ff ff       	jmp    101e4b <_namei+0x4b>
  101f8e:	66 90                	xchg   %ax,%ax

00101f90 <nameiparent>:
  return _namei(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101f90:	55                   	push   %ebp
  return _namei(path, 1, name);
  101f91:	ba 01 00 00 00       	mov    $0x1,%edx
  return _namei(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101f96:	89 e5                	mov    %esp,%ebp
  101f98:	8b 45 08             	mov    0x8(%ebp),%eax
  101f9b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  return _namei(path, 1, name);
}
  101f9e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return _namei(path, 1, name);
  101f9f:	e9 5c fe ff ff       	jmp    101e00 <_namei>
  101fa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101faa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101fb0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101fb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  101fb1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
  101fb3:	89 e5                	mov    %esp,%ebp
  101fb5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  101fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101fbb:	8d 4d f2             	lea    -0xe(%ebp),%ecx
  101fbe:	e8 3d fe ff ff       	call   101e00 <_namei>
}
  101fc3:	c9                   	leave  
  101fc4:	c3                   	ret    
  101fc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101fd0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  101fd0:	55                   	push   %ebp
  101fd1:	89 e5                	mov    %esp,%ebp
  101fd3:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache.lock");
  101fd6:	c7 44 24 04 e6 62 10 	movl   $0x1062e6,0x4(%esp)
  101fdd:	00 
  101fde:	c7 04 24 80 a3 10 00 	movl   $0x10a380,(%esp)
  101fe5:	e8 86 1f 00 00       	call   103f70 <initlock>
}
  101fea:	c9                   	leave  
  101feb:	c3                   	ret    
  101fec:	90                   	nop    
  101fed:	90                   	nop    
  101fee:	90                   	nop    
  101fef:	90                   	nop    

00101ff0 <ide_start_request>:
}

// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  101ff0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101ff1:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101ff6:	89 e5                	mov    %esp,%ebp
  101ff8:	56                   	push   %esi
  101ff9:	89 c6                	mov    %eax,%esi
  101ffb:	83 ec 04             	sub    $0x4,%esp
  if(b == 0)
  101ffe:	85 c0                	test   %eax,%eax
  102000:	0f 84 89 00 00 00    	je     10208f <ide_start_request+0x9f>
  102006:	66 90                	xchg   %ax,%ax
  102008:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  102009:	0f b6 c0             	movzbl %al,%eax
  10200c:	84 c0                	test   %al,%al
  10200e:	78 f8                	js     102008 <ide_start_request+0x18>
  102010:	a8 40                	test   $0x40,%al
  102012:	74 f4                	je     102008 <ide_start_request+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102014:	ba f6 03 00 00       	mov    $0x3f6,%edx
  102019:	31 c0                	xor    %eax,%eax
  10201b:	ee                   	out    %al,(%dx)
    panic("ide_start_request");

  ide_wait_ready(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  10201c:	ba f2 01 00 00       	mov    $0x1f2,%edx
  102021:	b8 01 00 00 00       	mov    $0x1,%eax
  102026:	ee                   	out    %al,(%dx)
  102027:	8b 4e 08             	mov    0x8(%esi),%ecx
  10202a:	b2 f3                	mov    $0xf3,%dl
  10202c:	89 c8                	mov    %ecx,%eax
  10202e:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
  10202f:	c1 e9 08             	shr    $0x8,%ecx
  102032:	b2 f4                	mov    $0xf4,%dl
  102034:	89 c8                	mov    %ecx,%eax
  102036:	ee                   	out    %al,(%dx)
  102037:	c1 e9 08             	shr    $0x8,%ecx
  10203a:	b2 f5                	mov    $0xf5,%dl
  10203c:	89 c8                	mov    %ecx,%eax
  10203e:	ee                   	out    %al,(%dx)
  10203f:	8b 46 04             	mov    0x4(%esi),%eax
  102042:	c1 e9 08             	shr    $0x8,%ecx
  102045:	89 ca                	mov    %ecx,%edx
  102047:	83 e2 0f             	and    $0xf,%edx
  10204a:	83 e0 01             	and    $0x1,%eax
  10204d:	c1 e0 04             	shl    $0x4,%eax
  102050:	09 d0                	or     %edx,%eax
  102052:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102057:	83 c8 e0             	or     $0xffffffe0,%eax
  10205a:	ee                   	out    %al,(%dx)
  10205b:	f6 06 04             	testb  $0x4,(%esi)
  10205e:	75 11                	jne    102071 <ide_start_request+0x81>
  102060:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102065:	b8 20 00 00 00       	mov    $0x20,%eax
  10206a:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  10206b:	83 c4 04             	add    $0x4,%esp
  10206e:	5e                   	pop    %esi
  10206f:	5d                   	pop    %ebp
  102070:	c3                   	ret    
  102071:	b2 f7                	mov    $0xf7,%dl
  102073:	b8 30 00 00 00       	mov    $0x30,%eax
  102078:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\toutsl"    :
  102079:	b9 80 00 00 00       	mov    $0x80,%ecx
  10207e:	83 c6 18             	add    $0x18,%esi
  102081:	ba f0 01 00 00       	mov    $0x1f0,%edx
  102086:	fc                   	cld    
  102087:	f2 6f                	repnz outsl %ds:(%esi),(%dx)
  102089:	83 c4 04             	add    $0x4,%esp
  10208c:	5e                   	pop    %esi
  10208d:	5d                   	pop    %ebp
  10208e:	c3                   	ret    
// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  if(b == 0)
    panic("ide_start_request");
  10208f:	c7 04 24 f2 62 10 00 	movl   $0x1062f2,(%esp)
  102096:	e8 d5 e8 ff ff       	call   100970 <panic>
  10209b:	90                   	nop    
  10209c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001020a0 <ide_rw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
ide_rw(struct buf *b)
{
  1020a0:	55                   	push   %ebp
  1020a1:	89 e5                	mov    %esp,%ebp
  1020a3:	53                   	push   %ebx
  1020a4:	83 ec 14             	sub    $0x14,%esp
  1020a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  1020aa:	8b 03                	mov    (%ebx),%eax
  1020ac:	a8 01                	test   $0x1,%al
  1020ae:	0f 84 90 00 00 00    	je     102144 <ide_rw+0xa4>
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  1020b4:	83 e0 06             	and    $0x6,%eax
  1020b7:	83 f8 02             	cmp    $0x2,%eax
  1020ba:	0f 84 90 00 00 00    	je     102150 <ide_rw+0xb0>
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
  1020c0:	8b 53 04             	mov    0x4(%ebx),%edx
  1020c3:	85 d2                	test   %edx,%edx
  1020c5:	74 0d                	je     1020d4 <ide_rw+0x34>
  1020c7:	a1 38 81 10 00       	mov    0x108138,%eax
  1020cc:	85 c0                	test   %eax,%eax
  1020ce:	0f 84 88 00 00 00    	je     10215c <ide_rw+0xbc>
    panic("ide disk 1 not present");

  acquire(&ide_lock);
  1020d4:	c7 04 24 00 81 10 00 	movl   $0x108100,(%esp)
  1020db:	e8 60 20 00 00       	call   104140 <acquire>

  // Append b to ide_queue.
  b->qnext = 0;
  1020e0:	a1 34 81 10 00       	mov    0x108134,%eax
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  1020e5:	ba 34 81 10 00       	mov    $0x108134,%edx
    panic("ide disk 1 not present");

  acquire(&ide_lock);

  // Append b to ide_queue.
  b->qnext = 0;
  1020ea:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  1020f1:	85 c0                	test   %eax,%eax
  1020f3:	74 0d                	je     102102 <ide_rw+0x62>
  1020f5:	8d 76 00             	lea    0x0(%esi),%esi
  1020f8:	8d 50 14             	lea    0x14(%eax),%edx
  1020fb:	8b 40 14             	mov    0x14(%eax),%eax
  1020fe:	85 c0                	test   %eax,%eax
  102100:	75 f6                	jne    1020f8 <ide_rw+0x58>
    ;
  *pp = b;
  102102:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(ide_queue == b)
  102104:	39 1d 34 81 10 00    	cmp    %ebx,0x108134
  10210a:	75 14                	jne    102120 <ide_rw+0x80>
  10210c:	eb 2d                	jmp    10213b <ide_rw+0x9b>
  10210e:	66 90                	xchg   %ax,%ax
    ide_start_request(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);
  102110:	c7 44 24 04 00 81 10 	movl   $0x108100,0x4(%esp)
  102117:	00 
  102118:	89 1c 24             	mov    %ebx,(%esp)
  10211b:	e8 00 16 00 00       	call   103720 <sleep>
  if(ide_queue == b)
    ide_start_request(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  102120:	8b 03                	mov    (%ebx),%eax
  102122:	83 e0 06             	and    $0x6,%eax
  102125:	83 f8 02             	cmp    $0x2,%eax
  102128:	75 e6                	jne    102110 <ide_rw+0x70>
    sleep(b, &ide_lock);

  release(&ide_lock);
  10212a:	c7 45 08 00 81 10 00 	movl   $0x108100,0x8(%ebp)
}
  102131:	83 c4 14             	add    $0x14,%esp
  102134:	5b                   	pop    %ebx
  102135:	5d                   	pop    %ebp
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);

  release(&ide_lock);
  102136:	e9 c5 1f 00 00       	jmp    104100 <release>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(ide_queue == b)
    ide_start_request(b);
  10213b:	89 d8                	mov    %ebx,%eax
  10213d:	e8 ae fe ff ff       	call   101ff0 <ide_start_request>
  102142:	eb dc                	jmp    102120 <ide_rw+0x80>
ide_rw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  102144:	c7 04 24 04 63 10 00 	movl   $0x106304,(%esp)
  10214b:	e8 20 e8 ff ff       	call   100970 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  102150:	c7 04 24 19 63 10 00 	movl   $0x106319,(%esp)
  102157:	e8 14 e8 ff ff       	call   100970 <panic>
  if(b->dev != 0 && !disk_1_present)
    panic("ide disk 1 not present");
  10215c:	c7 04 24 2f 63 10 00 	movl   $0x10632f,(%esp)
  102163:	e8 08 e8 ff ff       	call   100970 <panic>
  102168:	90                   	nop    
  102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102170 <ide_intr>:
}

// Interrupt handler.
void
ide_intr(void)
{
  102170:	55                   	push   %ebp
  102171:	89 e5                	mov    %esp,%ebp
  102173:	57                   	push   %edi
  102174:	53                   	push   %ebx
  102175:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  acquire(&ide_lock);
  102178:	c7 04 24 00 81 10 00 	movl   $0x108100,(%esp)
  10217f:	e8 bc 1f 00 00       	call   104140 <acquire>
  if((b = ide_queue) == 0){
  102184:	8b 1d 34 81 10 00    	mov    0x108134,%ebx
  10218a:	85 db                	test   %ebx,%ebx
  10218c:	74 28                	je     1021b6 <ide_intr+0x46>
    release(&ide_lock);
    return;
  }

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
  10218e:	8b 0b                	mov    (%ebx),%ecx
  102190:	f6 c1 04             	test   $0x4,%cl
  102193:	74 3b                	je     1021d0 <ide_intr+0x60>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  102195:	83 c9 02             	or     $0x2,%ecx
  102198:	83 e1 fb             	and    $0xfffffffb,%ecx
  10219b:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
  10219d:	89 1c 24             	mov    %ebx,(%esp)
  1021a0:	e8 9b 12 00 00       	call   103440 <wakeup>
  
  // Start disk on next buf in queue.
  if((ide_queue = b->qnext) != 0)
  1021a5:	8b 43 14             	mov    0x14(%ebx),%eax
  1021a8:	85 c0                	test   %eax,%eax
  1021aa:	a3 34 81 10 00       	mov    %eax,0x108134
  1021af:	74 05                	je     1021b6 <ide_intr+0x46>
    ide_start_request(ide_queue);
  1021b1:	e8 3a fe ff ff       	call   101ff0 <ide_start_request>

  release(&ide_lock);
  1021b6:	c7 04 24 00 81 10 00 	movl   $0x108100,(%esp)
  1021bd:	e8 3e 1f 00 00       	call   104100 <release>
}
  1021c2:	83 c4 10             	add    $0x10,%esp
  1021c5:	5b                   	pop    %ebx
  1021c6:	5f                   	pop    %edi
  1021c7:	5d                   	pop    %ebp
  1021c8:	c3                   	ret    
  1021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1021d0:	ba f7 01 00 00       	mov    $0x1f7,%edx
  1021d5:	8d 76 00             	lea    0x0(%esi),%esi
  1021d8:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  1021d9:	0f b6 c0             	movzbl %al,%eax
  1021dc:	84 c0                	test   %al,%al
  1021de:	78 f8                	js     1021d8 <ide_intr+0x68>
  1021e0:	a8 40                	test   $0x40,%al
  1021e2:	74 f4                	je     1021d8 <ide_intr+0x68>
    ;
  if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
  1021e4:	a8 21                	test   $0x21,%al
  1021e6:	75 ad                	jne    102195 <ide_intr+0x25>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\tinsl"     :
  1021e8:	8d 7b 18             	lea    0x18(%ebx),%edi
  1021eb:	b9 80 00 00 00       	mov    $0x80,%ecx
  1021f0:	ba f0 01 00 00       	mov    $0x1f0,%edx
  1021f5:	fc                   	cld    
  1021f6:	f2 6d                	repnz insl (%dx),%es:(%edi)
  1021f8:	8b 0b                	mov    (%ebx),%ecx
  1021fa:	eb 99                	jmp    102195 <ide_intr+0x25>
  1021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102200 <ide_init>:
  return 0;
}

void
ide_init(void)
{
  102200:	55                   	push   %ebp
  102201:	89 e5                	mov    %esp,%ebp
  102203:	53                   	push   %ebx
  102204:	83 ec 14             	sub    $0x14,%esp
  int i;

  initlock(&ide_lock, "ide");
  102207:	c7 44 24 04 46 63 10 	movl   $0x106346,0x4(%esp)
  10220e:	00 
  10220f:	c7 04 24 00 81 10 00 	movl   $0x108100,(%esp)
  102216:	e8 55 1d 00 00       	call   103f70 <initlock>
  pic_enable(IRQ_IDE);
  10221b:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102222:	e8 a9 0b 00 00       	call   102dd0 <pic_enable>
  ioapic_enable(IRQ_IDE, ncpu - 1);
  102227:	a1 20 ba 10 00       	mov    0x10ba20,%eax
  10222c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102233:	83 e8 01             	sub    $0x1,%eax
  102236:	89 44 24 04          	mov    %eax,0x4(%esp)
  10223a:	e8 61 00 00 00       	call   1022a0 <ioapic_enable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10223f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102248:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  102249:	0f b6 c0             	movzbl %al,%eax
  10224c:	84 c0                	test   %al,%al
  10224e:	78 f8                	js     102248 <ide_init+0x48>
  102250:	a8 40                	test   $0x40,%al
  102252:	74 f4                	je     102248 <ide_init+0x48>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102254:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102259:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  10225e:	ee                   	out    %al,(%dx)
  10225f:	31 db                	xor    %ebx,%ebx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102261:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
  102266:	eb 0b                	jmp    102273 <ide_init+0x73>
  ioapic_enable(IRQ_IDE, ncpu - 1);
  ide_wait_ready(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  102268:	83 c3 01             	add    $0x1,%ebx
  10226b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  102271:	74 11                	je     102284 <ide_init+0x84>
  102273:	89 ca                	mov    %ecx,%edx
  102275:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102276:	84 c0                	test   %al,%al
  102278:	74 ee                	je     102268 <ide_init+0x68>
      disk_1_present = 1;
  10227a:	c7 05 38 81 10 00 01 	movl   $0x1,0x108138
  102281:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102284:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102289:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  10228e:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10228f:	83 c4 14             	add    $0x14,%esp
  102292:	5b                   	pop    %ebx
  102293:	5d                   	pop    %ebp
  102294:	c3                   	ret    
  102295:	90                   	nop    
  102296:	90                   	nop    
  102297:	90                   	nop    
  102298:	90                   	nop    
  102299:	90                   	nop    
  10229a:	90                   	nop    
  10229b:	90                   	nop    
  10229c:	90                   	nop    
  10229d:	90                   	nop    
  10229e:	90                   	nop    
  10229f:	90                   	nop    

001022a0 <ioapic_enable>:
}

void
ioapic_enable(int irq, int cpunum)
{
  if(!ismp)
  1022a0:	a1 a0 b3 10 00       	mov    0x10b3a0,%eax
  }
}

void
ioapic_enable(int irq, int cpunum)
{
  1022a5:	55                   	push   %ebp
  1022a6:	89 e5                	mov    %esp,%ebp
  1022a8:	8b 55 08             	mov    0x8(%ebp),%edx
  if(!ismp)
  1022ab:	85 c0                	test   %eax,%eax
  }
}

void
ioapic_enable(int irq, int cpunum)
{
  1022ad:	53                   	push   %ebx
  1022ae:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(!ismp)
  1022b1:	74 1d                	je     1022d0 <ioapic_enable+0x30>
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  1022b3:	8b 0d 54 b3 10 00    	mov    0x10b354,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  1022b9:	8d 42 20             	lea    0x20(%edx),%eax
  1022bc:	8d 54 12 10          	lea    0x10(%edx,%edx,1),%edx
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  1022c0:	c1 e3 18             	shl    $0x18,%ebx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  1022c3:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
  1022c5:	83 c2 01             	add    $0x1,%edx
  1022c8:	89 41 10             	mov    %eax,0x10(%ecx)
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  1022cb:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
  1022cd:	89 59 10             	mov    %ebx,0x10(%ecx)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
}
  1022d0:	5b                   	pop    %ebx
  1022d1:	5d                   	pop    %ebp
  1022d2:	c3                   	ret    
  1022d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001022e0 <ioapic_init>:
  ioapic->data = data;
}

void
ioapic_init(void)
{
  1022e0:	55                   	push   %ebp
  1022e1:	89 e5                	mov    %esp,%ebp
  1022e3:	56                   	push   %esi
  1022e4:	53                   	push   %ebx
  1022e5:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  if(!ismp)
  1022e8:	8b 15 a0 b3 10 00    	mov    0x10b3a0,%edx
  1022ee:	85 d2                	test   %edx,%edx
  1022f0:	74 71                	je     102363 <ioapic_init+0x83>
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  1022f2:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  1022f9:	00 00 00 
  return ioapic->data;
  1022fc:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  102301:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  102308:	00 00 00 
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  10230b:	0f b6 15 a4 b3 10 00 	movzbl 0x10b3a4,%edx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  102312:	c7 05 54 b3 10 00 00 	movl   $0xfec00000,0x10b354
  102319:	00 c0 fe 
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  10231c:	c1 e8 10             	shr    $0x10,%eax
  10231f:	0f b6 f0             	movzbl %al,%esi

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
  102322:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  102327:	c1 e8 18             	shr    $0x18,%eax
  10232a:	39 c2                	cmp    %eax,%edx
  10232c:	75 42                	jne    102370 <ioapic_init+0x90>
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  10232e:	8b 0d 54 b3 10 00    	mov    0x10b354,%ecx
  102334:	31 db                	xor    %ebx,%ebx
  102336:	ba 10 00 00 00       	mov    $0x10,%edx
  10233b:	90                   	nop    
  10233c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  102340:	8d 43 20             	lea    0x20(%ebx),%eax
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  102343:	83 c3 01             	add    $0x1,%ebx
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  102346:	0d 00 00 01 00       	or     $0x10000,%eax
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  10234b:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
  10234d:	89 41 10             	mov    %eax,0x10(%ecx)
  102350:	8d 42 01             	lea    0x1(%edx),%eax
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  102353:	83 c2 02             	add    $0x2,%edx
  102356:	39 de                	cmp    %ebx,%esi
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102358:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  10235a:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  102361:	7d dd                	jge    102340 <ioapic_init+0x60>
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
    ioapic_write(REG_TABLE+2*i+1, 0);
  }
}
  102363:	83 c4 10             	add    $0x10,%esp
  102366:	5b                   	pop    %ebx
  102367:	5e                   	pop    %esi
  102368:	5d                   	pop    %ebp
  102369:	c3                   	ret    
  10236a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");
  102370:	c7 04 24 4c 63 10 00 	movl   $0x10634c,(%esp)
  102377:	e8 24 e4 ff ff       	call   1007a0 <cprintf>
  10237c:	eb b0                	jmp    10232e <ioapic_init+0x4e>
  10237e:	90                   	nop    
  10237f:	90                   	nop    

00102380 <kalloc>:
// Allocate n bytes of physical memory.
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(int n)
{
  102380:	55                   	push   %ebp
  102381:	89 e5                	mov    %esp,%ebp
  102383:	56                   	push   %esi
  102384:	53                   	push   %ebx
  102385:	83 ec 10             	sub    $0x10,%esp
  102388:	8b 75 08             	mov    0x8(%ebp),%esi
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  10238b:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
  102391:	74 0d                	je     1023a0 <kalloc+0x20>
    panic("kalloc");
  102393:	c7 04 24 80 63 10 00 	movl   $0x106380,(%esp)
  10239a:	e8 d1 e5 ff ff       	call   100970 <panic>
  10239f:	90                   	nop    
kalloc(int n)
{
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  1023a0:	85 f6                	test   %esi,%esi
  1023a2:	7e ef                	jle    102393 <kalloc+0x13>
    panic("kalloc");

  acquire(&kalloc_lock);
  1023a4:	c7 04 24 60 b3 10 00 	movl   $0x10b360,(%esp)
  1023ab:	e8 90 1d 00 00       	call   104140 <acquire>
  1023b0:	8b 1d 94 b3 10 00    	mov    0x10b394,%ebx
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  1023b6:	85 db                	test   %ebx,%ebx
  1023b8:	74 3e                	je     1023f8 <kalloc+0x78>
    if(r->len == n){
  1023ba:	8b 43 04             	mov    0x4(%ebx),%eax
  1023bd:	ba 94 b3 10 00       	mov    $0x10b394,%edx
  1023c2:	39 f0                	cmp    %esi,%eax
  1023c4:	75 11                	jne    1023d7 <kalloc+0x57>
  1023c6:	eb 58                	jmp    102420 <kalloc+0xa0>

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  1023c8:	89 da                	mov    %ebx,%edx
  1023ca:	8b 1b                	mov    (%ebx),%ebx
  1023cc:	85 db                	test   %ebx,%ebx
  1023ce:	74 28                	je     1023f8 <kalloc+0x78>
    if(r->len == n){
  1023d0:	8b 43 04             	mov    0x4(%ebx),%eax
  1023d3:	39 f0                	cmp    %esi,%eax
  1023d5:	74 49                	je     102420 <kalloc+0xa0>
      *rp = r->next;
      release(&kalloc_lock);
      return (char*)r;
    }
    if(r->len > n){
  1023d7:	39 c6                	cmp    %eax,%esi
  1023d9:	7d ed                	jge    1023c8 <kalloc+0x48>
      r->len -= n;
  1023db:	29 f0                	sub    %esi,%eax
  1023dd:	89 43 04             	mov    %eax,0x4(%ebx)
      p = (char*)r + r->len;
  1023e0:	01 c3                	add    %eax,%ebx
      release(&kalloc_lock);
  1023e2:	c7 04 24 60 b3 10 00 	movl   $0x10b360,(%esp)
  1023e9:	e8 12 1d 00 00       	call   104100 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  1023ee:	83 c4 10             	add    $0x10,%esp
  1023f1:	89 d8                	mov    %ebx,%eax
  1023f3:	5b                   	pop    %ebx
  1023f4:	5e                   	pop    %esi
  1023f5:	5d                   	pop    %ebp
  1023f6:	c3                   	ret    
  1023f7:	90                   	nop    
      return p;
    }
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  1023f8:	31 db                	xor    %ebx,%ebx
      p = (char*)r + r->len;
      release(&kalloc_lock);
      return p;
    }
  }
  release(&kalloc_lock);
  1023fa:	c7 04 24 60 b3 10 00 	movl   $0x10b360,(%esp)
  102401:	e8 fa 1c 00 00       	call   104100 <release>

  cprintf("kalloc: out of memory\n");
  102406:	c7 04 24 87 63 10 00 	movl   $0x106387,(%esp)
  10240d:	e8 8e e3 ff ff       	call   1007a0 <cprintf>
  return 0;
}
  102412:	83 c4 10             	add    $0x10,%esp
  102415:	89 d8                	mov    %ebx,%eax
  102417:	5b                   	pop    %ebx
  102418:	5e                   	pop    %esi
  102419:	5d                   	pop    %ebp
  10241a:	c3                   	ret    
  10241b:	90                   	nop    
  10241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
    if(r->len == n){
      *rp = r->next;
  102420:	8b 03                	mov    (%ebx),%eax
  102422:	89 02                	mov    %eax,(%edx)
      release(&kalloc_lock);
  102424:	c7 04 24 60 b3 10 00 	movl   $0x10b360,(%esp)
  10242b:	e8 d0 1c 00 00       	call   104100 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  102430:	83 c4 10             	add    $0x10,%esp
  102433:	89 d8                	mov    %ebx,%eax
  102435:	5b                   	pop    %ebx
  102436:	5e                   	pop    %esi
  102437:	5d                   	pop    %ebp
  102438:	c3                   	ret    
  102439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102440 <kfree>:
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102440:	55                   	push   %ebp
  102441:	89 e5                	mov    %esp,%ebp
  102443:	57                   	push   %edi
  102444:	56                   	push   %esi
  102445:	53                   	push   %ebx
  102446:	83 ec 1c             	sub    $0x1c,%esp
  102449:	8b 45 0c             	mov    0xc(%ebp),%eax
  10244c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  10244f:	85 c0                	test   %eax,%eax
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102451:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  102454:	7e 07                	jle    10245d <kfree+0x1d>
  102456:	a9 ff 0f 00 00       	test   $0xfff,%eax
  10245b:	74 13                	je     102470 <kfree+0x30>
    panic("kfree");
  10245d:	c7 04 24 9e 63 10 00 	movl   $0x10639e,(%esp)
  102464:	e8 07 e5 ff ff       	call   100970 <panic>
  102469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102470:	8b 45 f0             	mov    -0x10(%ebp),%eax

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  102473:	bf 94 b3 10 00       	mov    $0x10b394,%edi

  if(len <= 0 || len % PAGE)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102478:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10247f:	00 
  102480:	89 1c 24             	mov    %ebx,(%esp)
  102483:	89 44 24 08          	mov    %eax,0x8(%esp)
  102487:	e8 24 1d 00 00       	call   1041b0 <memset>

  acquire(&kalloc_lock);
  10248c:	c7 04 24 60 b3 10 00 	movl   $0x10b360,(%esp)
  102493:	e8 a8 1c 00 00       	call   104140 <acquire>
  p = (struct run*)v;
  102498:	8b 15 94 b3 10 00    	mov    0x10b394,%edx
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  10249e:	85 d2                	test   %edx,%edx
  1024a0:	0f 84 82 00 00 00    	je     102528 <kfree+0xe8>
  // Fill with junk to catch dangling refs.
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  1024a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1024a9:	bf 94 b3 10 00       	mov    $0x10b394,%edi
  // Fill with junk to catch dangling refs.
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  1024ae:	8d 34 03             	lea    (%ebx,%eax,1),%esi
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1024b1:	39 d6                	cmp    %edx,%esi
  1024b3:	72 73                	jb     102528 <kfree+0xe8>
    rend = (struct run*)((char*)r + r->len);
  1024b5:	8b 42 04             	mov    0x4(%edx),%eax
    if(r <= p && p < rend)
  1024b8:	39 d3                	cmp    %edx,%ebx

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
  1024ba:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    if(r <= p && p < rend)
  1024bd:	73 61                	jae    102520 <kfree+0xe0>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  1024bf:	39 d6                	cmp    %edx,%esi
  1024c1:	bf 94 b3 10 00       	mov    $0x10b394,%edi
  1024c6:	74 34                	je     1024fc <kfree+0xbc>
      p->len = len + r->len;
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
  1024c8:	39 d9                	cmp    %ebx,%ecx
  1024ca:	74 6c                	je     102538 <kfree+0xf8>
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1024cc:	89 d7                	mov    %edx,%edi
  1024ce:	8b 12                	mov    (%edx),%edx
  1024d0:	85 d2                	test   %edx,%edx
  1024d2:	74 54                	je     102528 <kfree+0xe8>
  1024d4:	39 d6                	cmp    %edx,%esi
  1024d6:	72 50                	jb     102528 <kfree+0xe8>
    rend = (struct run*)((char*)r + r->len);
  1024d8:	8b 42 04             	mov    0x4(%edx),%eax
    if(r <= p && p < rend)
  1024db:	39 d3                	cmp    %edx,%ebx

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
  1024dd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    if(r <= p && p < rend)
  1024e0:	72 16                	jb     1024f8 <kfree+0xb8>
  1024e2:	39 cb                	cmp    %ecx,%ebx
  1024e4:	73 12                	jae    1024f8 <kfree+0xb8>
      panic("freeing free page");
  1024e6:	c7 04 24 a4 63 10 00 	movl   $0x1063a4,(%esp)
  1024ed:	e8 7e e4 ff ff       	call   100970 <panic>
  1024f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pend == r){  // p next to r: replace r with p
  1024f8:	39 d6                	cmp    %edx,%esi
  1024fa:	75 cc                	jne    1024c8 <kfree+0x88>
      p->len = len + r->len;
  1024fc:	03 45 f0             	add    -0x10(%ebp),%eax
  1024ff:	89 43 04             	mov    %eax,0x4(%ebx)
      p->next = r->next;
  102502:	8b 06                	mov    (%esi),%eax
  102504:	89 03                	mov    %eax,(%ebx)
      *rp = p;
  102506:	89 1f                	mov    %ebx,(%edi)
  p->len = len;
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
  102508:	c7 45 08 60 b3 10 00 	movl   $0x10b360,0x8(%ebp)
}
  10250f:	83 c4 1c             	add    $0x1c,%esp
  102512:	5b                   	pop    %ebx
  102513:	5e                   	pop    %esi
  102514:	5f                   	pop    %edi
  102515:	5d                   	pop    %ebp
  p->len = len;
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
  102516:	e9 e5 1b 00 00       	jmp    104100 <release>
  10251b:	90                   	nop    
  10251c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
  102520:	39 cb                	cmp    %ecx,%ebx
  102522:	72 c2                	jb     1024e6 <kfree+0xa6>
  102524:	eb 99                	jmp    1024bf <kfree+0x7f>
  102526:	66 90                	xchg   %ax,%ax
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  102528:	8b 45 f0             	mov    -0x10(%ebp),%eax
  p->next = r;
  10252b:	89 13                	mov    %edx,(%ebx)
  *rp = p;
  10252d:	89 1f                	mov    %ebx,(%edi)
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  10252f:	89 43 04             	mov    %eax,0x4(%ebx)
  102532:	eb d4                	jmp    102508 <kfree+0xc8>
  102534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
  102538:	8b 0a                	mov    (%edx),%ecx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  10253a:	03 45 f0             	add    -0x10(%ebp),%eax
      if(r->next && r->next == pend){  // r now next to r->next?
  10253d:	85 c9                	test   %ecx,%ecx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  10253f:	89 42 04             	mov    %eax,0x4(%edx)
      if(r->next && r->next == pend){  // r now next to r->next?
  102542:	74 c4                	je     102508 <kfree+0xc8>
  102544:	39 ce                	cmp    %ecx,%esi
  102546:	75 c0                	jne    102508 <kfree+0xc8>
        r->len += r->next->len;
  102548:	03 46 04             	add    0x4(%esi),%eax
  10254b:	89 42 04             	mov    %eax,0x4(%edx)
        r->next = r->next->next;
  10254e:	8b 06                	mov    (%esi),%eax
  102550:	89 02                	mov    %eax,(%edx)
  102552:	eb b4                	jmp    102508 <kfree+0xc8>
  102554:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10255a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102560 <kinit>:
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  102560:	55                   	push   %ebp
  102561:	89 e5                	mov    %esp,%ebp
  102563:	53                   	push   %ebx
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  102564:	bb c4 fa 10 00       	mov    $0x10fac4,%ebx
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  102569:	83 ec 14             	sub    $0x14,%esp
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  10256c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
  extern int end;
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  102572:	c7 44 24 04 80 63 10 	movl   $0x106380,0x4(%esp)
  102579:	00 
  10257a:	c7 04 24 60 b3 10 00 	movl   $0x10b360,(%esp)
  102581:	e8 ea 19 00 00       	call   103f70 <initlock>
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  102586:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10258d:	00 
  10258e:	c7 04 24 b6 63 10 00 	movl   $0x1063b6,(%esp)
  102595:	e8 06 e2 ff ff       	call   1007a0 <cprintf>
  kfree(start, mem * PAGE);
  10259a:	89 1c 24             	mov    %ebx,(%esp)
  10259d:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  1025a4:	00 
  1025a5:	e8 96 fe ff ff       	call   102440 <kfree>
}
  1025aa:	83 c4 14             	add    $0x14,%esp
  1025ad:	5b                   	pop    %ebx
  1025ae:	5d                   	pop    %ebp
  1025af:	c3                   	ret    

001025b0 <kbd_getc>:
#include "defs.h"
#include "kbd.h"

int
kbd_getc(void)
{
  1025b0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1025b1:	ba 64 00 00 00       	mov    $0x64,%edx
  1025b6:	89 e5                	mov    %esp,%ebp
  1025b8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  1025b9:	a8 01                	test   $0x1,%al
  1025bb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1025c0:	74 76                	je     102638 <kbd_getc+0x88>
  1025c2:	ba 60 00 00 00       	mov    $0x60,%edx
  1025c7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  1025c8:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
  1025cb:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
  1025d1:	0f 84 99 00 00 00    	je     102670 <kbd_getc+0xc0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  1025d7:	84 c9                	test   %cl,%cl
  1025d9:	78 65                	js     102640 <kbd_getc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  1025db:	a1 3c 81 10 00       	mov    0x10813c,%eax
  1025e0:	a8 40                	test   $0x40,%al
  1025e2:	74 0b                	je     1025ef <kbd_getc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  1025e4:	83 e0 bf             	and    $0xffffffbf,%eax
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1025e7:	80 c9 80             	or     $0x80,%cl
    shift &= ~E0ESC;
  1025ea:	a3 3c 81 10 00       	mov    %eax,0x10813c
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1025ef:	0f b6 91 c0 64 10 00 	movzbl 0x1064c0(%ecx),%edx
  1025f6:	0f b6 81 c0 63 10 00 	movzbl 0x1063c0(%ecx),%eax
  1025fd:	0b 05 3c 81 10 00    	or     0x10813c,%eax
  102603:	31 d0                	xor    %edx,%eax
  c = charcode[shift & (CTL | SHIFT)][data];
  102605:	89 c2                	mov    %eax,%edx
  102607:	83 e2 03             	and    $0x3,%edx
  if(shift & CAPSLOCK){
  10260a:	a8 08                	test   $0x8,%al
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  10260c:	8b 14 95 c0 65 10 00 	mov    0x1065c0(,%edx,4),%edx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  102613:	a3 3c 81 10 00       	mov    %eax,0x10813c
  c = charcode[shift & (CTL | SHIFT)][data];
  102618:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
  if(shift & CAPSLOCK){
  10261c:	74 1a                	je     102638 <kbd_getc+0x88>
    if('a' <= c && c <= 'z')
  10261e:	8d 42 9f             	lea    -0x61(%edx),%eax
  102621:	83 f8 19             	cmp    $0x19,%eax
  102624:	76 5a                	jbe    102680 <kbd_getc+0xd0>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102626:	8d 42 bf             	lea    -0x41(%edx),%eax
  102629:	83 f8 19             	cmp    $0x19,%eax
  10262c:	77 0a                	ja     102638 <kbd_getc+0x88>
      c += 'a' - 'A';
  10262e:	83 c2 20             	add    $0x20,%edx
  102631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  return c;
}
  102638:	89 d0                	mov    %edx,%eax
  10263a:	5d                   	pop    %ebp
  10263b:	c3                   	ret    
  10263c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  102640:	8b 15 3c 81 10 00    	mov    0x10813c,%edx
  102646:	f6 c2 40             	test   $0x40,%dl
  102649:	75 03                	jne    10264e <kbd_getc+0x9e>
  10264b:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
  10264e:	0f b6 81 c0 63 10 00 	movzbl 0x1063c0(%ecx),%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102655:	5d                   	pop    %ebp
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
  102656:	83 c8 40             	or     $0x40,%eax
  102659:	0f b6 c0             	movzbl %al,%eax
  10265c:	f7 d0                	not    %eax
  10265e:	21 d0                	and    %edx,%eax
  102660:	31 d2                	xor    %edx,%edx
  102662:	a3 3c 81 10 00       	mov    %eax,0x10813c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102667:	89 d0                	mov    %edx,%eax
  102669:	c3                   	ret    
  10266a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102670:	31 d2                	xor    %edx,%edx
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102672:	89 d0                	mov    %edx,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102674:	83 0d 3c 81 10 00 40 	orl    $0x40,0x10813c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  10267b:	5d                   	pop    %ebp
  10267c:	c3                   	ret    
  10267d:	8d 76 00             	lea    0x0(%esi),%esi
  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
  102680:	83 ea 20             	sub    $0x20,%edx
  102683:	eb b3                	jmp    102638 <kbd_getc+0x88>
  102685:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102690 <kbd_intr>:
  return c;
}

void
kbd_intr(void)
{
  102690:	55                   	push   %ebp
  102691:	89 e5                	mov    %esp,%ebp
  102693:	83 ec 08             	sub    $0x8,%esp
  console_intr(kbd_getc);
  102696:	c7 04 24 b0 25 10 00 	movl   $0x1025b0,(%esp)
  10269d:	e8 8e de ff ff       	call   100530 <console_intr>
}
  1026a2:	c9                   	leave  
  1026a3:	c3                   	ret    
  1026a4:	90                   	nop    
  1026a5:	90                   	nop    
  1026a6:	90                   	nop    
  1026a7:	90                   	nop    
  1026a8:	90                   	nop    
  1026a9:	90                   	nop    
  1026aa:	90                   	nop    
  1026ab:	90                   	nop    
  1026ac:	90                   	nop    
  1026ad:	90                   	nop    
  1026ae:	90                   	nop    
  1026af:	90                   	nop    

001026b0 <lapic_init>:
}

void
lapic_init(int c)
{
  if(!lapic) 
  1026b0:	8b 15 98 b3 10 00    	mov    0x10b398,%edx
  lapic[ID];  // wait for write to finish, by reading
}

void
lapic_init(int c)
{
  1026b6:	55                   	push   %ebp
  1026b7:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
  1026b9:	85 d2                	test   %edx,%edx
  1026bb:	0f 84 c3 00 00 00    	je     102784 <lapic_init+0xd4>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026c1:	c7 82 f0 00 00 00 3f 	movl   $0x13f,0xf0(%edx)
  1026c8:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026cb:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026ce:	c7 82 e0 03 00 00 0b 	movl   $0xb,0x3e0(%edx)
  1026d5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026d8:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026db:	c7 82 20 03 00 00 20 	movl   $0x20020,0x320(%edx)
  1026e2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  1026e5:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026e8:	c7 82 80 03 00 00 80 	movl   $0x989680,0x380(%edx)
  1026ef:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  1026f2:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026f5:	c7 82 50 03 00 00 00 	movl   $0x10000,0x350(%edx)
  1026fc:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1026ff:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102702:	c7 82 60 03 00 00 00 	movl   $0x10000,0x360(%edx)
  102709:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  10270c:	8b 42 20             	mov    0x20(%edx),%eax
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  10270f:	8b 42 30             	mov    0x30(%edx),%eax
  102712:	c1 e8 10             	shr    $0x10,%eax
  102715:	3c 03                	cmp    $0x3,%al
  102717:	77 6f                	ja     102788 <lapic_init+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102719:	c7 82 70 03 00 00 33 	movl   $0x33,0x370(%edx)
  102720:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102723:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102726:	8d 8a 00 03 00 00    	lea    0x300(%edx),%ecx
  lapic[ID];  // wait for write to finish, by reading
  10272c:	c7 82 80 02 00 00 00 	movl   $0x0,0x280(%edx)
  102733:	00 00 00 
  102736:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102739:	c7 82 80 02 00 00 00 	movl   $0x0,0x280(%edx)
  102740:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102743:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102746:	c7 82 b0 00 00 00 00 	movl   $0x0,0xb0(%edx)
  10274d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102750:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102753:	c7 82 10 03 00 00 00 	movl   $0x0,0x310(%edx)
  10275a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10275d:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102760:	c7 82 00 03 00 00 00 	movl   $0x88500,0x300(%edx)
  102767:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  10276a:	8b 42 20             	mov    0x20(%edx),%eax
  10276d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  102770:	8b 01                	mov    (%ecx),%eax
  102772:	f6 c4 10             	test   $0x10,%ah
  102775:	75 f9                	jne    102770 <lapic_init+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102777:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%edx)
  10277e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102781:	8b 42 20             	mov    0x20(%edx),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  102784:	5d                   	pop    %ebp
  102785:	c3                   	ret    
  102786:	66 90                	xchg   %ax,%ax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102788:	c7 82 40 03 00 00 00 	movl   $0x10000,0x340(%edx)
  10278f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102792:	8b 42 20             	mov    0x20(%edx),%eax
  102795:	eb 82                	jmp    102719 <lapic_init+0x69>
  102797:	89 f6                	mov    %esi,%esi
  102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001027a0 <lapic_eoi>:

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  if(lapic)
  1027a0:	a1 98 b3 10 00       	mov    0x10b398,%eax
}

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  1027a5:	55                   	push   %ebp
  1027a6:	89 e5                	mov    %esp,%ebp
  if(lapic)
  1027a8:	85 c0                	test   %eax,%eax
  1027aa:	74 0d                	je     1027b9 <lapic_eoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027ac:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1027b3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1027b6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapic_eoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
  1027b9:	5d                   	pop    %ebp
  1027ba:	c3                   	ret    
  1027bb:	90                   	nop    
  1027bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001027c0 <lapic_startap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapic_startap(uchar apicid, uint addr)
{
  1027c0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1027c1:	ba 70 00 00 00       	mov    $0x70,%edx
  1027c6:	89 e5                	mov    %esp,%ebp
  1027c8:	b8 0f 00 00 00       	mov    $0xf,%eax
  1027cd:	57                   	push   %edi
  1027ce:	56                   	push   %esi
  1027cf:	53                   	push   %ebx
  1027d0:	83 ec 18             	sub    $0x18,%esp
  1027d3:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
  1027d7:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  1027d8:	b8 0a 00 00 00       	mov    $0xa,%eax
  1027dd:	b2 71                	mov    $0x71,%dl
  1027df:	ee                   	out    %al,(%dx)
  1027e0:	8b 45 0c             	mov    0xc(%ebp),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027e3:	89 cf                	mov    %ecx,%edi
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  1027e5:	ba c7 00 00 00       	mov    $0xc7,%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027ea:	8b 1d 98 b3 10 00    	mov    0x10b398,%ebx
  1027f0:	c1 e7 18             	shl    $0x18,%edi
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  1027f3:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  1027fa:	00 00 
  wrv[1] = addr >> 4;
  1027fc:	c1 e8 04             	shr    $0x4,%eax
  1027ff:	66 a3 69 04 00 00    	mov    %ax,0x469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102805:	8d 83 10 03 00 00    	lea    0x310(%ebx),%eax
  10280b:	89 bb 10 03 00 00    	mov    %edi,0x310(%ebx)
  lapic[ID];  // wait for write to finish, by reading
  102811:	8d 73 20             	lea    0x20(%ebx),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102814:	89 45 dc             	mov    %eax,-0x24(%ebp)
  lapic[ID];  // wait for write to finish, by reading
  102817:	8b 43 20             	mov    0x20(%ebx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10281a:	8d 83 00 03 00 00    	lea    0x300(%ebx),%eax
  102820:	c7 83 00 03 00 00 00 	movl   $0xc500,0x300(%ebx)
  102827:	c5 00 00 
  10282a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  lapic[ID];  // wait for write to finish, by reading
  10282d:	8b 43 20             	mov    0x20(%ebx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  102830:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102837:	eb 0e                	jmp    102847 <lapic_startap+0x87>
  102839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  while(us-- > 0)
  102840:	85 d2                	test   %edx,%edx
  102842:	74 2b                	je     10286f <lapic_startap+0xaf>
  102844:	83 ea 01             	sub    $0x1,%edx
    for(j=0; j<10000; j++);
  102847:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  10284e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102851:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102856:	7f e8                	jg     102840 <lapic_startap+0x80>
  102858:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10285b:	83 c0 01             	add    $0x1,%eax
  10285e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102861:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102864:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102869:	7e ed                	jle    102858 <lapic_startap+0x98>
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  10286b:	85 d2                	test   %edx,%edx
  10286d:	75 d5                	jne    102844 <lapic_startap+0x84>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10286f:	c7 83 00 03 00 00 00 	movl   $0x8500,0x300(%ebx)
  102876:	85 00 00 
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  102879:	ba 63 00 00 00       	mov    $0x63,%edx

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  10287e:	8b 43 20             	mov    0x20(%ebx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  102881:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102888:	eb 0d                	jmp    102897 <lapic_startap+0xd7>
  10288a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  while(us-- > 0)
  102890:	85 d2                	test   %edx,%edx
  102892:	74 2b                	je     1028bf <lapic_startap+0xff>
  102894:	83 ea 01             	sub    $0x1,%edx
    for(j=0; j<10000; j++);
  102897:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  10289e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1028a1:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  1028a6:	7f e8                	jg     102890 <lapic_startap+0xd0>
  1028a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1028ab:	83 c0 01             	add    $0x1,%eax
  1028ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1028b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1028b4:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  1028b9:	7e ed                	jle    1028a8 <lapic_startap+0xe8>
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  1028bb:	85 d2                	test   %edx,%edx
  1028bd:	75 d5                	jne    102894 <lapic_startap+0xd4>
  1028bf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1028c2:	31 db                	xor    %ebx,%ebx
  1028c4:	c1 e9 0c             	shr    $0xc,%ecx
  1028c7:	80 cd 06             	or     $0x6,%ch
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1028ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  1028cd:	ba c7 00 00 00       	mov    $0xc7,%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1028d2:	89 38                	mov    %edi,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1028d4:	8b 06                	mov    (%esi),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1028d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1028d9:	89 08                	mov    %ecx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1028db:	8b 06                	mov    (%esi),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  1028dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1028e4:	eb 09                	jmp    1028ef <lapic_startap+0x12f>
  1028e6:	66 90                	xchg   %ax,%ax
  
  while(us-- > 0)
  1028e8:	85 d2                	test   %edx,%edx
  1028ea:	74 2c                	je     102918 <lapic_startap+0x158>
  1028ec:	83 ea 01             	sub    $0x1,%edx
    for(j=0; j<10000; j++);
  1028ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1028f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1028f9:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  1028fe:	7f e8                	jg     1028e8 <lapic_startap+0x128>
  102900:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102903:	83 c0 01             	add    $0x1,%eax
  102906:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102909:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10290c:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102911:	7e ed                	jle    102900 <lapic_startap+0x140>
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  102913:	85 d2                	test   %edx,%edx
  102915:	75 d5                	jne    1028ec <lapic_startap+0x12c>
  102917:	90                   	nop    
  // Send startup IPI (twice!) to enter bootstrap code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
  102918:	83 c3 01             	add    $0x1,%ebx
  10291b:	83 fb 02             	cmp    $0x2,%ebx
  10291e:	75 aa                	jne    1028ca <lapic_startap+0x10a>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
  102920:	83 c4 18             	add    $0x18,%esp
  102923:	5b                   	pop    %ebx
  102924:	5e                   	pop    %esi
  102925:	5f                   	pop    %edi
  102926:	5d                   	pop    %ebp
  102927:	c3                   	ret    
  102928:	90                   	nop    
  102929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102930 <cpu>:
  lapicw(TPR, 0);
}

int
cpu(void)
{
  102930:	55                   	push   %ebp
  102931:	89 e5                	mov    %esp,%ebp
  102933:	83 ec 08             	sub    $0x8,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  102936:	9c                   	pushf  
  102937:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
  102938:	f6 c4 02             	test   $0x2,%ah
  10293b:	74 12                	je     10294f <cpu+0x1f>
    static int n;
    if(n++ == 0)
  10293d:	8b 15 40 81 10 00    	mov    0x108140,%edx
  102943:	8d 42 01             	lea    0x1(%edx),%eax
  102946:	85 d2                	test   %edx,%edx
  102948:	a3 40 81 10 00       	mov    %eax,0x108140
  10294d:	74 19                	je     102968 <cpu+0x38>
      cprintf("cpu called from %x with interrupts enabled\n",
        ((uint*)read_ebp())[1]);
  }

  if(lapic)
  10294f:	8b 15 98 b3 10 00    	mov    0x10b398,%edx
  102955:	31 c0                	xor    %eax,%eax
  102957:	85 d2                	test   %edx,%edx
  102959:	74 06                	je     102961 <cpu+0x31>
    return lapic[ID]>>24;
  10295b:	8b 42 20             	mov    0x20(%edx),%eax
  10295e:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  102961:	c9                   	leave  
  102962:	c3                   	ret    
  102963:	90                   	nop    
  102964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uint
read_ebp(void)
{
  uint ebp;
  
  asm volatile("movl %%ebp, %0" : "=a" (ebp));
  102968:	89 e8                	mov    %ebp,%eax
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  10296a:	8b 40 04             	mov    0x4(%eax),%eax
  10296d:	c7 04 24 d0 65 10 00 	movl   $0x1065d0,(%esp)
  102974:	89 44 24 04          	mov    %eax,0x4(%esp)
  102978:	e8 23 de ff ff       	call   1007a0 <cprintf>
  10297d:	eb d0                	jmp    10294f <cpu+0x1f>
  10297f:	90                   	nop    

00102980 <mpmain>:

// Bootstrap processor gets here after setting up the hardware.
// Additional processors start here.
static void
mpmain(void)
{
  102980:	55                   	push   %ebp
  102981:	89 e5                	mov    %esp,%ebp
  102983:	53                   	push   %ebx
  102984:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: mpmain\n", cpu());
  102987:	e8 a4 ff ff ff       	call   102930 <cpu>
  10298c:	c7 04 24 fc 65 10 00 	movl   $0x1065fc,(%esp)
  102993:	89 44 24 04          	mov    %eax,0x4(%esp)
  102997:	e8 04 de ff ff       	call   1007a0 <cprintf>
  idtinit();
  10299c:	e8 4f 2a 00 00       	call   1053f0 <idtinit>
  if(cpu() != mp_bcpu())
  1029a1:	e8 8a ff ff ff       	call   102930 <cpu>
  1029a6:	89 c3                	mov    %eax,%ebx
  1029a8:	e8 c3 01 00 00       	call   102b70 <mp_bcpu>
  1029ad:	39 c3                	cmp    %eax,%ebx
  1029af:	74 0d                	je     1029be <mpmain+0x3e>
    lapic_init(cpu());
  1029b1:	e8 7a ff ff ff       	call   102930 <cpu>
  1029b6:	89 04 24             	mov    %eax,(%esp)
  1029b9:	e8 f2 fc ff ff       	call   1026b0 <lapic_init>
  setupsegs(0);
  1029be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1029c5:	e8 76 0f 00 00       	call   103940 <setupsegs>
  xchg(&cpus[cpu()].booted, 1);
  1029ca:	e8 61 ff ff ff       	call   102930 <cpu>
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  1029cf:	ba 01 00 00 00       	mov    $0x1,%edx
  1029d4:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  1029da:	8d 88 80 b4 10 00    	lea    0x10b480(%eax),%ecx
  1029e0:	89 d0                	mov    %edx,%eax
  1029e2:	f0 87 01             	lock xchg %eax,(%ecx)

  cprintf("cpu%d: scheduling\n", cpu());
  1029e5:	e8 46 ff ff ff       	call   102930 <cpu>
  1029ea:	c7 04 24 0b 66 10 00 	movl   $0x10660b,(%esp)
  1029f1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1029f5:	e8 a6 dd ff ff       	call   1007a0 <cprintf>
  scheduler();
  1029fa:	e8 11 11 00 00       	call   103b10 <scheduler>
  1029ff:	90                   	nop    

00102a00 <main>:
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  102a00:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  102a04:	83 e4 f0             	and    $0xfffffff0,%esp
  102a07:	ff 71 fc             	pushl  -0x4(%ecx)
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  102a0a:	b8 c4 ea 10 00       	mov    $0x10eac4,%eax
  102a0f:	2d 92 80 10 00       	sub    $0x108092,%eax
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  102a14:	55                   	push   %ebp
  102a15:	89 e5                	mov    %esp,%ebp
  102a17:	53                   	push   %ebx
  102a18:	51                   	push   %ecx
  102a19:	83 ec 10             	sub    $0x10,%esp
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  102a1c:	89 44 24 08          	mov    %eax,0x8(%esp)
  102a20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  102a27:	00 
  102a28:	c7 04 24 92 80 10 00 	movl   $0x108092,(%esp)
  102a2f:	e8 7c 17 00 00       	call   1041b0 <memset>

  mp_init(); // collect info about this machine
  102a34:	e8 c7 01 00 00       	call   102c00 <mp_init>
  lapic_init(mp_bcpu());
  102a39:	e8 32 01 00 00       	call   102b70 <mp_bcpu>
  102a3e:	89 04 24             	mov    %eax,(%esp)
  102a41:	e8 6a fc ff ff       	call   1026b0 <lapic_init>
  cprintf("\ncpu%d: starting xv6\n\n", cpu());
  102a46:	e8 e5 fe ff ff       	call   102930 <cpu>
  102a4b:	c7 04 24 1e 66 10 00 	movl   $0x10661e,(%esp)
  102a52:	89 44 24 04          	mov    %eax,0x4(%esp)
  102a56:	e8 45 dd ff ff       	call   1007a0 <cprintf>

  pinit();         // process table
  102a5b:	e8 f0 14 00 00       	call   103f50 <pinit>
  binit();         // buffer cache
  102a60:	e8 3b d7 ff ff       	call   1001a0 <binit>
  102a65:	8d 76 00             	lea    0x0(%esi),%esi
  pic_init();      // interrupt controller
  102a68:	e8 93 03 00 00       	call   102e00 <pic_init>
  102a6d:	8d 76 00             	lea    0x0(%esi),%esi
  ioapic_init();   // another interrupt controller
  102a70:	e8 6b f8 ff ff       	call   1022e0 <ioapic_init>
  102a75:	8d 76 00             	lea    0x0(%esi),%esi
  kinit();         // physical memory allocator
  102a78:	e8 e3 fa ff ff       	call   102560 <kinit>
  102a7d:	8d 76 00             	lea    0x0(%esi),%esi
  tvinit();        // trap vectors
  102a80:	e8 1b 2c 00 00       	call   1056a0 <tvinit>
  102a85:	8d 76 00             	lea    0x0(%esi),%esi
  fileinit();      // file table
  102a88:	e8 83 e6 ff ff       	call   101110 <fileinit>
  102a8d:	8d 76 00             	lea    0x0(%esi),%esi
  iinit();         // inode cache
  102a90:	e8 3b f5 ff ff       	call   101fd0 <iinit>
  102a95:	8d 76 00             	lea    0x0(%esi),%esi
  console_init();  // I/O devices & their interrupts
  102a98:	e8 83 d7 ff ff       	call   100220 <console_init>
  102a9d:	8d 76 00             	lea    0x0(%esi),%esi
  ide_init();      // disk
  102aa0:	e8 5b f7 ff ff       	call   102200 <ide_init>
  if(!ismp)
  102aa5:	a1 a0 b3 10 00       	mov    0x10b3a0,%eax
  102aaa:	85 c0                	test   %eax,%eax
  102aac:	0f 84 ae 00 00 00    	je     102b60 <main+0x160>
    timer_init();  // uniprocessor timer
  userinit();      // first user process
  102ab2:	e8 99 13 00 00       	call   103e50 <userinit>
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  102ab7:	c7 44 24 08 5a 00 00 	movl   $0x5a,0x8(%esp)
  102abe:	00 
  102abf:	c7 44 24 04 38 80 10 	movl   $0x108038,0x4(%esp)
  102ac6:	00 
  102ac7:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  102ace:	e8 6d 17 00 00       	call   104240 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  102ad3:	69 05 20 ba 10 00 cc 	imul   $0xcc,0x10ba20,%eax
  102ada:	00 00 00 
  102add:	05 c0 b3 10 00       	add    $0x10b3c0,%eax
  102ae2:	3d c0 b3 10 00       	cmp    $0x10b3c0,%eax
  102ae7:	76 72                	jbe    102b5b <main+0x15b>
  102ae9:	bb c0 b3 10 00       	mov    $0x10b3c0,%ebx
  102aee:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpu())  // We've started already.
  102af0:	e8 3b fe ff ff       	call   102930 <cpu>
  102af5:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  102afb:	05 c0 b3 10 00       	add    $0x10b3c0,%eax
  102b00:	39 c3                	cmp    %eax,%ebx
  102b02:	74 3e                	je     102b42 <main+0x142>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
  102b04:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  102b0b:	e8 70 f8 ff ff       	call   102380 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  102b10:	c7 05 f8 6f 00 00 80 	movl   $0x102980,0x6ff8
  102b17:	29 10 00 
    if(c == cpus+cpu())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
    *(void**)(code-4) = stack + KSTACKSIZE;
  102b1a:	05 00 10 00 00       	add    $0x1000,%eax
  102b1f:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapic_startap(c->apicid, (uint)code);
  102b24:	0f b6 03             	movzbl (%ebx),%eax
  102b27:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102b2e:	00 
  102b2f:	89 04 24             	mov    %eax,(%esp)
  102b32:	e8 89 fc ff ff       	call   1027c0 <lapic_startap>
  102b37:	90                   	nop    

    // Wait for cpu to get through bootstrap.
    while(c->booted == 0)
  102b38:	8b 83 c0 00 00 00    	mov    0xc0(%ebx),%eax
  102b3e:	85 c0                	test   %eax,%eax
  102b40:	74 f6                	je     102b38 <main+0x138>

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  102b42:	69 05 20 ba 10 00 cc 	imul   $0xcc,0x10ba20,%eax
  102b49:	00 00 00 
  102b4c:	81 c3 cc 00 00 00    	add    $0xcc,%ebx
  102b52:	05 c0 b3 10 00       	add    $0x10b3c0,%eax
  102b57:	39 c3                	cmp    %eax,%ebx
  102b59:	72 95                	jb     102af0 <main+0xf0>
    timer_init();  // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102b5b:	e8 20 fe ff ff       	call   102980 <mpmain>
  fileinit();      // file table
  iinit();         // inode cache
  console_init();  // I/O devices & their interrupts
  ide_init();      // disk
  if(!ismp)
    timer_init();  // uniprocessor timer
  102b60:	e8 2b 28 00 00       	call   105390 <timer_init>
  102b65:	8d 76 00             	lea    0x0(%esi),%esi
  102b68:	e9 45 ff ff ff       	jmp    102ab2 <main+0xb2>
  102b6d:	90                   	nop    
  102b6e:	90                   	nop    
  102b6f:	90                   	nop    

00102b70 <mp_bcpu>:
int ncpu;
uchar ioapic_id;

int
mp_bcpu(void)
{
  102b70:	a1 44 81 10 00       	mov    0x108144,%eax
  102b75:	55                   	push   %ebp
  102b76:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  102b78:	5d                   	pop    %ebp
int ncpu;
uchar ioapic_id;

int
mp_bcpu(void)
{
  102b79:	2d c0 b3 10 00       	sub    $0x10b3c0,%eax
  102b7e:	c1 f8 02             	sar    $0x2,%eax
  102b81:	69 c0 fb fa fa fa    	imul   $0xfafafafb,%eax,%eax
  return bcpu-cpus;
}
  102b87:	c3                   	ret    
  102b88:	90                   	nop    
  102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102b90 <mp_search1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  102b90:	55                   	push   %ebp
  102b91:	89 e5                	mov    %esp,%ebp
  102b93:	56                   	push   %esi
  102b94:	53                   	push   %ebx
  uchar *e, *p;

  e = addr+len;
  102b95:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  102b98:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102b9b:	39 f0                	cmp    %esi,%eax
  102b9d:	73 42                	jae    102be1 <mp_search1+0x51>
  102b9f:	89 c3                	mov    %eax,%ebx
  102ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102ba8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102baf:	00 
  102bb0:	c7 44 24 04 35 66 10 	movl   $0x106635,0x4(%esp)
  102bb7:	00 
  102bb8:	89 1c 24             	mov    %ebx,(%esp)
  102bbb:	e8 20 16 00 00       	call   1041e0 <memcmp>
  102bc0:	85 c0                	test   %eax,%eax
  102bc2:	75 16                	jne    102bda <mp_search1+0x4a>
  102bc4:	31 d2                	xor    %edx,%edx
  102bc6:	31 c9                	xor    %ecx,%ecx
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  102bc8:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102bcc:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  102bcf:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102bd1:	83 fa 10             	cmp    $0x10,%edx
  102bd4:	75 f2                	jne    102bc8 <mp_search1+0x38>
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102bd6:	84 c9                	test   %cl,%cl
  102bd8:	74 10                	je     102bea <mp_search1+0x5a>
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102bda:	83 c3 10             	add    $0x10,%ebx
  102bdd:	39 de                	cmp    %ebx,%esi
  102bdf:	77 c7                	ja     102ba8 <mp_search1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102be1:	83 c4 10             	add    $0x10,%esp
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102be4:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102be6:	5b                   	pop    %ebx
  102be7:	5e                   	pop    %esi
  102be8:	5d                   	pop    %ebp
  102be9:	c3                   	ret    
  102bea:	83 c4 10             	add    $0x10,%esp
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  102bed:	89 d8                	mov    %ebx,%eax
  return 0;
}
  102bef:	5b                   	pop    %ebx
  102bf0:	5e                   	pop    %esi
  102bf1:	5d                   	pop    %ebp
  102bf2:	c3                   	ret    
  102bf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102c00 <mp_init>:
  return conf;
}

void
mp_init(void)
{
  102c00:	55                   	push   %ebp
  102c01:	89 e5                	mov    %esp,%ebp
  102c03:	57                   	push   %edi
  102c04:	56                   	push   %esi
  102c05:	53                   	push   %ebx
  102c06:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102c09:	0f b6 0d 0f 04 00 00 	movzbl 0x40f,%ecx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[ncpu];
  102c10:	69 05 20 ba 10 00 cc 	imul   $0xcc,0x10ba20,%eax
  102c17:	00 00 00 
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102c1a:	c1 e1 08             	shl    $0x8,%ecx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[ncpu];
  102c1d:	05 c0 b3 10 00       	add    $0x10b3c0,%eax
  102c22:	a3 44 81 10 00       	mov    %eax,0x108144
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102c27:	0f b6 05 0e 04 00 00 	movzbl 0x40e,%eax
  102c2e:	09 c1                	or     %eax,%ecx
  102c30:	c1 e1 04             	shl    $0x4,%ecx
  102c33:	85 c9                	test   %ecx,%ecx
  102c35:	74 51                	je     102c88 <mp_init+0x88>
    if((mp = mp_search1((uchar*)p, 1024)))
  102c37:	ba 00 04 00 00       	mov    $0x400,%edx
  102c3c:	89 c8                	mov    %ecx,%eax
  102c3e:	e8 4d ff ff ff       	call   102b90 <mp_search1>
  102c43:	85 c0                	test   %eax,%eax
  102c45:	89 c7                	mov    %eax,%edi
  102c47:	74 6a                	je     102cb3 <mp_init+0xb3>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102c49:	8b 5f 04             	mov    0x4(%edi),%ebx
  102c4c:	85 db                	test   %ebx,%ebx
  102c4e:	74 30                	je     102c80 <mp_init+0x80>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  102c50:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102c57:	00 
  102c58:	c7 44 24 04 3a 66 10 	movl   $0x10663a,0x4(%esp)
  102c5f:	00 
  102c60:	89 1c 24             	mov    %ebx,(%esp)
  102c63:	e8 78 15 00 00       	call   1041e0 <memcmp>
  102c68:	85 c0                	test   %eax,%eax
  102c6a:	75 14                	jne    102c80 <mp_init+0x80>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102c6c:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  102c70:	3c 01                	cmp    $0x1,%al
  102c72:	74 5c                	je     102cd0 <mp_init+0xd0>
  102c74:	3c 04                	cmp    $0x4,%al
  102c76:	66 90                	xchg   %ax,%ax
  102c78:	74 56                	je     102cd0 <mp_init+0xd0>
  102c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102c80:	83 c4 1c             	add    $0x1c,%esp
  102c83:	5b                   	pop    %ebx
  102c84:	5e                   	pop    %esi
  102c85:	5f                   	pop    %edi
  102c86:	5d                   	pop    %ebp
  102c87:	c3                   	ret    
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
    if((mp = mp_search1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
  102c88:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102c8f:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102c96:	c1 e0 08             	shl    $0x8,%eax
  102c99:	09 d0                	or     %edx,%eax
  102c9b:	ba 00 04 00 00       	mov    $0x400,%edx
  102ca0:	c1 e0 0a             	shl    $0xa,%eax
  102ca3:	2d 00 04 00 00       	sub    $0x400,%eax
  102ca8:	e8 e3 fe ff ff       	call   102b90 <mp_search1>
  102cad:	85 c0                	test   %eax,%eax
  102caf:	89 c7                	mov    %eax,%edi
  102cb1:	75 96                	jne    102c49 <mp_init+0x49>
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102cb3:	ba 00 00 01 00       	mov    $0x10000,%edx
  102cb8:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102cbd:	e8 ce fe ff ff       	call   102b90 <mp_search1>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102cc2:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102cc4:	89 c7                	mov    %eax,%edi
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102cc6:	75 81                	jne    102c49 <mp_init+0x49>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102cc8:	83 c4 1c             	add    $0x1c,%esp
  102ccb:	5b                   	pop    %ebx
  102ccc:	5e                   	pop    %esi
  102ccd:	5f                   	pop    %edi
  102cce:	5d                   	pop    %ebp
  102ccf:	c3                   	ret    
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102cd0:	0f b7 73 04          	movzwl 0x4(%ebx),%esi
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102cd4:	85 f6                	test   %esi,%esi
  102cd6:	74 19                	je     102cf1 <mp_init+0xf1>
  102cd8:	31 d2                	xor    %edx,%edx
  102cda:	31 c9                	xor    %ecx,%ecx
  102cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
  102ce0:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102ce4:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  102ce7:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102ce9:	39 d6                	cmp    %edx,%esi
  102ceb:	7f f3                	jg     102ce0 <mp_init+0xe0>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102ced:	84 c9                	test   %cl,%cl
  102cef:	75 8f                	jne    102c80 <mp_init+0x80>
  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  102cf1:	8b 43 24             	mov    0x24(%ebx),%eax

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102cf4:	8d 34 33             	lea    (%ebx,%esi,1),%esi
  102cf7:	8d 53 2c             	lea    0x2c(%ebx),%edx
  102cfa:	39 f2                	cmp    %esi,%edx

  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  102cfc:	c7 05 a0 b3 10 00 01 	movl   $0x1,0x10b3a0
  102d03:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  102d06:	a3 98 b3 10 00       	mov    %eax,0x10b398

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102d0b:	89 75 f0             	mov    %esi,-0x10(%ebp)
  102d0e:	73 5f                	jae    102d6f <mp_init+0x16f>
  102d10:	8b 35 44 81 10 00    	mov    0x108144,%esi
    switch(*p){
  102d16:	0f b6 02             	movzbl (%edx),%eax
  102d19:	3c 04                	cmp    $0x4,%al
  102d1b:	76 2b                	jbe    102d48 <mp_init+0x148>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102d1d:	0f b6 c0             	movzbl %al,%eax
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  102d20:	89 35 44 81 10 00    	mov    %esi,0x108144
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102d26:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d2a:	c7 04 24 48 66 10 00 	movl   $0x106648,(%esp)
  102d31:	e8 6a da ff ff       	call   1007a0 <cprintf>
      panic("mp_init");
  102d36:	c7 04 24 3f 66 10 00 	movl   $0x10663f,(%esp)
  102d3d:	e8 2e dc ff ff       	call   100970 <panic>
  102d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  102d48:	0f b6 c0             	movzbl %al,%eax
  102d4b:	ff 24 85 6c 66 10 00 	jmp    *0x10666c(,%eax,4)
  102d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102d58:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
  102d5c:	83 c2 08             	add    $0x8,%edx
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102d5f:	a2 a4 b3 10 00       	mov    %al,0x10b3a4
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102d64:	39 55 f0             	cmp    %edx,-0x10(%ebp)
  102d67:	77 ad                	ja     102d16 <mp_init+0x116>
  102d69:	89 35 44 81 10 00    	mov    %esi,0x108144
      cprintf("mp_init: unknown config type %x\n", *p);
      panic("mp_init");
    }
  }

  if(mp->imcrp){
  102d6f:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  102d73:	0f 84 07 ff ff ff    	je     102c80 <mp_init+0x80>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102d79:	ba 22 00 00 00       	mov    $0x22,%edx
  102d7e:	b8 70 00 00 00       	mov    $0x70,%eax
  102d83:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102d84:	b2 23                	mov    $0x23,%dl
  102d86:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102d87:	83 c8 01             	or     $0x1,%eax
  102d8a:	ee                   	out    %al,(%dx)
  102d8b:	e9 f0 fe ff ff       	jmp    102c80 <mp_init+0x80>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102d90:	83 c2 08             	add    $0x8,%edx
  102d93:	eb cf                	jmp    102d64 <mp_init+0x164>
  102d95:	8d 76 00             	lea    0x0(%esi),%esi

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
  102d98:	8b 1d 20 ba 10 00    	mov    0x10ba20,%ebx
  102d9e:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  102da2:	69 cb cc 00 00 00    	imul   $0xcc,%ebx,%ecx
  102da8:	88 81 c0 b3 10 00    	mov    %al,0x10b3c0(%ecx)
      if(proc->flags & MPBOOT)
  102dae:	f6 42 03 02          	testb  $0x2,0x3(%edx)
  102db2:	74 06                	je     102dba <mp_init+0x1ba>
        bcpu = &cpus[ncpu];
  102db4:	8d b1 c0 b3 10 00    	lea    0x10b3c0(%ecx),%esi
      ncpu++;
  102dba:	8d 43 01             	lea    0x1(%ebx),%eax
      p += sizeof(struct mpproc);
  102dbd:	83 c2 14             	add    $0x14,%edx
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      ncpu++;
  102dc0:	a3 20 ba 10 00       	mov    %eax,0x10ba20
  102dc5:	eb 9d                	jmp    102d64 <mp_init+0x164>
  102dc7:	90                   	nop    
  102dc8:	90                   	nop    
  102dc9:	90                   	nop    
  102dca:	90                   	nop    
  102dcb:	90                   	nop    
  102dcc:	90                   	nop    
  102dcd:	90                   	nop    
  102dce:	90                   	nop    
  102dcf:	90                   	nop    

00102dd0 <pic_enable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
pic_enable(int irq)
{
  102dd0:	55                   	push   %ebp
  pic_setmask(irqmask & ~(1<<irq));
  102dd1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
pic_enable(int irq)
{
  102dd6:	89 e5                	mov    %esp,%ebp
  102dd8:	ba 21 00 00 00       	mov    $0x21,%edx
  pic_setmask(irqmask & ~(1<<irq));
  102ddd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  102de0:	d3 c0                	rol    %cl,%eax
  102de2:	66 23 05 00 7c 10 00 	and    0x107c00,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
pic_setmask(ushort mask)
{
  irqmask = mask;
  102de9:	66 a3 00 7c 10 00    	mov    %ax,0x107c00
  102def:	ee                   	out    %al,(%dx)

void
pic_enable(int irq)
{
  pic_setmask(irqmask & ~(1<<irq));
}
  102df0:	66 c1 e8 08          	shr    $0x8,%ax
  102df4:	b2 a1                	mov    $0xa1,%dl
  102df6:	ee                   	out    %al,(%dx)
  102df7:	5d                   	pop    %ebp
  102df8:	c3                   	ret    
  102df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102e00 <pic_init>:

// Initialize the 8259A interrupt controllers.
void
pic_init(void)
{
  102e00:	55                   	push   %ebp
  102e01:	b9 21 00 00 00       	mov    $0x21,%ecx
  102e06:	89 e5                	mov    %esp,%ebp
  102e08:	83 ec 0c             	sub    $0xc,%esp
  102e0b:	89 1c 24             	mov    %ebx,(%esp)
  102e0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102e13:	89 ca                	mov    %ecx,%edx
  102e15:	89 74 24 04          	mov    %esi,0x4(%esp)
  102e19:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102e1d:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102e1e:	bb a1 00 00 00       	mov    $0xa1,%ebx
  102e23:	89 da                	mov    %ebx,%edx
  102e25:	ee                   	out    %al,(%dx)
  102e26:	be 20 00 00 00       	mov    $0x20,%esi
  102e2b:	b8 11 00 00 00       	mov    $0x11,%eax
  102e30:	89 f2                	mov    %esi,%edx
  102e32:	ee                   	out    %al,(%dx)
  102e33:	b8 20 00 00 00       	mov    $0x20,%eax
  102e38:	89 ca                	mov    %ecx,%edx
  102e3a:	ee                   	out    %al,(%dx)
  102e3b:	b8 04 00 00 00       	mov    $0x4,%eax
  102e40:	ee                   	out    %al,(%dx)
  102e41:	bf 03 00 00 00       	mov    $0x3,%edi
  102e46:	89 f8                	mov    %edi,%eax
  102e48:	ee                   	out    %al,(%dx)
  102e49:	b1 a0                	mov    $0xa0,%cl
  102e4b:	b8 11 00 00 00       	mov    $0x11,%eax
  102e50:	89 ca                	mov    %ecx,%edx
  102e52:	ee                   	out    %al,(%dx)
  102e53:	b8 28 00 00 00       	mov    $0x28,%eax
  102e58:	89 da                	mov    %ebx,%edx
  102e5a:	ee                   	out    %al,(%dx)
  102e5b:	b8 02 00 00 00       	mov    $0x2,%eax
  102e60:	ee                   	out    %al,(%dx)
  102e61:	89 f8                	mov    %edi,%eax
  102e63:	ee                   	out    %al,(%dx)
  102e64:	bb 68 00 00 00       	mov    $0x68,%ebx
  102e69:	89 f2                	mov    %esi,%edx
  102e6b:	89 d8                	mov    %ebx,%eax
  102e6d:	ee                   	out    %al,(%dx)
  102e6e:	bf 0a 00 00 00       	mov    $0xa,%edi
  102e73:	89 f8                	mov    %edi,%eax
  102e75:	ee                   	out    %al,(%dx)
  102e76:	89 d8                	mov    %ebx,%eax
  102e78:	89 ca                	mov    %ecx,%edx
  102e7a:	ee                   	out    %al,(%dx)
  102e7b:	89 f8                	mov    %edi,%eax
  102e7d:	ee                   	out    %al,(%dx)
  102e7e:	0f b7 05 00 7c 10 00 	movzwl 0x107c00,%eax
  102e85:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102e89:	74 0a                	je     102e95 <pic_init+0x95>
  102e8b:	b2 21                	mov    $0x21,%dl
  102e8d:	ee                   	out    %al,(%dx)
    pic_setmask(irqmask);
}
  102e8e:	66 c1 e8 08          	shr    $0x8,%ax
  102e92:	b2 a1                	mov    $0xa1,%dl
  102e94:	ee                   	out    %al,(%dx)
  102e95:	8b 1c 24             	mov    (%esp),%ebx
  102e98:	8b 74 24 04          	mov    0x4(%esp),%esi
  102e9c:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102ea0:	89 ec                	mov    %ebp,%esp
  102ea2:	5d                   	pop    %ebp
  102ea3:	c3                   	ret    
  102ea4:	90                   	nop    
  102ea5:	90                   	nop    
  102ea6:	90                   	nop    
  102ea7:	90                   	nop    
  102ea8:	90                   	nop    
  102ea9:	90                   	nop    
  102eaa:	90                   	nop    
  102eab:	90                   	nop    
  102eac:	90                   	nop    
  102ead:	90                   	nop    
  102eae:	90                   	nop    
  102eaf:	90                   	nop    

00102eb0 <piperead>:
  return i;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  102eb0:	55                   	push   %ebp
  102eb1:	89 e5                	mov    %esp,%ebp
  102eb3:	57                   	push   %edi
  102eb4:	56                   	push   %esi
  102eb5:	53                   	push   %ebx
  102eb6:	83 ec 0c             	sub    $0xc,%esp
  102eb9:	8b 75 08             	mov    0x8(%ebp),%esi
  int i;

  acquire(&p->lock);
  102ebc:	8d 7e 10             	lea    0x10(%esi),%edi
  102ebf:	89 3c 24             	mov    %edi,(%esp)
  102ec2:	e8 79 12 00 00       	call   104140 <acquire>
  while(p->readp == p->writep && p->writeopen){
  102ec7:	8b 46 0c             	mov    0xc(%esi),%eax
  102eca:	3b 46 08             	cmp    0x8(%esi),%eax
  102ecd:	75 51                	jne    102f20 <piperead+0x70>
  102ecf:	8b 56 04             	mov    0x4(%esi),%edx
  102ed2:	85 d2                	test   %edx,%edx
  102ed4:	74 4a                	je     102f20 <piperead+0x70>
    if(cp->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  102ed6:	8d 5e 0c             	lea    0xc(%esi),%ebx
  102ed9:	eb 20                	jmp    102efb <piperead+0x4b>
  102edb:	90                   	nop    
  102edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102ee0:	89 7c 24 04          	mov    %edi,0x4(%esp)
  102ee4:	89 1c 24             	mov    %ebx,(%esp)
  102ee7:	e8 34 08 00 00       	call   103720 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
  102eec:	8b 46 0c             	mov    0xc(%esi),%eax
  102eef:	3b 46 08             	cmp    0x8(%esi),%eax
  102ef2:	75 2c                	jne    102f20 <piperead+0x70>
  102ef4:	8b 4e 04             	mov    0x4(%esi),%ecx
  102ef7:	85 c9                	test   %ecx,%ecx
  102ef9:	74 25                	je     102f20 <piperead+0x70>
    if(cp->killed){
  102efb:	e8 c0 05 00 00       	call   1034c0 <curproc>
  102f00:	8b 40 1c             	mov    0x1c(%eax),%eax
  102f03:	85 c0                	test   %eax,%eax
  102f05:	74 d9                	je     102ee0 <piperead+0x30>
      release(&p->lock);
  102f07:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  102f0c:	89 3c 24             	mov    %edi,(%esp)
  102f0f:	e8 ec 11 00 00       	call   104100 <release>
    addr[i] = p->data[p->readp++ % PIPESIZE];
  }
  wakeup(&p->writep);
  release(&p->lock);
  return i;
}
  102f14:	83 c4 0c             	add    $0xc,%esp
  102f17:	89 d8                	mov    %ebx,%eax
  102f19:	5b                   	pop    %ebx
  102f1a:	5e                   	pop    %esi
  102f1b:	5f                   	pop    %edi
  102f1c:	5d                   	pop    %ebp
  102f1d:	c3                   	ret    
  102f1e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102f20:	8b 55 10             	mov    0x10(%ebp),%edx
  102f23:	85 d2                	test   %edx,%edx
  102f25:	7e 58                	jle    102f7f <piperead+0xcf>
    if(p->readp == p->writep)
  102f27:	31 db                	xor    %ebx,%ebx
  102f29:	89 c2                	mov    %eax,%edx
  102f2b:	3b 46 08             	cmp    0x8(%esi),%eax
  102f2e:	75 12                	jne    102f42 <piperead+0x92>
  102f30:	eb 4d                	jmp    102f7f <piperead+0xcf>
  102f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102f38:	39 56 08             	cmp    %edx,0x8(%esi)
  102f3b:	90                   	nop    
  102f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102f40:	74 20                	je     102f62 <piperead+0xb2>
      break;
    addr[i] = p->data[p->readp++ % PIPESIZE];
  102f42:	89 d0                	mov    %edx,%eax
  102f44:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102f47:	83 c2 01             	add    $0x1,%edx
  102f4a:	25 ff 01 00 00       	and    $0x1ff,%eax
  102f4f:	0f b6 44 06 44       	movzbl 0x44(%esi,%eax,1),%eax
  102f54:	88 04 19             	mov    %al,(%ecx,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102f57:	83 c3 01             	add    $0x1,%ebx
  102f5a:	39 5d 10             	cmp    %ebx,0x10(%ebp)
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp++ % PIPESIZE];
  102f5d:	89 56 0c             	mov    %edx,0xc(%esi)
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102f60:	7f d6                	jg     102f38 <piperead+0x88>
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp++ % PIPESIZE];
  }
  wakeup(&p->writep);
  102f62:	8d 46 08             	lea    0x8(%esi),%eax
  102f65:	89 04 24             	mov    %eax,(%esp)
  102f68:	e8 d3 04 00 00       	call   103440 <wakeup>
  release(&p->lock);
  102f6d:	89 3c 24             	mov    %edi,(%esp)
  102f70:	e8 8b 11 00 00       	call   104100 <release>
  return i;
}
  102f75:	83 c4 0c             	add    $0xc,%esp
  102f78:	89 d8                	mov    %ebx,%eax
  102f7a:	5b                   	pop    %ebx
  102f7b:	5e                   	pop    %esi
  102f7c:	5f                   	pop    %edi
  102f7d:	5d                   	pop    %ebp
  102f7e:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102f7f:	31 db                	xor    %ebx,%ebx
  102f81:	eb df                	jmp    102f62 <piperead+0xb2>
  102f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102f90 <pipewrite>:
    kfree((char*)p, PAGE);
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102f90:	55                   	push   %ebp
  102f91:	89 e5                	mov    %esp,%ebp
  102f93:	57                   	push   %edi
  102f94:	56                   	push   %esi
  102f95:	53                   	push   %ebx
  102f96:	83 ec 1c             	sub    $0x1c,%esp
  102f99:	8b 75 08             	mov    0x8(%ebp),%esi
  int i;

  acquire(&p->lock);
  102f9c:	8d 46 10             	lea    0x10(%esi),%eax
  102f9f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102fa2:	89 04 24             	mov    %eax,(%esp)
  102fa5:	e8 96 11 00 00       	call   104140 <acquire>
  for(i = 0; i < n; i++){
  102faa:	8b 7d 10             	mov    0x10(%ebp),%edi
  102fad:	85 ff                	test   %edi,%edi
  102faf:	0f 8e ca 00 00 00    	jle    10307f <pipewrite+0xef>
  102fb5:	8b 5e 0c             	mov    0xc(%esi),%ebx
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
  102fb8:	8d 56 08             	lea    0x8(%esi),%edx
    while(p->writep == p->readp + PIPESIZE) {
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102fbb:	8d 7e 0c             	lea    0xc(%esi),%edi
      sleep(&p->writep, &p->lock);
  102fbe:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102fc1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->writep == p->readp + PIPESIZE) {
  102fc8:	8b 4e 08             	mov    0x8(%esi),%ecx
  102fcb:	8d 83 00 02 00 00    	lea    0x200(%ebx),%eax
  102fd1:	39 c1                	cmp    %eax,%ecx
  102fd3:	74 3f                	je     103014 <pipewrite+0x84>
  102fd5:	eb 61                	jmp    103038 <pipewrite+0xa8>
  102fd7:	90                   	nop    
      if(p->readopen == 0 || cp->killed){
  102fd8:	e8 e3 04 00 00       	call   1034c0 <curproc>
  102fdd:	8b 48 1c             	mov    0x1c(%eax),%ecx
  102fe0:	85 c9                	test   %ecx,%ecx
  102fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102fe8:	75 30                	jne    10301a <pipewrite+0x8a>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102fea:	89 3c 24             	mov    %edi,(%esp)
  102fed:	e8 4e 04 00 00       	call   103440 <wakeup>
      sleep(&p->writep, &p->lock);
  102ff2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ff5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102ff8:	89 04 24             	mov    %eax,(%esp)
  102ffb:	89 54 24 04          	mov    %edx,0x4(%esp)
  102fff:	e8 1c 07 00 00       	call   103720 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->writep == p->readp + PIPESIZE) {
  103004:	8b 5e 0c             	mov    0xc(%esi),%ebx
  103007:	8b 4e 08             	mov    0x8(%esi),%ecx
  10300a:	8d 83 00 02 00 00    	lea    0x200(%ebx),%eax
  103010:	39 c1                	cmp    %eax,%ecx
  103012:	75 24                	jne    103038 <pipewrite+0xa8>
      if(p->readopen == 0 || cp->killed){
  103014:	8b 1e                	mov    (%esi),%ebx
  103016:	85 db                	test   %ebx,%ebx
  103018:	75 be                	jne    102fd8 <pipewrite+0x48>
        release(&p->lock);
  10301a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10301d:	89 04 24             	mov    %eax,(%esp)
  103020:	e8 db 10 00 00       	call   104100 <release>
  103025:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    p->data[p->writep++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->readp);
  release(&p->lock);
  return i;
}
  10302c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10302f:	83 c4 1c             	add    $0x1c,%esp
  103032:	5b                   	pop    %ebx
  103033:	5e                   	pop    %esi
  103034:	5f                   	pop    %edi
  103035:	5d                   	pop    %ebp
  103036:	c3                   	ret    
  103037:	90                   	nop    
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep++ % PIPESIZE] = addr[i];
  103038:	89 ca                	mov    %ecx,%edx
  10303a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10303d:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  103043:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103046:	8b 55 0c             	mov    0xc(%ebp),%edx
  103049:	0f b6 04 02          	movzbl (%edx,%eax,1),%eax
  10304d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103050:	88 44 16 44          	mov    %al,0x44(%esi,%edx,1)
  103054:	8d 41 01             	lea    0x1(%ecx),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  103057:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep++ % PIPESIZE] = addr[i];
  10305b:	89 46 08             	mov    %eax,0x8(%esi)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  10305e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103061:	39 45 10             	cmp    %eax,0x10(%ebp)
  103064:	0f 8f 5e ff ff ff    	jg     102fc8 <pipewrite+0x38>
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->readp);
  10306a:	89 3c 24             	mov    %edi,(%esp)
  10306d:	e8 ce 03 00 00       	call   103440 <wakeup>
  release(&p->lock);
  103072:	8b 55 e8             	mov    -0x18(%ebp),%edx
  103075:	89 14 24             	mov    %edx,(%esp)
  103078:	e8 83 10 00 00       	call   104100 <release>
  10307d:	eb ad                	jmp    10302c <pipewrite+0x9c>
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->writep == p->readp + PIPESIZE) {
      if(p->readopen == 0 || cp->killed){
  10307f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  103086:	8d 7e 0c             	lea    0xc(%esi),%edi
  103089:	eb df                	jmp    10306a <pipewrite+0xda>
  10308b:	90                   	nop    
  10308c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103090 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  103090:	55                   	push   %ebp
  103091:	89 e5                	mov    %esp,%ebp
  103093:	83 ec 18             	sub    $0x18,%esp
  103096:	89 75 f8             	mov    %esi,-0x8(%ebp)
  103099:	8b 75 08             	mov    0x8(%ebp),%esi
  10309c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10309f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  1030a2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&p->lock);
  1030a5:	8d 7e 10             	lea    0x10(%esi),%edi
  1030a8:	89 3c 24             	mov    %edi,(%esp)
  1030ab:	e8 90 10 00 00       	call   104140 <acquire>
  if(writable){
  1030b0:	85 db                	test   %ebx,%ebx
  1030b2:	74 34                	je     1030e8 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->readp);
  1030b4:	8d 46 0c             	lea    0xc(%esi),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  1030b7:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
    wakeup(&p->readp);
  1030be:	89 04 24             	mov    %eax,(%esp)
  1030c1:	e8 7a 03 00 00       	call   103440 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  }
  release(&p->lock);
  1030c6:	89 3c 24             	mov    %edi,(%esp)
  1030c9:	e8 32 10 00 00       	call   104100 <release>

  if(p->readopen == 0 && p->writeopen == 0)
  1030ce:	8b 06                	mov    (%esi),%eax
  1030d0:	85 c0                	test   %eax,%eax
  1030d2:	75 07                	jne    1030db <pipeclose+0x4b>
  1030d4:	8b 46 04             	mov    0x4(%esi),%eax
  1030d7:	85 c0                	test   %eax,%eax
  1030d9:	74 25                	je     103100 <pipeclose+0x70>
    kfree((char*)p, PAGE);
}
  1030db:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1030de:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1030e1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1030e4:	89 ec                	mov    %ebp,%esp
  1030e6:	5d                   	pop    %ebp
  1030e7:	c3                   	ret    
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  1030e8:	8d 46 08             	lea    0x8(%esi),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
  1030eb:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    wakeup(&p->writep);
  1030f1:	89 04 24             	mov    %eax,(%esp)
  1030f4:	e8 47 03 00 00       	call   103440 <wakeup>
  1030f9:	eb cb                	jmp    1030c6 <pipeclose+0x36>
  1030fb:	90                   	nop    
  1030fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  103100:	89 75 08             	mov    %esi,0x8(%ebp)
}
  103103:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  103106:	c7 45 0c 00 10 00 00 	movl   $0x1000,0xc(%ebp)
}
  10310d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  103110:	8b 7d fc             	mov    -0x4(%ebp),%edi
  103113:	89 ec                	mov    %ebp,%esp
  103115:	5d                   	pop    %ebp
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  103116:	e9 25 f3 ff ff       	jmp    102440 <kfree>
  10311b:	90                   	nop    
  10311c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103120 <pipealloc>:
  char data[PIPESIZE];
};

int
pipealloc(struct file **f0, struct file **f1)
{
  103120:	55                   	push   %ebp
  103121:	89 e5                	mov    %esp,%ebp
  103123:	83 ec 18             	sub    $0x18,%esp
  103126:	89 75 f8             	mov    %esi,-0x8(%ebp)
  103129:	8b 75 08             	mov    0x8(%ebp),%esi
  10312c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10312f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  103132:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  103135:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  10313b:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  103141:	e8 7a de ff ff       	call   100fc0 <filealloc>
  103146:	85 c0                	test   %eax,%eax
  103148:	89 06                	mov    %eax,(%esi)
  10314a:	0f 84 a4 00 00 00    	je     1031f4 <pipealloc+0xd4>
  103150:	e8 6b de ff ff       	call   100fc0 <filealloc>
  103155:	85 c0                	test   %eax,%eax
  103157:	89 07                	mov    %eax,(%edi)
  103159:	0f 84 81 00 00 00    	je     1031e0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
  10315f:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103166:	e8 15 f2 ff ff       	call   102380 <kalloc>
  10316b:	85 c0                	test   %eax,%eax
  10316d:	89 c3                	mov    %eax,%ebx
  10316f:	74 6f                	je     1031e0 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
  103171:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  p->writeopen = 1;
  103177:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
  p->writep = 0;
  10317e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  p->readp = 0;
  103185:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  initlock(&p->lock, "pipe");
  10318c:	8d 40 10             	lea    0x10(%eax),%eax
  10318f:	89 04 24             	mov    %eax,(%esp)
  103192:	c7 44 24 04 80 66 10 	movl   $0x106680,0x4(%esp)
  103199:	00 
  10319a:	e8 d1 0d 00 00       	call   103f70 <initlock>
  (*f0)->type = FD_PIPE;
  10319f:	8b 06                	mov    (%esi),%eax
  (*f0)->readable = 1;
  1031a1:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->readopen = 1;
  p->writeopen = 1;
  p->writep = 0;
  p->readp = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  1031a5:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  1031ab:	8b 06                	mov    (%esi),%eax
  1031ad:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  1031b1:	8b 06                	mov    (%esi),%eax
  1031b3:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
  1031b6:	8b 07                	mov    (%edi),%eax
  (*f1)->readable = 0;
  1031b8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  1031bc:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  1031c2:	8b 07                	mov    (%edi),%eax
  1031c4:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  1031c8:	8b 07                	mov    (%edi),%eax
  1031ca:	89 58 0c             	mov    %ebx,0xc(%eax)
  1031cd:	31 c0                	xor    %eax,%eax
  if(*f1){
    (*f1)->type = FD_NONE;
    fileclose(*f1);
  }
  return -1;
}
  1031cf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1031d2:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1031d5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1031d8:	89 ec                	mov    %ebp,%esp
  1031da:	5d                   	pop    %ebp
  1031db:	c3                   	ret    
  1031dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;

 bad:
  if(p)
    kfree((char*)p, PAGE);
  if(*f0){
  1031e0:	8b 06                	mov    (%esi),%eax
  1031e2:	85 c0                	test   %eax,%eax
  1031e4:	74 0e                	je     1031f4 <pipealloc+0xd4>
    (*f0)->type = FD_NONE;
  1031e6:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    fileclose(*f0);
  1031ec:	89 04 24             	mov    %eax,(%esp)
  1031ef:	e8 4c de ff ff       	call   101040 <fileclose>
  }
  if(*f1){
  1031f4:	8b 17                	mov    (%edi),%edx
  1031f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1031fb:	85 d2                	test   %edx,%edx
  1031fd:	74 d0                	je     1031cf <pipealloc+0xaf>
    (*f1)->type = FD_NONE;
  1031ff:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    fileclose(*f1);
  103205:	89 14 24             	mov    %edx,(%esp)
  103208:	e8 33 de ff ff       	call   101040 <fileclose>
  10320d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103212:	eb bb                	jmp    1031cf <pipealloc+0xaf>
  103214:	90                   	nop    
  103215:	90                   	nop    
  103216:	90                   	nop    
  103217:	90                   	nop    
  103218:	90                   	nop    
  103219:	90                   	nop    
  10321a:	90                   	nop    
  10321b:	90                   	nop    
  10321c:	90                   	nop    
  10321d:	90                   	nop    
  10321e:	90                   	nop    
  10321f:	90                   	nop    

00103220 <randInt>:
unsigned long int next = 1;
 
/* randInt: returns random integer  0..32767 */
int randInt(void)
{
  next = next * 1103515245 + 12345;
  103220:	69 05 08 7c 10 00 6d 	imul   $0x41c64e6d,0x107c08,%eax
  103227:	4e c6 41 

unsigned long int next = 1;
 
/* randInt: returns random integer  0..32767 */
int randInt(void)
{
  10322a:	55                   	push   %ebp
  10322b:	89 e5                	mov    %esp,%ebp
  next = next * 1103515245 + 12345;
  return (unsigned int)(next/65536) % 32768;
}
  10322d:	5d                   	pop    %ebp
unsigned long int next = 1;
 
/* randInt: returns random integer  0..32767 */
int randInt(void)
{
  next = next * 1103515245 + 12345;
  10322e:	05 39 30 00 00       	add    $0x3039,%eax
  103233:	a3 08 7c 10 00       	mov    %eax,0x107c08
  103238:	c1 e8 10             	shr    $0x10,%eax
  10323b:	25 ff 7f 00 00       	and    $0x7fff,%eax
  return (unsigned int)(next/65536) % 32768;
}
  103240:	c3                   	ret    
  103241:	eb 0d                	jmp    103250 <setticks>
  103243:	90                   	nop    
  103244:	90                   	nop    
  103245:	90                   	nop    
  103246:	90                   	nop    
  103247:	90                   	nop    
  103248:	90                   	nop    
  103249:	90                   	nop    
  10324a:	90                   	nop    
  10324b:	90                   	nop    
  10324c:	90                   	nop    
  10324d:	90                   	nop    
  10324e:	90                   	nop    
  10324f:	90                   	nop    

00103250 <setticks>:
  }
}
//sets the number of tickets that process pid has.
int
setticks(int pid, int newTickets)
{
  103250:	55                   	push   %ebp
  103251:	ba 40 ba 10 00       	mov    $0x10ba40,%edx
  103256:	89 e5                	mov    %esp,%ebp
  103258:	8b 45 08             	mov    0x8(%ebp),%eax
  10325b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10325e:	eb 0e                	jmp    10326e <setticks+0x1e>
    p = &proc[i];
    if(p->pid == pid)
    {
      numTickets += (newTickets - p->tickets);
      p->tickets = newTickets;
      return 0;
  103260:	81 c2 a0 00 00 00    	add    $0xa0,%edx
  struct proc *p;
  int i;
 

 
  for(i = 0; i < NPROC; i++)
  103266:	81 fa 40 e2 10 00    	cmp    $0x10e240,%edx
  10326c:	74 22                	je     103290 <setticks+0x40>
  {
    p = &proc[i];
    if(p->pid == pid)
  10326e:	39 42 10             	cmp    %eax,0x10(%edx)
  103271:	75 ed                	jne    103260 <setticks+0x10>
    {
      numTickets += (newTickets - p->tickets);
  103273:	89 c8                	mov    %ecx,%eax
  103275:	03 05 48 81 10 00    	add    0x108148,%eax
  10327b:	2b 82 98 00 00 00    	sub    0x98(%edx),%eax
  103281:	a3 48 81 10 00       	mov    %eax,0x108148
      p->tickets = newTickets;
  103286:	31 c0                	xor    %eax,%eax
  103288:	89 8a 98 00 00 00    	mov    %ecx,0x98(%edx)
  }
 
 

  return -1;
}
  10328e:	5d                   	pop    %ebp
  10328f:	c3                   	ret    
  struct proc *p;
  int i;
 

 
  for(i = 0; i < NPROC; i++)
  103290:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
 
 

  return -1;
}
  103295:	5d                   	pop    %ebp
  103296:	c3                   	ret    
  103297:	89 f6                	mov    %esi,%esi
  103299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001032a0 <getRunTimeOfProcess>:
//returns the number of times process with pid was chosen by scheduler
int getRunTimeOfProcess(int pid)
{
  1032a0:	55                   	push   %ebp
  1032a1:	b8 40 ba 10 00       	mov    $0x10ba40,%eax
  1032a6:	89 e5                	mov    %esp,%ebp
  1032a8:	8b 55 08             	mov    0x8(%ebp),%edx
  1032ab:	eb 0f                	jmp    1032bc <getRunTimeOfProcess+0x1c>
  1032ad:	8d 76 00             	lea    0x0(%esi),%esi
  int i;
  struct proc *p;
  for(i = 0; i < NPROC; i++) {
    p = &proc[i];
    if(p->pid == pid)
      return p->runTime;
  1032b0:	05 a0 00 00 00       	add    $0xa0,%eax
//returns the number of times process with pid was chosen by scheduler
int getRunTimeOfProcess(int pid)
{
  int i;
  struct proc *p;
  for(i = 0; i < NPROC; i++) {
  1032b5:	3d 40 e2 10 00       	cmp    $0x10e240,%eax
  1032ba:	74 14                	je     1032d0 <getRunTimeOfProcess+0x30>
    p = &proc[i];
    if(p->pid == pid)
  1032bc:	39 50 10             	cmp    %edx,0x10(%eax)
  1032bf:	75 ef                	jne    1032b0 <getRunTimeOfProcess+0x10>
      return p->runTime;
  1032c1:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
  }
  return -1;
}
  1032c7:	5d                   	pop    %ebp
  1032c8:	c3                   	ret    
  1032c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
//returns the number of times process with pid was chosen by scheduler
int getRunTimeOfProcess(int pid)
{
  int i;
  struct proc *p;
  for(i = 0; i < NPROC; i++) {
  1032d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p = &proc[i];
    if(p->pid == pid)
      return p->runTime;
  }
  return -1;
}
  1032d5:	5d                   	pop    %ebp
  1032d6:	66 90                	xchg   %ax,%ax
  1032d8:	c3                   	ret    
  1032d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001032e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  1032e0:	55                   	push   %ebp
  1032e1:	89 e5                	mov    %esp,%ebp
  1032e3:	57                   	push   %edi
  1032e4:	56                   	push   %esi
  1032e5:	53                   	push   %ebx
  1032e6:	bb 4c ba 10 00       	mov    $0x10ba4c,%ebx
  1032eb:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
  1032ee:	8d 7d cc             	lea    -0x34(%ebp),%edi
  1032f1:	eb 4f                	jmp    103342 <procdump+0x62>
  1032f3:	90                   	nop    
  1032f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  1032f8:	8b 14 95 48 67 10 00 	mov    0x106748(,%edx,4),%edx
  1032ff:	85 d2                	test   %edx,%edx
  103301:	74 4d                	je     103350 <procdump+0x70>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
  103303:	05 88 00 00 00       	add    $0x88,%eax
  103308:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10330c:	8b 43 04             	mov    0x4(%ebx),%eax
  10330f:	89 54 24 08          	mov    %edx,0x8(%esp)
  103313:	c7 04 24 89 66 10 00 	movl   $0x106689,(%esp)
  10331a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10331e:	e8 7d d4 ff ff       	call   1007a0 <cprintf>
    if(p->state == SLEEPING){
  103323:	83 3b 02             	cmpl   $0x2,(%ebx)
  103326:	74 30                	je     103358 <procdump+0x78>
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  103328:	c7 04 24 33 66 10 00 	movl   $0x106633,(%esp)
  10332f:	e8 6c d4 ff ff       	call   1007a0 <cprintf>
  103334:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
  int i, j;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(i = 0; i < NPROC; i++){
  10333a:	81 fb 4c e2 10 00    	cmp    $0x10e24c,%ebx
  103340:	74 56                	je     103398 <procdump+0xb8>
    p = &proc[i];
    if(p->state == UNUSED)
  103342:	8b 13                	mov    (%ebx),%edx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103344:	8d 43 f4             	lea    -0xc(%ebx),%eax
  char *state;
  uint pc[10];
  
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED)
  103347:	85 d2                	test   %edx,%edx
  103349:	74 e9                	je     103334 <procdump+0x54>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  10334b:	83 fa 05             	cmp    $0x5,%edx
  10334e:	76 a8                	jbe    1032f8 <procdump+0x18>
  103350:	ba 85 66 10 00       	mov    $0x106685,%edx
  103355:	eb ac                	jmp    103303 <procdump+0x23>
  103357:	90                   	nop    
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
  103358:	8b 43 74             	mov    0x74(%ebx),%eax
  10335b:	89 fe                	mov    %edi,%esi
  10335d:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103361:	83 c0 08             	add    $0x8,%eax
  103364:	89 04 24             	mov    %eax,(%esp)
  103367:	e8 24 0c 00 00       	call   103f90 <getcallerpcs>
  10336c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(j=0; j<10 && pc[j] != 0; j++)
  103370:	8b 06                	mov    (%esi),%eax
  103372:	85 c0                	test   %eax,%eax
  103374:	74 b2                	je     103328 <procdump+0x48>
        cprintf(" %p", pc[j]);
  103376:	89 44 24 04          	mov    %eax,0x4(%esp)
  10337a:	83 c6 04             	add    $0x4,%esi
  10337d:	c7 04 24 f5 61 10 00 	movl   $0x1061f5,(%esp)
  103384:	e8 17 d4 ff ff       	call   1007a0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
  103389:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10338c:	39 c6                	cmp    %eax,%esi
  10338e:	75 e0                	jne    103370 <procdump+0x90>
  103390:	eb 96                	jmp    103328 <procdump+0x48>
  103392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  }
}
  103398:	83 c4 4c             	add    $0x4c,%esp
  10339b:	5b                   	pop    %ebx
  10339c:	5e                   	pop    %esi
  10339d:	5f                   	pop    %edi
  10339e:	5d                   	pop    %ebp
  10339f:	90                   	nop    
  1033a0:	c3                   	ret    
  1033a1:	eb 0d                	jmp    1033b0 <kill>
  1033a3:	90                   	nop    
  1033a4:	90                   	nop    
  1033a5:	90                   	nop    
  1033a6:	90                   	nop    
  1033a7:	90                   	nop    
  1033a8:	90                   	nop    
  1033a9:	90                   	nop    
  1033aa:	90                   	nop    
  1033ab:	90                   	nop    
  1033ac:	90                   	nop    
  1033ad:	90                   	nop    
  1033ae:	90                   	nop    
  1033af:	90                   	nop    

001033b0 <kill>:
// Kill the process with the given pid.
// Process won't actually exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  1033b0:	55                   	push   %ebp
  1033b1:	89 e5                	mov    %esp,%ebp
  1033b3:	53                   	push   %ebx
  1033b4:	83 ec 04             	sub    $0x4,%esp
  1033b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&proc_table_lock);
  1033ba:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  1033c1:	e8 7a 0d 00 00       	call   104140 <acquire>
  for(p = proc; p < &proc[NPROC]; p++){
  1033c6:	b8 40 e2 10 00       	mov    $0x10e240,%eax
  1033cb:	3d 40 ba 10 00       	cmp    $0x10ba40,%eax
  1033d0:	76 56                	jbe    103428 <kill+0x78>
    if(p->pid == pid){
  1033d2:	39 1d 50 ba 10 00    	cmp    %ebx,0x10ba50
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&proc_table_lock);
      return 0;
  1033d8:	b8 40 ba 10 00       	mov    $0x10ba40,%eax
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
  1033dd:	74 12                	je     1033f1 <kill+0x41>
  1033df:	90                   	nop    
kill(int pid)
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
  1033e0:	05 a0 00 00 00       	add    $0xa0,%eax
  1033e5:	3d 40 e2 10 00       	cmp    $0x10e240,%eax
  1033ea:	74 3c                	je     103428 <kill+0x78>
    if(p->pid == pid){
  1033ec:	39 58 10             	cmp    %ebx,0x10(%eax)
  1033ef:	75 ef                	jne    1033e0 <kill+0x30>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1033f1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  1033f5:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1033fc:	74 1a                	je     103418 <kill+0x68>
        p->state = RUNNABLE;
      release(&proc_table_lock);
  1033fe:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103405:	e8 f6 0c 00 00       	call   104100 <release>
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
}
  10340a:	83 c4 04             	add    $0x4,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&proc_table_lock);
  10340d:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
}
  10340f:	5b                   	pop    %ebx
  103410:	5d                   	pop    %ebp
  103411:	c3                   	ret    
  103412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  103418:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  10341f:	eb dd                	jmp    1033fe <kill+0x4e>
  103421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  103428:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  10342f:	e8 cc 0c 00 00       	call   104100 <release>
  return -1;
}
  103434:	83 c4 04             	add    $0x4,%esp
        p->state = RUNNABLE;
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  103437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  10343c:	5b                   	pop    %ebx
  10343d:	5d                   	pop    %ebp
  10343e:	c3                   	ret    
  10343f:	90                   	nop    

00103440 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  103440:	55                   	push   %ebp
  103441:	89 e5                	mov    %esp,%ebp
  103443:	53                   	push   %ebx
  103444:	83 ec 04             	sub    $0x4,%esp
  103447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&proc_table_lock);
  10344a:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103451:	e8 ea 0c 00 00       	call   104140 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103456:	b8 40 e2 10 00       	mov    $0x10e240,%eax
  10345b:	3d 40 ba 10 00       	cmp    $0x10ba40,%eax
  103460:	76 3e                	jbe    1034a0 <wakeup+0x60>
  103462:	b8 40 ba 10 00       	mov    $0x10ba40,%eax
  103467:	eb 13                	jmp    10347c <wakeup+0x3c>
  103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103470:	05 a0 00 00 00       	add    $0xa0,%eax
  103475:	3d 40 e2 10 00       	cmp    $0x10e240,%eax
  10347a:	74 24                	je     1034a0 <wakeup+0x60>
    if(p->state == SLEEPING && p->chan == chan)
  10347c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103480:	75 ee                	jne    103470 <wakeup+0x30>
  103482:	3b 58 18             	cmp    0x18(%eax),%ebx
  103485:	75 e9                	jne    103470 <wakeup+0x30>
      p->state = RUNNABLE;
  103487:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  10348e:	05 a0 00 00 00       	add    $0xa0,%eax
  103493:	3d 40 e2 10 00       	cmp    $0x10e240,%eax
  103498:	75 e2                	jne    10347c <wakeup+0x3c>
  10349a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  1034a0:	c7 45 08 40 e2 10 00 	movl   $0x10e240,0x8(%ebp)
}
  1034a7:	83 c4 04             	add    $0x4,%esp
  1034aa:	5b                   	pop    %ebx
  1034ab:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  1034ac:	e9 4f 0c 00 00       	jmp    104100 <release>
  1034b1:	eb 0d                	jmp    1034c0 <curproc>
  1034b3:	90                   	nop    
  1034b4:	90                   	nop    
  1034b5:	90                   	nop    
  1034b6:	90                   	nop    
  1034b7:	90                   	nop    
  1034b8:	90                   	nop    
  1034b9:	90                   	nop    
  1034ba:	90                   	nop    
  1034bb:	90                   	nop    
  1034bc:	90                   	nop    
  1034bd:	90                   	nop    
  1034be:	90                   	nop    
  1034bf:	90                   	nop    

001034c0 <curproc>:
}

// Return currently running process.
struct proc*
curproc(void)
{
  1034c0:	55                   	push   %ebp
  1034c1:	89 e5                	mov    %esp,%ebp
  1034c3:	53                   	push   %ebx
  1034c4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;

  pushcli();
  1034c7:	e8 a4 0b 00 00       	call   104070 <pushcli>
  p = cpus[cpu()].curproc;
  1034cc:	e8 5f f4 ff ff       	call   102930 <cpu>
  1034d1:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  1034d7:	8b 98 c4 b3 10 00    	mov    0x10b3c4(%eax),%ebx
  popcli();
  1034dd:	e8 0e 0b 00 00       	call   103ff0 <popcli>
  return p;
}
  1034e2:	83 c4 04             	add    $0x4,%esp
  1034e5:	89 d8                	mov    %ebx,%eax
  1034e7:	5b                   	pop    %ebx
  1034e8:	5d                   	pop    %ebp
  1034e9:	c3                   	ret    
  1034ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001034f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  1034f0:	55                   	push   %ebp
  1034f1:	89 e5                	mov    %esp,%ebp
  1034f3:	83 ec 08             	sub    $0x8,%esp
  // Still holding proc_table_lock from scheduler.
  release(&proc_table_lock);
  1034f6:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  1034fd:	e8 fe 0b 00 00       	call   104100 <release>

  // Jump into assembly, never to return.
  forkret1(cp->tf);
  103502:	e8 b9 ff ff ff       	call   1034c0 <curproc>
  103507:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  10350d:	89 04 24             	mov    %eax,(%esp)
  103510:	e8 c7 1e 00 00       	call   1053dc <forkret1>
}
  103515:	c9                   	leave  
  103516:	c3                   	ret    
  103517:	89 f6                	mov    %esi,%esi
  103519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103520 <sched>:

// Enter scheduler.  Must already hold proc_table_lock
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  103520:	55                   	push   %ebp
  103521:	89 e5                	mov    %esp,%ebp
  103523:	53                   	push   %ebx
  103524:	83 ec 14             	sub    $0x14,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103527:	9c                   	pushf  
  103528:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  103529:	f6 c4 02             	test   $0x2,%ah
  10352c:	75 5c                	jne    10358a <sched+0x6a>
    panic("sched interruptible");
  if(cp->state == RUNNING)
  10352e:	e8 8d ff ff ff       	call   1034c0 <curproc>
  103533:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  103537:	74 5d                	je     103596 <sched+0x76>
    panic("sched running");
  if(!holding(&proc_table_lock))
  103539:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103540:	e8 7b 0b 00 00       	call   1040c0 <holding>
  103545:	85 c0                	test   %eax,%eax
  103547:	74 59                	je     1035a2 <sched+0x82>
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
  103549:	e8 e2 f3 ff ff       	call   102930 <cpu>
  10354e:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103554:	83 b8 84 b4 10 00 01 	cmpl   $0x1,0x10b484(%eax)
  10355b:	75 51                	jne    1035ae <sched+0x8e>
    panic("sched locks");

  swtch(&cp->context, &cpus[cpu()].context);
  10355d:	e8 ce f3 ff ff       	call   102930 <cpu>
  103562:	89 c3                	mov    %eax,%ebx
  103564:	e8 57 ff ff ff       	call   1034c0 <curproc>
  103569:	69 d3 cc 00 00 00    	imul   $0xcc,%ebx,%edx
  10356f:	81 c2 c8 b3 10 00    	add    $0x10b3c8,%edx
  103575:	89 54 24 04          	mov    %edx,0x4(%esp)
  103579:	83 c0 64             	add    $0x64,%eax
  10357c:	89 04 24             	mov    %eax,(%esp)
  10357f:	e8 28 0e 00 00       	call   1043ac <swtch>
}
  103584:	83 c4 14             	add    $0x14,%esp
  103587:	5b                   	pop    %ebx
  103588:	5d                   	pop    %ebp
  103589:	c3                   	ret    
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  10358a:	c7 04 24 92 66 10 00 	movl   $0x106692,(%esp)
  103591:	e8 da d3 ff ff       	call   100970 <panic>
  if(cp->state == RUNNING)
    panic("sched running");
  103596:	c7 04 24 a6 66 10 00 	movl   $0x1066a6,(%esp)
  10359d:	e8 ce d3 ff ff       	call   100970 <panic>
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  1035a2:	c7 04 24 b4 66 10 00 	movl   $0x1066b4,(%esp)
  1035a9:	e8 c2 d3 ff ff       	call   100970 <panic>
  if(cpus[cpu()].ncli != 1)
    panic("sched locks");
  1035ae:	c7 04 24 ca 66 10 00 	movl   $0x1066ca,(%esp)
  1035b5:	e8 b6 d3 ff ff       	call   100970 <panic>
  1035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001035c0 <exit>:
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  1035c0:	55                   	push   %ebp
  1035c1:	89 e5                	mov    %esp,%ebp
  1035c3:	83 ec 18             	sub    $0x18,%esp
  1035c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1035c9:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1035cc:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct proc *p;
  int fd;

  if(cp == initproc)
  1035cf:	e8 ec fe ff ff       	call   1034c0 <curproc>
  1035d4:	3b 05 4c 81 10 00    	cmp    0x10814c,%eax
  1035da:	75 0c                	jne    1035e8 <exit+0x28>
    panic("init exiting");
  1035dc:	c7 04 24 d6 66 10 00 	movl   $0x1066d6,(%esp)
  1035e3:	e8 88 d3 ff ff       	call   100970 <panic>
  1035e8:	31 f6                	xor    %esi,%esi
  1035ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd]){
  1035f0:	e8 cb fe ff ff       	call   1034c0 <curproc>
  1035f5:	8d 5e 08             	lea    0x8(%esi),%ebx
  1035f8:	8b 04 98             	mov    (%eax,%ebx,4),%eax
  1035fb:	85 c0                	test   %eax,%eax
  1035fd:	74 1c                	je     10361b <exit+0x5b>
      fileclose(cp->ofile[fd]);
  1035ff:	e8 bc fe ff ff       	call   1034c0 <curproc>
  103604:	8b 04 98             	mov    (%eax,%ebx,4),%eax
  103607:	89 04 24             	mov    %eax,(%esp)
  10360a:	e8 31 da ff ff       	call   101040 <fileclose>
      cp->ofile[fd] = 0;
  10360f:	e8 ac fe ff ff       	call   1034c0 <curproc>
  103614:	c7 04 98 00 00 00 00 	movl   $0x0,(%eax,%ebx,4)

  if(cp == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  10361b:	83 c6 01             	add    $0x1,%esi
  10361e:	83 fe 10             	cmp    $0x10,%esi
  103621:	75 cd                	jne    1035f0 <exit+0x30>
      fileclose(cp->ofile[fd]);
      cp->ofile[fd] = 0;
    }
  }

  iput(cp->cwd);
  103623:	e8 98 fe ff ff       	call   1034c0 <curproc>
  103628:	8b 40 60             	mov    0x60(%eax),%eax
  10362b:	89 04 24             	mov    %eax,(%esp)
  10362e:	e8 fd e3 ff ff       	call   101a30 <iput>
  cp->cwd = 0;
  103633:	e8 88 fe ff ff       	call   1034c0 <curproc>
  103638:	c7 40 60 00 00 00 00 	movl   $0x0,0x60(%eax)

  acquire(&proc_table_lock);
  10363f:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103646:	e8 f5 0a 00 00       	call   104140 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);
  10364b:	e8 70 fe ff ff       	call   1034c0 <curproc>
  103650:	8b 50 14             	mov    0x14(%eax),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103653:	b8 40 e2 10 00       	mov    $0x10e240,%eax
  103658:	3d 40 ba 10 00       	cmp    $0x10ba40,%eax
  10365d:	76 2b                	jbe    10368a <exit+0xca>
  10365f:	be 40 ba 10 00       	mov    $0x10ba40,%esi
  103664:	eb 10                	jmp    103676 <exit+0xb6>
  103666:	66 90                	xchg   %ax,%ax
  103668:	81 c6 a0 00 00 00    	add    $0xa0,%esi
  10366e:	81 fe 40 e2 10 00    	cmp    $0x10e240,%esi
  103674:	74 43                	je     1036b9 <exit+0xf9>
    if(p->state == SLEEPING && p->chan == chan)
  103676:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
  10367a:	75 ec                	jne    103668 <exit+0xa8>
  10367c:	3b 56 18             	cmp    0x18(%esi),%edx
  10367f:	75 e7                	jne    103668 <exit+0xa8>
      p->state = RUNNABLE;
  103681:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  103688:	eb de                	jmp    103668 <exit+0xa8>
  10368a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  cp->killed = 0;
  103690:	e8 2b fe ff ff       	call   1034c0 <curproc>
  103695:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  
  cp->state = ZOMBIE;
  10369c:	e8 1f fe ff ff       	call   1034c0 <curproc>
  1036a1:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
  1036a8:	e8 73 fe ff ff       	call   103520 <sched>
  panic("zombie exit");
  1036ad:	c7 04 24 e3 66 10 00 	movl   $0x1066e3,(%esp)
  1036b4:	e8 b7 d2 ff ff       	call   100970 <panic>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  1036b9:	bf 40 ba 10 00       	mov    $0x10ba40,%edi
  1036be:	eb 0e                	jmp    1036ce <exit+0x10e>

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
  1036c0:	81 c7 a0 00 00 00    	add    $0xa0,%edi
  1036c6:	81 ff 40 e2 10 00    	cmp    $0x10e240,%edi
  1036cc:	74 bc                	je     10368a <exit+0xca>
    if(p->parent == cp){
  1036ce:	8b 5f 14             	mov    0x14(%edi),%ebx
  1036d1:	e8 ea fd ff ff       	call   1034c0 <curproc>
  1036d6:	39 c3                	cmp    %eax,%ebx
  1036d8:	75 e6                	jne    1036c0 <exit+0x100>
      p->parent = initproc;
  1036da:	8b 15 4c 81 10 00    	mov    0x10814c,%edx
      if(p->state == ZOMBIE)
  1036e0:	83 7f 0c 05          	cmpl   $0x5,0xc(%edi)
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->parent == cp){
      p->parent = initproc;
  1036e4:	89 57 14             	mov    %edx,0x14(%edi)
      if(p->state == ZOMBIE)
  1036e7:	75 d7                	jne    1036c0 <exit+0x100>
  1036e9:	b8 40 ba 10 00       	mov    $0x10ba40,%eax
  1036ee:	eb 09                	jmp    1036f9 <exit+0x139>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  1036f0:	05 a0 00 00 00       	add    $0xa0,%eax
  1036f5:	39 c6                	cmp    %eax,%esi
  1036f7:	74 c7                	je     1036c0 <exit+0x100>
    if(p->state == SLEEPING && p->chan == chan)
  1036f9:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  1036fd:	75 f1                	jne    1036f0 <exit+0x130>
  1036ff:	3b 50 18             	cmp    0x18(%eax),%edx
  103702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103708:	75 e6                	jne    1036f0 <exit+0x130>
      p->state = RUNNABLE;
  10370a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103718:	eb d6                	jmp    1036f0 <exit+0x130>
  10371a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103720 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  103720:	55                   	push   %ebp
  103721:	89 e5                	mov    %esp,%ebp
  103723:	56                   	push   %esi
  103724:	53                   	push   %ebx
  103725:	83 ec 10             	sub    $0x10,%esp
  103728:	8b 75 08             	mov    0x8(%ebp),%esi
  10372b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(cp == 0)
  10372e:	e8 8d fd ff ff       	call   1034c0 <curproc>
  103733:	85 c0                	test   %eax,%eax
  103735:	0f 84 99 00 00 00    	je     1037d4 <sleep+0xb4>
    panic("sleep");

  if(lk == 0)
  10373b:	85 db                	test   %ebx,%ebx
  10373d:	0f 84 9d 00 00 00    	je     1037e0 <sleep+0xc0>
  // change p->state and then call sched.
  // Once we hold proc_table_lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with proc_table_lock locked),
  // so it's okay to release lk.
  if(lk != &proc_table_lock){
  103743:	81 fb 40 e2 10 00    	cmp    $0x10e240,%ebx
  103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103750:	74 56                	je     1037a8 <sleep+0x88>
    acquire(&proc_table_lock);
  103752:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103759:	e8 e2 09 00 00       	call   104140 <acquire>
    release(lk);
  10375e:	89 1c 24             	mov    %ebx,(%esp)
  103761:	e8 9a 09 00 00       	call   104100 <release>
  }

  // Go to sleep.
  cp->chan = chan;
  103766:	e8 55 fd ff ff       	call   1034c0 <curproc>
  10376b:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  10376e:	e8 4d fd ff ff       	call   1034c0 <curproc>
  103773:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  10377a:	e8 a1 fd ff ff       	call   103520 <sched>

  // Tidy up.
  cp->chan = 0;
  10377f:	e8 3c fd ff ff       	call   1034c0 <curproc>
  103784:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
  10378b:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103792:	e8 69 09 00 00       	call   104100 <release>
    acquire(lk);
  103797:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  10379a:	83 c4 10             	add    $0x10,%esp
  10379d:	5b                   	pop    %ebx
  10379e:	5e                   	pop    %esi
  10379f:	5d                   	pop    %ebp
  cp->chan = 0;

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  1037a0:	e9 9b 09 00 00       	jmp    104140 <acquire>
  1037a5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&proc_table_lock);
    release(lk);
  }

  // Go to sleep.
  cp->chan = chan;
  1037a8:	e8 13 fd ff ff       	call   1034c0 <curproc>
  1037ad:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  1037b0:	e8 0b fd ff ff       	call   1034c0 <curproc>
  1037b5:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  1037bc:	e8 5f fd ff ff       	call   103520 <sched>

  // Tidy up.
  cp->chan = 0;
  1037c1:	e8 fa fc ff ff       	call   1034c0 <curproc>
  1037c6:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  }
}
  1037cd:	83 c4 10             	add    $0x10,%esp
  1037d0:	5b                   	pop    %ebx
  1037d1:	5e                   	pop    %esi
  1037d2:	5d                   	pop    %ebp
  1037d3:	c3                   	ret    
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(cp == 0)
    panic("sleep");
  1037d4:	c7 04 24 ef 66 10 00 	movl   $0x1066ef,(%esp)
  1037db:	e8 90 d1 ff ff       	call   100970 <panic>

  if(lk == 0)
    panic("sleep without lk");
  1037e0:	c7 04 24 f5 66 10 00 	movl   $0x1066f5,(%esp)
  1037e7:	e8 84 d1 ff ff       	call   100970 <panic>
  1037ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001037f0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1037f0:	55                   	push   %ebp
  1037f1:	89 e5                	mov    %esp,%ebp
  1037f3:	57                   	push   %edi
  1037f4:	56                   	push   %esi
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  1037f5:	31 f6                	xor    %esi,%esi

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1037f7:	53                   	push   %ebx
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  1037f8:	31 db                	xor    %ebx,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1037fa:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  1037fd:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103804:	e8 37 09 00 00       	call   104140 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  103809:	83 fe 3f             	cmp    $0x3f,%esi
  10380c:	7e 35                	jle    103843 <wait+0x53>
  10380e:	66 90                	xchg   %ax,%ax
        havekids = 1;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
  103810:	85 db                	test   %ebx,%ebx
  103812:	74 74                	je     103888 <wait+0x98>
  103814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103818:	e8 a3 fc ff ff       	call   1034c0 <curproc>
  10381d:	8b 50 1c             	mov    0x1c(%eax),%edx
  103820:	85 d2                	test   %edx,%edx
  103822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103828:	75 5e                	jne    103888 <wait+0x98>
      release(&proc_table_lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  10382a:	e8 91 fc ff ff       	call   1034c0 <curproc>
  10382f:	31 f6                	xor    %esi,%esi
  103831:	31 db                	xor    %ebx,%ebx
  103833:	c7 44 24 04 40 e2 10 	movl   $0x10e240,0x4(%esp)
  10383a:	00 
  10383b:	89 04 24             	mov    %eax,(%esp)
  10383e:	e8 dd fe ff ff       	call   103720 <sleep>
  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
      p = &proc[i];
  103843:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  103846:	c1 e0 05             	shl    $0x5,%eax
  103849:	8d b8 40 ba 10 00    	lea    0x10ba40(%eax),%edi
      if(p->state == UNUSED)
  10384f:	8b 4f 0c             	mov    0xc(%edi),%ecx
  103852:	85 c9                	test   %ecx,%ecx
  103854:	75 0a                	jne    103860 <wait+0x70>

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  103856:	83 c6 01             	add    $0x1,%esi
  103859:	83 fe 3f             	cmp    $0x3f,%esi
  10385c:	7e e5                	jle    103843 <wait+0x53>
  10385e:	eb b0                	jmp    103810 <wait+0x20>
      p = &proc[i];
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
  103860:	8b 47 14             	mov    0x14(%edi),%eax
  103863:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103866:	e8 55 fc ff ff       	call   1034c0 <curproc>
  10386b:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  10386e:	66 90                	xchg   %ax,%ax
  103870:	75 e4                	jne    103856 <wait+0x66>
        if(p->state == ZOMBIE){
  103872:	83 7f 0c 05          	cmpl   $0x5,0xc(%edi)
  103876:	74 2b                	je     1038a3 <wait+0xb3>
          p->state = UNUSED;
          p->pid = 0;
          p->parent = 0;
          p->name[0] = 0;
          release(&proc_table_lock);
          return pid;
  103878:	bb 01 00 00 00       	mov    $0x1,%ebx
  10387d:	8d 76 00             	lea    0x0(%esi),%esi
  103880:	eb d4                	jmp    103856 <wait+0x66>
  103882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
      release(&proc_table_lock);
  103888:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  10388f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  103894:	e8 67 08 00 00       	call   104100 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  }
}
  103899:	83 c4 0c             	add    $0xc,%esp
  10389c:	89 d8                	mov    %ebx,%eax
  10389e:	5b                   	pop    %ebx
  10389f:	5e                   	pop    %esi
  1038a0:	5f                   	pop    %edi
  1038a1:	5d                   	pop    %ebp
  1038a2:	c3                   	ret    
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
  1038a3:	8b 47 04             	mov    0x4(%edi),%eax
  1038a6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1038aa:	8b 07                	mov    (%edi),%eax
  1038ac:	89 04 24             	mov    %eax,(%esp)
  1038af:	e8 8c eb ff ff       	call   102440 <kfree>
          kfree(p->kstack, KSTACKSIZE);
  1038b4:	8b 47 08             	mov    0x8(%edi),%eax
  1038b7:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  1038be:	00 
  1038bf:	89 04 24             	mov    %eax,(%esp)
  1038c2:	e8 79 eb ff ff       	call   102440 <kfree>
          pid = p->pid;
  1038c7:	8b 5f 10             	mov    0x10(%edi),%ebx
          p->state = UNUSED;
  1038ca:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
          p->pid = 0;
  1038d1:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
          p->parent = 0;
  1038d8:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
          p->name[0] = 0;
  1038df:	c6 87 88 00 00 00 00 	movb   $0x0,0x88(%edi)
          release(&proc_table_lock);
  1038e6:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  1038ed:	e8 0e 08 00 00       	call   104100 <release>
  1038f2:	eb a5                	jmp    103899 <wait+0xa9>
  1038f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1038fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103900 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  103900:	55                   	push   %ebp
  103901:	89 e5                	mov    %esp,%ebp
  103903:	83 ec 08             	sub    $0x8,%esp
  acquire(&proc_table_lock);
  103906:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  10390d:	e8 2e 08 00 00       	call   104140 <acquire>
  cp->state = RUNNABLE;
  103912:	e8 a9 fb ff ff       	call   1034c0 <curproc>
  103917:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  10391e:	e8 fd fb ff ff       	call   103520 <sched>
  release(&proc_table_lock);
  103923:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  10392a:	e8 d1 07 00 00       	call   104100 <release>
}
  10392f:	c9                   	leave  
  103930:	c3                   	ret    
  103931:	eb 0d                	jmp    103940 <setupsegs>
  103933:	90                   	nop    
  103934:	90                   	nop    
  103935:	90                   	nop    
  103936:	90                   	nop    
  103937:	90                   	nop    
  103938:	90                   	nop    
  103939:	90                   	nop    
  10393a:	90                   	nop    
  10393b:	90                   	nop    
  10393c:	90                   	nop    
  10393d:	90                   	nop    
  10393e:	90                   	nop    
  10393f:	90                   	nop    

00103940 <setupsegs>:

// Set up CPU's segment descriptors and task state for a given process.
// If p==0, set up for "idle" state for when scheduler() is running.
void
setupsegs(struct proc *p)
{
  103940:	55                   	push   %ebp
  103941:	89 e5                	mov    %esp,%ebp
  103943:	53                   	push   %ebx
  103944:	83 ec 14             	sub    $0x14,%esp
  103947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct cpu *c;
  
  pushcli();
  10394a:	e8 21 07 00 00       	call   104070 <pushcli>
  c = &cpus[cpu()];
  10394f:	e8 dc ef ff ff       	call   102930 <cpu>
  103954:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  c->ts.ss0 = SEG_KDATA << 3;
  if(p)
  10395a:	85 db                	test   %ebx,%ebx
setupsegs(struct proc *p)
{
  struct cpu *c;
  
  pushcli();
  c = &cpus[cpu()];
  10395c:	8d 88 c0 b3 10 00    	lea    0x10b3c0(%eax),%ecx
  c->ts.ss0 = SEG_KDATA << 3;
  103962:	66 c7 41 30 10 00    	movw   $0x10,0x30(%ecx)
  if(p)
  103968:	0f 84 92 01 00 00    	je     103b00 <setupsegs+0x1c0>
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  10396e:	8b 43 08             	mov    0x8(%ebx),%eax
  103971:	05 00 10 00 00       	add    $0x1000,%eax
  103976:	89 41 2c             	mov    %eax,0x2c(%ecx)
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  103979:	8d 41 28             	lea    0x28(%ecx),%eax
  10397c:	66 89 81 ba 00 00 00 	mov    %ax,0xba(%ecx)
  103983:	c1 e8 10             	shr    $0x10,%eax
  103986:	88 81 bc 00 00 00    	mov    %al,0xbc(%ecx)
  10398c:	c1 e8 08             	shr    $0x8,%eax
  c->gdt[SEG_TSS].s = 0;
  if(p){
  10398f:	85 db                	test   %ebx,%ebx
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  103991:	c7 81 90 00 00 00 00 	movl   $0x0,0x90(%ecx)
  103998:	00 00 00 
  10399b:	c7 81 94 00 00 00 00 	movl   $0x0,0x94(%ecx)
  1039a2:	00 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1039a5:	66 c7 81 98 00 00 00 	movw   $0x10f,0x98(%ecx)
  1039ac:	0f 01 
  1039ae:	66 c7 81 9a 00 00 00 	movw   $0x0,0x9a(%ecx)
  1039b5:	00 00 
  1039b7:	c6 81 9c 00 00 00 00 	movb   $0x0,0x9c(%ecx)
  1039be:	c6 81 9d 00 00 00 9a 	movb   $0x9a,0x9d(%ecx)
  1039c5:	c6 81 9e 00 00 00 c0 	movb   $0xc0,0x9e(%ecx)
  1039cc:	c6 81 9f 00 00 00 00 	movb   $0x0,0x9f(%ecx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1039d3:	66 c7 81 a0 00 00 00 	movw   $0xffff,0xa0(%ecx)
  1039da:	ff ff 
  1039dc:	66 c7 81 a2 00 00 00 	movw   $0x0,0xa2(%ecx)
  1039e3:	00 00 
  1039e5:	c6 81 a4 00 00 00 00 	movb   $0x0,0xa4(%ecx)
  1039ec:	c6 81 a5 00 00 00 92 	movb   $0x92,0xa5(%ecx)
  1039f3:	c6 81 a6 00 00 00 cf 	movb   $0xcf,0xa6(%ecx)
  1039fa:	c6 81 a7 00 00 00 00 	movb   $0x0,0xa7(%ecx)
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  103a01:	66 c7 81 b8 00 00 00 	movw   $0x67,0xb8(%ecx)
  103a08:	67 00 
  103a0a:	c6 81 be 00 00 00 40 	movb   $0x40,0xbe(%ecx)
  103a11:	88 81 bf 00 00 00    	mov    %al,0xbf(%ecx)
  c->gdt[SEG_TSS].s = 0;
  103a17:	c6 81 bd 00 00 00 89 	movb   $0x89,0xbd(%ecx)
  if(p){
  103a1e:	0f 84 ac 00 00 00    	je     103ad0 <setupsegs+0x190>
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  103a24:	8b 43 04             	mov    0x4(%ebx),%eax
  103a27:	8b 13                	mov    (%ebx),%edx
  103a29:	c6 81 ad 00 00 00 fa 	movb   $0xfa,0xad(%ecx)
  103a30:	83 e8 01             	sub    $0x1,%eax
  103a33:	c1 e8 0c             	shr    $0xc,%eax
  103a36:	66 89 81 a8 00 00 00 	mov    %ax,0xa8(%ecx)
  103a3d:	c1 e8 10             	shr    $0x10,%eax
  103a40:	83 c8 c0             	or     $0xffffffc0,%eax
  103a43:	88 81 ae 00 00 00    	mov    %al,0xae(%ecx)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  103a49:	8b 43 04             	mov    0x4(%ebx),%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  103a4c:	66 89 91 aa 00 00 00 	mov    %dx,0xaa(%ecx)
  103a53:	c1 ea 10             	shr    $0x10,%edx
  103a56:	88 91 ac 00 00 00    	mov    %dl,0xac(%ecx)
  103a5c:	c1 ea 08             	shr    $0x8,%edx
  103a5f:	88 91 af 00 00 00    	mov    %dl,0xaf(%ecx)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  103a65:	8b 13                	mov    (%ebx),%edx
  103a67:	83 e8 01             	sub    $0x1,%eax
  103a6a:	c1 e8 0c             	shr    $0xc,%eax
  103a6d:	66 89 81 b0 00 00 00 	mov    %ax,0xb0(%ecx)
  103a74:	c1 e8 10             	shr    $0x10,%eax
  103a77:	66 89 91 b2 00 00 00 	mov    %dx,0xb2(%ecx)
  103a7e:	c1 ea 10             	shr    $0x10,%edx
  103a81:	83 c8 c0             	or     $0xffffffc0,%eax
  103a84:	88 91 b4 00 00 00    	mov    %dl,0xb4(%ecx)
  103a8a:	c1 ea 08             	shr    $0x8,%edx
  103a8d:	c6 81 b5 00 00 00 f2 	movb   $0xf2,0xb5(%ecx)
  103a94:	88 81 b6 00 00 00    	mov    %al,0xb6(%ecx)
  103a9a:	88 91 b7 00 00 00    	mov    %dl,0xb7(%ecx)
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
    c->gdt[SEG_UDATA] = SEG_NULL;
  }

  lgdt(c->gdt, sizeof(c->gdt));
  103aa0:	8d 81 90 00 00 00    	lea    0x90(%ecx),%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  103aa6:	66 c7 45 f6 2f 00    	movw   $0x2f,-0xa(%ebp)
  pd[1] = (uint)p;
  103aac:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
  pd[2] = (uint)p >> 16;
  103ab0:	c1 e8 10             	shr    $0x10,%eax
  103ab3:	66 89 45 fa          	mov    %ax,-0x6(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  103ab7:	8d 45 f6             	lea    -0xa(%ebp),%eax
  103aba:	0f 01 10             	lgdtl  (%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  103abd:	b8 28 00 00 00       	mov    $0x28,%eax
  103ac2:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  popcli();
  103ac5:	e8 26 05 00 00       	call   103ff0 <popcli>
}
  103aca:	83 c4 14             	add    $0x14,%esp
  103acd:	5b                   	pop    %ebx
  103ace:	5d                   	pop    %ebp
  103acf:	c3                   	ret    
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
  103ad0:	c7 81 a8 00 00 00 00 	movl   $0x0,0xa8(%ecx)
  103ad7:	00 00 00 
  103ada:	c7 81 ac 00 00 00 00 	movl   $0x0,0xac(%ecx)
  103ae1:	00 00 00 
    c->gdt[SEG_UDATA] = SEG_NULL;
  103ae4:	c7 81 b0 00 00 00 00 	movl   $0x0,0xb0(%ecx)
  103aeb:	00 00 00 
  103aee:	c7 81 b4 00 00 00 00 	movl   $0x0,0xb4(%ecx)
  103af5:	00 00 00 
  103af8:	eb a6                	jmp    103aa0 <setupsegs+0x160>
  103afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c = &cpus[cpu()];
  c->ts.ss0 = SEG_KDATA << 3;
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;
  103b00:	c7 41 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%ecx)
  103b07:	e9 6d fe ff ff       	jmp    103979 <setupsegs+0x39>
  103b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103b10 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  103b10:	55                   	push   %ebp
  103b11:	89 e5                	mov    %esp,%ebp
  103b13:	57                   	push   %edi
  103b14:	56                   	push   %esi
  103b15:	53                   	push   %ebx
  103b16:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c;
  int i;

  c = &cpus[cpu()];
  103b19:	e8 12 ee ff ff       	call   102930 <cpu>
  103b1e:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103b24:	8d b0 c0 b3 10 00    	lea    0x10b3c0(%eax),%esi
 
      
 
          p->runTime++;
 
          swtch(&c->context, &p->context);
  103b2a:	8d 7e 08             	lea    0x8(%esi),%edi
  103b2d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
  103b30:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  103b31:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)

	int randomNumber = randInt() % numTickets;
  103b38:	bb 40 ba 10 00       	mov    $0x10ba40,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  103b3d:	e8 fe 05 00 00       	call   104140 <acquire>

	int randomNumber = randInt() % numTickets;
  103b42:	e8 d9 f6 ff ff       	call   103220 <randInt>
  103b47:	89 c2                	mov    %eax,%edx
  103b49:	c1 fa 1f             	sar    $0x1f,%edx
  103b4c:	f7 3d 48 81 10 00    	idivl  0x108148
  103b52:	eb 12                	jmp    103b66 <scheduler+0x56>
  103b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 
          // Process is done running for now.
          // It should have changed its p->state before coming back.
          c->curproc = 0;
          setupsegs(0);
          break;
  103b58:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
    acquire(&proc_table_lock);

	int randomNumber = randInt() % numTickets;
	

    for(i = 0; i < NPROC; i++){
  103b5e:	81 fb 40 e2 10 00    	cmp    $0x10e240,%ebx
  103b64:	74 4b                	je     103bb1 <scheduler+0xa1>
      p = &proc[i];
      randomNumber -= p->tickets;
  103b66:	2b 93 98 00 00 00    	sub    0x98(%ebx),%edx
      if(randomNumber <= 0)
  103b6c:	85 d2                	test   %edx,%edx
  103b6e:	7f e8                	jg     103b58 <scheduler+0x48>
      	{
	if(p->state != RUNNABLE) {
  103b70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
  103b74:	75 e2                	jne    103b58 <scheduler+0x48>
        	
        else {
          // Switch to chosen process. It is the process's job
          // to release proc_table_lock and then reacquire it
          // before jumping back to us.
          c->curproc = p;
  103b76:	89 5e 04             	mov    %ebx,0x4(%esi)
          setupsegs(p);
  103b79:	89 1c 24             	mov    %ebx,(%esp)
  103b7c:	e8 bf fd ff ff       	call   103940 <setupsegs>
 
      
 
          p->runTime++;
 
          swtch(&c->context, &p->context);
  103b81:	8d 43 64             	lea    0x64(%ebx),%eax
          // Switch to chosen process. It is the process's job
          // to release proc_table_lock and then reacquire it
          // before jumping back to us.
          c->curproc = p;
          setupsegs(p);
          p->state = RUNNING;
  103b84:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
 
 
      
 
          p->runTime++;
  103b8b:	83 83 9c 00 00 00 01 	addl   $0x1,0x9c(%ebx)
 
          swtch(&c->context, &p->context);
  103b92:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b96:	89 3c 24             	mov    %edi,(%esp)
  103b99:	e8 0e 08 00 00       	call   1043ac <swtch>
 
          // Process is done running for now.
          // It should have changed its p->state before coming back.
          c->curproc = 0;
  103b9e:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
          setupsegs(0);
  103ba5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103bac:	e8 8f fd ff ff       	call   103940 <setupsegs>
          break;
        }
      }
    }
    release(&proc_table_lock);
  103bb1:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103bb8:	e8 43 05 00 00       	call   104100 <release>
  103bbd:	e9 6e ff ff ff       	jmp    103b30 <scheduler+0x20>
  103bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103bd0 <growproc>:

// Grow current process's memory by n bytes.
// Return old size on success, -1 on failure.
int
growproc(int n)
{
  103bd0:	55                   	push   %ebp
  103bd1:	89 e5                	mov    %esp,%ebp
  103bd3:	57                   	push   %edi
  103bd4:	56                   	push   %esi
  103bd5:	53                   	push   %ebx
  103bd6:	83 ec 0c             	sub    $0xc,%esp
  103bd9:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *newmem;

  newmem = kalloc(cp->sz + n);
  103bdc:	e8 df f8 ff ff       	call   1034c0 <curproc>
  103be1:	8b 50 04             	mov    0x4(%eax),%edx
  103be4:	8d 04 17             	lea    (%edi,%edx,1),%eax
  103be7:	89 04 24             	mov    %eax,(%esp)
  103bea:	e8 91 e7 ff ff       	call   102380 <kalloc>
  103bef:	89 c6                	mov    %eax,%esi
  if(newmem == 0)
  103bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103bf6:	85 f6                	test   %esi,%esi
  103bf8:	74 7f                	je     103c79 <growproc+0xa9>
    return -1;
  memmove(newmem, cp->mem, cp->sz);
  103bfa:	e8 c1 f8 ff ff       	call   1034c0 <curproc>
  103bff:	8b 58 04             	mov    0x4(%eax),%ebx
  103c02:	e8 b9 f8 ff ff       	call   1034c0 <curproc>
  103c07:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  103c0b:	8b 00                	mov    (%eax),%eax
  103c0d:	89 34 24             	mov    %esi,(%esp)
  103c10:	89 44 24 04          	mov    %eax,0x4(%esp)
  103c14:	e8 27 06 00 00       	call   104240 <memmove>
  memset(newmem + cp->sz, 0, n);
  103c19:	e8 a2 f8 ff ff       	call   1034c0 <curproc>
  103c1e:	89 7c 24 08          	mov    %edi,0x8(%esp)
  103c22:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103c29:	00 
  103c2a:	8b 50 04             	mov    0x4(%eax),%edx
  103c2d:	8d 04 16             	lea    (%esi,%edx,1),%eax
  103c30:	89 04 24             	mov    %eax,(%esp)
  103c33:	e8 78 05 00 00       	call   1041b0 <memset>
  kfree(cp->mem, cp->sz);
  103c38:	e8 83 f8 ff ff       	call   1034c0 <curproc>
  103c3d:	8b 58 04             	mov    0x4(%eax),%ebx
  103c40:	e8 7b f8 ff ff       	call   1034c0 <curproc>
  103c45:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103c49:	8b 00                	mov    (%eax),%eax
  103c4b:	89 04 24             	mov    %eax,(%esp)
  103c4e:	e8 ed e7 ff ff       	call   102440 <kfree>
  cp->mem = newmem;
  103c53:	e8 68 f8 ff ff       	call   1034c0 <curproc>
  103c58:	89 30                	mov    %esi,(%eax)
  cp->sz += n;
  103c5a:	e8 61 f8 ff ff       	call   1034c0 <curproc>
  103c5f:	01 78 04             	add    %edi,0x4(%eax)
  setupsegs(cp);
  103c62:	e8 59 f8 ff ff       	call   1034c0 <curproc>
  103c67:	89 04 24             	mov    %eax,(%esp)
  103c6a:	e8 d1 fc ff ff       	call   103940 <setupsegs>
  return cp->sz - n;
  103c6f:	e8 4c f8 ff ff       	call   1034c0 <curproc>
  103c74:	8b 40 04             	mov    0x4(%eax),%eax
  103c77:	29 f8                	sub    %edi,%eax
}
  103c79:	83 c4 0c             	add    $0xc,%esp
  103c7c:	5b                   	pop    %ebx
  103c7d:	5e                   	pop    %esi
  103c7e:	5f                   	pop    %edi
  103c7f:	5d                   	pop    %ebp
  103c80:	c3                   	ret    
  103c81:	eb 0d                	jmp    103c90 <copyproc>
  103c83:	90                   	nop    
  103c84:	90                   	nop    
  103c85:	90                   	nop    
  103c86:	90                   	nop    
  103c87:	90                   	nop    
  103c88:	90                   	nop    
  103c89:	90                   	nop    
  103c8a:	90                   	nop    
  103c8b:	90                   	nop    
  103c8c:	90                   	nop    
  103c8d:	90                   	nop    
  103c8e:	90                   	nop    
  103c8f:	90                   	nop    

00103c90 <copyproc>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  103c90:	55                   	push   %ebp
  103c91:	89 e5                	mov    %esp,%ebp
  103c93:	57                   	push   %edi
  103c94:	56                   	push   %esi
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  103c95:	be 40 ba 10 00       	mov    $0x10ba40,%esi
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  103c9a:	53                   	push   %ebx
  103c9b:	83 ec 0c             	sub    $0xc,%esp
  103c9e:	8b 7d 08             	mov    0x8(%ebp),%edi
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  103ca1:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103ca8:	e8 93 04 00 00       	call   104140 <acquire>
  103cad:	eb 13                	jmp    103cc2 <copyproc+0x32>
  103caf:	90                   	nop    
{
  int i;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103cb0:	81 c6 a0 00 00 00    	add    $0xa0,%esi
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
  103cb6:	81 fe 40 e2 10 00    	cmp    $0x10e240,%esi
  103cbc:	0f 84 26 01 00 00    	je     103de8 <copyproc+0x158>
    p = &proc[i];
    if(p->state == UNUSED){
  103cc2:	8b 5e 0c             	mov    0xc(%esi),%ebx
  103cc5:	85 db                	test   %ebx,%ebx
  103cc7:	75 e7                	jne    103cb0 <copyproc+0x20>
      p->state = EMBRYO;
      p->pid = nextpid++;
  103cc9:	a1 04 7c 10 00       	mov    0x107c04,%eax
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED){
  103cce:	89 f3                	mov    %esi,%ebx
      p->state = EMBRYO;
  103cd0:	c7 46 0c 01 00 00 00 	movl   $0x1,0xc(%esi)
      p->pid = nextpid++;
  103cd7:	89 46 10             	mov    %eax,0x10(%esi)
  103cda:	83 c0 01             	add    $0x1,%eax
  103cdd:	a3 04 7c 10 00       	mov    %eax,0x107c04
	p-> tickets = 1;
  103ce2:	c7 86 98 00 00 00 01 	movl   $0x1,0x98(%esi)
  103ce9:	00 00 00 
	numTickets += 1;
  103cec:	83 05 48 81 10 00 01 	addl   $0x1,0x108148

      release(&proc_table_lock);
  103cf3:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103cfa:	e8 01 04 00 00       	call   104100 <release>
{
  int i;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103cff:	85 f6                	test   %esi,%esi
  103d01:	0f 84 d7 00 00 00    	je     103dde <copyproc+0x14e>
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
  103d07:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103d0e:	e8 6d e6 ff ff       	call   102380 <kalloc>
  103d13:	85 c0                	test   %eax,%eax
  103d15:	89 46 08             	mov    %eax,0x8(%esi)
  103d18:	0f 84 1f 01 00 00    	je     103e3d <copyproc+0x1ad>
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  103d1e:	8d 90 bc 0f 00 00    	lea    0xfbc(%eax),%edx

  if(p){  // Copy process state from p.
  103d24:	85 ff                	test   %edi,%edi
  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  103d26:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)

  if(p){  // Copy process state from p.
  103d2c:	74 7c                	je     103daa <copyproc+0x11a>
    np->parent = p;
  103d2e:	89 7e 14             	mov    %edi,0x14(%esi)
    memmove(np->tf, p->tf, sizeof(*np->tf));
  103d31:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  103d38:	00 
  103d39:	8b 87 84 00 00 00    	mov    0x84(%edi),%eax
  103d3f:	89 14 24             	mov    %edx,(%esp)
  103d42:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d46:	e8 f5 04 00 00       	call   104240 <memmove>
  
    np->sz = p->sz;
  103d4b:	8b 47 04             	mov    0x4(%edi),%eax
  103d4e:	89 46 04             	mov    %eax,0x4(%esi)
    if((np->mem = kalloc(np->sz)) == 0){
  103d51:	89 04 24             	mov    %eax,(%esp)
  103d54:	e8 27 e6 ff ff       	call   102380 <kalloc>
  103d59:	85 c0                	test   %eax,%eax
  103d5b:	89 c2                	mov    %eax,%edx
  103d5d:	89 03                	mov    %eax,(%ebx)
  103d5f:	0f 84 9b 00 00 00    	je     103e00 <copyproc+0x170>
	np->tickets = 1;
	numTickets += 1;

      return 0;
    }
    memmove(np->mem, p->mem, np->sz);
  103d65:	8b 46 04             	mov    0x4(%esi),%eax
  103d68:	31 db                	xor    %ebx,%ebx
  103d6a:	89 44 24 08          	mov    %eax,0x8(%esp)
  103d6e:	8b 07                	mov    (%edi),%eax
  103d70:	89 14 24             	mov    %edx,(%esp)
  103d73:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d77:	e8 c4 04 00 00       	call   104240 <memmove>
  103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    for(i = 0; i < NOFILE; i++)
      if(p->ofile[i])
  103d80:	8b 44 9f 20          	mov    0x20(%edi,%ebx,4),%eax
  103d84:	85 c0                	test   %eax,%eax
  103d86:	74 0c                	je     103d94 <copyproc+0x104>
        np->ofile[i] = filedup(p->ofile[i]);
  103d88:	89 04 24             	mov    %eax,(%esp)
  103d8b:	e8 e0 d1 ff ff       	call   100f70 <filedup>
  103d90:	89 44 9e 20          	mov    %eax,0x20(%esi,%ebx,4)

      return 0;
    }
    memmove(np->mem, p->mem, np->sz);

    for(i = 0; i < NOFILE; i++)
  103d94:	83 c3 01             	add    $0x1,%ebx
  103d97:	83 fb 10             	cmp    $0x10,%ebx
  103d9a:	75 e4                	jne    103d80 <copyproc+0xf0>
      if(p->ofile[i])
        np->ofile[i] = filedup(p->ofile[i]);
    np->cwd = idup(p->cwd);
  103d9c:	8b 47 60             	mov    0x60(%edi),%eax
  103d9f:	89 04 24             	mov    %eax,(%esp)
  103da2:	e8 b9 d3 ff ff       	call   101160 <idup>
  103da7:	89 46 60             	mov    %eax,0x60(%esi)
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  103daa:	8d 46 64             	lea    0x64(%esi),%eax
  np->context.eip = (uint)forkret;
  np->context.esp = (uint)np->tf;

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  103dad:	89 f3                	mov    %esi,%ebx
        np->ofile[i] = filedup(p->ofile[i]);
    np->cwd = idup(p->cwd);
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  103daf:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
  103db6:	00 
  103db7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103dbe:	00 
  103dbf:	89 04 24             	mov    %eax,(%esp)
  103dc2:	e8 e9 03 00 00       	call   1041b0 <memset>
  np->context.eip = (uint)forkret;
  np->context.esp = (uint)np->tf;
  103dc7:	8b 86 84 00 00 00    	mov    0x84(%esi),%eax
    np->cwd = idup(p->cwd);
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  np->context.eip = (uint)forkret;
  103dcd:	c7 46 64 f0 34 10 00 	movl   $0x1034f0,0x64(%esi)
  np->context.esp = (uint)np->tf;
  103dd4:	89 46 68             	mov    %eax,0x68(%esi)

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  103dd7:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  return np;
}
  103dde:	83 c4 0c             	add    $0xc,%esp
  103de1:	89 d8                	mov    %ebx,%eax
  103de3:	5b                   	pop    %ebx
  103de4:	5e                   	pop    %esi
  103de5:	5f                   	pop    %edi
  103de6:	5d                   	pop    %ebp
  103de7:	c3                   	ret    

      release(&proc_table_lock);
      return p;
    }
  }
  release(&proc_table_lock);
  103de8:	31 db                	xor    %ebx,%ebx
  103dea:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103df1:	e8 0a 03 00 00       	call   104100 <release>
  np->context.esp = (uint)np->tf;

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  return np;
}
  103df6:	83 c4 0c             	add    $0xc,%esp
  103df9:	89 d8                	mov    %ebx,%eax
  103dfb:	5b                   	pop    %ebx
  103dfc:	5e                   	pop    %esi
  103dfd:	5f                   	pop    %edi
  103dfe:	5d                   	pop    %ebp
  103dff:	c3                   	ret    
    np->parent = p;
    memmove(np->tf, p->tf, sizeof(*np->tf));
  
    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
  103e00:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103e07:	00 
  103e08:	8b 46 08             	mov    0x8(%esi),%eax
      np->kstack = 0;
      np->state = UNUSED;
      np->parent = 0;

	np->tickets = 1;
	numTickets += 1;
  103e0b:	31 db                	xor    %ebx,%ebx
    np->parent = p;
    memmove(np->tf, p->tf, sizeof(*np->tf));
  
    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
  103e0d:	89 04 24             	mov    %eax,(%esp)
  103e10:	e8 2b e6 ff ff       	call   102440 <kfree>
      np->kstack = 0;
      np->state = UNUSED;
      np->parent = 0;

	np->tickets = 1;
  103e15:	c7 86 98 00 00 00 01 	movl   $0x1,0x98(%esi)
  103e1c:	00 00 00 
    memmove(np->tf, p->tf, sizeof(*np->tf));
  
    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
  103e1f:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
      np->state = UNUSED;
  103e26:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
      np->parent = 0;
  103e2d:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)

	np->tickets = 1;
	numTickets += 1;
  103e34:	83 05 48 81 10 00 01 	addl   $0x1,0x108148
  103e3b:	eb a1                	jmp    103dde <copyproc+0x14e>
  if((np = allocproc()) == 0)
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
  103e3d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  103e44:	31 db                	xor    %ebx,%ebx
  103e46:	eb 96                	jmp    103dde <copyproc+0x14e>
  103e48:	90                   	nop    
  103e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103e50 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  103e50:	55                   	push   %ebp
  103e51:	89 e5                	mov    %esp,%ebp
  103e53:	53                   	push   %ebx
  103e54:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = copyproc(0);
  103e57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103e5e:	e8 2d fe ff ff       	call   103c90 <copyproc>
  p->sz = PAGE;
  103e63:	c7 40 04 00 10 00 00 	movl   $0x1000,0x4(%eax)
userinit(void)
{
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = copyproc(0);
  103e6a:	89 c3                	mov    %eax,%ebx
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  103e6c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103e73:	e8 08 e5 ff ff       	call   102380 <kalloc>
  103e78:	89 03                	mov    %eax,(%ebx)
  p->cwd = namei("/");
  103e7a:	c7 04 24 06 67 10 00 	movl   $0x106706,(%esp)
  103e81:	e8 2a e1 ff ff       	call   101fb0 <namei>
  103e86:	89 43 60             	mov    %eax,0x60(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  103e89:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  103e90:	00 
  103e91:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103e98:	00 
  103e99:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  103e9f:	89 04 24             	mov    %eax,(%esp)
  103ea2:	e8 09 03 00 00       	call   1041b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103ea7:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103ead:	8b 0b                	mov    (%ebx),%ecx
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  103eaf:	c7 40 38 00 02 00 00 	movl   $0x200,0x38(%eax)
  p->tf->esp = p->sz;
  103eb6:	8b 53 04             	mov    0x4(%ebx),%edx
  p = copyproc(0);
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103eb9:	66 c7 40 34 1b 00    	movw   $0x1b,0x34(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  103ebf:	66 c7 40 24 23 00    	movw   $0x23,0x24(%eax)
  p->tf->es = p->tf->ds;
  103ec5:	66 c7 40 20 23 00    	movw   $0x23,0x20(%eax)
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  103ecb:	89 50 3c             	mov    %edx,0x3c(%eax)
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  103ece:	83 68 3c 04          	subl   $0x4,0x3c(%eax)
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103ed2:	8b 50 3c             	mov    0x3c(%eax),%edx
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  103ed5:	66 c7 40 40 23 00    	movw   $0x23,0x40(%eax)
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103edb:	c7 04 11 ef ef ef ef 	movl   $0xefefefef,(%ecx,%edx,1)

  // On entry to user space, start executing at beginning of initcode.S.
  p->tf->eip = 0;
  103ee2:	c7 40 30 00 00 00 00 	movl   $0x0,0x30(%eax)
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  103ee9:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  103ef0:	00 
  103ef1:	c7 44 24 04 0c 80 10 	movl   $0x10800c,0x4(%esp)
  103ef8:	00 
  103ef9:	8b 03                	mov    (%ebx),%eax
  103efb:	89 04 24             	mov    %eax,(%esp)
  103efe:	e8 3d 03 00 00       	call   104240 <memmove>
  safestrcpy(p->name, "initcode", sizeof(p->name));
  103f03:	8d 83 88 00 00 00    	lea    0x88(%ebx),%eax
  103f09:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  103f10:	00 
  103f11:	c7 44 24 04 08 67 10 	movl   $0x106708,0x4(%esp)
  103f18:	00 
  103f19:	89 04 24             	mov    %eax,(%esp)
  103f1c:	e8 2f 04 00 00       	call   104350 <safestrcpy>
  p->state = RUNNABLE;
  
	p->tickets = 5;
  103f21:	c7 83 98 00 00 00 05 	movl   $0x5,0x98(%ebx)
  103f28:	00 00 00 

  // On entry to user space, start executing at beginning of initcode.S.
  p->tf->eip = 0;
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->state = RUNNABLE;
  103f2b:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  
	p->tickets = 5;
	numTickets += 5;

  initproc = p;
  103f32:	89 1d 4c 81 10 00    	mov    %ebx,0x10814c
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->state = RUNNABLE;
  
	p->tickets = 5;
	numTickets += 5;
  103f38:	83 05 48 81 10 00 05 	addl   $0x5,0x108148

  initproc = p;
}
  103f3f:	83 c4 14             	add    $0x14,%esp
  103f42:	5b                   	pop    %ebx
  103f43:	5d                   	pop    %ebp
  103f44:	c3                   	ret    
  103f45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103f50 <pinit>:
}


void
pinit(void)
{
  103f50:	55                   	push   %ebp
  103f51:	89 e5                	mov    %esp,%ebp
  103f53:	83 ec 08             	sub    $0x8,%esp
  initlock(&proc_table_lock, "proc_table");
  103f56:	c7 44 24 04 11 67 10 	movl   $0x106711,0x4(%esp)
  103f5d:	00 
  103f5e:	c7 04 24 40 e2 10 00 	movl   $0x10e240,(%esp)
  103f65:	e8 06 00 00 00       	call   103f70 <initlock>
}
  103f6a:	c9                   	leave  
  103f6b:	c3                   	ret    
  103f6c:	90                   	nop    
  103f6d:	90                   	nop    
  103f6e:	90                   	nop    
  103f6f:	90                   	nop    

00103f70 <initlock>:

extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  103f70:	55                   	push   %ebp
  103f71:	89 e5                	mov    %esp,%ebp
  103f73:	8b 45 08             	mov    0x8(%ebp),%eax
  lock->name = name;
  103f76:	8b 55 0c             	mov    0xc(%ebp),%edx
  lock->locked = 0;
  103f79:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  lock->name = name;
  103f7f:	89 50 04             	mov    %edx,0x4(%eax)
  lock->locked = 0;
  lock->cpu = 0xffffffff;
  103f82:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
}
  103f89:	5d                   	pop    %ebp
  103f8a:	c3                   	ret    
  103f8b:	90                   	nop    
  103f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103f90 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103f90:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103f91:	31 d2                	xor    %edx,%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103f93:	89 e5                	mov    %esp,%ebp
  103f95:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103f96:	8b 4d 08             	mov    0x8(%ebp),%ecx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103f99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103f9c:	83 e9 08             	sub    $0x8,%ecx
  103f9f:	eb 09                	jmp    103faa <getcallerpcs+0x1a>
  103fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103fa8:	89 c1                	mov    %eax,%ecx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103faa:	8d 41 ff             	lea    -0x1(%ecx),%eax
  103fad:	83 f8 fd             	cmp    $0xfffffffd,%eax
  103fb0:	77 16                	ja     103fc8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103fb2:	8b 41 04             	mov    0x4(%ecx),%eax
  103fb5:	89 04 93             	mov    %eax,(%ebx,%edx,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103fb8:	83 c2 01             	add    $0x1,%edx
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103fbb:	8b 01                	mov    (%ecx),%eax
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103fbd:	83 fa 0a             	cmp    $0xa,%edx
  103fc0:	75 e6                	jne    103fa8 <getcallerpcs+0x18>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  103fc2:	5b                   	pop    %ebx
  103fc3:	5d                   	pop    %ebp
  103fc4:	c3                   	ret    
  103fc5:	8d 76 00             	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103fc8:	83 fa 09             	cmp    $0x9,%edx
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103fcb:	8d 04 93             	lea    (%ebx,%edx,4),%eax
  }
  for(; i < 10; i++)
  103fce:	7f f2                	jg     103fc2 <getcallerpcs+0x32>
  103fd0:	83 c2 01             	add    $0x1,%edx
    pcs[i] = 0;
  103fd3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103fd9:	83 c0 04             	add    $0x4,%eax
  103fdc:	83 fa 09             	cmp    $0x9,%edx
  103fdf:	7e ef                	jle    103fd0 <getcallerpcs+0x40>
    pcs[i] = 0;
}
  103fe1:	5b                   	pop    %ebx
  103fe2:	5d                   	pop    %ebp
  103fe3:	c3                   	ret    
  103fe4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103fea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103ff0 <popcli>:
    cpus[cpu()].intena = eflags & FL_IF;
}

void
popcli(void)
{
  103ff0:	55                   	push   %ebp
  103ff1:	89 e5                	mov    %esp,%ebp
  103ff3:	83 ec 08             	sub    $0x8,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103ff6:	9c                   	pushf  
  103ff7:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  103ff8:	f6 c4 02             	test   $0x2,%ah
  103ffb:	75 53                	jne    104050 <popcli+0x60>
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
  103ffd:	e8 2e e9 ff ff       	call   102930 <cpu>
  104002:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  104008:	05 c4 b3 10 00       	add    $0x10b3c4,%eax
  10400d:	8b 90 c0 00 00 00    	mov    0xc0(%eax),%edx
  104013:	83 ea 01             	sub    $0x1,%edx
  104016:	85 d2                	test   %edx,%edx
  104018:	89 90 c0 00 00 00    	mov    %edx,0xc0(%eax)
  10401e:	78 3c                	js     10405c <popcli+0x6c>
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  104020:	e8 0b e9 ff ff       	call   102930 <cpu>
  104025:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  10402b:	8b 90 84 b4 10 00    	mov    0x10b484(%eax),%edx
  104031:	85 d2                	test   %edx,%edx
  104033:	74 03                	je     104038 <popcli+0x48>
    sti();
}
  104035:	c9                   	leave  
  104036:	c3                   	ret    
  104037:	90                   	nop    
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  104038:	e8 f3 e8 ff ff       	call   102930 <cpu>
  10403d:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  104043:	8b 80 88 b4 10 00    	mov    0x10b488(%eax),%eax
  104049:	85 c0                	test   %eax,%eax
  10404b:	74 e8                	je     104035 <popcli+0x45>
}

static inline void
sti(void)
{
  asm volatile("sti");
  10404d:	fb                   	sti    
    sti();
}
  10404e:	c9                   	leave  
  10404f:	c3                   	ret    

void
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  104050:	c7 04 24 60 67 10 00 	movl   $0x106760,(%esp)
  104057:	e8 14 c9 ff ff       	call   100970 <panic>
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  10405c:	c7 04 24 77 67 10 00 	movl   $0x106777,(%esp)
  104063:	e8 08 c9 ff ff       	call   100970 <panic>
  104068:	90                   	nop    
  104069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104070 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  104070:	55                   	push   %ebp
  104071:	89 e5                	mov    %esp,%ebp
  104073:	53                   	push   %ebx
  104074:	83 ec 04             	sub    $0x4,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  104077:	9c                   	pushf  
  104078:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
  104079:	fa                   	cli    
  int eflags;
  
  eflags = read_eflags();
  cli();
  if(cpus[cpu()].ncli++ == 0)
  10407a:	e8 b1 e8 ff ff       	call   102930 <cpu>
  10407f:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  104085:	05 c4 b3 10 00       	add    $0x10b3c4,%eax
  10408a:	8b 88 c0 00 00 00    	mov    0xc0(%eax),%ecx
  104090:	8d 51 01             	lea    0x1(%ecx),%edx
  104093:	85 c9                	test   %ecx,%ecx
  104095:	89 90 c0 00 00 00    	mov    %edx,0xc0(%eax)
  10409b:	75 17                	jne    1040b4 <pushcli+0x44>
    cpus[cpu()].intena = eflags & FL_IF;
  10409d:	e8 8e e8 ff ff       	call   102930 <cpu>
  1040a2:	81 e3 00 02 00 00    	and    $0x200,%ebx
  1040a8:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  1040ae:	89 98 88 b4 10 00    	mov    %ebx,0x10b488(%eax)
}
  1040b4:	83 c4 04             	add    $0x4,%esp
  1040b7:	5b                   	pop    %ebx
  1040b8:	5d                   	pop    %ebp
  1040b9:	c3                   	ret    
  1040ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001040c0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  1040c0:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu() + 10;
  1040c1:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  1040c3:	89 e5                	mov    %esp,%ebp
  1040c5:	53                   	push   %ebx
  1040c6:	83 ec 04             	sub    $0x4,%esp
  1040c9:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu() + 10;
  1040cc:	8b 0a                	mov    (%edx),%ecx
  1040ce:	85 c9                	test   %ecx,%ecx
  1040d0:	75 06                	jne    1040d8 <holding+0x18>
}
  1040d2:	83 c4 04             	add    $0x4,%esp
  1040d5:	5b                   	pop    %ebx
  1040d6:	5d                   	pop    %ebp
  1040d7:	c3                   	ret    

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  1040d8:	8b 5a 08             	mov    0x8(%edx),%ebx
  1040db:	e8 50 e8 ff ff       	call   102930 <cpu>
  1040e0:	83 c0 0a             	add    $0xa,%eax
  1040e3:	39 c3                	cmp    %eax,%ebx
  1040e5:	0f 94 c0             	sete   %al
}
  1040e8:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  1040eb:	0f b6 c0             	movzbl %al,%eax
}
  1040ee:	5b                   	pop    %ebx
  1040ef:	5d                   	pop    %ebp
  1040f0:	c3                   	ret    
  1040f1:	eb 0d                	jmp    104100 <release>
  1040f3:	90                   	nop    
  1040f4:	90                   	nop    
  1040f5:	90                   	nop    
  1040f6:	90                   	nop    
  1040f7:	90                   	nop    
  1040f8:	90                   	nop    
  1040f9:	90                   	nop    
  1040fa:	90                   	nop    
  1040fb:	90                   	nop    
  1040fc:	90                   	nop    
  1040fd:	90                   	nop    
  1040fe:	90                   	nop    
  1040ff:	90                   	nop    

00104100 <release>:
}

// Release the lock.
void
release(struct spinlock *lock)
{
  104100:	55                   	push   %ebp
  104101:	89 e5                	mov    %esp,%ebp
  104103:	53                   	push   %ebx
  104104:	83 ec 04             	sub    $0x4,%esp
  104107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lock))
  10410a:	89 1c 24             	mov    %ebx,(%esp)
  10410d:	e8 ae ff ff ff       	call   1040c0 <holding>
  104112:	85 c0                	test   %eax,%eax
  104114:	74 1d                	je     104133 <release+0x33>
    panic("release");

  lock->pcs[0] = 0;
  104116:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  10411d:	31 c0                	xor    %eax,%eax
  lock->cpu = 0xffffffff;
  10411f:	c7 43 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebx)
  104126:	f0 87 03             	lock xchg %eax,(%ebx)
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
}
  104129:	83 c4 04             	add    $0x4,%esp
  10412c:	5b                   	pop    %ebx
  10412d:	5d                   	pop    %ebp
  // by the Intel manuals, but does not happen on current 
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
  10412e:	e9 bd fe ff ff       	jmp    103ff0 <popcli>
// Release the lock.
void
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");
  104133:	c7 04 24 7e 67 10 00 	movl   $0x10677e,(%esp)
  10413a:	e8 31 c8 ff ff       	call   100970 <panic>
  10413f:	90                   	nop    

00104140 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  104140:	55                   	push   %ebp
  104141:	89 e5                	mov    %esp,%ebp
  104143:	53                   	push   %ebx
  104144:	83 ec 14             	sub    $0x14,%esp
  pushcli();
  104147:	e8 24 ff ff ff       	call   104070 <pushcli>
  if(holding(lock))
  10414c:	8b 45 08             	mov    0x8(%ebp),%eax
  10414f:	89 04 24             	mov    %eax,(%esp)
  104152:	e8 69 ff ff ff       	call   1040c0 <holding>
  104157:	85 c0                	test   %eax,%eax
  104159:	75 3d                	jne    104198 <acquire+0x58>
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it.  
  while(xchg(&lock->locked, 1) == 1)
  10415b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10415e:	ba 01 00 00 00       	mov    $0x1,%edx
  104163:	90                   	nop    
  104164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104168:	89 d0                	mov    %edx,%eax
  10416a:	f0 87 03             	lock xchg %eax,(%ebx)
  10416d:	83 e8 01             	sub    $0x1,%eax
  104170:	74 f6                	je     104168 <acquire+0x28>

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  104172:	e8 b9 e7 ff ff       	call   102930 <cpu>
  104177:	83 c0 0a             	add    $0xa,%eax
  10417a:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lock, lock->pcs);
  10417d:	8b 45 08             	mov    0x8(%ebp),%eax
  104180:	83 c0 0c             	add    $0xc,%eax
  104183:	89 44 24 04          	mov    %eax,0x4(%esp)
  104187:	8d 45 08             	lea    0x8(%ebp),%eax
  10418a:	89 04 24             	mov    %eax,(%esp)
  10418d:	e8 fe fd ff ff       	call   103f90 <getcallerpcs>
}
  104192:	83 c4 14             	add    $0x14,%esp
  104195:	5b                   	pop    %ebx
  104196:	5d                   	pop    %ebp
  104197:	c3                   	ret    
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
    panic("acquire");
  104198:	c7 04 24 86 67 10 00 	movl   $0x106786,(%esp)
  10419f:	e8 cc c7 ff ff       	call   100970 <panic>
  1041a4:	90                   	nop    
  1041a5:	90                   	nop    
  1041a6:	90                   	nop    
  1041a7:	90                   	nop    
  1041a8:	90                   	nop    
  1041a9:	90                   	nop    
  1041aa:	90                   	nop    
  1041ab:	90                   	nop    
  1041ac:	90                   	nop    
  1041ad:	90                   	nop    
  1041ae:	90                   	nop    
  1041af:	90                   	nop    

001041b0 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
  1041b0:	55                   	push   %ebp
  1041b1:	89 e5                	mov    %esp,%ebp
  1041b3:	8b 45 10             	mov    0x10(%ebp),%eax
  1041b6:	53                   	push   %ebx
  1041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  1041ba:	85 c0                	test   %eax,%eax
  1041bc:	74 14                	je     1041d2 <memset+0x22>
  1041be:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  1041c2:	31 d2                	xor    %edx,%edx
  1041c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
  1041c8:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
  1041cb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  1041ce:	39 c2                	cmp    %eax,%edx
  1041d0:	75 f6                	jne    1041c8 <memset+0x18>
    *d++ = c;

  return dst;
}
  1041d2:	89 d8                	mov    %ebx,%eax
  1041d4:	5b                   	pop    %ebx
  1041d5:	5d                   	pop    %ebp
  1041d6:	c3                   	ret    
  1041d7:	89 f6                	mov    %esi,%esi
  1041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001041e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  1041e0:	55                   	push   %ebp
  1041e1:	89 e5                	mov    %esp,%ebp
  1041e3:	57                   	push   %edi
  1041e4:	56                   	push   %esi
  1041e5:	53                   	push   %ebx
  1041e6:	8b 55 10             	mov    0x10(%ebp),%edx
  1041e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  1041ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  1041ef:	85 d2                	test   %edx,%edx
  1041f1:	74 2d                	je     104220 <memcmp+0x40>
    if(*s1 != *s2)
  1041f3:	0f b6 1f             	movzbl (%edi),%ebx
  1041f6:	0f b6 06             	movzbl (%esi),%eax
  1041f9:	38 c3                	cmp    %al,%bl
  1041fb:	75 33                	jne    104230 <memcmp+0x50>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  1041fd:	8d 4a ff             	lea    -0x1(%edx),%ecx
  104200:	31 d2                	xor    %edx,%edx
  104202:	eb 18                	jmp    10421c <memcmp+0x3c>
  104204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s1 != *s2)
  104208:	0f b6 5c 17 01       	movzbl 0x1(%edi,%edx,1),%ebx
  10420d:	83 e9 01             	sub    $0x1,%ecx
  104210:	0f b6 44 16 01       	movzbl 0x1(%esi,%edx,1),%eax
  104215:	83 c2 01             	add    $0x1,%edx
  104218:	38 c3                	cmp    %al,%bl
  10421a:	75 14                	jne    104230 <memcmp+0x50>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  10421c:	85 c9                	test   %ecx,%ecx
  10421e:	75 e8                	jne    104208 <memcmp+0x28>
  104220:	31 d2                	xor    %edx,%edx
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  104222:	89 d0                	mov    %edx,%eax
  104224:	5b                   	pop    %ebx
  104225:	5e                   	pop    %esi
  104226:	5f                   	pop    %edi
  104227:	5d                   	pop    %ebp
  104228:	c3                   	ret    
  104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  104230:	0f b6 d3             	movzbl %bl,%edx
  104233:	0f b6 c0             	movzbl %al,%eax
  104236:	29 c2                	sub    %eax,%edx
    s1++, s2++;
  }

  return 0;
}
  104238:	89 d0                	mov    %edx,%eax
  10423a:	5b                   	pop    %ebx
  10423b:	5e                   	pop    %esi
  10423c:	5f                   	pop    %edi
  10423d:	5d                   	pop    %ebp
  10423e:	c3                   	ret    
  10423f:	90                   	nop    

00104240 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  104240:	55                   	push   %ebp
  104241:	89 e5                	mov    %esp,%ebp
  104243:	57                   	push   %edi
  104244:	56                   	push   %esi
  104245:	53                   	push   %ebx
  104246:	8b 75 08             	mov    0x8(%ebp),%esi
  104249:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10424c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  10424f:	39 f1                	cmp    %esi,%ecx
  104251:	73 35                	jae    104288 <memmove+0x48>
  104253:	8d 3c 19             	lea    (%ecx,%ebx,1),%edi
  104256:	39 fe                	cmp    %edi,%esi
  104258:	73 2e                	jae    104288 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
  10425a:	85 db                	test   %ebx,%ebx
  10425c:	74 1d                	je     10427b <memmove+0x3b>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
  10425e:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
  104261:	31 d2                	xor    %edx,%edx
  104263:	90                   	nop    
  104264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
      *--d = *--s;
  104268:	0f b6 44 17 ff       	movzbl -0x1(%edi,%edx,1),%eax
  10426d:	88 44 11 ff          	mov    %al,-0x1(%ecx,%edx,1)
  104271:	83 ea 01             	sub    $0x1,%edx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  104274:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
  104277:	85 c0                	test   %eax,%eax
  104279:	75 ed                	jne    104268 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  10427b:	89 f0                	mov    %esi,%eax
  10427d:	5b                   	pop    %ebx
  10427e:	5e                   	pop    %esi
  10427f:	5f                   	pop    %edi
  104280:	5d                   	pop    %ebp
  104281:	c3                   	ret    
  104282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  104288:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
  10428a:	85 db                	test   %ebx,%ebx
  10428c:	74 ed                	je     10427b <memmove+0x3b>
  10428e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
  104290:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
  104294:	88 04 16             	mov    %al,(%esi,%edx,1)
  104297:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  10429a:	39 d3                	cmp    %edx,%ebx
  10429c:	75 f2                	jne    104290 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
  10429e:	89 f0                	mov    %esi,%eax
  1042a0:	5b                   	pop    %ebx
  1042a1:	5e                   	pop    %esi
  1042a2:	5f                   	pop    %edi
  1042a3:	5d                   	pop    %ebp
  1042a4:	c3                   	ret    
  1042a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001042b0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  1042b0:	55                   	push   %ebp
  1042b1:	89 e5                	mov    %esp,%ebp
  1042b3:	56                   	push   %esi
  1042b4:	53                   	push   %ebx
  1042b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  1042b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  1042bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
  1042be:	85 c9                	test   %ecx,%ecx
  1042c0:	75 1e                	jne    1042e0 <strncmp+0x30>
  1042c2:	eb 34                	jmp    1042f8 <strncmp+0x48>
  1042c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1042c8:	0f b6 16             	movzbl (%esi),%edx
  1042cb:	38 d0                	cmp    %dl,%al
  1042cd:	75 1b                	jne    1042ea <strncmp+0x3a>
  1042cf:	83 e9 01             	sub    $0x1,%ecx
  1042d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1042d8:	74 1e                	je     1042f8 <strncmp+0x48>
    n--, p++, q++;
  1042da:	83 c3 01             	add    $0x1,%ebx
  1042dd:	83 c6 01             	add    $0x1,%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  1042e0:	0f b6 03             	movzbl (%ebx),%eax
  1042e3:	84 c0                	test   %al,%al
  1042e5:	75 e1                	jne    1042c8 <strncmp+0x18>
  1042e7:	0f b6 16             	movzbl (%esi),%edx
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  1042ea:	0f b6 c8             	movzbl %al,%ecx
  1042ed:	0f b6 c2             	movzbl %dl,%eax
  1042f0:	29 c1                	sub    %eax,%ecx
}
  1042f2:	89 c8                	mov    %ecx,%eax
  1042f4:	5b                   	pop    %ebx
  1042f5:	5e                   	pop    %esi
  1042f6:	5d                   	pop    %ebp
  1042f7:	c3                   	ret    
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  1042f8:	31 c9                	xor    %ecx,%ecx
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  1042fa:	89 c8                	mov    %ecx,%eax
  1042fc:	5b                   	pop    %ebx
  1042fd:	5e                   	pop    %esi
  1042fe:	5d                   	pop    %ebp
  1042ff:	c3                   	ret    

00104300 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  104300:	55                   	push   %ebp
  104301:	89 e5                	mov    %esp,%ebp
  104303:	56                   	push   %esi
  104304:	8b 75 08             	mov    0x8(%ebp),%esi
  104307:	53                   	push   %ebx
  104308:	8b 55 10             	mov    0x10(%ebp),%edx
  10430b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  10430e:	89 f1                	mov    %esi,%ecx
  104310:	eb 09                	jmp    10431b <strncpy+0x1b>
  104312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104318:	83 c3 01             	add    $0x1,%ebx
  10431b:	83 ea 01             	sub    $0x1,%edx
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
  10431e:	8d 42 01             	lea    0x1(%edx),%eax
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104321:	85 c0                	test   %eax,%eax
  104323:	7e 0c                	jle    104331 <strncpy+0x31>
  104325:	0f b6 03             	movzbl (%ebx),%eax
  104328:	88 01                	mov    %al,(%ecx)
  10432a:	83 c1 01             	add    $0x1,%ecx
  10432d:	84 c0                	test   %al,%al
  10432f:	75 e7                	jne    104318 <strncpy+0x18>
  104331:	31 c0                	xor    %eax,%eax
    ;
  while(n-- > 0)
  104333:	85 d2                	test   %edx,%edx
  104335:	7e 0c                	jle    104343 <strncpy+0x43>
  104337:	90                   	nop    
    *s++ = 0;
  104338:	c6 04 01 00          	movb   $0x0,(%ecx,%eax,1)
  10433c:	83 c0 01             	add    $0x1,%eax
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  10433f:	39 d0                	cmp    %edx,%eax
  104341:	75 f5                	jne    104338 <strncpy+0x38>
    *s++ = 0;
  return os;
}
  104343:	89 f0                	mov    %esi,%eax
  104345:	5b                   	pop    %ebx
  104346:	5e                   	pop    %esi
  104347:	5d                   	pop    %ebp
  104348:	c3                   	ret    
  104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104350 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  104350:	55                   	push   %ebp
  104351:	89 e5                	mov    %esp,%ebp
  104353:	8b 4d 10             	mov    0x10(%ebp),%ecx
  104356:	56                   	push   %esi
  104357:	8b 75 08             	mov    0x8(%ebp),%esi
  10435a:	53                   	push   %ebx
  10435b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;
  
  os = s;
  if(n <= 0)
  10435e:	85 c9                	test   %ecx,%ecx
  104360:	7e 1f                	jle    104381 <safestrcpy+0x31>
  104362:	89 f2                	mov    %esi,%edx
  104364:	eb 05                	jmp    10436b <safestrcpy+0x1b>
  104366:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  104368:	83 c3 01             	add    $0x1,%ebx
  10436b:	83 e9 01             	sub    $0x1,%ecx
  10436e:	85 c9                	test   %ecx,%ecx
  104370:	7e 0c                	jle    10437e <safestrcpy+0x2e>
  104372:	0f b6 03             	movzbl (%ebx),%eax
  104375:	88 02                	mov    %al,(%edx)
  104377:	83 c2 01             	add    $0x1,%edx
  10437a:	84 c0                	test   %al,%al
  10437c:	75 ea                	jne    104368 <safestrcpy+0x18>
    ;
  *s = 0;
  10437e:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  104381:	89 f0                	mov    %esi,%eax
  104383:	5b                   	pop    %ebx
  104384:	5e                   	pop    %esi
  104385:	5d                   	pop    %ebp
  104386:	c3                   	ret    
  104387:	89 f6                	mov    %esi,%esi
  104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104390 <strlen>:

int
strlen(const char *s)
{
  104390:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  104391:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  104393:	89 e5                	mov    %esp,%ebp
  104395:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  104398:	80 3a 00             	cmpb   $0x0,(%edx)
  10439b:	74 0c                	je     1043a9 <strlen+0x19>
  10439d:	8d 76 00             	lea    0x0(%esi),%esi
  1043a0:	83 c0 01             	add    $0x1,%eax
  1043a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1043a7:	75 f7                	jne    1043a0 <strlen+0x10>
    ;
  return n;
}
  1043a9:	5d                   	pop    %ebp
  1043aa:	c3                   	ret    
  1043ab:	90                   	nop    

001043ac <swtch>:
  1043ac:	8b 44 24 04          	mov    0x4(%esp),%eax
  1043b0:	8f 00                	popl   (%eax)
  1043b2:	89 60 04             	mov    %esp,0x4(%eax)
  1043b5:	89 58 08             	mov    %ebx,0x8(%eax)
  1043b8:	89 48 0c             	mov    %ecx,0xc(%eax)
  1043bb:	89 50 10             	mov    %edx,0x10(%eax)
  1043be:	89 70 14             	mov    %esi,0x14(%eax)
  1043c1:	89 78 18             	mov    %edi,0x18(%eax)
  1043c4:	89 68 1c             	mov    %ebp,0x1c(%eax)
  1043c7:	8b 44 24 04          	mov    0x4(%esp),%eax
  1043cb:	8b 68 1c             	mov    0x1c(%eax),%ebp
  1043ce:	8b 78 18             	mov    0x18(%eax),%edi
  1043d1:	8b 70 14             	mov    0x14(%eax),%esi
  1043d4:	8b 50 10             	mov    0x10(%eax),%edx
  1043d7:	8b 48 0c             	mov    0xc(%eax),%ecx
  1043da:	8b 58 08             	mov    0x8(%eax),%ebx
  1043dd:	8b 60 04             	mov    0x4(%eax),%esp
  1043e0:	ff 30                	pushl  (%eax)
  1043e2:	c3                   	ret    
  1043e3:	90                   	nop    
  1043e4:	90                   	nop    
  1043e5:	90                   	nop    
  1043e6:	90                   	nop    
  1043e7:	90                   	nop    
  1043e8:	90                   	nop    
  1043e9:	90                   	nop    
  1043ea:	90                   	nop    
  1043eb:	90                   	nop    
  1043ec:	90                   	nop    
  1043ed:	90                   	nop    
  1043ee:	90                   	nop    
  1043ef:	90                   	nop    

001043f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  1043f0:	55                   	push   %ebp
  1043f1:	89 e5                	mov    %esp,%ebp
  1043f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= p->sz || addr+4 > p->sz)
  1043f6:	8b 51 04             	mov    0x4(%ecx),%edx
  1043f9:	3b 55 0c             	cmp    0xc(%ebp),%edx
  1043fc:	77 0a                	ja     104408 <fetchint+0x18>
    return -1;
  *ip = *(int*)(p->mem + addr);
  return 0;
  1043fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104403:	5d                   	pop    %ebp
  104404:	c3                   	ret    
  104405:	8d 76 00             	lea    0x0(%esi),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104408:	8b 45 0c             	mov    0xc(%ebp),%eax
  10440b:	83 c0 04             	add    $0x4,%eax
  10440e:	39 c2                	cmp    %eax,%edx
  104410:	72 ec                	jb     1043fe <fetchint+0xe>
    return -1;
  *ip = *(int*)(p->mem + addr);
  104412:	8b 55 0c             	mov    0xc(%ebp),%edx
  104415:	8b 01                	mov    (%ecx),%eax
  104417:	8b 04 10             	mov    (%eax,%edx,1),%eax
  10441a:	8b 55 10             	mov    0x10(%ebp),%edx
  10441d:	89 02                	mov    %eax,(%edx)
  10441f:	31 c0                	xor    %eax,%eax
  return 0;
}
  104421:	5d                   	pop    %ebp
  104422:	c3                   	ret    
  104423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104430 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  104430:	55                   	push   %ebp
  104431:	89 e5                	mov    %esp,%ebp
  104433:	8b 45 08             	mov    0x8(%ebp),%eax
  104436:	8b 55 0c             	mov    0xc(%ebp),%edx
  104439:	53                   	push   %ebx
  char *s, *ep;

  if(addr >= p->sz)
  10443a:	39 50 04             	cmp    %edx,0x4(%eax)
  10443d:	77 09                	ja     104448 <fetchstr+0x18>
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  10443f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
  104444:	5b                   	pop    %ebx
  104445:	5d                   	pop    %ebp
  104446:	c3                   	ret    
  104447:	90                   	nop    
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  104448:	89 d3                	mov    %edx,%ebx
  10444a:	8b 55 10             	mov    0x10(%ebp),%edx
  10444d:	03 18                	add    (%eax),%ebx
  10444f:	89 1a                	mov    %ebx,(%edx)
  ep = p->mem + p->sz;
  104451:	8b 08                	mov    (%eax),%ecx
  104453:	03 48 04             	add    0x4(%eax),%ecx
  for(s = *pp; s < ep; s++)
  104456:	39 cb                	cmp    %ecx,%ebx
  104458:	73 e5                	jae    10443f <fetchstr+0xf>
    if(*s == 0)
  10445a:	31 c0                	xor    %eax,%eax
  10445c:	89 da                	mov    %ebx,%edx
  10445e:	80 3b 00             	cmpb   $0x0,(%ebx)
  104461:	74 e1                	je     104444 <fetchstr+0x14>
  104463:	90                   	nop    
  104464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  104468:	83 c2 01             	add    $0x1,%edx
  10446b:	39 d1                	cmp    %edx,%ecx
  10446d:	76 d0                	jbe    10443f <fetchstr+0xf>
    if(*s == 0)
  10446f:	80 3a 00             	cmpb   $0x0,(%edx)
  104472:	75 f4                	jne    104468 <fetchstr+0x38>
  104474:	89 d0                	mov    %edx,%eax
  104476:	29 d8                	sub    %ebx,%eax
  104478:	eb ca                	jmp    104444 <fetchstr+0x14>
  10447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104480 <argint>:
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  104480:	55                   	push   %ebp
  104481:	89 e5                	mov    %esp,%ebp
  104483:	53                   	push   %ebx
  104484:	83 ec 04             	sub    $0x4,%esp
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  104487:	e8 34 f0 ff ff       	call   1034c0 <curproc>
  10448c:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104492:	8b 50 3c             	mov    0x3c(%eax),%edx
  104495:	8b 45 08             	mov    0x8(%ebp),%eax
  104498:	8d 5c 82 04          	lea    0x4(%edx,%eax,4),%ebx
  10449c:	e8 1f f0 ff ff       	call   1034c0 <curproc>

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1044a1:	8b 50 04             	mov    0x4(%eax),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  1044a4:	89 c1                	mov    %eax,%ecx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1044a6:	39 d3                	cmp    %edx,%ebx
  1044a8:	72 0e                	jb     1044b8 <argint+0x38>
    return -1;
  *ip = *(int*)(p->mem + addr);
  1044aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
  1044af:	83 c4 04             	add    $0x4,%esp
  1044b2:	5b                   	pop    %ebx
  1044b3:	5d                   	pop    %ebp
  1044b4:	c3                   	ret    
  1044b5:	8d 76 00             	lea    0x0(%esi),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1044b8:	8d 43 04             	lea    0x4(%ebx),%eax
  1044bb:	39 c2                	cmp    %eax,%edx
  1044bd:	72 eb                	jb     1044aa <argint+0x2a>
    return -1;
  *ip = *(int*)(p->mem + addr);
  1044bf:	8b 01                	mov    (%ecx),%eax
  1044c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1044c4:	8b 04 18             	mov    (%eax,%ebx,1),%eax
  1044c7:	89 02                	mov    %eax,(%edx)
  1044c9:	31 c0                	xor    %eax,%eax
  1044cb:	eb e2                	jmp    1044af <argint+0x2f>
  1044cd:	8d 76 00             	lea    0x0(%esi),%esi

001044d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  1044d0:	55                   	push   %ebp
  1044d1:	89 e5                	mov    %esp,%ebp
  1044d3:	53                   	push   %ebx
  1044d4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  if(argint(n, &addr) < 0)
  1044d7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1044da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044de:	8b 45 08             	mov    0x8(%ebp),%eax
  1044e1:	89 04 24             	mov    %eax,(%esp)
  1044e4:	e8 97 ff ff ff       	call   104480 <argint>
  1044e9:	85 c0                	test   %eax,%eax
  1044eb:	78 43                	js     104530 <argstr+0x60>
    return -1;
  return fetchstr(cp, addr, pp);
  1044ed:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1044f0:	e8 cb ef ff ff       	call   1034c0 <curproc>
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
  1044f5:	3b 58 04             	cmp    0x4(%eax),%ebx
  1044f8:	73 36                	jae    104530 <argstr+0x60>
    return -1;
  *pp = p->mem + addr;
  1044fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  1044fd:	03 18                	add    (%eax),%ebx
  1044ff:	89 1a                	mov    %ebx,(%edx)
  ep = p->mem + p->sz;
  104501:	8b 08                	mov    (%eax),%ecx
  104503:	03 48 04             	add    0x4(%eax),%ecx
  for(s = *pp; s < ep; s++)
  104506:	39 cb                	cmp    %ecx,%ebx
  104508:	73 26                	jae    104530 <argstr+0x60>
    if(*s == 0)
  10450a:	31 c0                	xor    %eax,%eax
  10450c:	89 da                	mov    %ebx,%edx
  10450e:	80 3b 00             	cmpb   $0x0,(%ebx)
  104511:	75 0f                	jne    104522 <argstr+0x52>
  104513:	eb 20                	jmp    104535 <argstr+0x65>
  104515:	8d 76 00             	lea    0x0(%esi),%esi
  104518:	80 3a 00             	cmpb   $0x0,(%edx)
  10451b:	90                   	nop    
  10451c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104520:	74 1e                	je     104540 <argstr+0x70>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  104522:	83 c2 01             	add    $0x1,%edx
  104525:	39 d1                	cmp    %edx,%ecx
  104527:	90                   	nop    
  104528:	77 ee                	ja     104518 <argstr+0x48>
  10452a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  104535:	83 c4 24             	add    $0x24,%esp
  104538:	5b                   	pop    %ebx
  104539:	5d                   	pop    %ebp
  10453a:	c3                   	ret    
  10453b:	90                   	nop    
  10453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  104540:	89 d0                	mov    %edx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  104542:	83 c4 24             	add    $0x24,%esp
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  104545:	29 d8                	sub    %ebx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  104547:	5b                   	pop    %ebx
  104548:	5d                   	pop    %ebp
  104549:	c3                   	ret    
  10454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104550 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  104550:	55                   	push   %ebp
  104551:	89 e5                	mov    %esp,%ebp
  104553:	53                   	push   %ebx
  104554:	83 ec 24             	sub    $0x24,%esp
  int i;
  
  if(argint(n, &i) < 0)
  104557:	8d 45 f8             	lea    -0x8(%ebp),%eax
  10455a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10455e:	8b 45 08             	mov    0x8(%ebp),%eax
  104561:	89 04 24             	mov    %eax,(%esp)
  104564:	e8 17 ff ff ff       	call   104480 <argint>
  104569:	85 c0                	test   %eax,%eax
  10456b:	79 0b                	jns    104578 <argptr+0x28>
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
    return -1;
  *pp = cp->mem + i;
  return 0;
  10456d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104572:	83 c4 24             	add    $0x24,%esp
  104575:	5b                   	pop    %ebx
  104576:	5d                   	pop    %ebp
  104577:	c3                   	ret    
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
  104578:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  10457b:	e8 40 ef ff ff       	call   1034c0 <curproc>
  104580:	3b 58 04             	cmp    0x4(%eax),%ebx
  104583:	73 e8                	jae    10456d <argptr+0x1d>
  104585:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104588:	01 45 10             	add    %eax,0x10(%ebp)
  10458b:	e8 30 ef ff ff       	call   1034c0 <curproc>
  104590:	8b 55 10             	mov    0x10(%ebp),%edx
  104593:	3b 50 04             	cmp    0x4(%eax),%edx
  104596:	73 d5                	jae    10456d <argptr+0x1d>
    return -1;
  *pp = cp->mem + i;
  104598:	e8 23 ef ff ff       	call   1034c0 <curproc>
  10459d:	8b 55 0c             	mov    0xc(%ebp),%edx
  1045a0:	8b 00                	mov    (%eax),%eax
  1045a2:	03 45 f8             	add    -0x8(%ebp),%eax
  1045a5:	89 02                	mov    %eax,(%edx)
  1045a7:	31 c0                	xor    %eax,%eax
  1045a9:	eb c7                	jmp    104572 <argptr+0x22>
  1045ab:	90                   	nop    
  1045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001045b0 <syscall>:
[SYS_getruntime] sys_getruntime
};

void
syscall(void)
{
  1045b0:	55                   	push   %ebp
  1045b1:	89 e5                	mov    %esp,%ebp
  1045b3:	83 ec 18             	sub    $0x18,%esp
  1045b6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1045b9:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  
  num = cp->tf->eax;
  1045bc:	e8 ff ee ff ff       	call   1034c0 <curproc>
  1045c1:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  1045c7:	8b 58 1c             	mov    0x1c(%eax),%ebx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  1045ca:	83 fb 17             	cmp    $0x17,%ebx
  1045cd:	77 29                	ja     1045f8 <syscall+0x48>
  1045cf:	8b 34 9d c0 67 10 00 	mov    0x1067c0(,%ebx,4),%esi
  1045d6:	85 f6                	test   %esi,%esi
  1045d8:	74 1e                	je     1045f8 <syscall+0x48>
    cp->tf->eax = syscalls[num]();
  1045da:	e8 e1 ee ff ff       	call   1034c0 <curproc>
  1045df:	8b 98 84 00 00 00    	mov    0x84(%eax),%ebx
  1045e5:	ff d6                	call   *%esi
  1045e7:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  }
}
  1045ea:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1045ed:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1045f0:	89 ec                	mov    %ebp,%esp
  1045f2:	5d                   	pop    %ebp
  1045f3:	c3                   	ret    
  1045f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  1045f8:	e8 c3 ee ff ff       	call   1034c0 <curproc>
  1045fd:	89 c6                	mov    %eax,%esi
  1045ff:	e8 bc ee ff ff       	call   1034c0 <curproc>
  104604:	8d 96 88 00 00 00    	lea    0x88(%esi),%edx
  10460a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10460e:	89 54 24 08          	mov    %edx,0x8(%esp)
  104612:	8b 40 10             	mov    0x10(%eax),%eax
  104615:	c7 04 24 8e 67 10 00 	movl   $0x10678e,(%esp)
  10461c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104620:	e8 7b c1 ff ff       	call   1007a0 <cprintf>
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  104625:	e8 96 ee ff ff       	call   1034c0 <curproc>
  10462a:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104630:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  104637:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  10463a:	8b 75 fc             	mov    -0x4(%ebp),%esi
  10463d:	89 ec                	mov    %ebp,%esp
  10463f:	5d                   	pop    %ebp
  104640:	c3                   	ret    
  104641:	90                   	nop    
  104642:	90                   	nop    
  104643:	90                   	nop    
  104644:	90                   	nop    
  104645:	90                   	nop    
  104646:	90                   	nop    
  104647:	90                   	nop    
  104648:	90                   	nop    
  104649:	90                   	nop    
  10464a:	90                   	nop    
  10464b:	90                   	nop    
  10464c:	90                   	nop    
  10464d:	90                   	nop    
  10464e:	90                   	nop    
  10464f:	90                   	nop    

00104650 <sys_mytime>:
  return 0;
}

int
sys_mytime(void)
{
  104650:	55                   	push   %ebp
  104651:	a1 c0 ea 10 00       	mov    0x10eac0,%eax
  104656:	89 e5                	mov    %esp,%ebp
	return ticks;
}
  104658:	5d                   	pop    %ebp
  104659:	c3                   	ret    
  10465a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104660 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  104660:	55                   	push   %ebp
  104661:	89 e5                	mov    %esp,%ebp
  104663:	57                   	push   %edi
  104664:	89 c7                	mov    %eax,%edi
  104666:	56                   	push   %esi
  104667:	53                   	push   %ebx
  104668:	31 db                	xor    %ebx,%ebx
  10466a:	83 ec 0c             	sub    $0xc,%esp
  10466d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
  104670:	e8 4b ee ff ff       	call   1034c0 <curproc>
  104675:	8d 73 08             	lea    0x8(%ebx),%esi
  104678:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  10467b:	85 c0                	test   %eax,%eax
  10467d:	74 19                	je     104698 <fdalloc+0x38>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  10467f:	83 c3 01             	add    $0x1,%ebx
  104682:	83 fb 10             	cmp    $0x10,%ebx
  104685:	75 e9                	jne    104670 <fdalloc+0x10>
  104687:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      cp->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
  10468c:	83 c4 0c             	add    $0xc,%esp
  10468f:	89 d8                	mov    %ebx,%eax
  104691:	5b                   	pop    %ebx
  104692:	5e                   	pop    %esi
  104693:	5f                   	pop    %edi
  104694:	5d                   	pop    %ebp
  104695:	c3                   	ret    
  104696:	66 90                	xchg   %ax,%ax
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  104698:	e8 23 ee ff ff       	call   1034c0 <curproc>
  10469d:	89 3c b0             	mov    %edi,(%eax,%esi,4)
      return fd;
    }
  }
  return -1;
}
  1046a0:	83 c4 0c             	add    $0xc,%esp
  1046a3:	89 d8                	mov    %ebx,%eax
  1046a5:	5b                   	pop    %ebx
  1046a6:	5e                   	pop    %esi
  1046a7:	5f                   	pop    %edi
  1046a8:	5d                   	pop    %ebp
  1046a9:	c3                   	ret    
  1046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001046b0 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
  1046b0:	55                   	push   %ebp
  1046b1:	89 e5                	mov    %esp,%ebp
  1046b3:	53                   	push   %ebx
  1046b4:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  1046b7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1046ba:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  1046c1:	00 
  1046c2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1046c6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1046cd:	e8 7e fe ff ff       	call   104550 <argptr>
  1046d2:	85 c0                	test   %eax,%eax
  1046d4:	79 12                	jns    1046e8 <sys_pipe+0x38>
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
  1046d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1046db:	83 c4 24             	add    $0x24,%esp
  1046de:	5b                   	pop    %ebx
  1046df:	5d                   	pop    %ebp
  1046e0:	c3                   	ret    
  1046e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  1046e8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1046eb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1046ef:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1046f2:	89 04 24             	mov    %eax,(%esp)
  1046f5:	e8 26 ea ff ff       	call   103120 <pipealloc>
  1046fa:	85 c0                	test   %eax,%eax
  1046fc:	78 d8                	js     1046d6 <sys_pipe+0x26>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  1046fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104701:	e8 5a ff ff ff       	call   104660 <fdalloc>
  104706:	85 c0                	test   %eax,%eax
  104708:	89 c3                	mov    %eax,%ebx
  10470a:	78 27                	js     104733 <sys_pipe+0x83>
  10470c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10470f:	e8 4c ff ff ff       	call   104660 <fdalloc>
  104714:	85 c0                	test   %eax,%eax
  104716:	89 c2                	mov    %eax,%edx
  104718:	78 0c                	js     104726 <sys_pipe+0x76>
      cp->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  10471a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10471d:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
  10471f:	89 50 04             	mov    %edx,0x4(%eax)
  104722:	31 c0                	xor    %eax,%eax
  104724:	eb b5                	jmp    1046db <sys_pipe+0x2b>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
  104726:	e8 95 ed ff ff       	call   1034c0 <curproc>
  10472b:	c7 44 98 20 00 00 00 	movl   $0x0,0x20(%eax,%ebx,4)
  104732:	00 
    fileclose(rf);
  104733:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104736:	89 04 24             	mov    %eax,(%esp)
  104739:	e8 02 c9 ff ff       	call   101040 <fileclose>
    fileclose(wf);
  10473e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104741:	89 04 24             	mov    %eax,(%esp)
  104744:	e8 f7 c8 ff ff       	call   101040 <fileclose>
  104749:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10474e:	eb 8b                	jmp    1046db <sys_pipe+0x2b>

00104750 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  104750:	55                   	push   %ebp
  104751:	89 e5                	mov    %esp,%ebp
  104753:	83 ec 28             	sub    $0x28,%esp
  104756:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  104759:	89 d3                	mov    %edx,%ebx
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  10475b:	8d 55 f4             	lea    -0xc(%ebp),%edx

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  10475e:	89 75 fc             	mov    %esi,-0x4(%ebp)
  104761:	89 ce                	mov    %ecx,%esi
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  104763:	89 54 24 04          	mov    %edx,0x4(%esp)
  104767:	89 04 24             	mov    %eax,(%esp)
  10476a:	e8 11 fd ff ff       	call   104480 <argint>
  10476f:	85 c0                	test   %eax,%eax
  104771:	79 15                	jns    104788 <argfd+0x38>
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  104773:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
  104778:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  10477b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  10477e:	89 ec                	mov    %ebp,%esp
  104780:	5d                   	pop    %ebp
  104781:	c3                   	ret    
  104782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
  104788:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  10478c:	77 e5                	ja     104773 <argfd+0x23>
  10478e:	e8 2d ed ff ff       	call   1034c0 <curproc>
  104793:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104796:	8b 4c 90 20          	mov    0x20(%eax,%edx,4),%ecx
  10479a:	85 c9                	test   %ecx,%ecx
  10479c:	74 d5                	je     104773 <argfd+0x23>
    return -1;
  if(pfd)
  10479e:	85 db                	test   %ebx,%ebx
  1047a0:	74 02                	je     1047a4 <argfd+0x54>
    *pfd = fd;
  1047a2:	89 13                	mov    %edx,(%ebx)
  if(pf)
  1047a4:	31 c0                	xor    %eax,%eax
  1047a6:	85 f6                	test   %esi,%esi
  1047a8:	74 ce                	je     104778 <argfd+0x28>
    *pf = f;
  1047aa:	89 0e                	mov    %ecx,(%esi)
  1047ac:	31 c0                	xor    %eax,%eax
  1047ae:	eb c8                	jmp    104778 <argfd+0x28>

001047b0 <sys_close>:
  return fd;
}

int
sys_close(void)
{
  1047b0:	55                   	push   %ebp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  1047b1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_close(void)
{
  1047b3:	89 e5                	mov    %esp,%ebp
  1047b5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  1047b8:	8d 55 fc             	lea    -0x4(%ebp),%edx
  1047bb:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  1047be:	e8 8d ff ff ff       	call   104750 <argfd>
  1047c3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1047c8:	85 c0                	test   %eax,%eax
  1047ca:	78 1d                	js     1047e9 <sys_close+0x39>
    return -1;
  cp->ofile[fd] = 0;
  1047cc:	e8 ef ec ff ff       	call   1034c0 <curproc>
  1047d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1047d4:	c7 44 90 20 00 00 00 	movl   $0x0,0x20(%eax,%edx,4)
  1047db:	00 
  fileclose(f);
  1047dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1047df:	89 04 24             	mov    %eax,(%esp)
  1047e2:	e8 59 c8 ff ff       	call   101040 <fileclose>
  1047e7:	31 d2                	xor    %edx,%edx
  return 0;
}
  1047e9:	89 d0                	mov    %edx,%eax
  1047eb:	c9                   	leave  
  1047ec:	c3                   	ret    
  1047ed:	8d 76 00             	lea    0x0(%esi),%esi

001047f0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  1047f0:	55                   	push   %ebp
  1047f1:	89 e5                	mov    %esp,%ebp
  1047f3:	83 ec 78             	sub    $0x78,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  1047f6:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
  1047f9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1047fc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1047ff:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104802:	89 44 24 04          	mov    %eax,0x4(%esp)
  104806:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10480d:	e8 be fc ff ff       	call   1044d0 <argstr>
  104812:	85 c0                	test   %eax,%eax
  104814:	79 12                	jns    104828 <sys_exec+0x38>
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
  104816:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  10481b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10481e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104821:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104824:	89 ec                	mov    %ebp,%esp
  104826:	5d                   	pop    %ebp
  104827:	c3                   	ret    
{
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104828:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10482b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10482f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104836:	e8 45 fc ff ff       	call   104480 <argint>
  10483b:	85 c0                	test   %eax,%eax
  10483d:	78 d7                	js     104816 <sys_exec+0x26>
    return -1;
  memset(argv, 0, sizeof(argv));
  10483f:	8d 45 98             	lea    -0x68(%ebp),%eax
  104842:	31 f6                	xor    %esi,%esi
  104844:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  10484b:	00 
  10484c:	31 ff                	xor    %edi,%edi
  10484e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104855:	00 
  104856:	89 04 24             	mov    %eax,(%esp)
  104859:	e8 52 f9 ff ff       	call   1041b0 <memset>
  10485e:	eb 27                	jmp    104887 <sys_exec+0x97>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
  104860:	e8 5b ec ff ff       	call   1034c0 <curproc>
  104865:	8d 54 bd 98          	lea    -0x68(%ebp,%edi,4),%edx
  104869:	89 54 24 08          	mov    %edx,0x8(%esp)
  10486d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104871:	89 04 24             	mov    %eax,(%esp)
  104874:	e8 b7 fb ff ff       	call   104430 <fetchstr>
  104879:	85 c0                	test   %eax,%eax
  10487b:	78 99                	js     104816 <sys_exec+0x26>
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  10487d:	83 c6 01             	add    $0x1,%esi
    if(i >= NELEM(argv))
  104880:	83 fe 14             	cmp    $0x14,%esi
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104883:	89 f7                	mov    %esi,%edi
    if(i >= NELEM(argv))
  104885:	74 8f                	je     104816 <sys_exec+0x26>
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
  104887:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
  10488e:	03 5d ec             	add    -0x14(%ebp),%ebx
  104891:	e8 2a ec ff ff       	call   1034c0 <curproc>
  104896:	8d 55 e8             	lea    -0x18(%ebp),%edx
  104899:	89 54 24 08          	mov    %edx,0x8(%esp)
  10489d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1048a1:	89 04 24             	mov    %eax,(%esp)
  1048a4:	e8 47 fb ff ff       	call   1043f0 <fetchint>
  1048a9:	85 c0                	test   %eax,%eax
  1048ab:	0f 88 65 ff ff ff    	js     104816 <sys_exec+0x26>
      return -1;
    if(uarg == 0){
  1048b1:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  1048b4:	85 db                	test   %ebx,%ebx
  1048b6:	75 a8                	jne    104860 <sys_exec+0x70>
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  1048b8:	8d 45 98             	lea    -0x68(%ebp),%eax
  1048bb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  1048c2:	c7 44 b5 98 00 00 00 	movl   $0x0,-0x68(%ebp,%esi,4)
  1048c9:	00 
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  1048ca:	89 04 24             	mov    %eax,(%esp)
  1048cd:	e8 1e c1 ff ff       	call   1009f0 <exec>
  1048d2:	e9 44 ff ff ff       	jmp    10481b <sys_exec+0x2b>
  1048d7:	89 f6                	mov    %esi,%esi
  1048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001048e0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  1048e0:	55                   	push   %ebp
  1048e1:	89 e5                	mov    %esp,%ebp
  1048e3:	53                   	push   %ebx
  1048e4:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1048e7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1048ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1048f5:	e8 d6 fb ff ff       	call   1044d0 <argstr>
  1048fa:	85 c0                	test   %eax,%eax
  1048fc:	79 12                	jns    104910 <sys_chdir+0x30>
    return -1;
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
  1048fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104903:	83 c4 24             	add    $0x24,%esp
  104906:	5b                   	pop    %ebx
  104907:	5d                   	pop    %ebp
  104908:	c3                   	ret    
  104909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104910:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104913:	89 04 24             	mov    %eax,(%esp)
  104916:	e8 95 d6 ff ff       	call   101fb0 <namei>
  10491b:	85 c0                	test   %eax,%eax
  10491d:	89 c3                	mov    %eax,%ebx
  10491f:	74 dd                	je     1048fe <sys_chdir+0x1e>
    return -1;
  ilock(ip);
  104921:	89 04 24             	mov    %eax,(%esp)
  104924:	e8 d7 d3 ff ff       	call   101d00 <ilock>
  if(ip->type != T_DIR){
  104929:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10492e:	75 24                	jne    104954 <sys_chdir+0x74>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104930:	89 1c 24             	mov    %ebx,(%esp)
  104933:	e8 48 d3 ff ff       	call   101c80 <iunlock>
  iput(cp->cwd);
  104938:	e8 83 eb ff ff       	call   1034c0 <curproc>
  10493d:	8b 40 60             	mov    0x60(%eax),%eax
  104940:	89 04 24             	mov    %eax,(%esp)
  104943:	e8 e8 d0 ff ff       	call   101a30 <iput>
  cp->cwd = ip;
  104948:	e8 73 eb ff ff       	call   1034c0 <curproc>
  10494d:	89 58 60             	mov    %ebx,0x60(%eax)
  104950:	31 c0                	xor    %eax,%eax
  104952:	eb af                	jmp    104903 <sys_chdir+0x23>

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  104954:	89 1c 24             	mov    %ebx,(%esp)
  104957:	e8 84 d3 ff ff       	call   101ce0 <iunlockput>
  10495c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104961:	eb a0                	jmp    104903 <sys_chdir+0x23>
  104963:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104970 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104970:	55                   	push   %ebp
  104971:	89 e5                	mov    %esp,%ebp
  104973:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104976:	8d 45 ec             	lea    -0x14(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104979:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10497c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10497f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104982:	89 44 24 04          	mov    %eax,0x4(%esp)
  104986:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10498d:	e8 3e fb ff ff       	call   1044d0 <argstr>
  104992:	85 c0                	test   %eax,%eax
  104994:	79 12                	jns    1049a8 <sys_link+0x38>
    iunlockput(dp);
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  104996:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10499b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10499e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1049a1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1049a4:	89 ec                	mov    %ebp,%esp
  1049a6:	5d                   	pop    %ebp
  1049a7:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1049a8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1049ab:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1049b6:	e8 15 fb ff ff       	call   1044d0 <argstr>
  1049bb:	85 c0                	test   %eax,%eax
  1049bd:	78 d7                	js     104996 <sys_link+0x26>
    return -1;
  if((ip = namei(old)) == 0)
  1049bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1049c2:	89 04 24             	mov    %eax,(%esp)
  1049c5:	e8 e6 d5 ff ff       	call   101fb0 <namei>
  1049ca:	85 c0                	test   %eax,%eax
  1049cc:	89 c3                	mov    %eax,%ebx
  1049ce:	74 c6                	je     104996 <sys_link+0x26>
    return -1;
  ilock(ip);
  1049d0:	89 04 24             	mov    %eax,(%esp)
  1049d3:	e8 28 d3 ff ff       	call   101d00 <ilock>
  if(ip->type == T_DIR){
  1049d8:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1049dd:	74 58                	je     104a37 <sys_link+0xc7>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  1049df:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  1049e4:	8d 7d de             	lea    -0x22(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  1049e7:	89 1c 24             	mov    %ebx,(%esp)
  1049ea:	e8 a1 cb ff ff       	call   101590 <iupdate>
  iunlock(ip);
  1049ef:	89 1c 24             	mov    %ebx,(%esp)
  1049f2:	e8 89 d2 ff ff       	call   101c80 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  1049f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1049fa:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1049fe:	89 04 24             	mov    %eax,(%esp)
  104a01:	e8 8a d5 ff ff       	call   101f90 <nameiparent>
  104a06:	85 c0                	test   %eax,%eax
  104a08:	89 c6                	mov    %eax,%esi
  104a0a:	74 16                	je     104a22 <sys_link+0xb2>
    goto  bad;
  ilock(dp);
  104a0c:	89 04 24             	mov    %eax,(%esp)
  104a0f:	e8 ec d2 ff ff       	call   101d00 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
  104a14:	8b 06                	mov    (%esi),%eax
  104a16:	3b 03                	cmp    (%ebx),%eax
  104a18:	74 2f                	je     104a49 <sys_link+0xd9>
  iput(ip);
  return 0;

bad:
  if(dp)
    iunlockput(dp);
  104a1a:	89 34 24             	mov    %esi,(%esp)
  104a1d:	e8 be d2 ff ff       	call   101ce0 <iunlockput>
  ilock(ip);
  104a22:	89 1c 24             	mov    %ebx,(%esp)
  104a25:	e8 d6 d2 ff ff       	call   101d00 <ilock>
  ip->nlink--;
  104a2a:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  104a2f:	89 1c 24             	mov    %ebx,(%esp)
  104a32:	e8 59 cb ff ff       	call   101590 <iupdate>
  iunlockput(ip);
  104a37:	89 1c 24             	mov    %ebx,(%esp)
  104a3a:	e8 a1 d2 ff ff       	call   101ce0 <iunlockput>
  104a3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104a44:	e9 52 ff ff ff       	jmp    10499b <sys_link+0x2b>
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto  bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
  104a49:	8b 43 04             	mov    0x4(%ebx),%eax
  104a4c:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104a50:	89 34 24             	mov    %esi,(%esp)
  104a53:	89 44 24 08          	mov    %eax,0x8(%esp)
  104a57:	e8 34 d1 ff ff       	call   101b90 <dirlink>
  104a5c:	85 c0                	test   %eax,%eax
  104a5e:	78 ba                	js     104a1a <sys_link+0xaa>
    goto bad;
  iunlockput(dp);
  104a60:	89 34 24             	mov    %esi,(%esp)
  104a63:	e8 78 d2 ff ff       	call   101ce0 <iunlockput>
  iput(ip);
  104a68:	89 1c 24             	mov    %ebx,(%esp)
  104a6b:	e8 c0 cf ff ff       	call   101a30 <iput>
  104a70:	31 c0                	xor    %eax,%eax
  104a72:	e9 24 ff ff ff       	jmp    10499b <sys_link+0x2b>
  104a77:	89 f6                	mov    %esi,%esi
  104a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104a80 <create>:
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  104a80:	55                   	push   %ebp
  104a81:	89 e5                	mov    %esp,%ebp
  104a83:	57                   	push   %edi
  104a84:	89 d7                	mov    %edx,%edi
  104a86:	56                   	push   %esi
  104a87:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104a88:	31 db                	xor    %ebx,%ebx
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  104a8a:	83 ec 3c             	sub    $0x3c,%esp
  104a8d:	0f b7 55 08          	movzwl 0x8(%ebp),%edx
  104a91:	66 89 4d d2          	mov    %cx,-0x2e(%ebp)
  104a95:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
  104a99:	0f b7 55 0c          	movzwl 0xc(%ebp),%edx
  104a9d:	66 89 55 ce          	mov    %dx,-0x32(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104aa1:	8d 55 e2             	lea    -0x1e(%ebp),%edx
  104aa4:	89 54 24 04          	mov    %edx,0x4(%esp)
  104aa8:	89 04 24             	mov    %eax,(%esp)
  104aab:	e8 e0 d4 ff ff       	call   101f90 <nameiparent>
  104ab0:	85 c0                	test   %eax,%eax
  104ab2:	89 c6                	mov    %eax,%esi
  104ab4:	74 77                	je     104b2d <create+0xad>
    return 0;
  ilock(dp);
  104ab6:	89 04 24             	mov    %eax,(%esp)
  104ab9:	e8 42 d2 ff ff       	call   101d00 <ilock>

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
  104abe:	85 ff                	test   %edi,%edi
  104ac0:	75 76                	jne    104b38 <create+0xb8>
      return 0;
    }
    return ip;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
  104ac2:	0f bf 45 d2          	movswl -0x2e(%ebp),%eax
  104ac6:	89 44 24 04          	mov    %eax,0x4(%esp)
  104aca:	8b 06                	mov    (%esi),%eax
  104acc:	89 04 24             	mov    %eax,(%esp)
  104acf:	e8 cc cd ff ff       	call   1018a0 <ialloc>
  104ad4:	85 c0                	test   %eax,%eax
  104ad6:	89 c3                	mov    %eax,%ebx
  104ad8:	74 4b                	je     104b25 <create+0xa5>
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  104ada:	89 04 24             	mov    %eax,(%esp)
  104add:	e8 1e d2 ff ff       	call   101d00 <ilock>
  ip->major = major;
  104ae2:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  ip->minor = minor;
  104ae6:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  ip->nlink = 1;
  104aea:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0){
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  ip->major = major;
  104af0:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  104af4:	66 89 53 14          	mov    %dx,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  104af8:	89 1c 24             	mov    %ebx,(%esp)
  104afb:	e8 90 ca ff ff       	call   101590 <iupdate>
  
  if(dirlink(dp, name, ip->inum) < 0){
  104b00:	8b 43 04             	mov    0x4(%ebx),%eax
  104b03:	89 34 24             	mov    %esi,(%esp)
  104b06:	89 44 24 08          	mov    %eax,0x8(%esp)
  104b0a:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  104b0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b11:	e8 7a d0 ff ff       	call   101b90 <dirlink>
  104b16:	85 c0                	test   %eax,%eax
  104b18:	0f 88 d5 00 00 00    	js     104bf3 <create+0x173>
    iunlockput(ip);
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
  104b1e:	66 83 7d d2 01       	cmpw   $0x1,-0x2e(%ebp)
  104b23:	74 7b                	je     104ba0 <create+0x120>
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  104b25:	89 34 24             	mov    %esi,(%esp)
  104b28:	e8 b3 d1 ff ff       	call   101ce0 <iunlockput>
  return ip;
}
  104b2d:	83 c4 3c             	add    $0x3c,%esp
  104b30:	89 d8                	mov    %ebx,%eax
  104b32:	5b                   	pop    %ebx
  104b33:	5e                   	pop    %esi
  104b34:	5f                   	pop    %edi
  104b35:	5d                   	pop    %ebp
  104b36:	c3                   	ret    
  104b37:	90                   	nop    

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
  104b38:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104b3b:	89 44 24 08          	mov    %eax,0x8(%esp)
  104b3f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  104b42:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b46:	89 34 24             	mov    %esi,(%esp)
  104b49:	e8 42 cc ff ff       	call   101790 <dirlookup>
  104b4e:	85 c0                	test   %eax,%eax
  104b50:	89 c3                	mov    %eax,%ebx
  104b52:	0f 84 6a ff ff ff    	je     104ac2 <create+0x42>
    iunlockput(dp);
  104b58:	89 34 24             	mov    %esi,(%esp)
  104b5b:	e8 80 d1 ff ff       	call   101ce0 <iunlockput>
    ilock(ip);
  104b60:	89 1c 24             	mov    %ebx,(%esp)
  104b63:	e8 98 d1 ff ff       	call   101d00 <ilock>
    if(ip->type != type || ip->major != major || ip->minor != minor){
  104b68:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  104b6c:	66 39 53 10          	cmp    %dx,0x10(%ebx)
  104b70:	75 0a                	jne    104b7c <create+0xfc>
  104b72:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  104b76:	66 39 43 12          	cmp    %ax,0x12(%ebx)
  104b7a:	74 14                	je     104b90 <create+0x110>
      iunlockput(ip);
  104b7c:	89 1c 24             	mov    %ebx,(%esp)
  104b7f:	31 db                	xor    %ebx,%ebx
  104b81:	e8 5a d1 ff ff       	call   101ce0 <iunlockput>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  return ip;
}
  104b86:	83 c4 3c             	add    $0x3c,%esp
  104b89:	89 d8                	mov    %ebx,%eax
  104b8b:	5b                   	pop    %ebx
  104b8c:	5e                   	pop    %esi
  104b8d:	5f                   	pop    %edi
  104b8e:	5d                   	pop    %ebp
  104b8f:	c3                   	ret    
  ilock(dp);

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(ip->type != type || ip->major != major || ip->minor != minor){
  104b90:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  104b94:	66 39 53 14          	cmp    %dx,0x14(%ebx)
  104b98:	75 e2                	jne    104b7c <create+0xfc>
  104b9a:	eb 91                	jmp    104b2d <create+0xad>
  104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  104ba0:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
    iupdate(dp);
  104ba5:	89 34 24             	mov    %esi,(%esp)
  104ba8:	e8 e3 c9 ff ff       	call   101590 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104bad:	8b 43 04             	mov    0x4(%ebx),%eax
  104bb0:	c7 44 24 04 21 68 10 	movl   $0x106821,0x4(%esp)
  104bb7:	00 
  104bb8:	89 1c 24             	mov    %ebx,(%esp)
  104bbb:	89 44 24 08          	mov    %eax,0x8(%esp)
  104bbf:	e8 cc cf ff ff       	call   101b90 <dirlink>
  104bc4:	85 c0                	test   %eax,%eax
  104bc6:	78 1f                	js     104be7 <create+0x167>
  104bc8:	8b 46 04             	mov    0x4(%esi),%eax
  104bcb:	c7 44 24 04 20 68 10 	movl   $0x106820,0x4(%esp)
  104bd2:	00 
  104bd3:	89 1c 24             	mov    %ebx,(%esp)
  104bd6:	89 44 24 08          	mov    %eax,0x8(%esp)
  104bda:	e8 b1 cf ff ff       	call   101b90 <dirlink>
  104bdf:	85 c0                	test   %eax,%eax
  104be1:	0f 89 3e ff ff ff    	jns    104b25 <create+0xa5>
      panic("create dots");
  104be7:	c7 04 24 23 68 10 00 	movl   $0x106823,(%esp)
  104bee:	e8 7d bd ff ff       	call   100970 <panic>
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);
  
  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
  104bf3:	66 c7 43 16 00 00    	movw   $0x0,0x16(%ebx)
    iunlockput(ip);
  104bf9:	89 1c 24             	mov    %ebx,(%esp)
    iunlockput(dp);
  104bfc:	31 db                	xor    %ebx,%ebx
  ip->nlink = 1;
  iupdate(ip);
  
  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
    iunlockput(ip);
  104bfe:	e8 dd d0 ff ff       	call   101ce0 <iunlockput>
    iunlockput(dp);
  104c03:	89 34 24             	mov    %esi,(%esp)
  104c06:	e8 d5 d0 ff ff       	call   101ce0 <iunlockput>
  104c0b:	e9 1d ff ff ff       	jmp    104b2d <create+0xad>

00104c10 <sys_mkdir>:
  return 0;
}

int
sys_mkdir(void)
{
  104c10:	55                   	push   %ebp
  104c11:	89 e5                	mov    %esp,%ebp
  104c13:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  104c16:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104c19:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c1d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c24:	e8 a7 f8 ff ff       	call   1044d0 <argstr>
  104c29:	85 c0                	test   %eax,%eax
  104c2b:	79 0b                	jns    104c38 <sys_mkdir+0x28>
    return -1;
  iunlockput(ip);
  return 0;
  104c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104c32:	c9                   	leave  
  104c33:	c3                   	ret    
  104c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  104c38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104c3b:	31 d2                	xor    %edx,%edx
  104c3d:	b9 01 00 00 00       	mov    $0x1,%ecx
  104c42:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104c49:	00 
  104c4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c51:	e8 2a fe ff ff       	call   104a80 <create>
  104c56:	85 c0                	test   %eax,%eax
  104c58:	74 d3                	je     104c2d <sys_mkdir+0x1d>
    return -1;
  iunlockput(ip);
  104c5a:	89 04 24             	mov    %eax,(%esp)
  104c5d:	e8 7e d0 ff ff       	call   101ce0 <iunlockput>
  104c62:	31 c0                	xor    %eax,%eax
  return 0;
}
  104c64:	c9                   	leave  
  104c65:	8d 76 00             	lea    0x0(%esi),%esi
  104c68:	c3                   	ret    
  104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104c70 <sys_mknod>:
  return fd;
}

int
sys_mknod(void)
{
  104c70:	55                   	push   %ebp
  104c71:	89 e5                	mov    %esp,%ebp
  104c73:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104c76:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104c79:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c84:	e8 47 f8 ff ff       	call   1044d0 <argstr>
  104c89:	85 c0                	test   %eax,%eax
  104c8b:	79 0b                	jns    104c98 <sys_mknod+0x28>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  104c8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104c92:	c9                   	leave  
  104c93:	c3                   	ret    
  104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104c98:	8d 45 f8             	lea    -0x8(%ebp),%eax
  104c9b:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c9f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104ca6:	e8 d5 f7 ff ff       	call   104480 <argint>
  104cab:	85 c0                	test   %eax,%eax
  104cad:	78 de                	js     104c8d <sys_mknod+0x1d>
  104caf:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104cb2:	89 44 24 04          	mov    %eax,0x4(%esp)
  104cb6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104cbd:	e8 be f7 ff ff       	call   104480 <argint>
  104cc2:	85 c0                	test   %eax,%eax
  104cc4:	78 c7                	js     104c8d <sys_mknod+0x1d>
  104cc6:	0f bf 55 f4          	movswl -0xc(%ebp),%edx
  104cca:	b9 03 00 00 00       	mov    $0x3,%ecx
  104ccf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104cd2:	89 54 24 04          	mov    %edx,0x4(%esp)
  104cd6:	0f bf 55 f8          	movswl -0x8(%ebp),%edx
  104cda:	89 14 24             	mov    %edx,(%esp)
  104cdd:	31 d2                	xor    %edx,%edx
  104cdf:	e8 9c fd ff ff       	call   104a80 <create>
  104ce4:	85 c0                	test   %eax,%eax
  104ce6:	74 a5                	je     104c8d <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  104ce8:	89 04 24             	mov    %eax,(%esp)
  104ceb:	e8 f0 cf ff ff       	call   101ce0 <iunlockput>
  104cf0:	31 c0                	xor    %eax,%eax
  return 0;
}
  104cf2:	c9                   	leave  
  104cf3:	90                   	nop    
  104cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104cf8:	c3                   	ret    
  104cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104d00 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104d00:	55                   	push   %ebp
  104d01:	89 e5                	mov    %esp,%ebp
  104d03:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104d06:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
  104d09:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  104d0c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104d0f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104d12:	89 44 24 04          	mov    %eax,0x4(%esp)
  104d16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104d1d:	e8 ae f7 ff ff       	call   1044d0 <argstr>
  104d22:	85 c0                	test   %eax,%eax
  104d24:	79 1a                	jns    104d40 <sys_open+0x40>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
  104d26:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  104d2b:	89 d8                	mov    %ebx,%eax
  104d2d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104d30:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104d33:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104d36:	89 ec                	mov    %ebp,%esp
  104d38:	5d                   	pop    %ebp
  104d39:	c3                   	ret    
  104d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104d40:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104d43:	89 44 24 04          	mov    %eax,0x4(%esp)
  104d47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104d4e:	e8 2d f7 ff ff       	call   104480 <argint>
  104d53:	85 c0                	test   %eax,%eax
  104d55:	78 cf                	js     104d26 <sys_open+0x26>
    return -1;

  if(omode & O_CREATE){
  104d57:	f6 45 ed 02          	testb  $0x2,-0x13(%ebp)
  104d5b:	74 5b                	je     104db8 <sys_open+0xb8>
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
  104d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104d60:	b9 02 00 00 00       	mov    $0x2,%ecx
  104d65:	ba 01 00 00 00       	mov    $0x1,%edx
  104d6a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104d71:	00 
  104d72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104d79:	e8 02 fd ff ff       	call   104a80 <create>
  104d7e:	85 c0                	test   %eax,%eax
  104d80:	89 c7                	mov    %eax,%edi
  104d82:	74 a2                	je     104d26 <sys_open+0x26>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  104d84:	e8 37 c2 ff ff       	call   100fc0 <filealloc>
  104d89:	85 c0                	test   %eax,%eax
  104d8b:	89 c6                	mov    %eax,%esi
  104d8d:	74 13                	je     104da2 <sys_open+0xa2>
  104d8f:	e8 cc f8 ff ff       	call   104660 <fdalloc>
  104d94:	85 c0                	test   %eax,%eax
  104d96:	89 c3                	mov    %eax,%ebx
  104d98:	79 56                	jns    104df0 <sys_open+0xf0>
    if(f)
      fileclose(f);
  104d9a:	89 34 24             	mov    %esi,(%esp)
  104d9d:	e8 9e c2 ff ff       	call   101040 <fileclose>
    iunlockput(ip);
  104da2:	89 3c 24             	mov    %edi,(%esp)
  104da5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104daa:	e8 31 cf ff ff       	call   101ce0 <iunlockput>
  104daf:	e9 77 ff ff ff       	jmp    104d2b <sys_open+0x2b>
  104db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(omode & O_CREATE){
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104db8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104dbb:	89 04 24             	mov    %eax,(%esp)
  104dbe:	e8 ed d1 ff ff       	call   101fb0 <namei>
  104dc3:	85 c0                	test   %eax,%eax
  104dc5:	89 c7                	mov    %eax,%edi
  104dc7:	0f 84 59 ff ff ff    	je     104d26 <sys_open+0x26>
      return -1;
    ilock(ip);
  104dcd:	89 04 24             	mov    %eax,(%esp)
  104dd0:	e8 2b cf ff ff       	call   101d00 <ilock>
    if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
  104dd5:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  104dda:	75 a8                	jne    104d84 <sys_open+0x84>
  104ddc:	f6 45 ec 03          	testb  $0x3,-0x14(%ebp)
  104de0:	74 a2                	je     104d84 <sys_open+0x84>
  104de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104de8:	eb b8                	jmp    104da2 <sys_open+0xa2>
  104dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104df0:	89 3c 24             	mov    %edi,(%esp)
  104df3:	90                   	nop    
  104df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104df8:	e8 83 ce ff ff       	call   101c80 <iunlock>

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104dfd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  104e00:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
  f->ip = ip;
  104e06:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  104e09:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104e10:	89 d0                	mov    %edx,%eax
  104e12:	83 f0 01             	xor    $0x1,%eax
  104e15:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104e18:	83 e2 03             	and    $0x3,%edx
  iunlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104e1b:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104e1e:	0f 95 46 09          	setne  0x9(%esi)
  104e22:	e9 04 ff ff ff       	jmp    104d2b <sys_open+0x2b>
  104e27:	89 f6                	mov    %esi,%esi
  104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e30 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  104e30:	55                   	push   %ebp
  104e31:	89 e5                	mov    %esp,%ebp
  104e33:	83 ec 68             	sub    $0x68,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104e36:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return 1;
}

int
sys_unlink(void)
{
  104e39:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  104e3c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104e3f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104e42:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e46:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104e4d:	e8 7e f6 ff ff       	call   1044d0 <argstr>
  104e52:	85 c0                	test   %eax,%eax
  104e54:	79 12                	jns    104e68 <sys_unlink+0x38>
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  104e56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104e5b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104e5e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104e61:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104e64:	89 ec                	mov    %ebp,%esp
  104e66:	5d                   	pop    %ebp
  104e67:	c3                   	ret    
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  104e68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e6b:	8d 5d de             	lea    -0x22(%ebp),%ebx
  104e6e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104e72:	89 04 24             	mov    %eax,(%esp)
  104e75:	e8 16 d1 ff ff       	call   101f90 <nameiparent>
  104e7a:	85 c0                	test   %eax,%eax
  104e7c:	89 c7                	mov    %eax,%edi
  104e7e:	74 d6                	je     104e56 <sys_unlink+0x26>
    return -1;
  ilock(dp);
  104e80:	89 04 24             	mov    %eax,(%esp)
  104e83:	e8 78 ce ff ff       	call   101d00 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104e88:	c7 44 24 04 21 68 10 	movl   $0x106821,0x4(%esp)
  104e8f:	00 
  104e90:	89 1c 24             	mov    %ebx,(%esp)
  104e93:	e8 c8 c8 ff ff       	call   101760 <namecmp>
  104e98:	85 c0                	test   %eax,%eax
  104e9a:	74 14                	je     104eb0 <sys_unlink+0x80>
  104e9c:	c7 44 24 04 20 68 10 	movl   $0x106820,0x4(%esp)
  104ea3:	00 
  104ea4:	89 1c 24             	mov    %ebx,(%esp)
  104ea7:	e8 b4 c8 ff ff       	call   101760 <namecmp>
  104eac:	85 c0                	test   %eax,%eax
  104eae:	75 18                	jne    104ec8 <sys_unlink+0x98>

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
  104eb0:	89 3c 24             	mov    %edi,(%esp)
  104eb3:	e8 28 ce ff ff       	call   101ce0 <iunlockput>
  104eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104ebd:	8d 76 00             	lea    0x0(%esi),%esi
  104ec0:	eb 99                	jmp    104e5b <sys_unlink+0x2b>
  104ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  104ec8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104ecb:	89 44 24 08          	mov    %eax,0x8(%esp)
  104ecf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104ed3:	89 3c 24             	mov    %edi,(%esp)
  104ed6:	e8 b5 c8 ff ff       	call   101790 <dirlookup>
  104edb:	85 c0                	test   %eax,%eax
  104edd:	89 c6                	mov    %eax,%esi
  104edf:	74 cf                	je     104eb0 <sys_unlink+0x80>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104ee1:	89 04 24             	mov    %eax,(%esp)
  104ee4:	e8 17 ce ff ff       	call   101d00 <ilock>

  if(ip->nlink < 1)
  104ee9:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104eee:	0f 8e d4 00 00 00    	jle    104fc8 <sys_unlink+0x198>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  104ef4:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104f00:	75 5b                	jne    104f5d <sys_unlink+0x12d>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104f02:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104f06:	66 90                	xchg   %ax,%ax
  104f08:	76 53                	jbe    104f5d <sys_unlink+0x12d>
  104f0a:	bb 20 00 00 00       	mov    $0x20,%ebx
  104f0f:	90                   	nop    
  104f10:	eb 10                	jmp    104f22 <sys_unlink+0xf2>
  104f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104f18:	83 c3 10             	add    $0x10,%ebx
  104f1b:	3b 5e 18             	cmp    0x18(%esi),%ebx
  104f1e:	66 90                	xchg   %ax,%ax
  104f20:	73 3b                	jae    104f5d <sys_unlink+0x12d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104f22:	8d 45 be             	lea    -0x42(%ebp),%eax
  104f25:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104f2c:	00 
  104f2d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  104f31:	89 44 24 04          	mov    %eax,0x4(%esp)
  104f35:	89 34 24             	mov    %esi,(%esp)
  104f38:	e8 43 c5 ff ff       	call   101480 <readi>
  104f3d:	83 f8 10             	cmp    $0x10,%eax
  104f40:	75 7a                	jne    104fbc <sys_unlink+0x18c>
      panic("isdirempty: readi");
    if(de.inum != 0)
  104f42:	66 83 7d be 00       	cmpw   $0x0,-0x42(%ebp)
  104f47:	74 cf                	je     104f18 <sys_unlink+0xe8>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  104f49:	89 34 24             	mov    %esi,(%esp)
  104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104f50:	e8 8b cd ff ff       	call   101ce0 <iunlockput>
  104f55:	8d 76 00             	lea    0x0(%esi),%esi
  104f58:	e9 53 ff ff ff       	jmp    104eb0 <sys_unlink+0x80>
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  104f5d:	8d 5d ce             	lea    -0x32(%ebp),%ebx
  104f60:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104f67:	00 
  104f68:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104f6f:	00 
  104f70:	89 1c 24             	mov    %ebx,(%esp)
  104f73:	e8 38 f2 ff ff       	call   1041b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104f78:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104f7b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104f82:	00 
  104f83:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104f87:	89 3c 24             	mov    %edi,(%esp)
  104f8a:	89 44 24 08          	mov    %eax,0x8(%esp)
  104f8e:	e8 8d c6 ff ff       	call   101620 <writei>
  104f93:	83 f8 10             	cmp    $0x10,%eax
  104f96:	75 3c                	jne    104fd4 <sys_unlink+0x1a4>
    panic("unlink: writei");
  iunlockput(dp);
  104f98:	89 3c 24             	mov    %edi,(%esp)
  104f9b:	e8 40 cd ff ff       	call   101ce0 <iunlockput>

  ip->nlink--;
  104fa0:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104fa5:	89 34 24             	mov    %esi,(%esp)
  104fa8:	e8 e3 c5 ff ff       	call   101590 <iupdate>
  iunlockput(ip);
  104fad:	89 34 24             	mov    %esi,(%esp)
  104fb0:	e8 2b cd ff ff       	call   101ce0 <iunlockput>
  104fb5:	31 c0                	xor    %eax,%eax
  104fb7:	e9 9f fe ff ff       	jmp    104e5b <sys_unlink+0x2b>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  104fbc:	c7 04 24 41 68 10 00 	movl   $0x106841,(%esp)
  104fc3:	e8 a8 b9 ff ff       	call   100970 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104fc8:	c7 04 24 2f 68 10 00 	movl   $0x10682f,(%esp)
  104fcf:	e8 9c b9 ff ff       	call   100970 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104fd4:	c7 04 24 53 68 10 00 	movl   $0x106853,(%esp)
  104fdb:	e8 90 b9 ff ff       	call   100970 <panic>

00104fe0 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104fe0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104fe1:	31 d2                	xor    %edx,%edx
  return 0;
}

int
sys_fstat(void)
{
  104fe3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104fe5:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104fe7:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104fea:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  104fed:	e8 5e f7 ff ff       	call   104750 <argfd>
  104ff2:	85 c0                	test   %eax,%eax
  104ff4:	79 0a                	jns    105000 <sys_fstat+0x20>
    return -1;
  return filestat(f, st);
  104ff6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104ffb:	c9                   	leave  
  104ffc:	c3                   	ret    
  104ffd:	8d 76 00             	lea    0x0(%esi),%esi
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  105000:	8d 45 f8             	lea    -0x8(%ebp),%eax
  105003:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10500a:	00 
  10500b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10500f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  105016:	e8 35 f5 ff ff       	call   104550 <argptr>
  10501b:	85 c0                	test   %eax,%eax
  10501d:	78 d7                	js     104ff6 <sys_fstat+0x16>
    return -1;
  return filestat(f, st);
  10501f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105022:	89 44 24 04          	mov    %eax,0x4(%esp)
  105026:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105029:	89 04 24             	mov    %eax,(%esp)
  10502c:	e8 ef be ff ff       	call   100f20 <filestat>
}
  105031:	c9                   	leave  
  105032:	c3                   	ret    
  105033:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105040 <sys_dup>:
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  105040:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  105041:	31 d2                	xor    %edx,%edx
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  105043:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  105045:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  105047:	53                   	push   %ebx
  105048:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  10504b:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  10504e:	e8 fd f6 ff ff       	call   104750 <argfd>
  105053:	85 c0                	test   %eax,%eax
  105055:	79 11                	jns    105068 <sys_dup+0x28>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
  105057:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  10505c:	89 d8                	mov    %ebx,%eax
  10505e:	83 c4 14             	add    $0x14,%esp
  105061:	5b                   	pop    %ebx
  105062:	5d                   	pop    %ebp
  105063:	c3                   	ret    
  105064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
  105068:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10506b:	e8 f0 f5 ff ff       	call   104660 <fdalloc>
  105070:	85 c0                	test   %eax,%eax
  105072:	89 c3                	mov    %eax,%ebx
  105074:	78 e1                	js     105057 <sys_dup+0x17>
    return -1;
  filedup(f);
  105076:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105079:	89 04 24             	mov    %eax,(%esp)
  10507c:	e8 ef be ff ff       	call   100f70 <filedup>
  105081:	eb d9                	jmp    10505c <sys_dup+0x1c>
  105083:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105090 <sys_write>:
  return fileread(f, p, n);
}

int
sys_write(void)
{
  105090:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  105091:	31 d2                	xor    %edx,%edx
  return fileread(f, p, n);
}

int
sys_write(void)
{
  105093:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  105095:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  105097:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10509a:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  10509d:	e8 ae f6 ff ff       	call   104750 <argfd>
  1050a2:	85 c0                	test   %eax,%eax
  1050a4:	79 0a                	jns    1050b0 <sys_write+0x20>
    return -1;
  return filewrite(f, p, n);
  1050a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1050ab:	c9                   	leave  
  1050ac:	c3                   	ret    
  1050ad:	8d 76 00             	lea    0x0(%esi),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1050b0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1050b3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1050b7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1050be:	e8 bd f3 ff ff       	call   104480 <argint>
  1050c3:	85 c0                	test   %eax,%eax
  1050c5:	78 df                	js     1050a6 <sys_write+0x16>
  1050c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1050ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1050d1:	89 44 24 08          	mov    %eax,0x8(%esp)
  1050d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1050d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1050dc:	e8 6f f4 ff ff       	call   104550 <argptr>
  1050e1:	85 c0                	test   %eax,%eax
  1050e3:	78 c1                	js     1050a6 <sys_write+0x16>
    return -1;
  return filewrite(f, p, n);
  1050e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1050e8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1050ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1050ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  1050f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1050f6:	89 04 24             	mov    %eax,(%esp)
  1050f9:	e8 c2 bc ff ff       	call   100dc0 <filewrite>
}
  1050fe:	c9                   	leave  
  1050ff:	c3                   	ret    

00105100 <sys_read>:
  return -1;
}

int
sys_read(void)
{
  105100:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  105101:	31 d2                	xor    %edx,%edx
  return -1;
}

int
sys_read(void)
{
  105103:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  105105:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_read(void)
{
  105107:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10510a:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  10510d:	e8 3e f6 ff ff       	call   104750 <argfd>
  105112:	85 c0                	test   %eax,%eax
  105114:	79 0a                	jns    105120 <sys_read+0x20>
    return -1;
  return fileread(f, p, n);
  105116:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10511b:	c9                   	leave  
  10511c:	c3                   	ret    
  10511d:	8d 76 00             	lea    0x0(%esi),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  105120:	8d 45 f8             	lea    -0x8(%ebp),%eax
  105123:	89 44 24 04          	mov    %eax,0x4(%esp)
  105127:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10512e:	e8 4d f3 ff ff       	call   104480 <argint>
  105133:	85 c0                	test   %eax,%eax
  105135:	78 df                	js     105116 <sys_read+0x16>
  105137:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10513a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  105141:	89 44 24 08          	mov    %eax,0x8(%esp)
  105145:	8d 45 f4             	lea    -0xc(%ebp),%eax
  105148:	89 44 24 04          	mov    %eax,0x4(%esp)
  10514c:	e8 ff f3 ff ff       	call   104550 <argptr>
  105151:	85 c0                	test   %eax,%eax
  105153:	78 c1                	js     105116 <sys_read+0x16>
    return -1;
  return fileread(f, p, n);
  105155:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105158:	89 44 24 08          	mov    %eax,0x8(%esp)
  10515c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10515f:	89 44 24 04          	mov    %eax,0x4(%esp)
  105163:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105166:	89 04 24             	mov    %eax,(%esp)
  105169:	e8 02 bd ff ff       	call   100e70 <fileread>
}
  10516e:	c9                   	leave  
  10516f:	c3                   	ret    

00105170 <sys_getruntime>:
  return setticks(pid, newticks);
}

int
sys_getruntime(void)
{
  105170:	55                   	push   %ebp
  105171:	89 e5                	mov    %esp,%ebp
  105173:	83 ec 18             	sub    $0x18,%esp
	int pid;
	if (argint(0, &pid) < 0)
  105176:	8d 45 fc             	lea    -0x4(%ebp),%eax
  105179:	89 44 24 04          	mov    %eax,0x4(%esp)
  10517d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105184:	e8 f7 f2 ff ff       	call   104480 <argint>
  105189:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10518e:	85 c0                	test   %eax,%eax
  105190:	78 0d                	js     10519f <sys_getruntime+0x2f>
		return -1;
  return getRunTimeOfProcess(pid);
  105192:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105195:	89 04 24             	mov    %eax,(%esp)
  105198:	e8 03 e1 ff ff       	call   1032a0 <getRunTimeOfProcess>
  10519d:	89 c2                	mov    %eax,%edx
}
  10519f:	89 d0                	mov    %edx,%eax
  1051a1:	c9                   	leave  
  1051a2:	c3                   	ret    
  1051a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1051a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001051b0 <sys_settickets>:
  return 0;
}

int
sys_settickets(void)
{
  1051b0:	55                   	push   %ebp
  1051b1:	89 e5                	mov    %esp,%ebp
  1051b3:	83 ec 18             	sub    $0x18,%esp
  int pid, newticks;
  if(argint(0, &pid) < 0 || argint(1, &newticks) < 0)
  1051b6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1051b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1051bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1051c4:	e8 b7 f2 ff ff       	call   104480 <argint>
  1051c9:	85 c0                	test   %eax,%eax
  1051cb:	79 0b                	jns    1051d8 <sys_settickets+0x28>
    return -1;
  return setticks(pid, newticks);
  1051cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1051d2:	c9                   	leave  
  1051d3:	c3                   	ret    
  1051d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
sys_settickets(void)
{
  int pid, newticks;
  if(argint(0, &pid) < 0 || argint(1, &newticks) < 0)
  1051d8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1051db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1051df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1051e6:	e8 95 f2 ff ff       	call   104480 <argint>
  1051eb:	85 c0                	test   %eax,%eax
  1051ed:	78 de                	js     1051cd <sys_settickets+0x1d>
    return -1;
  return setticks(pid, newticks);
  1051ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1051f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1051f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1051f9:	89 04 24             	mov    %eax,(%esp)
  1051fc:	e8 4f e0 ff ff       	call   103250 <setticks>
}
  105201:	c9                   	leave  
  105202:	c3                   	ret    
  105203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105210 <sys_getpid>:
  return kill(pid);
}

int
sys_getpid(void)
{
  105210:	55                   	push   %ebp
  105211:	89 e5                	mov    %esp,%ebp
  105213:	83 ec 08             	sub    $0x8,%esp
  return cp->pid;
  105216:	e8 a5 e2 ff ff       	call   1034c0 <curproc>
  10521b:	8b 40 10             	mov    0x10(%eax),%eax
}
  10521e:	c9                   	leave  
  10521f:	c3                   	ret    

00105220 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
  105220:	55                   	push   %ebp
  105221:	89 e5                	mov    %esp,%ebp
  105223:	53                   	push   %ebx
  105224:	83 ec 24             	sub    $0x24,%esp
  int n, ticks0;
  
  if(argint(0, &n) < 0)
  105227:	8d 45 f8             	lea    -0x8(%ebp),%eax
  10522a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10522e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105235:	e8 46 f2 ff ff       	call   104480 <argint>
  10523a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10523f:	85 c0                	test   %eax,%eax
  105241:	78 5a                	js     10529d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
  105243:	c7 04 24 80 e2 10 00 	movl   $0x10e280,(%esp)
  10524a:	e8 f1 ee ff ff       	call   104140 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  10524f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  int n, ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  105252:	8b 1d c0 ea 10 00    	mov    0x10eac0,%ebx
  while(ticks - ticks0 < n){
  105258:	85 d2                	test   %edx,%edx
  10525a:	7f 24                	jg     105280 <sys_sleep+0x60>
  10525c:	eb 4a                	jmp    1052a8 <sys_sleep+0x88>
  10525e:	66 90                	xchg   %ax,%ax
    if(cp->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  105260:	c7 44 24 04 80 e2 10 	movl   $0x10e280,0x4(%esp)
  105267:	00 
  105268:	c7 04 24 c0 ea 10 00 	movl   $0x10eac0,(%esp)
  10526f:	e8 ac e4 ff ff       	call   103720 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  105274:	a1 c0 ea 10 00       	mov    0x10eac0,%eax
  105279:	29 d8                	sub    %ebx,%eax
  10527b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  10527e:	7d 28                	jge    1052a8 <sys_sleep+0x88>
    if(cp->killed){
  105280:	e8 3b e2 ff ff       	call   1034c0 <curproc>
  105285:	8b 40 1c             	mov    0x1c(%eax),%eax
  105288:	85 c0                	test   %eax,%eax
  10528a:	74 d4                	je     105260 <sys_sleep+0x40>
      release(&tickslock);
  10528c:	c7 04 24 80 e2 10 00 	movl   $0x10e280,(%esp)
  105293:	e8 68 ee ff ff       	call   104100 <release>
  105298:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  10529d:	83 c4 24             	add    $0x24,%esp
  1052a0:	89 d0                	mov    %edx,%eax
  1052a2:	5b                   	pop    %ebx
  1052a3:	5d                   	pop    %ebp
  1052a4:	c3                   	ret    
  1052a5:	8d 76 00             	lea    0x0(%esi),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  1052a8:	c7 04 24 80 e2 10 00 	movl   $0x10e280,(%esp)
  1052af:	e8 4c ee ff ff       	call   104100 <release>
  1052b4:	31 d2                	xor    %edx,%edx
  return 0;
}
  1052b6:	83 c4 24             	add    $0x24,%esp
  1052b9:	89 d0                	mov    %edx,%eax
  1052bb:	5b                   	pop    %ebx
  1052bc:	5d                   	pop    %ebp
  1052bd:	c3                   	ret    
  1052be:	66 90                	xchg   %ax,%ax

001052c0 <sys_sbrk>:
  return cp->pid;
}

int
sys_sbrk(void)
{
  1052c0:	55                   	push   %ebp
  1052c1:	89 e5                	mov    %esp,%ebp
  1052c3:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  1052c6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1052c9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1052cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1052d4:	e8 a7 f1 ff ff       	call   104480 <argint>
  1052d9:	85 c0                	test   %eax,%eax
  1052db:	79 0b                	jns    1052e8 <sys_sbrk+0x28>
    return -1;
  if((addr = growproc(n)) < 0)
  1052dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  return addr;
}
  1052e2:	c9                   	leave  
  1052e3:	c3                   	ret    
  1052e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  if((addr = growproc(n)) < 0)
  1052e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1052eb:	89 04 24             	mov    %eax,(%esp)
  1052ee:	e8 dd e8 ff ff       	call   103bd0 <growproc>
  1052f3:	85 c0                	test   %eax,%eax
  1052f5:	78 e6                	js     1052dd <sys_sbrk+0x1d>
    return -1;
  return addr;
}
  1052f7:	c9                   	leave  
  1052f8:	c3                   	ret    
  1052f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105300 <sys_kill>:
  return wait();
}

int
sys_kill(void)
{
  105300:	55                   	push   %ebp
  105301:	89 e5                	mov    %esp,%ebp
  105303:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
  105306:	8d 45 fc             	lea    -0x4(%ebp),%eax
  105309:	89 44 24 04          	mov    %eax,0x4(%esp)
  10530d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105314:	e8 67 f1 ff ff       	call   104480 <argint>
  105319:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10531e:	85 c0                	test   %eax,%eax
  105320:	78 0d                	js     10532f <sys_kill+0x2f>
    return -1;
  return kill(pid);
  105322:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105325:	89 04 24             	mov    %eax,(%esp)
  105328:	e8 83 e0 ff ff       	call   1033b0 <kill>
  10532d:	89 c2                	mov    %eax,%edx
}
  10532f:	89 d0                	mov    %edx,%eax
  105331:	c9                   	leave  
  105332:	c3                   	ret    
  105333:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105340 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void)
{
  105340:	55                   	push   %ebp
  105341:	89 e5                	mov    %esp,%ebp
  return wait();
}
  105343:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
  105344:	e9 a7 e4 ff ff       	jmp    1037f0 <wait>
  105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105350 <sys_exit>:
  return pid;
}

int
sys_exit(void)
{
  105350:	55                   	push   %ebp
  105351:	89 e5                	mov    %esp,%ebp
  105353:	83 ec 08             	sub    $0x8,%esp
  exit();
  105356:	e8 65 e2 ff ff       	call   1035c0 <exit>
  return 0;  // not reached
}
  10535b:	31 c0                	xor    %eax,%eax
  10535d:	c9                   	leave  
  10535e:	c3                   	ret    
  10535f:	90                   	nop    

00105360 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  105360:	55                   	push   %ebp
  105361:	89 e5                	mov    %esp,%ebp
  105363:	83 ec 08             	sub    $0x8,%esp
  int pid;
  struct proc *np;

  if((np = copyproc(cp)) == 0)
  105366:	e8 55 e1 ff ff       	call   1034c0 <curproc>
  10536b:	89 04 24             	mov    %eax,(%esp)
  10536e:	e8 1d e9 ff ff       	call   103c90 <copyproc>
  105373:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  105378:	85 c0                	test   %eax,%eax
  10537a:	74 0a                	je     105386 <sys_fork+0x26>
    return -1;
  pid = np->pid;
  10537c:	8b 50 10             	mov    0x10(%eax),%edx
  np->state = RUNNABLE;
  10537f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  return pid;
}
  105386:	89 d0                	mov    %edx,%eax
  105388:	c9                   	leave  
  105389:	c3                   	ret    
  10538a:	90                   	nop    
  10538b:	90                   	nop    
  10538c:	90                   	nop    
  10538d:	90                   	nop    
  10538e:	90                   	nop    
  10538f:	90                   	nop    

00105390 <timer_init>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timer_init(void)
{
  105390:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105391:	ba 43 00 00 00       	mov    $0x43,%edx
  105396:	89 e5                	mov    %esp,%ebp
  105398:	b8 34 00 00 00       	mov    $0x34,%eax
  10539d:	83 ec 08             	sub    $0x8,%esp
  1053a0:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  pic_enable(IRQ_TIMER);
  1053a1:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  1053a6:	b2 40                	mov    $0x40,%dl
  1053a8:	ee                   	out    %al,(%dx)
  1053a9:	b8 2e 00 00 00       	mov    $0x2e,%eax
  1053ae:	ee                   	out    %al,(%dx)
  1053af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1053b6:	e8 15 da ff ff       	call   102dd0 <pic_enable>
}
  1053bb:	c9                   	leave  
  1053bc:	c3                   	ret    
  1053bd:	90                   	nop    
  1053be:	90                   	nop    
  1053bf:	90                   	nop    

001053c0 <alltraps>:
  1053c0:	1e                   	push   %ds
  1053c1:	06                   	push   %es
  1053c2:	60                   	pusha  
  1053c3:	b8 10 00 00 00       	mov    $0x10,%eax
  1053c8:	8e d8                	mov    %eax,%ds
  1053ca:	8e c0                	mov    %eax,%es
  1053cc:	54                   	push   %esp
  1053cd:	e8 4e 00 00 00       	call   105420 <trap>
  1053d2:	83 c4 04             	add    $0x4,%esp

001053d5 <trapret>:
  1053d5:	61                   	popa   
  1053d6:	07                   	pop    %es
  1053d7:	1f                   	pop    %ds
  1053d8:	83 c4 08             	add    $0x8,%esp
  1053db:	cf                   	iret   

001053dc <forkret1>:
  1053dc:	8b 64 24 04          	mov    0x4(%esp),%esp
  1053e0:	e9 f0 ff ff ff       	jmp    1053d5 <trapret>
  1053e5:	90                   	nop    
  1053e6:	90                   	nop    
  1053e7:	90                   	nop    
  1053e8:	90                   	nop    
  1053e9:	90                   	nop    
  1053ea:	90                   	nop    
  1053eb:	90                   	nop    
  1053ec:	90                   	nop    
  1053ed:	90                   	nop    
  1053ee:	90                   	nop    
  1053ef:	90                   	nop    

001053f0 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  1053f0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  1053f1:	b8 c0 e2 10 00       	mov    $0x10e2c0,%eax
  1053f6:	89 e5                	mov    %esp,%ebp
  1053f8:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  1053fb:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  105401:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  105405:	c1 e8 10             	shr    $0x10,%eax
  105408:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  10540c:	8d 45 fa             	lea    -0x6(%ebp),%eax
  10540f:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  105412:	c9                   	leave  
  105413:	c3                   	ret    
  105414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10541a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105420 <trap>:

void
trap(struct trapframe *tf)
{
  105420:	55                   	push   %ebp
  105421:	89 e5                	mov    %esp,%ebp
  105423:	83 ec 38             	sub    $0x38,%esp
  105426:	89 7d fc             	mov    %edi,-0x4(%ebp)
  105429:	8b 7d 08             	mov    0x8(%ebp),%edi
  10542c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10542f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(tf->trapno == T_SYSCALL){
  105432:	8b 47 28             	mov    0x28(%edi),%eax
  105435:	83 f8 30             	cmp    $0x30,%eax
  105438:	0f 84 22 01 00 00    	je     105560 <trap+0x140>
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  10543e:	83 f8 21             	cmp    $0x21,%eax
  105441:	0f 84 b1 01 00 00    	je     1055f8 <trap+0x1d8>
  105447:	0f 86 a3 00 00 00    	jbe    1054f0 <trap+0xd0>
  10544d:	83 f8 2e             	cmp    $0x2e,%eax
  105450:	0f 84 52 01 00 00    	je     1055a8 <trap+0x188>
  105456:	83 f8 3f             	cmp    $0x3f,%eax
  105459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105460:	0f 85 93 00 00 00    	jne    1054f9 <trap+0xd9>
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  105466:	8b 5f 30             	mov    0x30(%edi),%ebx
  105469:	0f b7 77 34          	movzwl 0x34(%edi),%esi
  10546d:	e8 be d4 ff ff       	call   102930 <cpu>
  105472:	c7 04 24 64 68 10 00 	movl   $0x106864,(%esp)
  105479:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10547d:	89 74 24 08          	mov    %esi,0x8(%esp)
  105481:	89 44 24 04          	mov    %eax,0x4(%esp)
  105485:	e8 16 b3 ff ff       	call   1007a0 <cprintf>
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
  10548a:	e8 11 d3 ff ff       	call   1027a0 <lapic_eoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  10548f:	e8 2c e0 ff ff       	call   1034c0 <curproc>
  105494:	85 c0                	test   %eax,%eax
  105496:	66 90                	xchg   %ax,%ax
  105498:	74 28                	je     1054c2 <trap+0xa2>
  10549a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1054a0:	e8 1b e0 ff ff       	call   1034c0 <curproc>
  1054a5:	8b 40 1c             	mov    0x1c(%eax),%eax
  1054a8:	85 c0                	test   %eax,%eax
  1054aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1054b0:	74 10                	je     1054c2 <trap+0xa2>
  1054b2:	0f b7 47 34          	movzwl 0x34(%edi),%eax
  1054b6:	83 e0 03             	and    $0x3,%eax
  1054b9:	83 f8 03             	cmp    $0x3,%eax
  1054bc:	0f 84 ce 01 00 00    	je     105690 <trap+0x270>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  1054c2:	e8 f9 df ff ff       	call   1034c0 <curproc>
  1054c7:	85 c0                	test   %eax,%eax
  1054c9:	74 17                	je     1054e2 <trap+0xc2>
  1054cb:	90                   	nop    
  1054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1054d0:	e8 eb df ff ff       	call   1034c0 <curproc>
  1054d5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  1054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054e0:	74 66                	je     105548 <trap+0x128>
    yield();
}
  1054e2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1054e5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1054e8:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1054eb:	89 ec                	mov    %ebp,%esp
  1054ed:	5d                   	pop    %ebp
  1054ee:	c3                   	ret    
  1054ef:	90                   	nop    
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  1054f0:	83 f8 20             	cmp    $0x20,%eax
  1054f3:	0f 84 c7 00 00 00    	je     1055c0 <trap+0x1a0>
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
  1054f9:	e8 c2 df ff ff       	call   1034c0 <curproc>
  1054fe:	85 c0                	test   %eax,%eax
  105500:	74 0c                	je     10550e <trap+0xee>
  105502:	f6 47 34 03          	testb  $0x3,0x34(%edi)
  105506:	66 90                	xchg   %ax,%ax
  105508:	0f 85 12 01 00 00    	jne    105620 <trap+0x200>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x\n",
  10550e:	8b 5f 30             	mov    0x30(%edi),%ebx
  105511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105518:	e8 13 d4 ff ff       	call   102930 <cpu>
  10551d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  105521:	89 44 24 08          	mov    %eax,0x8(%esp)
  105525:	8b 47 28             	mov    0x28(%edi),%eax
  105528:	c7 04 24 88 68 10 00 	movl   $0x106888,(%esp)
  10552f:	89 44 24 04          	mov    %eax,0x4(%esp)
  105533:	e8 68 b2 ff ff       	call   1007a0 <cprintf>
              tf->trapno, cpu(), tf->eip);
      panic("trap");
  105538:	c7 04 24 ec 68 10 00 	movl   $0x1068ec,(%esp)
  10553f:	e8 2c b4 ff ff       	call   100970 <panic>
  105544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  105548:	83 7f 28 20          	cmpl   $0x20,0x28(%edi)
  10554c:	75 94                	jne    1054e2 <trap+0xc2>
    yield();
}
  10554e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105551:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105554:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105557:	89 ec                	mov    %ebp,%esp
  105559:	5d                   	pop    %ebp
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
  10555a:	e9 a1 e3 ff ff       	jmp    103900 <yield>
  10555f:	90                   	nop    

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
  105560:	e8 5b df ff ff       	call   1034c0 <curproc>
  105565:	8b 48 1c             	mov    0x1c(%eax),%ecx
  105568:	85 c9                	test   %ecx,%ecx
  10556a:	0f 85 a0 00 00 00    	jne    105610 <trap+0x1f0>
      exit();
    cp->tf = tf;
  105570:	e8 4b df ff ff       	call   1034c0 <curproc>
  105575:	89 b8 84 00 00 00    	mov    %edi,0x84(%eax)
    syscall();
  10557b:	e8 30 f0 ff ff       	call   1045b0 <syscall>
    if(cp->killed)
  105580:	e8 3b df ff ff       	call   1034c0 <curproc>
  105585:	8b 50 1c             	mov    0x1c(%eax),%edx
  105588:	85 d2                	test   %edx,%edx
  10558a:	0f 84 52 ff ff ff    	je     1054e2 <trap+0xc2>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
}
  105590:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105593:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105596:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105599:	89 ec                	mov    %ebp,%esp
  10559b:	5d                   	pop    %ebp
    if(cp->killed)
      exit();
    cp->tf = tf;
    syscall();
    if(cp->killed)
      exit();
  10559c:	e9 1f e0 ff ff       	jmp    1035c0 <exit>
  1055a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
  1055a8:	e8 c3 cb ff ff       	call   102170 <ide_intr>
    lapic_eoi();
  1055ad:	e8 ee d1 ff ff       	call   1027a0 <lapic_eoi>
  1055b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1055b8:	e9 d2 fe ff ff       	jmp    10548f <trap+0x6f>
  1055bd:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
  1055c0:	e8 6b d3 ff ff       	call   102930 <cpu>
  1055c5:	85 c0                	test   %eax,%eax
  1055c7:	90                   	nop    
  1055c8:	75 e3                	jne    1055ad <trap+0x18d>
      acquire(&tickslock);
  1055ca:	c7 04 24 80 e2 10 00 	movl   $0x10e280,(%esp)
  1055d1:	e8 6a eb ff ff       	call   104140 <acquire>
      ticks++;
  1055d6:	83 05 c0 ea 10 00 01 	addl   $0x1,0x10eac0
      wakeup(&ticks);
  1055dd:	c7 04 24 c0 ea 10 00 	movl   $0x10eac0,(%esp)
  1055e4:	e8 57 de ff ff       	call   103440 <wakeup>
      release(&tickslock);
  1055e9:	c7 04 24 80 e2 10 00 	movl   $0x10e280,(%esp)
  1055f0:	e8 0b eb ff ff       	call   104100 <release>
  1055f5:	eb b6                	jmp    1055ad <trap+0x18d>
  1055f7:	90                   	nop    
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
  1055f8:	e8 93 d0 ff ff       	call   102690 <kbd_intr>
  1055fd:	8d 76 00             	lea    0x0(%esi),%esi
    lapic_eoi();
  105600:	e8 9b d1 ff ff       	call   1027a0 <lapic_eoi>
  105605:	8d 76 00             	lea    0x0(%esi),%esi
  105608:	e9 82 fe ff ff       	jmp    10548f <trap+0x6f>
  10560d:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
      exit();
  105610:	e8 ab df ff ff       	call   1035c0 <exit>
  105615:	8d 76 00             	lea    0x0(%esi),%esi
  105618:	e9 53 ff ff ff       	jmp    105570 <trap+0x150>
  10561d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  105620:	8b 47 30             	mov    0x30(%edi),%eax
  105623:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105626:	e8 05 d3 ff ff       	call   102930 <cpu>
  10562b:	8b 57 28             	mov    0x28(%edi),%edx
  10562e:	8b 77 2c             	mov    0x2c(%edi),%esi
  105631:	89 55 f0             	mov    %edx,-0x10(%ebp)
  105634:	89 c3                	mov    %eax,%ebx
  105636:	e8 85 de ff ff       	call   1034c0 <curproc>
  10563b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10563e:	e8 7d de ff ff       	call   1034c0 <curproc>
  105643:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105646:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  10564a:	89 74 24 10          	mov    %esi,0x10(%esp)
  10564e:	89 54 24 18          	mov    %edx,0x18(%esp)
  105652:	8b 55 f0             	mov    -0x10(%ebp),%edx
  105655:	89 54 24 0c          	mov    %edx,0xc(%esp)
  105659:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10565c:	81 c2 88 00 00 00    	add    $0x88,%edx
  105662:	89 54 24 08          	mov    %edx,0x8(%esp)
  105666:	8b 40 10             	mov    0x10(%eax),%eax
  105669:	c7 04 24 b0 68 10 00 	movl   $0x1068b0,(%esp)
  105670:	89 44 24 04          	mov    %eax,0x4(%esp)
  105674:	e8 27 b1 ff ff       	call   1007a0 <cprintf>
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
    cp->killed = 1;
  105679:	e8 42 de ff ff       	call   1034c0 <curproc>
  10567e:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
  105685:	e9 05 fe ff ff       	jmp    10548f <trap+0x6f>
  10568a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();
  105690:	e8 2b df ff ff       	call   1035c0 <exit>
  105695:	8d 76 00             	lea    0x0(%esi),%esi
  105698:	e9 25 fe ff ff       	jmp    1054c2 <trap+0xa2>
  10569d:	8d 76 00             	lea    0x0(%esi),%esi

001056a0 <tvinit>:
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  1056a0:	55                   	push   %ebp
  1056a1:	31 d2                	xor    %edx,%edx
  1056a3:	89 e5                	mov    %esp,%ebp
  1056a5:	b9 c0 e2 10 00       	mov    $0x10e2c0,%ecx
  1056aa:	83 ec 08             	sub    $0x8,%esp
  1056ad:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  1056b0:	8b 04 95 0c 7c 10 00 	mov    0x107c0c(,%edx,4),%eax
  1056b7:	66 c7 44 d1 02 08 00 	movw   $0x8,0x2(%ecx,%edx,8)
  1056be:	66 89 04 d5 c0 e2 10 	mov    %ax,0x10e2c0(,%edx,8)
  1056c5:	00 
  1056c6:	c1 e8 10             	shr    $0x10,%eax
  1056c9:	c6 44 d1 04 00       	movb   $0x0,0x4(%ecx,%edx,8)
  1056ce:	c6 44 d1 05 8e       	movb   $0x8e,0x5(%ecx,%edx,8)
  1056d3:	66 89 44 d1 06       	mov    %ax,0x6(%ecx,%edx,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  1056d8:	83 c2 01             	add    $0x1,%edx
  1056db:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  1056e1:	75 cd                	jne    1056b0 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1056e3:	a1 cc 7c 10 00       	mov    0x107ccc,%eax
  
  initlock(&tickslock, "time");
  1056e8:	c7 44 24 04 f1 68 10 	movl   $0x1068f1,0x4(%esp)
  1056ef:	00 
  1056f0:	c7 04 24 80 e2 10 00 	movl   $0x10e280,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1056f7:	66 c7 05 42 e4 10 00 	movw   $0x8,0x10e442
  1056fe:	08 00 
  105700:	66 a3 40 e4 10 00    	mov    %ax,0x10e440
  105706:	c1 e8 10             	shr    $0x10,%eax
  105709:	c6 05 44 e4 10 00 00 	movb   $0x0,0x10e444
  105710:	c6 05 45 e4 10 00 ef 	movb   $0xef,0x10e445
  105717:	66 a3 46 e4 10 00    	mov    %ax,0x10e446
  
  initlock(&tickslock, "time");
  10571d:	e8 4e e8 ff ff       	call   103f70 <initlock>
}
  105722:	c9                   	leave  
  105723:	c3                   	ret    

00105724 <vector0>:
  105724:	6a 00                	push   $0x0
  105726:	6a 00                	push   $0x0
  105728:	e9 93 fc ff ff       	jmp    1053c0 <alltraps>

0010572d <vector1>:
  10572d:	6a 00                	push   $0x0
  10572f:	6a 01                	push   $0x1
  105731:	e9 8a fc ff ff       	jmp    1053c0 <alltraps>

00105736 <vector2>:
  105736:	6a 00                	push   $0x0
  105738:	6a 02                	push   $0x2
  10573a:	e9 81 fc ff ff       	jmp    1053c0 <alltraps>

0010573f <vector3>:
  10573f:	6a 00                	push   $0x0
  105741:	6a 03                	push   $0x3
  105743:	e9 78 fc ff ff       	jmp    1053c0 <alltraps>

00105748 <vector4>:
  105748:	6a 00                	push   $0x0
  10574a:	6a 04                	push   $0x4
  10574c:	e9 6f fc ff ff       	jmp    1053c0 <alltraps>

00105751 <vector5>:
  105751:	6a 00                	push   $0x0
  105753:	6a 05                	push   $0x5
  105755:	e9 66 fc ff ff       	jmp    1053c0 <alltraps>

0010575a <vector6>:
  10575a:	6a 00                	push   $0x0
  10575c:	6a 06                	push   $0x6
  10575e:	e9 5d fc ff ff       	jmp    1053c0 <alltraps>

00105763 <vector7>:
  105763:	6a 00                	push   $0x0
  105765:	6a 07                	push   $0x7
  105767:	e9 54 fc ff ff       	jmp    1053c0 <alltraps>

0010576c <vector8>:
  10576c:	6a 08                	push   $0x8
  10576e:	e9 4d fc ff ff       	jmp    1053c0 <alltraps>

00105773 <vector9>:
  105773:	6a 09                	push   $0x9
  105775:	e9 46 fc ff ff       	jmp    1053c0 <alltraps>

0010577a <vector10>:
  10577a:	6a 0a                	push   $0xa
  10577c:	e9 3f fc ff ff       	jmp    1053c0 <alltraps>

00105781 <vector11>:
  105781:	6a 0b                	push   $0xb
  105783:	e9 38 fc ff ff       	jmp    1053c0 <alltraps>

00105788 <vector12>:
  105788:	6a 0c                	push   $0xc
  10578a:	e9 31 fc ff ff       	jmp    1053c0 <alltraps>

0010578f <vector13>:
  10578f:	6a 0d                	push   $0xd
  105791:	e9 2a fc ff ff       	jmp    1053c0 <alltraps>

00105796 <vector14>:
  105796:	6a 0e                	push   $0xe
  105798:	e9 23 fc ff ff       	jmp    1053c0 <alltraps>

0010579d <vector15>:
  10579d:	6a 00                	push   $0x0
  10579f:	6a 0f                	push   $0xf
  1057a1:	e9 1a fc ff ff       	jmp    1053c0 <alltraps>

001057a6 <vector16>:
  1057a6:	6a 00                	push   $0x0
  1057a8:	6a 10                	push   $0x10
  1057aa:	e9 11 fc ff ff       	jmp    1053c0 <alltraps>

001057af <vector17>:
  1057af:	6a 11                	push   $0x11
  1057b1:	e9 0a fc ff ff       	jmp    1053c0 <alltraps>

001057b6 <vector18>:
  1057b6:	6a 00                	push   $0x0
  1057b8:	6a 12                	push   $0x12
  1057ba:	e9 01 fc ff ff       	jmp    1053c0 <alltraps>

001057bf <vector19>:
  1057bf:	6a 00                	push   $0x0
  1057c1:	6a 13                	push   $0x13
  1057c3:	e9 f8 fb ff ff       	jmp    1053c0 <alltraps>

001057c8 <vector20>:
  1057c8:	6a 00                	push   $0x0
  1057ca:	6a 14                	push   $0x14
  1057cc:	e9 ef fb ff ff       	jmp    1053c0 <alltraps>

001057d1 <vector21>:
  1057d1:	6a 00                	push   $0x0
  1057d3:	6a 15                	push   $0x15
  1057d5:	e9 e6 fb ff ff       	jmp    1053c0 <alltraps>

001057da <vector22>:
  1057da:	6a 00                	push   $0x0
  1057dc:	6a 16                	push   $0x16
  1057de:	e9 dd fb ff ff       	jmp    1053c0 <alltraps>

001057e3 <vector23>:
  1057e3:	6a 00                	push   $0x0
  1057e5:	6a 17                	push   $0x17
  1057e7:	e9 d4 fb ff ff       	jmp    1053c0 <alltraps>

001057ec <vector24>:
  1057ec:	6a 00                	push   $0x0
  1057ee:	6a 18                	push   $0x18
  1057f0:	e9 cb fb ff ff       	jmp    1053c0 <alltraps>

001057f5 <vector25>:
  1057f5:	6a 00                	push   $0x0
  1057f7:	6a 19                	push   $0x19
  1057f9:	e9 c2 fb ff ff       	jmp    1053c0 <alltraps>

001057fe <vector26>:
  1057fe:	6a 00                	push   $0x0
  105800:	6a 1a                	push   $0x1a
  105802:	e9 b9 fb ff ff       	jmp    1053c0 <alltraps>

00105807 <vector27>:
  105807:	6a 00                	push   $0x0
  105809:	6a 1b                	push   $0x1b
  10580b:	e9 b0 fb ff ff       	jmp    1053c0 <alltraps>

00105810 <vector28>:
  105810:	6a 00                	push   $0x0
  105812:	6a 1c                	push   $0x1c
  105814:	e9 a7 fb ff ff       	jmp    1053c0 <alltraps>

00105819 <vector29>:
  105819:	6a 00                	push   $0x0
  10581b:	6a 1d                	push   $0x1d
  10581d:	e9 9e fb ff ff       	jmp    1053c0 <alltraps>

00105822 <vector30>:
  105822:	6a 00                	push   $0x0
  105824:	6a 1e                	push   $0x1e
  105826:	e9 95 fb ff ff       	jmp    1053c0 <alltraps>

0010582b <vector31>:
  10582b:	6a 00                	push   $0x0
  10582d:	6a 1f                	push   $0x1f
  10582f:	e9 8c fb ff ff       	jmp    1053c0 <alltraps>

00105834 <vector32>:
  105834:	6a 00                	push   $0x0
  105836:	6a 20                	push   $0x20
  105838:	e9 83 fb ff ff       	jmp    1053c0 <alltraps>

0010583d <vector33>:
  10583d:	6a 00                	push   $0x0
  10583f:	6a 21                	push   $0x21
  105841:	e9 7a fb ff ff       	jmp    1053c0 <alltraps>

00105846 <vector34>:
  105846:	6a 00                	push   $0x0
  105848:	6a 22                	push   $0x22
  10584a:	e9 71 fb ff ff       	jmp    1053c0 <alltraps>

0010584f <vector35>:
  10584f:	6a 00                	push   $0x0
  105851:	6a 23                	push   $0x23
  105853:	e9 68 fb ff ff       	jmp    1053c0 <alltraps>

00105858 <vector36>:
  105858:	6a 00                	push   $0x0
  10585a:	6a 24                	push   $0x24
  10585c:	e9 5f fb ff ff       	jmp    1053c0 <alltraps>

00105861 <vector37>:
  105861:	6a 00                	push   $0x0
  105863:	6a 25                	push   $0x25
  105865:	e9 56 fb ff ff       	jmp    1053c0 <alltraps>

0010586a <vector38>:
  10586a:	6a 00                	push   $0x0
  10586c:	6a 26                	push   $0x26
  10586e:	e9 4d fb ff ff       	jmp    1053c0 <alltraps>

00105873 <vector39>:
  105873:	6a 00                	push   $0x0
  105875:	6a 27                	push   $0x27
  105877:	e9 44 fb ff ff       	jmp    1053c0 <alltraps>

0010587c <vector40>:
  10587c:	6a 00                	push   $0x0
  10587e:	6a 28                	push   $0x28
  105880:	e9 3b fb ff ff       	jmp    1053c0 <alltraps>

00105885 <vector41>:
  105885:	6a 00                	push   $0x0
  105887:	6a 29                	push   $0x29
  105889:	e9 32 fb ff ff       	jmp    1053c0 <alltraps>

0010588e <vector42>:
  10588e:	6a 00                	push   $0x0
  105890:	6a 2a                	push   $0x2a
  105892:	e9 29 fb ff ff       	jmp    1053c0 <alltraps>

00105897 <vector43>:
  105897:	6a 00                	push   $0x0
  105899:	6a 2b                	push   $0x2b
  10589b:	e9 20 fb ff ff       	jmp    1053c0 <alltraps>

001058a0 <vector44>:
  1058a0:	6a 00                	push   $0x0
  1058a2:	6a 2c                	push   $0x2c
  1058a4:	e9 17 fb ff ff       	jmp    1053c0 <alltraps>

001058a9 <vector45>:
  1058a9:	6a 00                	push   $0x0
  1058ab:	6a 2d                	push   $0x2d
  1058ad:	e9 0e fb ff ff       	jmp    1053c0 <alltraps>

001058b2 <vector46>:
  1058b2:	6a 00                	push   $0x0
  1058b4:	6a 2e                	push   $0x2e
  1058b6:	e9 05 fb ff ff       	jmp    1053c0 <alltraps>

001058bb <vector47>:
  1058bb:	6a 00                	push   $0x0
  1058bd:	6a 2f                	push   $0x2f
  1058bf:	e9 fc fa ff ff       	jmp    1053c0 <alltraps>

001058c4 <vector48>:
  1058c4:	6a 00                	push   $0x0
  1058c6:	6a 30                	push   $0x30
  1058c8:	e9 f3 fa ff ff       	jmp    1053c0 <alltraps>

001058cd <vector49>:
  1058cd:	6a 00                	push   $0x0
  1058cf:	6a 31                	push   $0x31
  1058d1:	e9 ea fa ff ff       	jmp    1053c0 <alltraps>

001058d6 <vector50>:
  1058d6:	6a 00                	push   $0x0
  1058d8:	6a 32                	push   $0x32
  1058da:	e9 e1 fa ff ff       	jmp    1053c0 <alltraps>

001058df <vector51>:
  1058df:	6a 00                	push   $0x0
  1058e1:	6a 33                	push   $0x33
  1058e3:	e9 d8 fa ff ff       	jmp    1053c0 <alltraps>

001058e8 <vector52>:
  1058e8:	6a 00                	push   $0x0
  1058ea:	6a 34                	push   $0x34
  1058ec:	e9 cf fa ff ff       	jmp    1053c0 <alltraps>

001058f1 <vector53>:
  1058f1:	6a 00                	push   $0x0
  1058f3:	6a 35                	push   $0x35
  1058f5:	e9 c6 fa ff ff       	jmp    1053c0 <alltraps>

001058fa <vector54>:
  1058fa:	6a 00                	push   $0x0
  1058fc:	6a 36                	push   $0x36
  1058fe:	e9 bd fa ff ff       	jmp    1053c0 <alltraps>

00105903 <vector55>:
  105903:	6a 00                	push   $0x0
  105905:	6a 37                	push   $0x37
  105907:	e9 b4 fa ff ff       	jmp    1053c0 <alltraps>

0010590c <vector56>:
  10590c:	6a 00                	push   $0x0
  10590e:	6a 38                	push   $0x38
  105910:	e9 ab fa ff ff       	jmp    1053c0 <alltraps>

00105915 <vector57>:
  105915:	6a 00                	push   $0x0
  105917:	6a 39                	push   $0x39
  105919:	e9 a2 fa ff ff       	jmp    1053c0 <alltraps>

0010591e <vector58>:
  10591e:	6a 00                	push   $0x0
  105920:	6a 3a                	push   $0x3a
  105922:	e9 99 fa ff ff       	jmp    1053c0 <alltraps>

00105927 <vector59>:
  105927:	6a 00                	push   $0x0
  105929:	6a 3b                	push   $0x3b
  10592b:	e9 90 fa ff ff       	jmp    1053c0 <alltraps>

00105930 <vector60>:
  105930:	6a 00                	push   $0x0
  105932:	6a 3c                	push   $0x3c
  105934:	e9 87 fa ff ff       	jmp    1053c0 <alltraps>

00105939 <vector61>:
  105939:	6a 00                	push   $0x0
  10593b:	6a 3d                	push   $0x3d
  10593d:	e9 7e fa ff ff       	jmp    1053c0 <alltraps>

00105942 <vector62>:
  105942:	6a 00                	push   $0x0
  105944:	6a 3e                	push   $0x3e
  105946:	e9 75 fa ff ff       	jmp    1053c0 <alltraps>

0010594b <vector63>:
  10594b:	6a 00                	push   $0x0
  10594d:	6a 3f                	push   $0x3f
  10594f:	e9 6c fa ff ff       	jmp    1053c0 <alltraps>

00105954 <vector64>:
  105954:	6a 00                	push   $0x0
  105956:	6a 40                	push   $0x40
  105958:	e9 63 fa ff ff       	jmp    1053c0 <alltraps>

0010595d <vector65>:
  10595d:	6a 00                	push   $0x0
  10595f:	6a 41                	push   $0x41
  105961:	e9 5a fa ff ff       	jmp    1053c0 <alltraps>

00105966 <vector66>:
  105966:	6a 00                	push   $0x0
  105968:	6a 42                	push   $0x42
  10596a:	e9 51 fa ff ff       	jmp    1053c0 <alltraps>

0010596f <vector67>:
  10596f:	6a 00                	push   $0x0
  105971:	6a 43                	push   $0x43
  105973:	e9 48 fa ff ff       	jmp    1053c0 <alltraps>

00105978 <vector68>:
  105978:	6a 00                	push   $0x0
  10597a:	6a 44                	push   $0x44
  10597c:	e9 3f fa ff ff       	jmp    1053c0 <alltraps>

00105981 <vector69>:
  105981:	6a 00                	push   $0x0
  105983:	6a 45                	push   $0x45
  105985:	e9 36 fa ff ff       	jmp    1053c0 <alltraps>

0010598a <vector70>:
  10598a:	6a 00                	push   $0x0
  10598c:	6a 46                	push   $0x46
  10598e:	e9 2d fa ff ff       	jmp    1053c0 <alltraps>

00105993 <vector71>:
  105993:	6a 00                	push   $0x0
  105995:	6a 47                	push   $0x47
  105997:	e9 24 fa ff ff       	jmp    1053c0 <alltraps>

0010599c <vector72>:
  10599c:	6a 00                	push   $0x0
  10599e:	6a 48                	push   $0x48
  1059a0:	e9 1b fa ff ff       	jmp    1053c0 <alltraps>

001059a5 <vector73>:
  1059a5:	6a 00                	push   $0x0
  1059a7:	6a 49                	push   $0x49
  1059a9:	e9 12 fa ff ff       	jmp    1053c0 <alltraps>

001059ae <vector74>:
  1059ae:	6a 00                	push   $0x0
  1059b0:	6a 4a                	push   $0x4a
  1059b2:	e9 09 fa ff ff       	jmp    1053c0 <alltraps>

001059b7 <vector75>:
  1059b7:	6a 00                	push   $0x0
  1059b9:	6a 4b                	push   $0x4b
  1059bb:	e9 00 fa ff ff       	jmp    1053c0 <alltraps>

001059c0 <vector76>:
  1059c0:	6a 00                	push   $0x0
  1059c2:	6a 4c                	push   $0x4c
  1059c4:	e9 f7 f9 ff ff       	jmp    1053c0 <alltraps>

001059c9 <vector77>:
  1059c9:	6a 00                	push   $0x0
  1059cb:	6a 4d                	push   $0x4d
  1059cd:	e9 ee f9 ff ff       	jmp    1053c0 <alltraps>

001059d2 <vector78>:
  1059d2:	6a 00                	push   $0x0
  1059d4:	6a 4e                	push   $0x4e
  1059d6:	e9 e5 f9 ff ff       	jmp    1053c0 <alltraps>

001059db <vector79>:
  1059db:	6a 00                	push   $0x0
  1059dd:	6a 4f                	push   $0x4f
  1059df:	e9 dc f9 ff ff       	jmp    1053c0 <alltraps>

001059e4 <vector80>:
  1059e4:	6a 00                	push   $0x0
  1059e6:	6a 50                	push   $0x50
  1059e8:	e9 d3 f9 ff ff       	jmp    1053c0 <alltraps>

001059ed <vector81>:
  1059ed:	6a 00                	push   $0x0
  1059ef:	6a 51                	push   $0x51
  1059f1:	e9 ca f9 ff ff       	jmp    1053c0 <alltraps>

001059f6 <vector82>:
  1059f6:	6a 00                	push   $0x0
  1059f8:	6a 52                	push   $0x52
  1059fa:	e9 c1 f9 ff ff       	jmp    1053c0 <alltraps>

001059ff <vector83>:
  1059ff:	6a 00                	push   $0x0
  105a01:	6a 53                	push   $0x53
  105a03:	e9 b8 f9 ff ff       	jmp    1053c0 <alltraps>

00105a08 <vector84>:
  105a08:	6a 00                	push   $0x0
  105a0a:	6a 54                	push   $0x54
  105a0c:	e9 af f9 ff ff       	jmp    1053c0 <alltraps>

00105a11 <vector85>:
  105a11:	6a 00                	push   $0x0
  105a13:	6a 55                	push   $0x55
  105a15:	e9 a6 f9 ff ff       	jmp    1053c0 <alltraps>

00105a1a <vector86>:
  105a1a:	6a 00                	push   $0x0
  105a1c:	6a 56                	push   $0x56
  105a1e:	e9 9d f9 ff ff       	jmp    1053c0 <alltraps>

00105a23 <vector87>:
  105a23:	6a 00                	push   $0x0
  105a25:	6a 57                	push   $0x57
  105a27:	e9 94 f9 ff ff       	jmp    1053c0 <alltraps>

00105a2c <vector88>:
  105a2c:	6a 00                	push   $0x0
  105a2e:	6a 58                	push   $0x58
  105a30:	e9 8b f9 ff ff       	jmp    1053c0 <alltraps>

00105a35 <vector89>:
  105a35:	6a 00                	push   $0x0
  105a37:	6a 59                	push   $0x59
  105a39:	e9 82 f9 ff ff       	jmp    1053c0 <alltraps>

00105a3e <vector90>:
  105a3e:	6a 00                	push   $0x0
  105a40:	6a 5a                	push   $0x5a
  105a42:	e9 79 f9 ff ff       	jmp    1053c0 <alltraps>

00105a47 <vector91>:
  105a47:	6a 00                	push   $0x0
  105a49:	6a 5b                	push   $0x5b
  105a4b:	e9 70 f9 ff ff       	jmp    1053c0 <alltraps>

00105a50 <vector92>:
  105a50:	6a 00                	push   $0x0
  105a52:	6a 5c                	push   $0x5c
  105a54:	e9 67 f9 ff ff       	jmp    1053c0 <alltraps>

00105a59 <vector93>:
  105a59:	6a 00                	push   $0x0
  105a5b:	6a 5d                	push   $0x5d
  105a5d:	e9 5e f9 ff ff       	jmp    1053c0 <alltraps>

00105a62 <vector94>:
  105a62:	6a 00                	push   $0x0
  105a64:	6a 5e                	push   $0x5e
  105a66:	e9 55 f9 ff ff       	jmp    1053c0 <alltraps>

00105a6b <vector95>:
  105a6b:	6a 00                	push   $0x0
  105a6d:	6a 5f                	push   $0x5f
  105a6f:	e9 4c f9 ff ff       	jmp    1053c0 <alltraps>

00105a74 <vector96>:
  105a74:	6a 00                	push   $0x0
  105a76:	6a 60                	push   $0x60
  105a78:	e9 43 f9 ff ff       	jmp    1053c0 <alltraps>

00105a7d <vector97>:
  105a7d:	6a 00                	push   $0x0
  105a7f:	6a 61                	push   $0x61
  105a81:	e9 3a f9 ff ff       	jmp    1053c0 <alltraps>

00105a86 <vector98>:
  105a86:	6a 00                	push   $0x0
  105a88:	6a 62                	push   $0x62
  105a8a:	e9 31 f9 ff ff       	jmp    1053c0 <alltraps>

00105a8f <vector99>:
  105a8f:	6a 00                	push   $0x0
  105a91:	6a 63                	push   $0x63
  105a93:	e9 28 f9 ff ff       	jmp    1053c0 <alltraps>

00105a98 <vector100>:
  105a98:	6a 00                	push   $0x0
  105a9a:	6a 64                	push   $0x64
  105a9c:	e9 1f f9 ff ff       	jmp    1053c0 <alltraps>

00105aa1 <vector101>:
  105aa1:	6a 00                	push   $0x0
  105aa3:	6a 65                	push   $0x65
  105aa5:	e9 16 f9 ff ff       	jmp    1053c0 <alltraps>

00105aaa <vector102>:
  105aaa:	6a 00                	push   $0x0
  105aac:	6a 66                	push   $0x66
  105aae:	e9 0d f9 ff ff       	jmp    1053c0 <alltraps>

00105ab3 <vector103>:
  105ab3:	6a 00                	push   $0x0
  105ab5:	6a 67                	push   $0x67
  105ab7:	e9 04 f9 ff ff       	jmp    1053c0 <alltraps>

00105abc <vector104>:
  105abc:	6a 00                	push   $0x0
  105abe:	6a 68                	push   $0x68
  105ac0:	e9 fb f8 ff ff       	jmp    1053c0 <alltraps>

00105ac5 <vector105>:
  105ac5:	6a 00                	push   $0x0
  105ac7:	6a 69                	push   $0x69
  105ac9:	e9 f2 f8 ff ff       	jmp    1053c0 <alltraps>

00105ace <vector106>:
  105ace:	6a 00                	push   $0x0
  105ad0:	6a 6a                	push   $0x6a
  105ad2:	e9 e9 f8 ff ff       	jmp    1053c0 <alltraps>

00105ad7 <vector107>:
  105ad7:	6a 00                	push   $0x0
  105ad9:	6a 6b                	push   $0x6b
  105adb:	e9 e0 f8 ff ff       	jmp    1053c0 <alltraps>

00105ae0 <vector108>:
  105ae0:	6a 00                	push   $0x0
  105ae2:	6a 6c                	push   $0x6c
  105ae4:	e9 d7 f8 ff ff       	jmp    1053c0 <alltraps>

00105ae9 <vector109>:
  105ae9:	6a 00                	push   $0x0
  105aeb:	6a 6d                	push   $0x6d
  105aed:	e9 ce f8 ff ff       	jmp    1053c0 <alltraps>

00105af2 <vector110>:
  105af2:	6a 00                	push   $0x0
  105af4:	6a 6e                	push   $0x6e
  105af6:	e9 c5 f8 ff ff       	jmp    1053c0 <alltraps>

00105afb <vector111>:
  105afb:	6a 00                	push   $0x0
  105afd:	6a 6f                	push   $0x6f
  105aff:	e9 bc f8 ff ff       	jmp    1053c0 <alltraps>

00105b04 <vector112>:
  105b04:	6a 00                	push   $0x0
  105b06:	6a 70                	push   $0x70
  105b08:	e9 b3 f8 ff ff       	jmp    1053c0 <alltraps>

00105b0d <vector113>:
  105b0d:	6a 00                	push   $0x0
  105b0f:	6a 71                	push   $0x71
  105b11:	e9 aa f8 ff ff       	jmp    1053c0 <alltraps>

00105b16 <vector114>:
  105b16:	6a 00                	push   $0x0
  105b18:	6a 72                	push   $0x72
  105b1a:	e9 a1 f8 ff ff       	jmp    1053c0 <alltraps>

00105b1f <vector115>:
  105b1f:	6a 00                	push   $0x0
  105b21:	6a 73                	push   $0x73
  105b23:	e9 98 f8 ff ff       	jmp    1053c0 <alltraps>

00105b28 <vector116>:
  105b28:	6a 00                	push   $0x0
  105b2a:	6a 74                	push   $0x74
  105b2c:	e9 8f f8 ff ff       	jmp    1053c0 <alltraps>

00105b31 <vector117>:
  105b31:	6a 00                	push   $0x0
  105b33:	6a 75                	push   $0x75
  105b35:	e9 86 f8 ff ff       	jmp    1053c0 <alltraps>

00105b3a <vector118>:
  105b3a:	6a 00                	push   $0x0
  105b3c:	6a 76                	push   $0x76
  105b3e:	e9 7d f8 ff ff       	jmp    1053c0 <alltraps>

00105b43 <vector119>:
  105b43:	6a 00                	push   $0x0
  105b45:	6a 77                	push   $0x77
  105b47:	e9 74 f8 ff ff       	jmp    1053c0 <alltraps>

00105b4c <vector120>:
  105b4c:	6a 00                	push   $0x0
  105b4e:	6a 78                	push   $0x78
  105b50:	e9 6b f8 ff ff       	jmp    1053c0 <alltraps>

00105b55 <vector121>:
  105b55:	6a 00                	push   $0x0
  105b57:	6a 79                	push   $0x79
  105b59:	e9 62 f8 ff ff       	jmp    1053c0 <alltraps>

00105b5e <vector122>:
  105b5e:	6a 00                	push   $0x0
  105b60:	6a 7a                	push   $0x7a
  105b62:	e9 59 f8 ff ff       	jmp    1053c0 <alltraps>

00105b67 <vector123>:
  105b67:	6a 00                	push   $0x0
  105b69:	6a 7b                	push   $0x7b
  105b6b:	e9 50 f8 ff ff       	jmp    1053c0 <alltraps>

00105b70 <vector124>:
  105b70:	6a 00                	push   $0x0
  105b72:	6a 7c                	push   $0x7c
  105b74:	e9 47 f8 ff ff       	jmp    1053c0 <alltraps>

00105b79 <vector125>:
  105b79:	6a 00                	push   $0x0
  105b7b:	6a 7d                	push   $0x7d
  105b7d:	e9 3e f8 ff ff       	jmp    1053c0 <alltraps>

00105b82 <vector126>:
  105b82:	6a 00                	push   $0x0
  105b84:	6a 7e                	push   $0x7e
  105b86:	e9 35 f8 ff ff       	jmp    1053c0 <alltraps>

00105b8b <vector127>:
  105b8b:	6a 00                	push   $0x0
  105b8d:	6a 7f                	push   $0x7f
  105b8f:	e9 2c f8 ff ff       	jmp    1053c0 <alltraps>

00105b94 <vector128>:
  105b94:	6a 00                	push   $0x0
  105b96:	68 80 00 00 00       	push   $0x80
  105b9b:	e9 20 f8 ff ff       	jmp    1053c0 <alltraps>

00105ba0 <vector129>:
  105ba0:	6a 00                	push   $0x0
  105ba2:	68 81 00 00 00       	push   $0x81
  105ba7:	e9 14 f8 ff ff       	jmp    1053c0 <alltraps>

00105bac <vector130>:
  105bac:	6a 00                	push   $0x0
  105bae:	68 82 00 00 00       	push   $0x82
  105bb3:	e9 08 f8 ff ff       	jmp    1053c0 <alltraps>

00105bb8 <vector131>:
  105bb8:	6a 00                	push   $0x0
  105bba:	68 83 00 00 00       	push   $0x83
  105bbf:	e9 fc f7 ff ff       	jmp    1053c0 <alltraps>

00105bc4 <vector132>:
  105bc4:	6a 00                	push   $0x0
  105bc6:	68 84 00 00 00       	push   $0x84
  105bcb:	e9 f0 f7 ff ff       	jmp    1053c0 <alltraps>

00105bd0 <vector133>:
  105bd0:	6a 00                	push   $0x0
  105bd2:	68 85 00 00 00       	push   $0x85
  105bd7:	e9 e4 f7 ff ff       	jmp    1053c0 <alltraps>

00105bdc <vector134>:
  105bdc:	6a 00                	push   $0x0
  105bde:	68 86 00 00 00       	push   $0x86
  105be3:	e9 d8 f7 ff ff       	jmp    1053c0 <alltraps>

00105be8 <vector135>:
  105be8:	6a 00                	push   $0x0
  105bea:	68 87 00 00 00       	push   $0x87
  105bef:	e9 cc f7 ff ff       	jmp    1053c0 <alltraps>

00105bf4 <vector136>:
  105bf4:	6a 00                	push   $0x0
  105bf6:	68 88 00 00 00       	push   $0x88
  105bfb:	e9 c0 f7 ff ff       	jmp    1053c0 <alltraps>

00105c00 <vector137>:
  105c00:	6a 00                	push   $0x0
  105c02:	68 89 00 00 00       	push   $0x89
  105c07:	e9 b4 f7 ff ff       	jmp    1053c0 <alltraps>

00105c0c <vector138>:
  105c0c:	6a 00                	push   $0x0
  105c0e:	68 8a 00 00 00       	push   $0x8a
  105c13:	e9 a8 f7 ff ff       	jmp    1053c0 <alltraps>

00105c18 <vector139>:
  105c18:	6a 00                	push   $0x0
  105c1a:	68 8b 00 00 00       	push   $0x8b
  105c1f:	e9 9c f7 ff ff       	jmp    1053c0 <alltraps>

00105c24 <vector140>:
  105c24:	6a 00                	push   $0x0
  105c26:	68 8c 00 00 00       	push   $0x8c
  105c2b:	e9 90 f7 ff ff       	jmp    1053c0 <alltraps>

00105c30 <vector141>:
  105c30:	6a 00                	push   $0x0
  105c32:	68 8d 00 00 00       	push   $0x8d
  105c37:	e9 84 f7 ff ff       	jmp    1053c0 <alltraps>

00105c3c <vector142>:
  105c3c:	6a 00                	push   $0x0
  105c3e:	68 8e 00 00 00       	push   $0x8e
  105c43:	e9 78 f7 ff ff       	jmp    1053c0 <alltraps>

00105c48 <vector143>:
  105c48:	6a 00                	push   $0x0
  105c4a:	68 8f 00 00 00       	push   $0x8f
  105c4f:	e9 6c f7 ff ff       	jmp    1053c0 <alltraps>

00105c54 <vector144>:
  105c54:	6a 00                	push   $0x0
  105c56:	68 90 00 00 00       	push   $0x90
  105c5b:	e9 60 f7 ff ff       	jmp    1053c0 <alltraps>

00105c60 <vector145>:
  105c60:	6a 00                	push   $0x0
  105c62:	68 91 00 00 00       	push   $0x91
  105c67:	e9 54 f7 ff ff       	jmp    1053c0 <alltraps>

00105c6c <vector146>:
  105c6c:	6a 00                	push   $0x0
  105c6e:	68 92 00 00 00       	push   $0x92
  105c73:	e9 48 f7 ff ff       	jmp    1053c0 <alltraps>

00105c78 <vector147>:
  105c78:	6a 00                	push   $0x0
  105c7a:	68 93 00 00 00       	push   $0x93
  105c7f:	e9 3c f7 ff ff       	jmp    1053c0 <alltraps>

00105c84 <vector148>:
  105c84:	6a 00                	push   $0x0
  105c86:	68 94 00 00 00       	push   $0x94
  105c8b:	e9 30 f7 ff ff       	jmp    1053c0 <alltraps>

00105c90 <vector149>:
  105c90:	6a 00                	push   $0x0
  105c92:	68 95 00 00 00       	push   $0x95
  105c97:	e9 24 f7 ff ff       	jmp    1053c0 <alltraps>

00105c9c <vector150>:
  105c9c:	6a 00                	push   $0x0
  105c9e:	68 96 00 00 00       	push   $0x96
  105ca3:	e9 18 f7 ff ff       	jmp    1053c0 <alltraps>

00105ca8 <vector151>:
  105ca8:	6a 00                	push   $0x0
  105caa:	68 97 00 00 00       	push   $0x97
  105caf:	e9 0c f7 ff ff       	jmp    1053c0 <alltraps>

00105cb4 <vector152>:
  105cb4:	6a 00                	push   $0x0
  105cb6:	68 98 00 00 00       	push   $0x98
  105cbb:	e9 00 f7 ff ff       	jmp    1053c0 <alltraps>

00105cc0 <vector153>:
  105cc0:	6a 00                	push   $0x0
  105cc2:	68 99 00 00 00       	push   $0x99
  105cc7:	e9 f4 f6 ff ff       	jmp    1053c0 <alltraps>

00105ccc <vector154>:
  105ccc:	6a 00                	push   $0x0
  105cce:	68 9a 00 00 00       	push   $0x9a
  105cd3:	e9 e8 f6 ff ff       	jmp    1053c0 <alltraps>

00105cd8 <vector155>:
  105cd8:	6a 00                	push   $0x0
  105cda:	68 9b 00 00 00       	push   $0x9b
  105cdf:	e9 dc f6 ff ff       	jmp    1053c0 <alltraps>

00105ce4 <vector156>:
  105ce4:	6a 00                	push   $0x0
  105ce6:	68 9c 00 00 00       	push   $0x9c
  105ceb:	e9 d0 f6 ff ff       	jmp    1053c0 <alltraps>

00105cf0 <vector157>:
  105cf0:	6a 00                	push   $0x0
  105cf2:	68 9d 00 00 00       	push   $0x9d
  105cf7:	e9 c4 f6 ff ff       	jmp    1053c0 <alltraps>

00105cfc <vector158>:
  105cfc:	6a 00                	push   $0x0
  105cfe:	68 9e 00 00 00       	push   $0x9e
  105d03:	e9 b8 f6 ff ff       	jmp    1053c0 <alltraps>

00105d08 <vector159>:
  105d08:	6a 00                	push   $0x0
  105d0a:	68 9f 00 00 00       	push   $0x9f
  105d0f:	e9 ac f6 ff ff       	jmp    1053c0 <alltraps>

00105d14 <vector160>:
  105d14:	6a 00                	push   $0x0
  105d16:	68 a0 00 00 00       	push   $0xa0
  105d1b:	e9 a0 f6 ff ff       	jmp    1053c0 <alltraps>

00105d20 <vector161>:
  105d20:	6a 00                	push   $0x0
  105d22:	68 a1 00 00 00       	push   $0xa1
  105d27:	e9 94 f6 ff ff       	jmp    1053c0 <alltraps>

00105d2c <vector162>:
  105d2c:	6a 00                	push   $0x0
  105d2e:	68 a2 00 00 00       	push   $0xa2
  105d33:	e9 88 f6 ff ff       	jmp    1053c0 <alltraps>

00105d38 <vector163>:
  105d38:	6a 00                	push   $0x0
  105d3a:	68 a3 00 00 00       	push   $0xa3
  105d3f:	e9 7c f6 ff ff       	jmp    1053c0 <alltraps>

00105d44 <vector164>:
  105d44:	6a 00                	push   $0x0
  105d46:	68 a4 00 00 00       	push   $0xa4
  105d4b:	e9 70 f6 ff ff       	jmp    1053c0 <alltraps>

00105d50 <vector165>:
  105d50:	6a 00                	push   $0x0
  105d52:	68 a5 00 00 00       	push   $0xa5
  105d57:	e9 64 f6 ff ff       	jmp    1053c0 <alltraps>

00105d5c <vector166>:
  105d5c:	6a 00                	push   $0x0
  105d5e:	68 a6 00 00 00       	push   $0xa6
  105d63:	e9 58 f6 ff ff       	jmp    1053c0 <alltraps>

00105d68 <vector167>:
  105d68:	6a 00                	push   $0x0
  105d6a:	68 a7 00 00 00       	push   $0xa7
  105d6f:	e9 4c f6 ff ff       	jmp    1053c0 <alltraps>

00105d74 <vector168>:
  105d74:	6a 00                	push   $0x0
  105d76:	68 a8 00 00 00       	push   $0xa8
  105d7b:	e9 40 f6 ff ff       	jmp    1053c0 <alltraps>

00105d80 <vector169>:
  105d80:	6a 00                	push   $0x0
  105d82:	68 a9 00 00 00       	push   $0xa9
  105d87:	e9 34 f6 ff ff       	jmp    1053c0 <alltraps>

00105d8c <vector170>:
  105d8c:	6a 00                	push   $0x0
  105d8e:	68 aa 00 00 00       	push   $0xaa
  105d93:	e9 28 f6 ff ff       	jmp    1053c0 <alltraps>

00105d98 <vector171>:
  105d98:	6a 00                	push   $0x0
  105d9a:	68 ab 00 00 00       	push   $0xab
  105d9f:	e9 1c f6 ff ff       	jmp    1053c0 <alltraps>

00105da4 <vector172>:
  105da4:	6a 00                	push   $0x0
  105da6:	68 ac 00 00 00       	push   $0xac
  105dab:	e9 10 f6 ff ff       	jmp    1053c0 <alltraps>

00105db0 <vector173>:
  105db0:	6a 00                	push   $0x0
  105db2:	68 ad 00 00 00       	push   $0xad
  105db7:	e9 04 f6 ff ff       	jmp    1053c0 <alltraps>

00105dbc <vector174>:
  105dbc:	6a 00                	push   $0x0
  105dbe:	68 ae 00 00 00       	push   $0xae
  105dc3:	e9 f8 f5 ff ff       	jmp    1053c0 <alltraps>

00105dc8 <vector175>:
  105dc8:	6a 00                	push   $0x0
  105dca:	68 af 00 00 00       	push   $0xaf
  105dcf:	e9 ec f5 ff ff       	jmp    1053c0 <alltraps>

00105dd4 <vector176>:
  105dd4:	6a 00                	push   $0x0
  105dd6:	68 b0 00 00 00       	push   $0xb0
  105ddb:	e9 e0 f5 ff ff       	jmp    1053c0 <alltraps>

00105de0 <vector177>:
  105de0:	6a 00                	push   $0x0
  105de2:	68 b1 00 00 00       	push   $0xb1
  105de7:	e9 d4 f5 ff ff       	jmp    1053c0 <alltraps>

00105dec <vector178>:
  105dec:	6a 00                	push   $0x0
  105dee:	68 b2 00 00 00       	push   $0xb2
  105df3:	e9 c8 f5 ff ff       	jmp    1053c0 <alltraps>

00105df8 <vector179>:
  105df8:	6a 00                	push   $0x0
  105dfa:	68 b3 00 00 00       	push   $0xb3
  105dff:	e9 bc f5 ff ff       	jmp    1053c0 <alltraps>

00105e04 <vector180>:
  105e04:	6a 00                	push   $0x0
  105e06:	68 b4 00 00 00       	push   $0xb4
  105e0b:	e9 b0 f5 ff ff       	jmp    1053c0 <alltraps>

00105e10 <vector181>:
  105e10:	6a 00                	push   $0x0
  105e12:	68 b5 00 00 00       	push   $0xb5
  105e17:	e9 a4 f5 ff ff       	jmp    1053c0 <alltraps>

00105e1c <vector182>:
  105e1c:	6a 00                	push   $0x0
  105e1e:	68 b6 00 00 00       	push   $0xb6
  105e23:	e9 98 f5 ff ff       	jmp    1053c0 <alltraps>

00105e28 <vector183>:
  105e28:	6a 00                	push   $0x0
  105e2a:	68 b7 00 00 00       	push   $0xb7
  105e2f:	e9 8c f5 ff ff       	jmp    1053c0 <alltraps>

00105e34 <vector184>:
  105e34:	6a 00                	push   $0x0
  105e36:	68 b8 00 00 00       	push   $0xb8
  105e3b:	e9 80 f5 ff ff       	jmp    1053c0 <alltraps>

00105e40 <vector185>:
  105e40:	6a 00                	push   $0x0
  105e42:	68 b9 00 00 00       	push   $0xb9
  105e47:	e9 74 f5 ff ff       	jmp    1053c0 <alltraps>

00105e4c <vector186>:
  105e4c:	6a 00                	push   $0x0
  105e4e:	68 ba 00 00 00       	push   $0xba
  105e53:	e9 68 f5 ff ff       	jmp    1053c0 <alltraps>

00105e58 <vector187>:
  105e58:	6a 00                	push   $0x0
  105e5a:	68 bb 00 00 00       	push   $0xbb
  105e5f:	e9 5c f5 ff ff       	jmp    1053c0 <alltraps>

00105e64 <vector188>:
  105e64:	6a 00                	push   $0x0
  105e66:	68 bc 00 00 00       	push   $0xbc
  105e6b:	e9 50 f5 ff ff       	jmp    1053c0 <alltraps>

00105e70 <vector189>:
  105e70:	6a 00                	push   $0x0
  105e72:	68 bd 00 00 00       	push   $0xbd
  105e77:	e9 44 f5 ff ff       	jmp    1053c0 <alltraps>

00105e7c <vector190>:
  105e7c:	6a 00                	push   $0x0
  105e7e:	68 be 00 00 00       	push   $0xbe
  105e83:	e9 38 f5 ff ff       	jmp    1053c0 <alltraps>

00105e88 <vector191>:
  105e88:	6a 00                	push   $0x0
  105e8a:	68 bf 00 00 00       	push   $0xbf
  105e8f:	e9 2c f5 ff ff       	jmp    1053c0 <alltraps>

00105e94 <vector192>:
  105e94:	6a 00                	push   $0x0
  105e96:	68 c0 00 00 00       	push   $0xc0
  105e9b:	e9 20 f5 ff ff       	jmp    1053c0 <alltraps>

00105ea0 <vector193>:
  105ea0:	6a 00                	push   $0x0
  105ea2:	68 c1 00 00 00       	push   $0xc1
  105ea7:	e9 14 f5 ff ff       	jmp    1053c0 <alltraps>

00105eac <vector194>:
  105eac:	6a 00                	push   $0x0
  105eae:	68 c2 00 00 00       	push   $0xc2
  105eb3:	e9 08 f5 ff ff       	jmp    1053c0 <alltraps>

00105eb8 <vector195>:
  105eb8:	6a 00                	push   $0x0
  105eba:	68 c3 00 00 00       	push   $0xc3
  105ebf:	e9 fc f4 ff ff       	jmp    1053c0 <alltraps>

00105ec4 <vector196>:
  105ec4:	6a 00                	push   $0x0
  105ec6:	68 c4 00 00 00       	push   $0xc4
  105ecb:	e9 f0 f4 ff ff       	jmp    1053c0 <alltraps>

00105ed0 <vector197>:
  105ed0:	6a 00                	push   $0x0
  105ed2:	68 c5 00 00 00       	push   $0xc5
  105ed7:	e9 e4 f4 ff ff       	jmp    1053c0 <alltraps>

00105edc <vector198>:
  105edc:	6a 00                	push   $0x0
  105ede:	68 c6 00 00 00       	push   $0xc6
  105ee3:	e9 d8 f4 ff ff       	jmp    1053c0 <alltraps>

00105ee8 <vector199>:
  105ee8:	6a 00                	push   $0x0
  105eea:	68 c7 00 00 00       	push   $0xc7
  105eef:	e9 cc f4 ff ff       	jmp    1053c0 <alltraps>

00105ef4 <vector200>:
  105ef4:	6a 00                	push   $0x0
  105ef6:	68 c8 00 00 00       	push   $0xc8
  105efb:	e9 c0 f4 ff ff       	jmp    1053c0 <alltraps>

00105f00 <vector201>:
  105f00:	6a 00                	push   $0x0
  105f02:	68 c9 00 00 00       	push   $0xc9
  105f07:	e9 b4 f4 ff ff       	jmp    1053c0 <alltraps>

00105f0c <vector202>:
  105f0c:	6a 00                	push   $0x0
  105f0e:	68 ca 00 00 00       	push   $0xca
  105f13:	e9 a8 f4 ff ff       	jmp    1053c0 <alltraps>

00105f18 <vector203>:
  105f18:	6a 00                	push   $0x0
  105f1a:	68 cb 00 00 00       	push   $0xcb
  105f1f:	e9 9c f4 ff ff       	jmp    1053c0 <alltraps>

00105f24 <vector204>:
  105f24:	6a 00                	push   $0x0
  105f26:	68 cc 00 00 00       	push   $0xcc
  105f2b:	e9 90 f4 ff ff       	jmp    1053c0 <alltraps>

00105f30 <vector205>:
  105f30:	6a 00                	push   $0x0
  105f32:	68 cd 00 00 00       	push   $0xcd
  105f37:	e9 84 f4 ff ff       	jmp    1053c0 <alltraps>

00105f3c <vector206>:
  105f3c:	6a 00                	push   $0x0
  105f3e:	68 ce 00 00 00       	push   $0xce
  105f43:	e9 78 f4 ff ff       	jmp    1053c0 <alltraps>

00105f48 <vector207>:
  105f48:	6a 00                	push   $0x0
  105f4a:	68 cf 00 00 00       	push   $0xcf
  105f4f:	e9 6c f4 ff ff       	jmp    1053c0 <alltraps>

00105f54 <vector208>:
  105f54:	6a 00                	push   $0x0
  105f56:	68 d0 00 00 00       	push   $0xd0
  105f5b:	e9 60 f4 ff ff       	jmp    1053c0 <alltraps>

00105f60 <vector209>:
  105f60:	6a 00                	push   $0x0
  105f62:	68 d1 00 00 00       	push   $0xd1
  105f67:	e9 54 f4 ff ff       	jmp    1053c0 <alltraps>

00105f6c <vector210>:
  105f6c:	6a 00                	push   $0x0
  105f6e:	68 d2 00 00 00       	push   $0xd2
  105f73:	e9 48 f4 ff ff       	jmp    1053c0 <alltraps>

00105f78 <vector211>:
  105f78:	6a 00                	push   $0x0
  105f7a:	68 d3 00 00 00       	push   $0xd3
  105f7f:	e9 3c f4 ff ff       	jmp    1053c0 <alltraps>

00105f84 <vector212>:
  105f84:	6a 00                	push   $0x0
  105f86:	68 d4 00 00 00       	push   $0xd4
  105f8b:	e9 30 f4 ff ff       	jmp    1053c0 <alltraps>

00105f90 <vector213>:
  105f90:	6a 00                	push   $0x0
  105f92:	68 d5 00 00 00       	push   $0xd5
  105f97:	e9 24 f4 ff ff       	jmp    1053c0 <alltraps>

00105f9c <vector214>:
  105f9c:	6a 00                	push   $0x0
  105f9e:	68 d6 00 00 00       	push   $0xd6
  105fa3:	e9 18 f4 ff ff       	jmp    1053c0 <alltraps>

00105fa8 <vector215>:
  105fa8:	6a 00                	push   $0x0
  105faa:	68 d7 00 00 00       	push   $0xd7
  105faf:	e9 0c f4 ff ff       	jmp    1053c0 <alltraps>

00105fb4 <vector216>:
  105fb4:	6a 00                	push   $0x0
  105fb6:	68 d8 00 00 00       	push   $0xd8
  105fbb:	e9 00 f4 ff ff       	jmp    1053c0 <alltraps>

00105fc0 <vector217>:
  105fc0:	6a 00                	push   $0x0
  105fc2:	68 d9 00 00 00       	push   $0xd9
  105fc7:	e9 f4 f3 ff ff       	jmp    1053c0 <alltraps>

00105fcc <vector218>:
  105fcc:	6a 00                	push   $0x0
  105fce:	68 da 00 00 00       	push   $0xda
  105fd3:	e9 e8 f3 ff ff       	jmp    1053c0 <alltraps>

00105fd8 <vector219>:
  105fd8:	6a 00                	push   $0x0
  105fda:	68 db 00 00 00       	push   $0xdb
  105fdf:	e9 dc f3 ff ff       	jmp    1053c0 <alltraps>

00105fe4 <vector220>:
  105fe4:	6a 00                	push   $0x0
  105fe6:	68 dc 00 00 00       	push   $0xdc
  105feb:	e9 d0 f3 ff ff       	jmp    1053c0 <alltraps>

00105ff0 <vector221>:
  105ff0:	6a 00                	push   $0x0
  105ff2:	68 dd 00 00 00       	push   $0xdd
  105ff7:	e9 c4 f3 ff ff       	jmp    1053c0 <alltraps>

00105ffc <vector222>:
  105ffc:	6a 00                	push   $0x0
  105ffe:	68 de 00 00 00       	push   $0xde
  106003:	e9 b8 f3 ff ff       	jmp    1053c0 <alltraps>

00106008 <vector223>:
  106008:	6a 00                	push   $0x0
  10600a:	68 df 00 00 00       	push   $0xdf
  10600f:	e9 ac f3 ff ff       	jmp    1053c0 <alltraps>

00106014 <vector224>:
  106014:	6a 00                	push   $0x0
  106016:	68 e0 00 00 00       	push   $0xe0
  10601b:	e9 a0 f3 ff ff       	jmp    1053c0 <alltraps>

00106020 <vector225>:
  106020:	6a 00                	push   $0x0
  106022:	68 e1 00 00 00       	push   $0xe1
  106027:	e9 94 f3 ff ff       	jmp    1053c0 <alltraps>

0010602c <vector226>:
  10602c:	6a 00                	push   $0x0
  10602e:	68 e2 00 00 00       	push   $0xe2
  106033:	e9 88 f3 ff ff       	jmp    1053c0 <alltraps>

00106038 <vector227>:
  106038:	6a 00                	push   $0x0
  10603a:	68 e3 00 00 00       	push   $0xe3
  10603f:	e9 7c f3 ff ff       	jmp    1053c0 <alltraps>

00106044 <vector228>:
  106044:	6a 00                	push   $0x0
  106046:	68 e4 00 00 00       	push   $0xe4
  10604b:	e9 70 f3 ff ff       	jmp    1053c0 <alltraps>

00106050 <vector229>:
  106050:	6a 00                	push   $0x0
  106052:	68 e5 00 00 00       	push   $0xe5
  106057:	e9 64 f3 ff ff       	jmp    1053c0 <alltraps>

0010605c <vector230>:
  10605c:	6a 00                	push   $0x0
  10605e:	68 e6 00 00 00       	push   $0xe6
  106063:	e9 58 f3 ff ff       	jmp    1053c0 <alltraps>

00106068 <vector231>:
  106068:	6a 00                	push   $0x0
  10606a:	68 e7 00 00 00       	push   $0xe7
  10606f:	e9 4c f3 ff ff       	jmp    1053c0 <alltraps>

00106074 <vector232>:
  106074:	6a 00                	push   $0x0
  106076:	68 e8 00 00 00       	push   $0xe8
  10607b:	e9 40 f3 ff ff       	jmp    1053c0 <alltraps>

00106080 <vector233>:
  106080:	6a 00                	push   $0x0
  106082:	68 e9 00 00 00       	push   $0xe9
  106087:	e9 34 f3 ff ff       	jmp    1053c0 <alltraps>

0010608c <vector234>:
  10608c:	6a 00                	push   $0x0
  10608e:	68 ea 00 00 00       	push   $0xea
  106093:	e9 28 f3 ff ff       	jmp    1053c0 <alltraps>

00106098 <vector235>:
  106098:	6a 00                	push   $0x0
  10609a:	68 eb 00 00 00       	push   $0xeb
  10609f:	e9 1c f3 ff ff       	jmp    1053c0 <alltraps>

001060a4 <vector236>:
  1060a4:	6a 00                	push   $0x0
  1060a6:	68 ec 00 00 00       	push   $0xec
  1060ab:	e9 10 f3 ff ff       	jmp    1053c0 <alltraps>

001060b0 <vector237>:
  1060b0:	6a 00                	push   $0x0
  1060b2:	68 ed 00 00 00       	push   $0xed
  1060b7:	e9 04 f3 ff ff       	jmp    1053c0 <alltraps>

001060bc <vector238>:
  1060bc:	6a 00                	push   $0x0
  1060be:	68 ee 00 00 00       	push   $0xee
  1060c3:	e9 f8 f2 ff ff       	jmp    1053c0 <alltraps>

001060c8 <vector239>:
  1060c8:	6a 00                	push   $0x0
  1060ca:	68 ef 00 00 00       	push   $0xef
  1060cf:	e9 ec f2 ff ff       	jmp    1053c0 <alltraps>

001060d4 <vector240>:
  1060d4:	6a 00                	push   $0x0
  1060d6:	68 f0 00 00 00       	push   $0xf0
  1060db:	e9 e0 f2 ff ff       	jmp    1053c0 <alltraps>

001060e0 <vector241>:
  1060e0:	6a 00                	push   $0x0
  1060e2:	68 f1 00 00 00       	push   $0xf1
  1060e7:	e9 d4 f2 ff ff       	jmp    1053c0 <alltraps>

001060ec <vector242>:
  1060ec:	6a 00                	push   $0x0
  1060ee:	68 f2 00 00 00       	push   $0xf2
  1060f3:	e9 c8 f2 ff ff       	jmp    1053c0 <alltraps>

001060f8 <vector243>:
  1060f8:	6a 00                	push   $0x0
  1060fa:	68 f3 00 00 00       	push   $0xf3
  1060ff:	e9 bc f2 ff ff       	jmp    1053c0 <alltraps>

00106104 <vector244>:
  106104:	6a 00                	push   $0x0
  106106:	68 f4 00 00 00       	push   $0xf4
  10610b:	e9 b0 f2 ff ff       	jmp    1053c0 <alltraps>

00106110 <vector245>:
  106110:	6a 00                	push   $0x0
  106112:	68 f5 00 00 00       	push   $0xf5
  106117:	e9 a4 f2 ff ff       	jmp    1053c0 <alltraps>

0010611c <vector246>:
  10611c:	6a 00                	push   $0x0
  10611e:	68 f6 00 00 00       	push   $0xf6
  106123:	e9 98 f2 ff ff       	jmp    1053c0 <alltraps>

00106128 <vector247>:
  106128:	6a 00                	push   $0x0
  10612a:	68 f7 00 00 00       	push   $0xf7
  10612f:	e9 8c f2 ff ff       	jmp    1053c0 <alltraps>

00106134 <vector248>:
  106134:	6a 00                	push   $0x0
  106136:	68 f8 00 00 00       	push   $0xf8
  10613b:	e9 80 f2 ff ff       	jmp    1053c0 <alltraps>

00106140 <vector249>:
  106140:	6a 00                	push   $0x0
  106142:	68 f9 00 00 00       	push   $0xf9
  106147:	e9 74 f2 ff ff       	jmp    1053c0 <alltraps>

0010614c <vector250>:
  10614c:	6a 00                	push   $0x0
  10614e:	68 fa 00 00 00       	push   $0xfa
  106153:	e9 68 f2 ff ff       	jmp    1053c0 <alltraps>

00106158 <vector251>:
  106158:	6a 00                	push   $0x0
  10615a:	68 fb 00 00 00       	push   $0xfb
  10615f:	e9 5c f2 ff ff       	jmp    1053c0 <alltraps>

00106164 <vector252>:
  106164:	6a 00                	push   $0x0
  106166:	68 fc 00 00 00       	push   $0xfc
  10616b:	e9 50 f2 ff ff       	jmp    1053c0 <alltraps>

00106170 <vector253>:
  106170:	6a 00                	push   $0x0
  106172:	68 fd 00 00 00       	push   $0xfd
  106177:	e9 44 f2 ff ff       	jmp    1053c0 <alltraps>

0010617c <vector254>:
  10617c:	6a 00                	push   $0x0
  10617e:	68 fe 00 00 00       	push   $0xfe
  106183:	e9 38 f2 ff ff       	jmp    1053c0 <alltraps>

00106188 <vector255>:
  106188:	6a 00                	push   $0x0
  10618a:	68 ff 00 00 00       	push   $0xff
  10618f:	e9 2c f2 ff ff       	jmp    1053c0 <alltraps>

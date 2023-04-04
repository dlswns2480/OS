
user/_ln:     file format elf32-i386


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
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  12:	83 39 03             	cmpl   $0x3,(%ecx)
  15:	74 14                	je     2b <main+0x2b>
    printf(2, "Usage: ln old new\n");
  17:	83 ec 08             	sub    $0x8,%esp
  1a:	68 5c 06 00 00       	push   $0x65c
  1f:	6a 02                	push   $0x2
  21:	e8 20 03 00 00       	call   346 <printf>
    exit();
  26:	e8 f1 01 00 00       	call   21c <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2b:	83 ec 08             	sub    $0x8,%esp
  2e:	ff 73 08             	pushl  0x8(%ebx)
  31:	ff 73 04             	pushl  0x4(%ebx)
  34:	e8 43 02 00 00       	call   27c <link>
  39:	83 c4 10             	add    $0x10,%esp
  3c:	85 c0                	test   %eax,%eax
  3e:	78 05                	js     45 <main+0x45>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  40:	e8 d7 01 00 00       	call   21c <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  45:	ff 73 08             	pushl  0x8(%ebx)
  48:	ff 73 04             	pushl  0x4(%ebx)
  4b:	68 6f 06 00 00       	push   $0x66f
  50:	6a 02                	push   $0x2
  52:	e8 ef 02 00 00       	call   346 <printf>
  57:	83 c4 10             	add    $0x10,%esp
  5a:	eb e4                	jmp    40 <main+0x40>

0000005c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  5c:	55                   	push   %ebp
  5d:	89 e5                	mov    %esp,%ebp
  5f:	53                   	push   %ebx
  60:	8b 45 08             	mov    0x8(%ebp),%eax
  63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	89 c2                	mov    %eax,%edx
  68:	83 c1 01             	add    $0x1,%ecx
  6b:	83 c2 01             	add    $0x1,%edx
  6e:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  72:	88 5a ff             	mov    %bl,-0x1(%edx)
  75:	84 db                	test   %bl,%bl
  77:	75 ef                	jne    68 <strcpy+0xc>
    ;
  return os;
}
  79:	5b                   	pop    %ebx
  7a:	5d                   	pop    %ebp
  7b:	c3                   	ret    

0000007c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  82:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  85:	0f b6 01             	movzbl (%ecx),%eax
  88:	84 c0                	test   %al,%al
  8a:	74 15                	je     a1 <strcmp+0x25>
  8c:	3a 02                	cmp    (%edx),%al
  8e:	75 11                	jne    a1 <strcmp+0x25>
    p++, q++;
  90:	83 c1 01             	add    $0x1,%ecx
  93:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  96:	0f b6 01             	movzbl (%ecx),%eax
  99:	84 c0                	test   %al,%al
  9b:	74 04                	je     a1 <strcmp+0x25>
  9d:	3a 02                	cmp    (%edx),%al
  9f:	74 ef                	je     90 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a1:	0f b6 c0             	movzbl %al,%eax
  a4:	0f b6 12             	movzbl (%edx),%edx
  a7:	29 d0                	sub    %edx,%eax
}
  a9:	5d                   	pop    %ebp
  aa:	c3                   	ret    

000000ab <strlen>:

uint
strlen(const char *s)
{
  ab:	55                   	push   %ebp
  ac:	89 e5                	mov    %esp,%ebp
  ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b1:	80 39 00             	cmpb   $0x0,(%ecx)
  b4:	74 12                	je     c8 <strlen+0x1d>
  b6:	ba 00 00 00 00       	mov    $0x0,%edx
  bb:	83 c2 01             	add    $0x1,%edx
  be:	89 d0                	mov    %edx,%eax
  c0:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c4:	75 f5                	jne    bb <strlen+0x10>
    ;
  return n;
}
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    
  for(n = 0; s[n]; n++)
  c8:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
  cd:	eb f7                	jmp    c6 <strlen+0x1b>

000000cf <memset>:

void*
memset(void *dst, int c, uint n)
{
  cf:	55                   	push   %ebp
  d0:	89 e5                	mov    %esp,%ebp
  d2:	57                   	push   %edi
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d6:	89 d7                	mov    %edx,%edi
  d8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  db:	8b 45 0c             	mov    0xc(%ebp),%eax
  de:	fc                   	cld    
  df:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e1:	89 d0                	mov    %edx,%eax
  e3:	5f                   	pop    %edi
  e4:	5d                   	pop    %ebp
  e5:	c3                   	ret    

000000e6 <strchr>:

char*
strchr(const char *s, char c)
{
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  e9:	53                   	push   %ebx
  ea:	8b 45 08             	mov    0x8(%ebp),%eax
  ed:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  f0:	0f b6 10             	movzbl (%eax),%edx
  f3:	84 d2                	test   %dl,%dl
  f5:	74 1e                	je     115 <strchr+0x2f>
  f7:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
  f9:	38 d3                	cmp    %dl,%bl
  fb:	74 15                	je     112 <strchr+0x2c>
  for(; *s; s++)
  fd:	83 c0 01             	add    $0x1,%eax
 100:	0f b6 10             	movzbl (%eax),%edx
 103:	84 d2                	test   %dl,%dl
 105:	74 06                	je     10d <strchr+0x27>
    if(*s == c)
 107:	38 ca                	cmp    %cl,%dl
 109:	75 f2                	jne    fd <strchr+0x17>
 10b:	eb 05                	jmp    112 <strchr+0x2c>
      return (char*)s;
  return 0;
 10d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 112:	5b                   	pop    %ebx
 113:	5d                   	pop    %ebp
 114:	c3                   	ret    
  return 0;
 115:	b8 00 00 00 00       	mov    $0x0,%eax
 11a:	eb f6                	jmp    112 <strchr+0x2c>

0000011c <gets>:

char*
gets(char *buf, int max)
{
 11c:	55                   	push   %ebp
 11d:	89 e5                	mov    %esp,%ebp
 11f:	57                   	push   %edi
 120:	56                   	push   %esi
 121:	53                   	push   %ebx
 122:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 12a:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 12d:	8d 5e 01             	lea    0x1(%esi),%ebx
 130:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 133:	7d 2b                	jge    160 <gets+0x44>
    cc = read(0, &c, 1);
 135:	83 ec 04             	sub    $0x4,%esp
 138:	6a 01                	push   $0x1
 13a:	57                   	push   %edi
 13b:	6a 00                	push   $0x0
 13d:	e8 f2 00 00 00       	call   234 <read>
    if(cc < 1)
 142:	83 c4 10             	add    $0x10,%esp
 145:	85 c0                	test   %eax,%eax
 147:	7e 17                	jle    160 <gets+0x44>
      break;
    buf[i++] = c;
 149:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 14d:	8b 55 08             	mov    0x8(%ebp),%edx
 150:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 154:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 156:	3c 0a                	cmp    $0xa,%al
 158:	74 04                	je     15e <gets+0x42>
 15a:	3c 0d                	cmp    $0xd,%al
 15c:	75 cf                	jne    12d <gets+0x11>
  for(i=0; i+1 < max; ){
 15e:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 167:	8d 65 f4             	lea    -0xc(%ebp),%esp
 16a:	5b                   	pop    %ebx
 16b:	5e                   	pop    %esi
 16c:	5f                   	pop    %edi
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    

0000016f <stat>:

int
stat(const char *n, struct stat *st)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	56                   	push   %esi
 173:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 174:	83 ec 08             	sub    $0x8,%esp
 177:	6a 00                	push   $0x0
 179:	ff 75 08             	pushl  0x8(%ebp)
 17c:	e8 db 00 00 00       	call   25c <open>
  if(fd < 0)
 181:	83 c4 10             	add    $0x10,%esp
 184:	85 c0                	test   %eax,%eax
 186:	78 24                	js     1ac <stat+0x3d>
 188:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 18a:	83 ec 08             	sub    $0x8,%esp
 18d:	ff 75 0c             	pushl  0xc(%ebp)
 190:	50                   	push   %eax
 191:	e8 de 00 00 00       	call   274 <fstat>
 196:	89 c6                	mov    %eax,%esi
  close(fd);
 198:	89 1c 24             	mov    %ebx,(%esp)
 19b:	e8 a4 00 00 00       	call   244 <close>
  return r;
 1a0:	83 c4 10             	add    $0x10,%esp
}
 1a3:	89 f0                	mov    %esi,%eax
 1a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret    
    return -1;
 1ac:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1b1:	eb f0                	jmp    1a3 <stat+0x34>

000001b3 <atoi>:

int
atoi(const char *s)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	53                   	push   %ebx
 1b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ba:	0f b6 11             	movzbl (%ecx),%edx
 1bd:	8d 42 d0             	lea    -0x30(%edx),%eax
 1c0:	3c 09                	cmp    $0x9,%al
 1c2:	77 20                	ja     1e4 <atoi+0x31>
  n = 0;
 1c4:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 1c9:	83 c1 01             	add    $0x1,%ecx
 1cc:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1cf:	0f be d2             	movsbl %dl,%edx
 1d2:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 1d6:	0f b6 11             	movzbl (%ecx),%edx
 1d9:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1dc:	80 fb 09             	cmp    $0x9,%bl
 1df:	76 e8                	jbe    1c9 <atoi+0x16>
  return n;
}
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
  n = 0;
 1e4:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 1e9:	eb f6                	jmp    1e1 <atoi+0x2e>

000001eb <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1eb:	55                   	push   %ebp
 1ec:	89 e5                	mov    %esp,%ebp
 1ee:	56                   	push   %esi
 1ef:	53                   	push   %ebx
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	8b 75 0c             	mov    0xc(%ebp),%esi
 1f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f9:	85 db                	test   %ebx,%ebx
 1fb:	7e 13                	jle    210 <memmove+0x25>
 1fd:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 202:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 206:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 209:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 20c:	39 d3                	cmp    %edx,%ebx
 20e:	75 f2                	jne    202 <memmove+0x17>
  return vdst;
}
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    

00000214 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 214:	b8 01 00 00 00       	mov    $0x1,%eax
 219:	cd 40                	int    $0x40
 21b:	c3                   	ret    

0000021c <exit>:
SYSCALL(exit)
 21c:	b8 02 00 00 00       	mov    $0x2,%eax
 221:	cd 40                	int    $0x40
 223:	c3                   	ret    

00000224 <wait>:
SYSCALL(wait)
 224:	b8 03 00 00 00       	mov    $0x3,%eax
 229:	cd 40                	int    $0x40
 22b:	c3                   	ret    

0000022c <pipe>:
SYSCALL(pipe)
 22c:	b8 04 00 00 00       	mov    $0x4,%eax
 231:	cd 40                	int    $0x40
 233:	c3                   	ret    

00000234 <read>:
SYSCALL(read)
 234:	b8 05 00 00 00       	mov    $0x5,%eax
 239:	cd 40                	int    $0x40
 23b:	c3                   	ret    

0000023c <write>:
SYSCALL(write)
 23c:	b8 10 00 00 00       	mov    $0x10,%eax
 241:	cd 40                	int    $0x40
 243:	c3                   	ret    

00000244 <close>:
SYSCALL(close)
 244:	b8 15 00 00 00       	mov    $0x15,%eax
 249:	cd 40                	int    $0x40
 24b:	c3                   	ret    

0000024c <kill>:
SYSCALL(kill)
 24c:	b8 06 00 00 00       	mov    $0x6,%eax
 251:	cd 40                	int    $0x40
 253:	c3                   	ret    

00000254 <exec>:
SYSCALL(exec)
 254:	b8 07 00 00 00       	mov    $0x7,%eax
 259:	cd 40                	int    $0x40
 25b:	c3                   	ret    

0000025c <open>:
SYSCALL(open)
 25c:	b8 0f 00 00 00       	mov    $0xf,%eax
 261:	cd 40                	int    $0x40
 263:	c3                   	ret    

00000264 <mknod>:
SYSCALL(mknod)
 264:	b8 11 00 00 00       	mov    $0x11,%eax
 269:	cd 40                	int    $0x40
 26b:	c3                   	ret    

0000026c <unlink>:
SYSCALL(unlink)
 26c:	b8 12 00 00 00       	mov    $0x12,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <fstat>:
SYSCALL(fstat)
 274:	b8 08 00 00 00       	mov    $0x8,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <link>:
SYSCALL(link)
 27c:	b8 13 00 00 00       	mov    $0x13,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <mkdir>:
SYSCALL(mkdir)
 284:	b8 14 00 00 00       	mov    $0x14,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <chdir>:
SYSCALL(chdir)
 28c:	b8 09 00 00 00       	mov    $0x9,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <dup>:
SYSCALL(dup)
 294:	b8 0a 00 00 00       	mov    $0xa,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <getpid>:
SYSCALL(getpid)
 29c:	b8 0b 00 00 00       	mov    $0xb,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <sbrk>:
SYSCALL(sbrk)
 2a4:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <sleep>:
SYSCALL(sleep)
 2ac:	b8 0d 00 00 00       	mov    $0xd,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <uptime>:
SYSCALL(uptime)
 2b4:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2bc:	55                   	push   %ebp
 2bd:	89 e5                	mov    %esp,%ebp
 2bf:	57                   	push   %edi
 2c0:	56                   	push   %esi
 2c1:	53                   	push   %ebx
 2c2:	83 ec 3c             	sub    $0x3c,%esp
 2c5:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2c7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2cb:	74 14                	je     2e1 <printint+0x25>
 2cd:	85 d2                	test   %edx,%edx
 2cf:	79 10                	jns    2e1 <printint+0x25>
    neg = 1;
    x = -xx;
 2d1:	f7 da                	neg    %edx
    neg = 1;
 2d3:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2da:	bf 00 00 00 00       	mov    $0x0,%edi
 2df:	eb 0b                	jmp    2ec <printint+0x30>
  neg = 0;
 2e1:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 2e8:	eb f0                	jmp    2da <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 2ea:	89 df                	mov    %ebx,%edi
 2ec:	8d 5f 01             	lea    0x1(%edi),%ebx
 2ef:	89 d0                	mov    %edx,%eax
 2f1:	ba 00 00 00 00       	mov    $0x0,%edx
 2f6:	f7 f1                	div    %ecx
 2f8:	0f b6 92 8c 06 00 00 	movzbl 0x68c(%edx),%edx
 2ff:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 303:	89 c2                	mov    %eax,%edx
 305:	85 c0                	test   %eax,%eax
 307:	75 e1                	jne    2ea <printint+0x2e>
  if(neg)
 309:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 30d:	74 08                	je     317 <printint+0x5b>
    buf[i++] = '-';
 30f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 314:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 317:	83 eb 01             	sub    $0x1,%ebx
 31a:	78 22                	js     33e <printint+0x82>
  write(fd, &c, 1);
 31c:	8d 7d d7             	lea    -0x29(%ebp),%edi
 31f:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 324:	88 45 d7             	mov    %al,-0x29(%ebp)
 327:	83 ec 04             	sub    $0x4,%esp
 32a:	6a 01                	push   $0x1
 32c:	57                   	push   %edi
 32d:	56                   	push   %esi
 32e:	e8 09 ff ff ff       	call   23c <write>
  while(--i >= 0)
 333:	83 eb 01             	sub    $0x1,%ebx
 336:	83 c4 10             	add    $0x10,%esp
 339:	83 fb ff             	cmp    $0xffffffff,%ebx
 33c:	75 e1                	jne    31f <printint+0x63>
    putc(fd, buf[i]);
}
 33e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 341:	5b                   	pop    %ebx
 342:	5e                   	pop    %esi
 343:	5f                   	pop    %edi
 344:	5d                   	pop    %ebp
 345:	c3                   	ret    

00000346 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	57                   	push   %edi
 34a:	56                   	push   %esi
 34b:	53                   	push   %ebx
 34c:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 34f:	8b 75 0c             	mov    0xc(%ebp),%esi
 352:	0f b6 1e             	movzbl (%esi),%ebx
 355:	84 db                	test   %bl,%bl
 357:	0f 84 b1 01 00 00    	je     50e <printf+0x1c8>
 35d:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 360:	8d 45 10             	lea    0x10(%ebp),%eax
 363:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 366:	bf 00 00 00 00       	mov    $0x0,%edi
 36b:	eb 2d                	jmp    39a <printf+0x54>
 36d:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 370:	83 ec 04             	sub    $0x4,%esp
 373:	6a 01                	push   $0x1
 375:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 378:	50                   	push   %eax
 379:	ff 75 08             	pushl  0x8(%ebp)
 37c:	e8 bb fe ff ff       	call   23c <write>
 381:	83 c4 10             	add    $0x10,%esp
 384:	eb 05                	jmp    38b <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 386:	83 ff 25             	cmp    $0x25,%edi
 389:	74 22                	je     3ad <printf+0x67>
 38b:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 38e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 392:	84 db                	test   %bl,%bl
 394:	0f 84 74 01 00 00    	je     50e <printf+0x1c8>
    c = fmt[i] & 0xff;
 39a:	0f be d3             	movsbl %bl,%edx
 39d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3a0:	85 ff                	test   %edi,%edi
 3a2:	75 e2                	jne    386 <printf+0x40>
      if(c == '%'){
 3a4:	83 f8 25             	cmp    $0x25,%eax
 3a7:	75 c4                	jne    36d <printf+0x27>
        state = '%';
 3a9:	89 c7                	mov    %eax,%edi
 3ab:	eb de                	jmp    38b <printf+0x45>
      if(c == 'd'){
 3ad:	83 f8 64             	cmp    $0x64,%eax
 3b0:	74 59                	je     40b <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3b2:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3b8:	83 fa 70             	cmp    $0x70,%edx
 3bb:	74 7a                	je     437 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3bd:	83 f8 73             	cmp    $0x73,%eax
 3c0:	0f 84 9d 00 00 00    	je     463 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3c6:	83 f8 63             	cmp    $0x63,%eax
 3c9:	0f 84 f2 00 00 00    	je     4c1 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3cf:	83 f8 25             	cmp    $0x25,%eax
 3d2:	0f 84 15 01 00 00    	je     4ed <printf+0x1a7>
 3d8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3dc:	83 ec 04             	sub    $0x4,%esp
 3df:	6a 01                	push   $0x1
 3e1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3e4:	50                   	push   %eax
 3e5:	ff 75 08             	pushl  0x8(%ebp)
 3e8:	e8 4f fe ff ff       	call   23c <write>
 3ed:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3f0:	83 c4 0c             	add    $0xc,%esp
 3f3:	6a 01                	push   $0x1
 3f5:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3f8:	50                   	push   %eax
 3f9:	ff 75 08             	pushl  0x8(%ebp)
 3fc:	e8 3b fe ff ff       	call   23c <write>
 401:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 404:	bf 00 00 00 00       	mov    $0x0,%edi
 409:	eb 80                	jmp    38b <printf+0x45>
        printint(fd, *ap, 10, 1);
 40b:	83 ec 0c             	sub    $0xc,%esp
 40e:	6a 01                	push   $0x1
 410:	b9 0a 00 00 00       	mov    $0xa,%ecx
 415:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 418:	8b 17                	mov    (%edi),%edx
 41a:	8b 45 08             	mov    0x8(%ebp),%eax
 41d:	e8 9a fe ff ff       	call   2bc <printint>
        ap++;
 422:	89 f8                	mov    %edi,%eax
 424:	83 c0 04             	add    $0x4,%eax
 427:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 42a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 42d:	bf 00 00 00 00       	mov    $0x0,%edi
 432:	e9 54 ff ff ff       	jmp    38b <printf+0x45>
        printint(fd, *ap, 16, 0);
 437:	83 ec 0c             	sub    $0xc,%esp
 43a:	6a 00                	push   $0x0
 43c:	b9 10 00 00 00       	mov    $0x10,%ecx
 441:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 444:	8b 17                	mov    (%edi),%edx
 446:	8b 45 08             	mov    0x8(%ebp),%eax
 449:	e8 6e fe ff ff       	call   2bc <printint>
        ap++;
 44e:	89 f8                	mov    %edi,%eax
 450:	83 c0 04             	add    $0x4,%eax
 453:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 456:	83 c4 10             	add    $0x10,%esp
      state = 0;
 459:	bf 00 00 00 00       	mov    $0x0,%edi
 45e:	e9 28 ff ff ff       	jmp    38b <printf+0x45>
        s = (char*)*ap;
 463:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 466:	8b 01                	mov    (%ecx),%eax
        ap++;
 468:	83 c1 04             	add    $0x4,%ecx
 46b:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 46e:	85 c0                	test   %eax,%eax
 470:	74 13                	je     485 <printf+0x13f>
        s = (char*)*ap;
 472:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 474:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 477:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 47c:	84 c0                	test   %al,%al
 47e:	75 0f                	jne    48f <printf+0x149>
 480:	e9 06 ff ff ff       	jmp    38b <printf+0x45>
          s = "(null)";
 485:	bb 83 06 00 00       	mov    $0x683,%ebx
        while(*s != 0){
 48a:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 48f:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 492:	89 75 d0             	mov    %esi,-0x30(%ebp)
 495:	8b 75 08             	mov    0x8(%ebp),%esi
 498:	88 45 e3             	mov    %al,-0x1d(%ebp)
 49b:	83 ec 04             	sub    $0x4,%esp
 49e:	6a 01                	push   $0x1
 4a0:	57                   	push   %edi
 4a1:	56                   	push   %esi
 4a2:	e8 95 fd ff ff       	call   23c <write>
          s++;
 4a7:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4aa:	0f b6 03             	movzbl (%ebx),%eax
 4ad:	83 c4 10             	add    $0x10,%esp
 4b0:	84 c0                	test   %al,%al
 4b2:	75 e4                	jne    498 <printf+0x152>
 4b4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 4b7:	bf 00 00 00 00       	mov    $0x0,%edi
 4bc:	e9 ca fe ff ff       	jmp    38b <printf+0x45>
        putc(fd, *ap);
 4c1:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c4:	8b 07                	mov    (%edi),%eax
 4c6:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4c9:	83 ec 04             	sub    $0x4,%esp
 4cc:	6a 01                	push   $0x1
 4ce:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 62 fd ff ff       	call   23c <write>
        ap++;
 4da:	83 c7 04             	add    $0x4,%edi
 4dd:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 4e0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e3:	bf 00 00 00 00       	mov    $0x0,%edi
 4e8:	e9 9e fe ff ff       	jmp    38b <printf+0x45>
 4ed:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	6a 01                	push   $0x1
 4f5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4f8:	50                   	push   %eax
 4f9:	ff 75 08             	pushl  0x8(%ebp)
 4fc:	e8 3b fd ff ff       	call   23c <write>
 501:	83 c4 10             	add    $0x10,%esp
      state = 0;
 504:	bf 00 00 00 00       	mov    $0x0,%edi
 509:	e9 7d fe ff ff       	jmp    38b <printf+0x45>
    }
  }
}
 50e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 511:	5b                   	pop    %ebx
 512:	5e                   	pop    %esi
 513:	5f                   	pop    %edi
 514:	5d                   	pop    %ebp
 515:	c3                   	ret    

00000516 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 516:	55                   	push   %ebp
 517:	89 e5                	mov    %esp,%ebp
 519:	57                   	push   %edi
 51a:	56                   	push   %esi
 51b:	53                   	push   %ebx
 51c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 51f:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 522:	a1 f8 08 00 00       	mov    0x8f8,%eax
 527:	eb 0c                	jmp    535 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 529:	8b 10                	mov    (%eax),%edx
 52b:	39 c2                	cmp    %eax,%edx
 52d:	77 04                	ja     533 <free+0x1d>
 52f:	39 ca                	cmp    %ecx,%edx
 531:	77 10                	ja     543 <free+0x2d>
{
 533:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 535:	39 c8                	cmp    %ecx,%eax
 537:	73 f0                	jae    529 <free+0x13>
 539:	8b 10                	mov    (%eax),%edx
 53b:	39 ca                	cmp    %ecx,%edx
 53d:	77 04                	ja     543 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 53f:	39 c2                	cmp    %eax,%edx
 541:	77 f0                	ja     533 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 543:	8b 73 fc             	mov    -0x4(%ebx),%esi
 546:	8b 10                	mov    (%eax),%edx
 548:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 54b:	39 fa                	cmp    %edi,%edx
 54d:	74 19                	je     568 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 54f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 552:	8b 50 04             	mov    0x4(%eax),%edx
 555:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 558:	39 f1                	cmp    %esi,%ecx
 55a:	74 1b                	je     577 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 55c:	89 08                	mov    %ecx,(%eax)
  freep = p;
 55e:	a3 f8 08 00 00       	mov    %eax,0x8f8
}
 563:	5b                   	pop    %ebx
 564:	5e                   	pop    %esi
 565:	5f                   	pop    %edi
 566:	5d                   	pop    %ebp
 567:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 568:	03 72 04             	add    0x4(%edx),%esi
 56b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 56e:	8b 10                	mov    (%eax),%edx
 570:	8b 12                	mov    (%edx),%edx
 572:	89 53 f8             	mov    %edx,-0x8(%ebx)
 575:	eb db                	jmp    552 <free+0x3c>
    p->s.size += bp->s.size;
 577:	03 53 fc             	add    -0x4(%ebx),%edx
 57a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 57d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 580:	89 10                	mov    %edx,(%eax)
 582:	eb da                	jmp    55e <free+0x48>

00000584 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	57                   	push   %edi
 588:	56                   	push   %esi
 589:	53                   	push   %ebx
 58a:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
 590:	8d 58 07             	lea    0x7(%eax),%ebx
 593:	c1 eb 03             	shr    $0x3,%ebx
 596:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 599:	8b 15 f8 08 00 00    	mov    0x8f8,%edx
 59f:	85 d2                	test   %edx,%edx
 5a1:	74 20                	je     5c3 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5a3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5a5:	8b 48 04             	mov    0x4(%eax),%ecx
 5a8:	39 cb                	cmp    %ecx,%ebx
 5aa:	76 3c                	jbe    5e8 <malloc+0x64>
 5ac:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5b2:	be 00 10 00 00       	mov    $0x1000,%esi
 5b7:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5ba:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 5c1:	eb 70                	jmp    633 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 5c3:	c7 05 f8 08 00 00 fc 	movl   $0x8fc,0x8f8
 5ca:	08 00 00 
 5cd:	c7 05 fc 08 00 00 fc 	movl   $0x8fc,0x8fc
 5d4:	08 00 00 
    base.s.size = 0;
 5d7:	c7 05 00 09 00 00 00 	movl   $0x0,0x900
 5de:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5e1:	ba fc 08 00 00       	mov    $0x8fc,%edx
 5e6:	eb bb                	jmp    5a3 <malloc+0x1f>
      if(p->s.size == nunits)
 5e8:	39 cb                	cmp    %ecx,%ebx
 5ea:	74 1c                	je     608 <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5ec:	29 d9                	sub    %ebx,%ecx
 5ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5f4:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5f7:	89 15 f8 08 00 00    	mov    %edx,0x8f8
      return (void*)(p + 1);
 5fd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 600:	8d 65 f4             	lea    -0xc(%ebp),%esp
 603:	5b                   	pop    %ebx
 604:	5e                   	pop    %esi
 605:	5f                   	pop    %edi
 606:	5d                   	pop    %ebp
 607:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 608:	8b 08                	mov    (%eax),%ecx
 60a:	89 0a                	mov    %ecx,(%edx)
 60c:	eb e9                	jmp    5f7 <malloc+0x73>
  hp->s.size = nu;
 60e:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 611:	83 ec 0c             	sub    $0xc,%esp
 614:	83 c0 08             	add    $0x8,%eax
 617:	50                   	push   %eax
 618:	e8 f9 fe ff ff       	call   516 <free>
  return freep;
 61d:	8b 15 f8 08 00 00    	mov    0x8f8,%edx
      if((p = morecore(nunits)) == 0)
 623:	83 c4 10             	add    $0x10,%esp
 626:	85 d2                	test   %edx,%edx
 628:	74 2b                	je     655 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 62a:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 62c:	8b 48 04             	mov    0x4(%eax),%ecx
 62f:	39 d9                	cmp    %ebx,%ecx
 631:	73 b5                	jae    5e8 <malloc+0x64>
 633:	89 c2                	mov    %eax,%edx
    if(p == freep)
 635:	39 05 f8 08 00 00    	cmp    %eax,0x8f8
 63b:	75 ed                	jne    62a <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 63d:	83 ec 0c             	sub    $0xc,%esp
 640:	57                   	push   %edi
 641:	e8 5e fc ff ff       	call   2a4 <sbrk>
  if(p == (char*)-1)
 646:	83 c4 10             	add    $0x10,%esp
 649:	83 f8 ff             	cmp    $0xffffffff,%eax
 64c:	75 c0                	jne    60e <malloc+0x8a>
        return 0;
 64e:	b8 00 00 00 00       	mov    $0x0,%eax
 653:	eb ab                	jmp    600 <malloc+0x7c>
 655:	b8 00 00 00 00       	mov    $0x0,%eax
 65a:	eb a4                	jmp    600 <malloc+0x7c>

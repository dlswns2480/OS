
user/_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 27                	jle    44 <main+0x44>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	ff 33                	pushl  (%ebx)
  28:	e8 82 01 00 00       	call   1af <atoi>
  2d:	89 04 24             	mov    %eax,(%esp)
  30:	e8 13 02 00 00       	call   248 <kill>
  35:	83 c3 04             	add    $0x4,%ebx
  for(i=1; i<argc; i++)
  38:	83 c4 10             	add    $0x10,%esp
  3b:	39 f3                	cmp    %esi,%ebx
  3d:	75 e4                	jne    23 <main+0x23>
  exit();
  3f:	e8 d4 01 00 00       	call   218 <exit>
    printf(2, "usage: kill pid...\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 58 06 00 00       	push   $0x658
  4c:	6a 02                	push   $0x2
  4e:	e8 ef 02 00 00       	call   342 <printf>
    exit();
  53:	e8 c0 01 00 00       	call   218 <exit>

00000058 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	53                   	push   %ebx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  62:	89 c2                	mov    %eax,%edx
  64:	83 c1 01             	add    $0x1,%ecx
  67:	83 c2 01             	add    $0x1,%edx
  6a:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  6e:	88 5a ff             	mov    %bl,-0x1(%edx)
  71:	84 db                	test   %bl,%bl
  73:	75 ef                	jne    64 <strcpy+0xc>
    ;
  return os;
}
  75:	5b                   	pop    %ebx
  76:	5d                   	pop    %ebp
  77:	c3                   	ret    

00000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  81:	0f b6 01             	movzbl (%ecx),%eax
  84:	84 c0                	test   %al,%al
  86:	74 15                	je     9d <strcmp+0x25>
  88:	3a 02                	cmp    (%edx),%al
  8a:	75 11                	jne    9d <strcmp+0x25>
    p++, q++;
  8c:	83 c1 01             	add    $0x1,%ecx
  8f:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  92:	0f b6 01             	movzbl (%ecx),%eax
  95:	84 c0                	test   %al,%al
  97:	74 04                	je     9d <strcmp+0x25>
  99:	3a 02                	cmp    (%edx),%al
  9b:	74 ef                	je     8c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  9d:	0f b6 c0             	movzbl %al,%eax
  a0:	0f b6 12             	movzbl (%edx),%edx
  a3:	29 d0                	sub    %edx,%eax
}
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    

000000a7 <strlen>:

uint
strlen(const char *s)
{
  a7:	55                   	push   %ebp
  a8:	89 e5                	mov    %esp,%ebp
  aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ad:	80 39 00             	cmpb   $0x0,(%ecx)
  b0:	74 12                	je     c4 <strlen+0x1d>
  b2:	ba 00 00 00 00       	mov    $0x0,%edx
  b7:	83 c2 01             	add    $0x1,%edx
  ba:	89 d0                	mov    %edx,%eax
  bc:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c0:	75 f5                	jne    b7 <strlen+0x10>
    ;
  return n;
}
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    
  for(n = 0; s[n]; n++)
  c4:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
  c9:	eb f7                	jmp    c2 <strlen+0x1b>

000000cb <memset>:

void*
memset(void *dst, int c, uint n)
{
  cb:	55                   	push   %ebp
  cc:	89 e5                	mov    %esp,%ebp
  ce:	57                   	push   %edi
  cf:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d2:	89 d7                	mov    %edx,%edi
  d4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  da:	fc                   	cld    
  db:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  dd:	89 d0                	mov    %edx,%eax
  df:	5f                   	pop    %edi
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    

000000e2 <strchr>:

char*
strchr(const char *s, char c)
{
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  e5:	53                   	push   %ebx
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  ec:	0f b6 10             	movzbl (%eax),%edx
  ef:	84 d2                	test   %dl,%dl
  f1:	74 1e                	je     111 <strchr+0x2f>
  f3:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
  f5:	38 d3                	cmp    %dl,%bl
  f7:	74 15                	je     10e <strchr+0x2c>
  for(; *s; s++)
  f9:	83 c0 01             	add    $0x1,%eax
  fc:	0f b6 10             	movzbl (%eax),%edx
  ff:	84 d2                	test   %dl,%dl
 101:	74 06                	je     109 <strchr+0x27>
    if(*s == c)
 103:	38 ca                	cmp    %cl,%dl
 105:	75 f2                	jne    f9 <strchr+0x17>
 107:	eb 05                	jmp    10e <strchr+0x2c>
      return (char*)s;
  return 0;
 109:	b8 00 00 00 00       	mov    $0x0,%eax
}
 10e:	5b                   	pop    %ebx
 10f:	5d                   	pop    %ebp
 110:	c3                   	ret    
  return 0;
 111:	b8 00 00 00 00       	mov    $0x0,%eax
 116:	eb f6                	jmp    10e <strchr+0x2c>

00000118 <gets>:

char*
gets(char *buf, int max)
{
 118:	55                   	push   %ebp
 119:	89 e5                	mov    %esp,%ebp
 11b:	57                   	push   %edi
 11c:	56                   	push   %esi
 11d:	53                   	push   %ebx
 11e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 121:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 126:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 129:	8d 5e 01             	lea    0x1(%esi),%ebx
 12c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 12f:	7d 2b                	jge    15c <gets+0x44>
    cc = read(0, &c, 1);
 131:	83 ec 04             	sub    $0x4,%esp
 134:	6a 01                	push   $0x1
 136:	57                   	push   %edi
 137:	6a 00                	push   $0x0
 139:	e8 f2 00 00 00       	call   230 <read>
    if(cc < 1)
 13e:	83 c4 10             	add    $0x10,%esp
 141:	85 c0                	test   %eax,%eax
 143:	7e 17                	jle    15c <gets+0x44>
      break;
    buf[i++] = c;
 145:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 149:	8b 55 08             	mov    0x8(%ebp),%edx
 14c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 150:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 152:	3c 0a                	cmp    $0xa,%al
 154:	74 04                	je     15a <gets+0x42>
 156:	3c 0d                	cmp    $0xd,%al
 158:	75 cf                	jne    129 <gets+0x11>
  for(i=0; i+1 < max; ){
 15a:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 163:	8d 65 f4             	lea    -0xc(%ebp),%esp
 166:	5b                   	pop    %ebx
 167:	5e                   	pop    %esi
 168:	5f                   	pop    %edi
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    

0000016b <stat>:

int
stat(const char *n, struct stat *st)
{
 16b:	55                   	push   %ebp
 16c:	89 e5                	mov    %esp,%ebp
 16e:	56                   	push   %esi
 16f:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 170:	83 ec 08             	sub    $0x8,%esp
 173:	6a 00                	push   $0x0
 175:	ff 75 08             	pushl  0x8(%ebp)
 178:	e8 db 00 00 00       	call   258 <open>
  if(fd < 0)
 17d:	83 c4 10             	add    $0x10,%esp
 180:	85 c0                	test   %eax,%eax
 182:	78 24                	js     1a8 <stat+0x3d>
 184:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 186:	83 ec 08             	sub    $0x8,%esp
 189:	ff 75 0c             	pushl  0xc(%ebp)
 18c:	50                   	push   %eax
 18d:	e8 de 00 00 00       	call   270 <fstat>
 192:	89 c6                	mov    %eax,%esi
  close(fd);
 194:	89 1c 24             	mov    %ebx,(%esp)
 197:	e8 a4 00 00 00       	call   240 <close>
  return r;
 19c:	83 c4 10             	add    $0x10,%esp
}
 19f:	89 f0                	mov    %esi,%eax
 1a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a4:	5b                   	pop    %ebx
 1a5:	5e                   	pop    %esi
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    
    return -1;
 1a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1ad:	eb f0                	jmp    19f <stat+0x34>

000001af <atoi>:

int
atoi(const char *s)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
 1b2:	53                   	push   %ebx
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b6:	0f b6 11             	movzbl (%ecx),%edx
 1b9:	8d 42 d0             	lea    -0x30(%edx),%eax
 1bc:	3c 09                	cmp    $0x9,%al
 1be:	77 20                	ja     1e0 <atoi+0x31>
  n = 0;
 1c0:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 1c5:	83 c1 01             	add    $0x1,%ecx
 1c8:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1cb:	0f be d2             	movsbl %dl,%edx
 1ce:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 1d2:	0f b6 11             	movzbl (%ecx),%edx
 1d5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1d8:	80 fb 09             	cmp    $0x9,%bl
 1db:	76 e8                	jbe    1c5 <atoi+0x16>
  return n;
}
 1dd:	5b                   	pop    %ebx
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    
  n = 0;
 1e0:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 1e5:	eb f6                	jmp    1dd <atoi+0x2e>

000001e7 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	56                   	push   %esi
 1eb:	53                   	push   %ebx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	8b 75 0c             	mov    0xc(%ebp),%esi
 1f2:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f5:	85 db                	test   %ebx,%ebx
 1f7:	7e 13                	jle    20c <memmove+0x25>
 1f9:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 1fe:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 202:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 205:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 208:	39 d3                	cmp    %edx,%ebx
 20a:	75 f2                	jne    1fe <memmove+0x17>
  return vdst;
}
 20c:	5b                   	pop    %ebx
 20d:	5e                   	pop    %esi
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    

00000210 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 210:	b8 01 00 00 00       	mov    $0x1,%eax
 215:	cd 40                	int    $0x40
 217:	c3                   	ret    

00000218 <exit>:
SYSCALL(exit)
 218:	b8 02 00 00 00       	mov    $0x2,%eax
 21d:	cd 40                	int    $0x40
 21f:	c3                   	ret    

00000220 <wait>:
SYSCALL(wait)
 220:	b8 03 00 00 00       	mov    $0x3,%eax
 225:	cd 40                	int    $0x40
 227:	c3                   	ret    

00000228 <pipe>:
SYSCALL(pipe)
 228:	b8 04 00 00 00       	mov    $0x4,%eax
 22d:	cd 40                	int    $0x40
 22f:	c3                   	ret    

00000230 <read>:
SYSCALL(read)
 230:	b8 05 00 00 00       	mov    $0x5,%eax
 235:	cd 40                	int    $0x40
 237:	c3                   	ret    

00000238 <write>:
SYSCALL(write)
 238:	b8 10 00 00 00       	mov    $0x10,%eax
 23d:	cd 40                	int    $0x40
 23f:	c3                   	ret    

00000240 <close>:
SYSCALL(close)
 240:	b8 15 00 00 00       	mov    $0x15,%eax
 245:	cd 40                	int    $0x40
 247:	c3                   	ret    

00000248 <kill>:
SYSCALL(kill)
 248:	b8 06 00 00 00       	mov    $0x6,%eax
 24d:	cd 40                	int    $0x40
 24f:	c3                   	ret    

00000250 <exec>:
SYSCALL(exec)
 250:	b8 07 00 00 00       	mov    $0x7,%eax
 255:	cd 40                	int    $0x40
 257:	c3                   	ret    

00000258 <open>:
SYSCALL(open)
 258:	b8 0f 00 00 00       	mov    $0xf,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <mknod>:
SYSCALL(mknod)
 260:	b8 11 00 00 00       	mov    $0x11,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <unlink>:
SYSCALL(unlink)
 268:	b8 12 00 00 00       	mov    $0x12,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <fstat>:
SYSCALL(fstat)
 270:	b8 08 00 00 00       	mov    $0x8,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <link>:
SYSCALL(link)
 278:	b8 13 00 00 00       	mov    $0x13,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <mkdir>:
SYSCALL(mkdir)
 280:	b8 14 00 00 00       	mov    $0x14,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <chdir>:
SYSCALL(chdir)
 288:	b8 09 00 00 00       	mov    $0x9,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <dup>:
SYSCALL(dup)
 290:	b8 0a 00 00 00       	mov    $0xa,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <getpid>:
SYSCALL(getpid)
 298:	b8 0b 00 00 00       	mov    $0xb,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <sbrk>:
SYSCALL(sbrk)
 2a0:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <sleep>:
SYSCALL(sleep)
 2a8:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <uptime>:
SYSCALL(uptime)
 2b0:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	57                   	push   %edi
 2bc:	56                   	push   %esi
 2bd:	53                   	push   %ebx
 2be:	83 ec 3c             	sub    $0x3c,%esp
 2c1:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2c3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2c7:	74 14                	je     2dd <printint+0x25>
 2c9:	85 d2                	test   %edx,%edx
 2cb:	79 10                	jns    2dd <printint+0x25>
    neg = 1;
    x = -xx;
 2cd:	f7 da                	neg    %edx
    neg = 1;
 2cf:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2d6:	bf 00 00 00 00       	mov    $0x0,%edi
 2db:	eb 0b                	jmp    2e8 <printint+0x30>
  neg = 0;
 2dd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 2e4:	eb f0                	jmp    2d6 <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 2e6:	89 df                	mov    %ebx,%edi
 2e8:	8d 5f 01             	lea    0x1(%edi),%ebx
 2eb:	89 d0                	mov    %edx,%eax
 2ed:	ba 00 00 00 00       	mov    $0x0,%edx
 2f2:	f7 f1                	div    %ecx
 2f4:	0f b6 92 74 06 00 00 	movzbl 0x674(%edx),%edx
 2fb:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 2ff:	89 c2                	mov    %eax,%edx
 301:	85 c0                	test   %eax,%eax
 303:	75 e1                	jne    2e6 <printint+0x2e>
  if(neg)
 305:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 309:	74 08                	je     313 <printint+0x5b>
    buf[i++] = '-';
 30b:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 310:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 313:	83 eb 01             	sub    $0x1,%ebx
 316:	78 22                	js     33a <printint+0x82>
  write(fd, &c, 1);
 318:	8d 7d d7             	lea    -0x29(%ebp),%edi
 31b:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 320:	88 45 d7             	mov    %al,-0x29(%ebp)
 323:	83 ec 04             	sub    $0x4,%esp
 326:	6a 01                	push   $0x1
 328:	57                   	push   %edi
 329:	56                   	push   %esi
 32a:	e8 09 ff ff ff       	call   238 <write>
  while(--i >= 0)
 32f:	83 eb 01             	sub    $0x1,%ebx
 332:	83 c4 10             	add    $0x10,%esp
 335:	83 fb ff             	cmp    $0xffffffff,%ebx
 338:	75 e1                	jne    31b <printint+0x63>
    putc(fd, buf[i]);
}
 33a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 33d:	5b                   	pop    %ebx
 33e:	5e                   	pop    %esi
 33f:	5f                   	pop    %edi
 340:	5d                   	pop    %ebp
 341:	c3                   	ret    

00000342 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 342:	55                   	push   %ebp
 343:	89 e5                	mov    %esp,%ebp
 345:	57                   	push   %edi
 346:	56                   	push   %esi
 347:	53                   	push   %ebx
 348:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
 34e:	0f b6 1e             	movzbl (%esi),%ebx
 351:	84 db                	test   %bl,%bl
 353:	0f 84 b1 01 00 00    	je     50a <printf+0x1c8>
 359:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 35c:	8d 45 10             	lea    0x10(%ebp),%eax
 35f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 362:	bf 00 00 00 00       	mov    $0x0,%edi
 367:	eb 2d                	jmp    396 <printf+0x54>
 369:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 36c:	83 ec 04             	sub    $0x4,%esp
 36f:	6a 01                	push   $0x1
 371:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 374:	50                   	push   %eax
 375:	ff 75 08             	pushl  0x8(%ebp)
 378:	e8 bb fe ff ff       	call   238 <write>
 37d:	83 c4 10             	add    $0x10,%esp
 380:	eb 05                	jmp    387 <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 382:	83 ff 25             	cmp    $0x25,%edi
 385:	74 22                	je     3a9 <printf+0x67>
 387:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 38a:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 38e:	84 db                	test   %bl,%bl
 390:	0f 84 74 01 00 00    	je     50a <printf+0x1c8>
    c = fmt[i] & 0xff;
 396:	0f be d3             	movsbl %bl,%edx
 399:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 39c:	85 ff                	test   %edi,%edi
 39e:	75 e2                	jne    382 <printf+0x40>
      if(c == '%'){
 3a0:	83 f8 25             	cmp    $0x25,%eax
 3a3:	75 c4                	jne    369 <printf+0x27>
        state = '%';
 3a5:	89 c7                	mov    %eax,%edi
 3a7:	eb de                	jmp    387 <printf+0x45>
      if(c == 'd'){
 3a9:	83 f8 64             	cmp    $0x64,%eax
 3ac:	74 59                	je     407 <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3ae:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3b4:	83 fa 70             	cmp    $0x70,%edx
 3b7:	74 7a                	je     433 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3b9:	83 f8 73             	cmp    $0x73,%eax
 3bc:	0f 84 9d 00 00 00    	je     45f <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3c2:	83 f8 63             	cmp    $0x63,%eax
 3c5:	0f 84 f2 00 00 00    	je     4bd <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3cb:	83 f8 25             	cmp    $0x25,%eax
 3ce:	0f 84 15 01 00 00    	je     4e9 <printf+0x1a7>
 3d4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3d8:	83 ec 04             	sub    $0x4,%esp
 3db:	6a 01                	push   $0x1
 3dd:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3e0:	50                   	push   %eax
 3e1:	ff 75 08             	pushl  0x8(%ebp)
 3e4:	e8 4f fe ff ff       	call   238 <write>
 3e9:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3ec:	83 c4 0c             	add    $0xc,%esp
 3ef:	6a 01                	push   $0x1
 3f1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3f4:	50                   	push   %eax
 3f5:	ff 75 08             	pushl  0x8(%ebp)
 3f8:	e8 3b fe ff ff       	call   238 <write>
 3fd:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 400:	bf 00 00 00 00       	mov    $0x0,%edi
 405:	eb 80                	jmp    387 <printf+0x45>
        printint(fd, *ap, 10, 1);
 407:	83 ec 0c             	sub    $0xc,%esp
 40a:	6a 01                	push   $0x1
 40c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 411:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 414:	8b 17                	mov    (%edi),%edx
 416:	8b 45 08             	mov    0x8(%ebp),%eax
 419:	e8 9a fe ff ff       	call   2b8 <printint>
        ap++;
 41e:	89 f8                	mov    %edi,%eax
 420:	83 c0 04             	add    $0x4,%eax
 423:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 426:	83 c4 10             	add    $0x10,%esp
      state = 0;
 429:	bf 00 00 00 00       	mov    $0x0,%edi
 42e:	e9 54 ff ff ff       	jmp    387 <printf+0x45>
        printint(fd, *ap, 16, 0);
 433:	83 ec 0c             	sub    $0xc,%esp
 436:	6a 00                	push   $0x0
 438:	b9 10 00 00 00       	mov    $0x10,%ecx
 43d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 440:	8b 17                	mov    (%edi),%edx
 442:	8b 45 08             	mov    0x8(%ebp),%eax
 445:	e8 6e fe ff ff       	call   2b8 <printint>
        ap++;
 44a:	89 f8                	mov    %edi,%eax
 44c:	83 c0 04             	add    $0x4,%eax
 44f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 452:	83 c4 10             	add    $0x10,%esp
      state = 0;
 455:	bf 00 00 00 00       	mov    $0x0,%edi
 45a:	e9 28 ff ff ff       	jmp    387 <printf+0x45>
        s = (char*)*ap;
 45f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 462:	8b 01                	mov    (%ecx),%eax
        ap++;
 464:	83 c1 04             	add    $0x4,%ecx
 467:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 46a:	85 c0                	test   %eax,%eax
 46c:	74 13                	je     481 <printf+0x13f>
        s = (char*)*ap;
 46e:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 470:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 473:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 478:	84 c0                	test   %al,%al
 47a:	75 0f                	jne    48b <printf+0x149>
 47c:	e9 06 ff ff ff       	jmp    387 <printf+0x45>
          s = "(null)";
 481:	bb 6c 06 00 00       	mov    $0x66c,%ebx
        while(*s != 0){
 486:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 48b:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 48e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 491:	8b 75 08             	mov    0x8(%ebp),%esi
 494:	88 45 e3             	mov    %al,-0x1d(%ebp)
 497:	83 ec 04             	sub    $0x4,%esp
 49a:	6a 01                	push   $0x1
 49c:	57                   	push   %edi
 49d:	56                   	push   %esi
 49e:	e8 95 fd ff ff       	call   238 <write>
          s++;
 4a3:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4a6:	0f b6 03             	movzbl (%ebx),%eax
 4a9:	83 c4 10             	add    $0x10,%esp
 4ac:	84 c0                	test   %al,%al
 4ae:	75 e4                	jne    494 <printf+0x152>
 4b0:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 4b3:	bf 00 00 00 00       	mov    $0x0,%edi
 4b8:	e9 ca fe ff ff       	jmp    387 <printf+0x45>
        putc(fd, *ap);
 4bd:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c0:	8b 07                	mov    (%edi),%eax
 4c2:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4c5:	83 ec 04             	sub    $0x4,%esp
 4c8:	6a 01                	push   $0x1
 4ca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4cd:	50                   	push   %eax
 4ce:	ff 75 08             	pushl  0x8(%ebp)
 4d1:	e8 62 fd ff ff       	call   238 <write>
        ap++;
 4d6:	83 c7 04             	add    $0x4,%edi
 4d9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 4dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4df:	bf 00 00 00 00       	mov    $0x0,%edi
 4e4:	e9 9e fe ff ff       	jmp    387 <printf+0x45>
 4e9:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 4ec:	83 ec 04             	sub    $0x4,%esp
 4ef:	6a 01                	push   $0x1
 4f1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4f4:	50                   	push   %eax
 4f5:	ff 75 08             	pushl  0x8(%ebp)
 4f8:	e8 3b fd ff ff       	call   238 <write>
 4fd:	83 c4 10             	add    $0x10,%esp
      state = 0;
 500:	bf 00 00 00 00       	mov    $0x0,%edi
 505:	e9 7d fe ff ff       	jmp    387 <printf+0x45>
    }
  }
}
 50a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50d:	5b                   	pop    %ebx
 50e:	5e                   	pop    %esi
 50f:	5f                   	pop    %edi
 510:	5d                   	pop    %ebp
 511:	c3                   	ret    

00000512 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 512:	55                   	push   %ebp
 513:	89 e5                	mov    %esp,%ebp
 515:	57                   	push   %edi
 516:	56                   	push   %esi
 517:	53                   	push   %ebx
 518:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 51b:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 51e:	a1 e4 08 00 00       	mov    0x8e4,%eax
 523:	eb 0c                	jmp    531 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 525:	8b 10                	mov    (%eax),%edx
 527:	39 c2                	cmp    %eax,%edx
 529:	77 04                	ja     52f <free+0x1d>
 52b:	39 ca                	cmp    %ecx,%edx
 52d:	77 10                	ja     53f <free+0x2d>
{
 52f:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 531:	39 c8                	cmp    %ecx,%eax
 533:	73 f0                	jae    525 <free+0x13>
 535:	8b 10                	mov    (%eax),%edx
 537:	39 ca                	cmp    %ecx,%edx
 539:	77 04                	ja     53f <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 53b:	39 c2                	cmp    %eax,%edx
 53d:	77 f0                	ja     52f <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 53f:	8b 73 fc             	mov    -0x4(%ebx),%esi
 542:	8b 10                	mov    (%eax),%edx
 544:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 547:	39 fa                	cmp    %edi,%edx
 549:	74 19                	je     564 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 54b:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 54e:	8b 50 04             	mov    0x4(%eax),%edx
 551:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 554:	39 f1                	cmp    %esi,%ecx
 556:	74 1b                	je     573 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 558:	89 08                	mov    %ecx,(%eax)
  freep = p;
 55a:	a3 e4 08 00 00       	mov    %eax,0x8e4
}
 55f:	5b                   	pop    %ebx
 560:	5e                   	pop    %esi
 561:	5f                   	pop    %edi
 562:	5d                   	pop    %ebp
 563:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 564:	03 72 04             	add    0x4(%edx),%esi
 567:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 56a:	8b 10                	mov    (%eax),%edx
 56c:	8b 12                	mov    (%edx),%edx
 56e:	89 53 f8             	mov    %edx,-0x8(%ebx)
 571:	eb db                	jmp    54e <free+0x3c>
    p->s.size += bp->s.size;
 573:	03 53 fc             	add    -0x4(%ebx),%edx
 576:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 579:	8b 53 f8             	mov    -0x8(%ebx),%edx
 57c:	89 10                	mov    %edx,(%eax)
 57e:	eb da                	jmp    55a <free+0x48>

00000580 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 589:	8b 45 08             	mov    0x8(%ebp),%eax
 58c:	8d 58 07             	lea    0x7(%eax),%ebx
 58f:	c1 eb 03             	shr    $0x3,%ebx
 592:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 595:	8b 15 e4 08 00 00    	mov    0x8e4,%edx
 59b:	85 d2                	test   %edx,%edx
 59d:	74 20                	je     5bf <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 59f:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5a1:	8b 48 04             	mov    0x4(%eax),%ecx
 5a4:	39 cb                	cmp    %ecx,%ebx
 5a6:	76 3c                	jbe    5e4 <malloc+0x64>
 5a8:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5ae:	be 00 10 00 00       	mov    $0x1000,%esi
 5b3:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5b6:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 5bd:	eb 70                	jmp    62f <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 5bf:	c7 05 e4 08 00 00 e8 	movl   $0x8e8,0x8e4
 5c6:	08 00 00 
 5c9:	c7 05 e8 08 00 00 e8 	movl   $0x8e8,0x8e8
 5d0:	08 00 00 
    base.s.size = 0;
 5d3:	c7 05 ec 08 00 00 00 	movl   $0x0,0x8ec
 5da:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5dd:	ba e8 08 00 00       	mov    $0x8e8,%edx
 5e2:	eb bb                	jmp    59f <malloc+0x1f>
      if(p->s.size == nunits)
 5e4:	39 cb                	cmp    %ecx,%ebx
 5e6:	74 1c                	je     604 <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5e8:	29 d9                	sub    %ebx,%ecx
 5ea:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5ed:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5f0:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5f3:	89 15 e4 08 00 00    	mov    %edx,0x8e4
      return (void*)(p + 1);
 5f9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ff:	5b                   	pop    %ebx
 600:	5e                   	pop    %esi
 601:	5f                   	pop    %edi
 602:	5d                   	pop    %ebp
 603:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 604:	8b 08                	mov    (%eax),%ecx
 606:	89 0a                	mov    %ecx,(%edx)
 608:	eb e9                	jmp    5f3 <malloc+0x73>
  hp->s.size = nu;
 60a:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 60d:	83 ec 0c             	sub    $0xc,%esp
 610:	83 c0 08             	add    $0x8,%eax
 613:	50                   	push   %eax
 614:	e8 f9 fe ff ff       	call   512 <free>
  return freep;
 619:	8b 15 e4 08 00 00    	mov    0x8e4,%edx
      if((p = morecore(nunits)) == 0)
 61f:	83 c4 10             	add    $0x10,%esp
 622:	85 d2                	test   %edx,%edx
 624:	74 2b                	je     651 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 626:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 628:	8b 48 04             	mov    0x4(%eax),%ecx
 62b:	39 d9                	cmp    %ebx,%ecx
 62d:	73 b5                	jae    5e4 <malloc+0x64>
 62f:	89 c2                	mov    %eax,%edx
    if(p == freep)
 631:	39 05 e4 08 00 00    	cmp    %eax,0x8e4
 637:	75 ed                	jne    626 <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 639:	83 ec 0c             	sub    $0xc,%esp
 63c:	57                   	push   %edi
 63d:	e8 5e fc ff ff       	call   2a0 <sbrk>
  if(p == (char*)-1)
 642:	83 c4 10             	add    $0x10,%esp
 645:	83 f8 ff             	cmp    $0xffffffff,%eax
 648:	75 c0                	jne    60a <malloc+0x8a>
        return 0;
 64a:	b8 00 00 00 00       	mov    $0x0,%eax
 64f:	eb ab                	jmp    5fc <malloc+0x7c>
 651:	b8 00 00 00 00       	mov    $0x0,%eax
 656:	eb a4                	jmp    5fc <malloc+0x7c>

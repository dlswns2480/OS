
user/_zombie:     file format elf32-i386


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
  11:	e8 d0 01 00 00       	call   1e6 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7f 05                	jg     1f <main+0x1f>
    sleep(5);  // Let child exit before parent.
  exit();
  1a:	e8 cf 01 00 00       	call   1ee <exit>
    sleep(5);  // Let child exit before parent.
  1f:	83 ec 0c             	sub    $0xc,%esp
  22:	6a 05                	push   $0x5
  24:	e8 55 02 00 00       	call   27e <sleep>
  29:	83 c4 10             	add    $0x10,%esp
  2c:	eb ec                	jmp    1a <main+0x1a>

0000002e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  2e:	55                   	push   %ebp
  2f:	89 e5                	mov    %esp,%ebp
  31:	53                   	push   %ebx
  32:	8b 45 08             	mov    0x8(%ebp),%eax
  35:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  38:	89 c2                	mov    %eax,%edx
  3a:	83 c1 01             	add    $0x1,%ecx
  3d:	83 c2 01             	add    $0x1,%edx
  40:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  44:	88 5a ff             	mov    %bl,-0x1(%edx)
  47:	84 db                	test   %bl,%bl
  49:	75 ef                	jne    3a <strcpy+0xc>
    ;
  return os;
}
  4b:	5b                   	pop    %ebx
  4c:	5d                   	pop    %ebp
  4d:	c3                   	ret    

0000004e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4e:	55                   	push   %ebp
  4f:	89 e5                	mov    %esp,%ebp
  51:	8b 4d 08             	mov    0x8(%ebp),%ecx
  54:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  57:	0f b6 01             	movzbl (%ecx),%eax
  5a:	84 c0                	test   %al,%al
  5c:	74 15                	je     73 <strcmp+0x25>
  5e:	3a 02                	cmp    (%edx),%al
  60:	75 11                	jne    73 <strcmp+0x25>
    p++, q++;
  62:	83 c1 01             	add    $0x1,%ecx
  65:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  68:	0f b6 01             	movzbl (%ecx),%eax
  6b:	84 c0                	test   %al,%al
  6d:	74 04                	je     73 <strcmp+0x25>
  6f:	3a 02                	cmp    (%edx),%al
  71:	74 ef                	je     62 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  73:	0f b6 c0             	movzbl %al,%eax
  76:	0f b6 12             	movzbl (%edx),%edx
  79:	29 d0                	sub    %edx,%eax
}
  7b:	5d                   	pop    %ebp
  7c:	c3                   	ret    

0000007d <strlen>:

uint
strlen(const char *s)
{
  7d:	55                   	push   %ebp
  7e:	89 e5                	mov    %esp,%ebp
  80:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  83:	80 39 00             	cmpb   $0x0,(%ecx)
  86:	74 12                	je     9a <strlen+0x1d>
  88:	ba 00 00 00 00       	mov    $0x0,%edx
  8d:	83 c2 01             	add    $0x1,%edx
  90:	89 d0                	mov    %edx,%eax
  92:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  96:	75 f5                	jne    8d <strlen+0x10>
    ;
  return n;
}
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    
  for(n = 0; s[n]; n++)
  9a:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
  9f:	eb f7                	jmp    98 <strlen+0x1b>

000000a1 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a1:	55                   	push   %ebp
  a2:	89 e5                	mov    %esp,%ebp
  a4:	57                   	push   %edi
  a5:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  a8:	89 d7                	mov    %edx,%edi
  aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	fc                   	cld    
  b1:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b3:	89 d0                	mov    %edx,%eax
  b5:	5f                   	pop    %edi
  b6:	5d                   	pop    %ebp
  b7:	c3                   	ret    

000000b8 <strchr>:

char*
strchr(const char *s, char c)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	53                   	push   %ebx
  bc:	8b 45 08             	mov    0x8(%ebp),%eax
  bf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  c2:	0f b6 10             	movzbl (%eax),%edx
  c5:	84 d2                	test   %dl,%dl
  c7:	74 1e                	je     e7 <strchr+0x2f>
  c9:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
  cb:	38 d3                	cmp    %dl,%bl
  cd:	74 15                	je     e4 <strchr+0x2c>
  for(; *s; s++)
  cf:	83 c0 01             	add    $0x1,%eax
  d2:	0f b6 10             	movzbl (%eax),%edx
  d5:	84 d2                	test   %dl,%dl
  d7:	74 06                	je     df <strchr+0x27>
    if(*s == c)
  d9:	38 ca                	cmp    %cl,%dl
  db:	75 f2                	jne    cf <strchr+0x17>
  dd:	eb 05                	jmp    e4 <strchr+0x2c>
      return (char*)s;
  return 0;
  df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  return 0;
  e7:	b8 00 00 00 00       	mov    $0x0,%eax
  ec:	eb f6                	jmp    e4 <strchr+0x2c>

000000ee <gets>:

char*
gets(char *buf, int max)
{
  ee:	55                   	push   %ebp
  ef:	89 e5                	mov    %esp,%ebp
  f1:	57                   	push   %edi
  f2:	56                   	push   %esi
  f3:	53                   	push   %ebx
  f4:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f7:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
  fc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
  ff:	8d 5e 01             	lea    0x1(%esi),%ebx
 102:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 105:	7d 2b                	jge    132 <gets+0x44>
    cc = read(0, &c, 1);
 107:	83 ec 04             	sub    $0x4,%esp
 10a:	6a 01                	push   $0x1
 10c:	57                   	push   %edi
 10d:	6a 00                	push   $0x0
 10f:	e8 f2 00 00 00       	call   206 <read>
    if(cc < 1)
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	7e 17                	jle    132 <gets+0x44>
      break;
    buf[i++] = c;
 11b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 11f:	8b 55 08             	mov    0x8(%ebp),%edx
 122:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 126:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 128:	3c 0a                	cmp    $0xa,%al
 12a:	74 04                	je     130 <gets+0x42>
 12c:	3c 0d                	cmp    $0xd,%al
 12e:	75 cf                	jne    ff <gets+0x11>
  for(i=0; i+1 < max; ){
 130:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 139:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13c:	5b                   	pop    %ebx
 13d:	5e                   	pop    %esi
 13e:	5f                   	pop    %edi
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    

00000141 <stat>:

int
stat(const char *n, struct stat *st)
{
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 146:	83 ec 08             	sub    $0x8,%esp
 149:	6a 00                	push   $0x0
 14b:	ff 75 08             	pushl  0x8(%ebp)
 14e:	e8 db 00 00 00       	call   22e <open>
  if(fd < 0)
 153:	83 c4 10             	add    $0x10,%esp
 156:	85 c0                	test   %eax,%eax
 158:	78 24                	js     17e <stat+0x3d>
 15a:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 15c:	83 ec 08             	sub    $0x8,%esp
 15f:	ff 75 0c             	pushl  0xc(%ebp)
 162:	50                   	push   %eax
 163:	e8 de 00 00 00       	call   246 <fstat>
 168:	89 c6                	mov    %eax,%esi
  close(fd);
 16a:	89 1c 24             	mov    %ebx,(%esp)
 16d:	e8 a4 00 00 00       	call   216 <close>
  return r;
 172:	83 c4 10             	add    $0x10,%esp
}
 175:	89 f0                	mov    %esi,%eax
 177:	8d 65 f8             	lea    -0x8(%ebp),%esp
 17a:	5b                   	pop    %ebx
 17b:	5e                   	pop    %esi
 17c:	5d                   	pop    %ebp
 17d:	c3                   	ret    
    return -1;
 17e:	be ff ff ff ff       	mov    $0xffffffff,%esi
 183:	eb f0                	jmp    175 <stat+0x34>

00000185 <atoi>:

int
atoi(const char *s)
{
 185:	55                   	push   %ebp
 186:	89 e5                	mov    %esp,%ebp
 188:	53                   	push   %ebx
 189:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 18c:	0f b6 11             	movzbl (%ecx),%edx
 18f:	8d 42 d0             	lea    -0x30(%edx),%eax
 192:	3c 09                	cmp    $0x9,%al
 194:	77 20                	ja     1b6 <atoi+0x31>
  n = 0;
 196:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 19b:	83 c1 01             	add    $0x1,%ecx
 19e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1a1:	0f be d2             	movsbl %dl,%edx
 1a4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 1a8:	0f b6 11             	movzbl (%ecx),%edx
 1ab:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ae:	80 fb 09             	cmp    $0x9,%bl
 1b1:	76 e8                	jbe    19b <atoi+0x16>
  return n;
}
 1b3:	5b                   	pop    %ebx
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
  n = 0;
 1b6:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 1bb:	eb f6                	jmp    1b3 <atoi+0x2e>

000001bd <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	56                   	push   %esi
 1c1:	53                   	push   %ebx
 1c2:	8b 45 08             	mov    0x8(%ebp),%eax
 1c5:	8b 75 0c             	mov    0xc(%ebp),%esi
 1c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1cb:	85 db                	test   %ebx,%ebx
 1cd:	7e 13                	jle    1e2 <memmove+0x25>
 1cf:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 1d4:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 1d8:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1db:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 1de:	39 d3                	cmp    %edx,%ebx
 1e0:	75 f2                	jne    1d4 <memmove+0x17>
  return vdst;
}
 1e2:	5b                   	pop    %ebx
 1e3:	5e                   	pop    %esi
 1e4:	5d                   	pop    %ebp
 1e5:	c3                   	ret    

000001e6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1e6:	b8 01 00 00 00       	mov    $0x1,%eax
 1eb:	cd 40                	int    $0x40
 1ed:	c3                   	ret    

000001ee <exit>:
SYSCALL(exit)
 1ee:	b8 02 00 00 00       	mov    $0x2,%eax
 1f3:	cd 40                	int    $0x40
 1f5:	c3                   	ret    

000001f6 <wait>:
SYSCALL(wait)
 1f6:	b8 03 00 00 00       	mov    $0x3,%eax
 1fb:	cd 40                	int    $0x40
 1fd:	c3                   	ret    

000001fe <pipe>:
SYSCALL(pipe)
 1fe:	b8 04 00 00 00       	mov    $0x4,%eax
 203:	cd 40                	int    $0x40
 205:	c3                   	ret    

00000206 <read>:
SYSCALL(read)
 206:	b8 05 00 00 00       	mov    $0x5,%eax
 20b:	cd 40                	int    $0x40
 20d:	c3                   	ret    

0000020e <write>:
SYSCALL(write)
 20e:	b8 10 00 00 00       	mov    $0x10,%eax
 213:	cd 40                	int    $0x40
 215:	c3                   	ret    

00000216 <close>:
SYSCALL(close)
 216:	b8 15 00 00 00       	mov    $0x15,%eax
 21b:	cd 40                	int    $0x40
 21d:	c3                   	ret    

0000021e <kill>:
SYSCALL(kill)
 21e:	b8 06 00 00 00       	mov    $0x6,%eax
 223:	cd 40                	int    $0x40
 225:	c3                   	ret    

00000226 <exec>:
SYSCALL(exec)
 226:	b8 07 00 00 00       	mov    $0x7,%eax
 22b:	cd 40                	int    $0x40
 22d:	c3                   	ret    

0000022e <open>:
SYSCALL(open)
 22e:	b8 0f 00 00 00       	mov    $0xf,%eax
 233:	cd 40                	int    $0x40
 235:	c3                   	ret    

00000236 <mknod>:
SYSCALL(mknod)
 236:	b8 11 00 00 00       	mov    $0x11,%eax
 23b:	cd 40                	int    $0x40
 23d:	c3                   	ret    

0000023e <unlink>:
SYSCALL(unlink)
 23e:	b8 12 00 00 00       	mov    $0x12,%eax
 243:	cd 40                	int    $0x40
 245:	c3                   	ret    

00000246 <fstat>:
SYSCALL(fstat)
 246:	b8 08 00 00 00       	mov    $0x8,%eax
 24b:	cd 40                	int    $0x40
 24d:	c3                   	ret    

0000024e <link>:
SYSCALL(link)
 24e:	b8 13 00 00 00       	mov    $0x13,%eax
 253:	cd 40                	int    $0x40
 255:	c3                   	ret    

00000256 <mkdir>:
SYSCALL(mkdir)
 256:	b8 14 00 00 00       	mov    $0x14,%eax
 25b:	cd 40                	int    $0x40
 25d:	c3                   	ret    

0000025e <chdir>:
SYSCALL(chdir)
 25e:	b8 09 00 00 00       	mov    $0x9,%eax
 263:	cd 40                	int    $0x40
 265:	c3                   	ret    

00000266 <dup>:
SYSCALL(dup)
 266:	b8 0a 00 00 00       	mov    $0xa,%eax
 26b:	cd 40                	int    $0x40
 26d:	c3                   	ret    

0000026e <getpid>:
SYSCALL(getpid)
 26e:	b8 0b 00 00 00       	mov    $0xb,%eax
 273:	cd 40                	int    $0x40
 275:	c3                   	ret    

00000276 <sbrk>:
SYSCALL(sbrk)
 276:	b8 0c 00 00 00       	mov    $0xc,%eax
 27b:	cd 40                	int    $0x40
 27d:	c3                   	ret    

0000027e <sleep>:
SYSCALL(sleep)
 27e:	b8 0d 00 00 00       	mov    $0xd,%eax
 283:	cd 40                	int    $0x40
 285:	c3                   	ret    

00000286 <uptime>:
SYSCALL(uptime)
 286:	b8 0e 00 00 00       	mov    $0xe,%eax
 28b:	cd 40                	int    $0x40
 28d:	c3                   	ret    

0000028e <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 28e:	55                   	push   %ebp
 28f:	89 e5                	mov    %esp,%ebp
 291:	57                   	push   %edi
 292:	56                   	push   %esi
 293:	53                   	push   %ebx
 294:	83 ec 3c             	sub    $0x3c,%esp
 297:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 299:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 29d:	74 14                	je     2b3 <printint+0x25>
 29f:	85 d2                	test   %edx,%edx
 2a1:	79 10                	jns    2b3 <printint+0x25>
    neg = 1;
    x = -xx;
 2a3:	f7 da                	neg    %edx
    neg = 1;
 2a5:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2ac:	bf 00 00 00 00       	mov    $0x0,%edi
 2b1:	eb 0b                	jmp    2be <printint+0x30>
  neg = 0;
 2b3:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 2ba:	eb f0                	jmp    2ac <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 2bc:	89 df                	mov    %ebx,%edi
 2be:	8d 5f 01             	lea    0x1(%edi),%ebx
 2c1:	89 d0                	mov    %edx,%eax
 2c3:	ba 00 00 00 00       	mov    $0x0,%edx
 2c8:	f7 f1                	div    %ecx
 2ca:	0f b6 92 38 06 00 00 	movzbl 0x638(%edx),%edx
 2d1:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 2d5:	89 c2                	mov    %eax,%edx
 2d7:	85 c0                	test   %eax,%eax
 2d9:	75 e1                	jne    2bc <printint+0x2e>
  if(neg)
 2db:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 2df:	74 08                	je     2e9 <printint+0x5b>
    buf[i++] = '-';
 2e1:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 2e6:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 2e9:	83 eb 01             	sub    $0x1,%ebx
 2ec:	78 22                	js     310 <printint+0x82>
  write(fd, &c, 1);
 2ee:	8d 7d d7             	lea    -0x29(%ebp),%edi
 2f1:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 2f6:	88 45 d7             	mov    %al,-0x29(%ebp)
 2f9:	83 ec 04             	sub    $0x4,%esp
 2fc:	6a 01                	push   $0x1
 2fe:	57                   	push   %edi
 2ff:	56                   	push   %esi
 300:	e8 09 ff ff ff       	call   20e <write>
  while(--i >= 0)
 305:	83 eb 01             	sub    $0x1,%ebx
 308:	83 c4 10             	add    $0x10,%esp
 30b:	83 fb ff             	cmp    $0xffffffff,%ebx
 30e:	75 e1                	jne    2f1 <printint+0x63>
    putc(fd, buf[i]);
}
 310:	8d 65 f4             	lea    -0xc(%ebp),%esp
 313:	5b                   	pop    %ebx
 314:	5e                   	pop    %esi
 315:	5f                   	pop    %edi
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    

00000318 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	57                   	push   %edi
 31c:	56                   	push   %esi
 31d:	53                   	push   %ebx
 31e:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 321:	8b 75 0c             	mov    0xc(%ebp),%esi
 324:	0f b6 1e             	movzbl (%esi),%ebx
 327:	84 db                	test   %bl,%bl
 329:	0f 84 b1 01 00 00    	je     4e0 <printf+0x1c8>
 32f:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 332:	8d 45 10             	lea    0x10(%ebp),%eax
 335:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 338:	bf 00 00 00 00       	mov    $0x0,%edi
 33d:	eb 2d                	jmp    36c <printf+0x54>
 33f:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 342:	83 ec 04             	sub    $0x4,%esp
 345:	6a 01                	push   $0x1
 347:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 34a:	50                   	push   %eax
 34b:	ff 75 08             	pushl  0x8(%ebp)
 34e:	e8 bb fe ff ff       	call   20e <write>
 353:	83 c4 10             	add    $0x10,%esp
 356:	eb 05                	jmp    35d <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 358:	83 ff 25             	cmp    $0x25,%edi
 35b:	74 22                	je     37f <printf+0x67>
 35d:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 360:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 364:	84 db                	test   %bl,%bl
 366:	0f 84 74 01 00 00    	je     4e0 <printf+0x1c8>
    c = fmt[i] & 0xff;
 36c:	0f be d3             	movsbl %bl,%edx
 36f:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 372:	85 ff                	test   %edi,%edi
 374:	75 e2                	jne    358 <printf+0x40>
      if(c == '%'){
 376:	83 f8 25             	cmp    $0x25,%eax
 379:	75 c4                	jne    33f <printf+0x27>
        state = '%';
 37b:	89 c7                	mov    %eax,%edi
 37d:	eb de                	jmp    35d <printf+0x45>
      if(c == 'd'){
 37f:	83 f8 64             	cmp    $0x64,%eax
 382:	74 59                	je     3dd <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 384:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 38a:	83 fa 70             	cmp    $0x70,%edx
 38d:	74 7a                	je     409 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 38f:	83 f8 73             	cmp    $0x73,%eax
 392:	0f 84 9d 00 00 00    	je     435 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 398:	83 f8 63             	cmp    $0x63,%eax
 39b:	0f 84 f2 00 00 00    	je     493 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3a1:	83 f8 25             	cmp    $0x25,%eax
 3a4:	0f 84 15 01 00 00    	je     4bf <printf+0x1a7>
 3aa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3ae:	83 ec 04             	sub    $0x4,%esp
 3b1:	6a 01                	push   $0x1
 3b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3b6:	50                   	push   %eax
 3b7:	ff 75 08             	pushl  0x8(%ebp)
 3ba:	e8 4f fe ff ff       	call   20e <write>
 3bf:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3c2:	83 c4 0c             	add    $0xc,%esp
 3c5:	6a 01                	push   $0x1
 3c7:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ca:	50                   	push   %eax
 3cb:	ff 75 08             	pushl  0x8(%ebp)
 3ce:	e8 3b fe ff ff       	call   20e <write>
 3d3:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3d6:	bf 00 00 00 00       	mov    $0x0,%edi
 3db:	eb 80                	jmp    35d <printf+0x45>
        printint(fd, *ap, 10, 1);
 3dd:	83 ec 0c             	sub    $0xc,%esp
 3e0:	6a 01                	push   $0x1
 3e2:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3e7:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 3ea:	8b 17                	mov    (%edi),%edx
 3ec:	8b 45 08             	mov    0x8(%ebp),%eax
 3ef:	e8 9a fe ff ff       	call   28e <printint>
        ap++;
 3f4:	89 f8                	mov    %edi,%eax
 3f6:	83 c0 04             	add    $0x4,%eax
 3f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3ff:	bf 00 00 00 00       	mov    $0x0,%edi
 404:	e9 54 ff ff ff       	jmp    35d <printf+0x45>
        printint(fd, *ap, 16, 0);
 409:	83 ec 0c             	sub    $0xc,%esp
 40c:	6a 00                	push   $0x0
 40e:	b9 10 00 00 00       	mov    $0x10,%ecx
 413:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 416:	8b 17                	mov    (%edi),%edx
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	e8 6e fe ff ff       	call   28e <printint>
        ap++;
 420:	89 f8                	mov    %edi,%eax
 422:	83 c0 04             	add    $0x4,%eax
 425:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 428:	83 c4 10             	add    $0x10,%esp
      state = 0;
 42b:	bf 00 00 00 00       	mov    $0x0,%edi
 430:	e9 28 ff ff ff       	jmp    35d <printf+0x45>
        s = (char*)*ap;
 435:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 438:	8b 01                	mov    (%ecx),%eax
        ap++;
 43a:	83 c1 04             	add    $0x4,%ecx
 43d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 440:	85 c0                	test   %eax,%eax
 442:	74 13                	je     457 <printf+0x13f>
        s = (char*)*ap;
 444:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 446:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 449:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 44e:	84 c0                	test   %al,%al
 450:	75 0f                	jne    461 <printf+0x149>
 452:	e9 06 ff ff ff       	jmp    35d <printf+0x45>
          s = "(null)";
 457:	bb 30 06 00 00       	mov    $0x630,%ebx
        while(*s != 0){
 45c:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 461:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 464:	89 75 d0             	mov    %esi,-0x30(%ebp)
 467:	8b 75 08             	mov    0x8(%ebp),%esi
 46a:	88 45 e3             	mov    %al,-0x1d(%ebp)
 46d:	83 ec 04             	sub    $0x4,%esp
 470:	6a 01                	push   $0x1
 472:	57                   	push   %edi
 473:	56                   	push   %esi
 474:	e8 95 fd ff ff       	call   20e <write>
          s++;
 479:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 47c:	0f b6 03             	movzbl (%ebx),%eax
 47f:	83 c4 10             	add    $0x10,%esp
 482:	84 c0                	test   %al,%al
 484:	75 e4                	jne    46a <printf+0x152>
 486:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 489:	bf 00 00 00 00       	mov    $0x0,%edi
 48e:	e9 ca fe ff ff       	jmp    35d <printf+0x45>
        putc(fd, *ap);
 493:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 496:	8b 07                	mov    (%edi),%eax
 498:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 49b:	83 ec 04             	sub    $0x4,%esp
 49e:	6a 01                	push   $0x1
 4a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4a3:	50                   	push   %eax
 4a4:	ff 75 08             	pushl  0x8(%ebp)
 4a7:	e8 62 fd ff ff       	call   20e <write>
        ap++;
 4ac:	83 c7 04             	add    $0x4,%edi
 4af:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 4b2:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4b5:	bf 00 00 00 00       	mov    $0x0,%edi
 4ba:	e9 9e fe ff ff       	jmp    35d <printf+0x45>
 4bf:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 4c2:	83 ec 04             	sub    $0x4,%esp
 4c5:	6a 01                	push   $0x1
 4c7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4ca:	50                   	push   %eax
 4cb:	ff 75 08             	pushl  0x8(%ebp)
 4ce:	e8 3b fd ff ff       	call   20e <write>
 4d3:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4d6:	bf 00 00 00 00       	mov    $0x0,%edi
 4db:	e9 7d fe ff ff       	jmp    35d <printf+0x45>
    }
  }
}
 4e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e3:	5b                   	pop    %ebx
 4e4:	5e                   	pop    %esi
 4e5:	5f                   	pop    %edi
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    

000004e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4e8:	55                   	push   %ebp
 4e9:	89 e5                	mov    %esp,%ebp
 4eb:	57                   	push   %edi
 4ec:	56                   	push   %esi
 4ed:	53                   	push   %ebx
 4ee:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4f1:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4f4:	a1 a0 08 00 00       	mov    0x8a0,%eax
 4f9:	eb 0c                	jmp    507 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4fb:	8b 10                	mov    (%eax),%edx
 4fd:	39 c2                	cmp    %eax,%edx
 4ff:	77 04                	ja     505 <free+0x1d>
 501:	39 ca                	cmp    %ecx,%edx
 503:	77 10                	ja     515 <free+0x2d>
{
 505:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 507:	39 c8                	cmp    %ecx,%eax
 509:	73 f0                	jae    4fb <free+0x13>
 50b:	8b 10                	mov    (%eax),%edx
 50d:	39 ca                	cmp    %ecx,%edx
 50f:	77 04                	ja     515 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 511:	39 c2                	cmp    %eax,%edx
 513:	77 f0                	ja     505 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 515:	8b 73 fc             	mov    -0x4(%ebx),%esi
 518:	8b 10                	mov    (%eax),%edx
 51a:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 51d:	39 fa                	cmp    %edi,%edx
 51f:	74 19                	je     53a <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 521:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 524:	8b 50 04             	mov    0x4(%eax),%edx
 527:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 52a:	39 f1                	cmp    %esi,%ecx
 52c:	74 1b                	je     549 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 52e:	89 08                	mov    %ecx,(%eax)
  freep = p;
 530:	a3 a0 08 00 00       	mov    %eax,0x8a0
}
 535:	5b                   	pop    %ebx
 536:	5e                   	pop    %esi
 537:	5f                   	pop    %edi
 538:	5d                   	pop    %ebp
 539:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 53a:	03 72 04             	add    0x4(%edx),%esi
 53d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 540:	8b 10                	mov    (%eax),%edx
 542:	8b 12                	mov    (%edx),%edx
 544:	89 53 f8             	mov    %edx,-0x8(%ebx)
 547:	eb db                	jmp    524 <free+0x3c>
    p->s.size += bp->s.size;
 549:	03 53 fc             	add    -0x4(%ebx),%edx
 54c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 54f:	8b 53 f8             	mov    -0x8(%ebx),%edx
 552:	89 10                	mov    %edx,(%eax)
 554:	eb da                	jmp    530 <free+0x48>

00000556 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 556:	55                   	push   %ebp
 557:	89 e5                	mov    %esp,%ebp
 559:	57                   	push   %edi
 55a:	56                   	push   %esi
 55b:	53                   	push   %ebx
 55c:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 55f:	8b 45 08             	mov    0x8(%ebp),%eax
 562:	8d 58 07             	lea    0x7(%eax),%ebx
 565:	c1 eb 03             	shr    $0x3,%ebx
 568:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 56b:	8b 15 a0 08 00 00    	mov    0x8a0,%edx
 571:	85 d2                	test   %edx,%edx
 573:	74 20                	je     595 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 575:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 577:	8b 48 04             	mov    0x4(%eax),%ecx
 57a:	39 cb                	cmp    %ecx,%ebx
 57c:	76 3c                	jbe    5ba <malloc+0x64>
 57e:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 584:	be 00 10 00 00       	mov    $0x1000,%esi
 589:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 58c:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 593:	eb 70                	jmp    605 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 595:	c7 05 a0 08 00 00 a4 	movl   $0x8a4,0x8a0
 59c:	08 00 00 
 59f:	c7 05 a4 08 00 00 a4 	movl   $0x8a4,0x8a4
 5a6:	08 00 00 
    base.s.size = 0;
 5a9:	c7 05 a8 08 00 00 00 	movl   $0x0,0x8a8
 5b0:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5b3:	ba a4 08 00 00       	mov    $0x8a4,%edx
 5b8:	eb bb                	jmp    575 <malloc+0x1f>
      if(p->s.size == nunits)
 5ba:	39 cb                	cmp    %ecx,%ebx
 5bc:	74 1c                	je     5da <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5be:	29 d9                	sub    %ebx,%ecx
 5c0:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5c3:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5c6:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5c9:	89 15 a0 08 00 00    	mov    %edx,0x8a0
      return (void*)(p + 1);
 5cf:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d5:	5b                   	pop    %ebx
 5d6:	5e                   	pop    %esi
 5d7:	5f                   	pop    %edi
 5d8:	5d                   	pop    %ebp
 5d9:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5da:	8b 08                	mov    (%eax),%ecx
 5dc:	89 0a                	mov    %ecx,(%edx)
 5de:	eb e9                	jmp    5c9 <malloc+0x73>
  hp->s.size = nu;
 5e0:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 5e3:	83 ec 0c             	sub    $0xc,%esp
 5e6:	83 c0 08             	add    $0x8,%eax
 5e9:	50                   	push   %eax
 5ea:	e8 f9 fe ff ff       	call   4e8 <free>
  return freep;
 5ef:	8b 15 a0 08 00 00    	mov    0x8a0,%edx
      if((p = morecore(nunits)) == 0)
 5f5:	83 c4 10             	add    $0x10,%esp
 5f8:	85 d2                	test   %edx,%edx
 5fa:	74 2b                	je     627 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5fc:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5fe:	8b 48 04             	mov    0x4(%eax),%ecx
 601:	39 d9                	cmp    %ebx,%ecx
 603:	73 b5                	jae    5ba <malloc+0x64>
 605:	89 c2                	mov    %eax,%edx
    if(p == freep)
 607:	39 05 a0 08 00 00    	cmp    %eax,0x8a0
 60d:	75 ed                	jne    5fc <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 60f:	83 ec 0c             	sub    $0xc,%esp
 612:	57                   	push   %edi
 613:	e8 5e fc ff ff       	call   276 <sbrk>
  if(p == (char*)-1)
 618:	83 c4 10             	add    $0x10,%esp
 61b:	83 f8 ff             	cmp    $0xffffffff,%eax
 61e:	75 c0                	jne    5e0 <malloc+0x8a>
        return 0;
 620:	b8 00 00 00 00       	mov    $0x0,%eax
 625:	eb ab                	jmp    5d2 <malloc+0x7c>
 627:	b8 00 00 00 00       	mov    $0x0,%eax
 62c:	eb a4                	jmp    5d2 <malloc+0x7c>

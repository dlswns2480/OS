
user/_rm:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	83 c3 04             	add    $0x4,%ebx
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  1c:	be 01 00 00 00       	mov    $0x1,%esi
  if(argc < 2){
  21:	83 ff 01             	cmp    $0x1,%edi
  24:	7e 20                	jle    46 <main+0x46>
    if(unlink(argv[i]) < 0){
  26:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	ff 33                	pushl  (%ebx)
  2e:	e8 53 02 00 00       	call   286 <unlink>
  33:	83 c4 10             	add    $0x10,%esp
  36:	85 c0                	test   %eax,%eax
  38:	78 20                	js     5a <main+0x5a>
  for(i = 1; i < argc; i++){
  3a:	83 c6 01             	add    $0x1,%esi
  3d:	83 c3 04             	add    $0x4,%ebx
  40:	39 f7                	cmp    %esi,%edi
  42:	75 e2                	jne    26 <main+0x26>
  44:	eb 2b                	jmp    71 <main+0x71>
    printf(2, "Usage: rm files...\n");
  46:	83 ec 08             	sub    $0x8,%esp
  49:	68 78 06 00 00       	push   $0x678
  4e:	6a 02                	push   $0x2
  50:	e8 0b 03 00 00       	call   360 <printf>
    exit();
  55:	e8 dc 01 00 00       	call   236 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	83 ec 04             	sub    $0x4,%esp
  5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  60:	ff 30                	pushl  (%eax)
  62:	68 8c 06 00 00       	push   $0x68c
  67:	6a 02                	push   $0x2
  69:	e8 f2 02 00 00       	call   360 <printf>
      break;
  6e:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit();
  71:	e8 c0 01 00 00       	call   236 <exit>

00000076 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  76:	55                   	push   %ebp
  77:	89 e5                	mov    %esp,%ebp
  79:	53                   	push   %ebx
  7a:	8b 45 08             	mov    0x8(%ebp),%eax
  7d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	89 c2                	mov    %eax,%edx
  82:	83 c1 01             	add    $0x1,%ecx
  85:	83 c2 01             	add    $0x1,%edx
  88:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	84 db                	test   %bl,%bl
  91:	75 ef                	jne    82 <strcpy+0xc>
    ;
  return os;
}
  93:	5b                   	pop    %ebx
  94:	5d                   	pop    %ebp
  95:	c3                   	ret    

00000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	55                   	push   %ebp
  97:	89 e5                	mov    %esp,%ebp
  99:	8b 4d 08             	mov    0x8(%ebp),%ecx
  9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  9f:	0f b6 01             	movzbl (%ecx),%eax
  a2:	84 c0                	test   %al,%al
  a4:	74 15                	je     bb <strcmp+0x25>
  a6:	3a 02                	cmp    (%edx),%al
  a8:	75 11                	jne    bb <strcmp+0x25>
    p++, q++;
  aa:	83 c1 01             	add    $0x1,%ecx
  ad:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b0:	0f b6 01             	movzbl (%ecx),%eax
  b3:	84 c0                	test   %al,%al
  b5:	74 04                	je     bb <strcmp+0x25>
  b7:	3a 02                	cmp    (%edx),%al
  b9:	74 ef                	je     aa <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  bb:	0f b6 c0             	movzbl %al,%eax
  be:	0f b6 12             	movzbl (%edx),%edx
  c1:	29 d0                	sub    %edx,%eax
}
  c3:	5d                   	pop    %ebp
  c4:	c3                   	ret    

000000c5 <strlen>:

uint
strlen(const char *s)
{
  c5:	55                   	push   %ebp
  c6:	89 e5                	mov    %esp,%ebp
  c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  cb:	80 39 00             	cmpb   $0x0,(%ecx)
  ce:	74 12                	je     e2 <strlen+0x1d>
  d0:	ba 00 00 00 00       	mov    $0x0,%edx
  d5:	83 c2 01             	add    $0x1,%edx
  d8:	89 d0                	mov    %edx,%eax
  da:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  de:	75 f5                	jne    d5 <strlen+0x10>
    ;
  return n;
}
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    
  for(n = 0; s[n]; n++)
  e2:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
  e7:	eb f7                	jmp    e0 <strlen+0x1b>

000000e9 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e9:	55                   	push   %ebp
  ea:	89 e5                	mov    %esp,%ebp
  ec:	57                   	push   %edi
  ed:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f0:	89 d7                	mov    %edx,%edi
  f2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  f8:	fc                   	cld    
  f9:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  fb:	89 d0                	mov    %edx,%eax
  fd:	5f                   	pop    %edi
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1e                	je     12f <strchr+0x2f>
 111:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 113:	38 d3                	cmp    %dl,%bl
 115:	74 15                	je     12c <strchr+0x2c>
  for(; *s; s++)
 117:	83 c0 01             	add    $0x1,%eax
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	74 06                	je     127 <strchr+0x27>
    if(*s == c)
 121:	38 ca                	cmp    %cl,%dl
 123:	75 f2                	jne    117 <strchr+0x17>
 125:	eb 05                	jmp    12c <strchr+0x2c>
      return (char*)s;
  return 0;
 127:	b8 00 00 00 00       	mov    $0x0,%eax
}
 12c:	5b                   	pop    %ebx
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    
  return 0;
 12f:	b8 00 00 00 00       	mov    $0x0,%eax
 134:	eb f6                	jmp    12c <strchr+0x2c>

00000136 <gets>:

char*
gets(char *buf, int max)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
 139:	57                   	push   %edi
 13a:	56                   	push   %esi
 13b:	53                   	push   %ebx
 13c:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13f:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 144:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 147:	8d 5e 01             	lea    0x1(%esi),%ebx
 14a:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 14d:	7d 2b                	jge    17a <gets+0x44>
    cc = read(0, &c, 1);
 14f:	83 ec 04             	sub    $0x4,%esp
 152:	6a 01                	push   $0x1
 154:	57                   	push   %edi
 155:	6a 00                	push   $0x0
 157:	e8 f2 00 00 00       	call   24e <read>
    if(cc < 1)
 15c:	83 c4 10             	add    $0x10,%esp
 15f:	85 c0                	test   %eax,%eax
 161:	7e 17                	jle    17a <gets+0x44>
      break;
    buf[i++] = c;
 163:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 167:	8b 55 08             	mov    0x8(%ebp),%edx
 16a:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 16e:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 170:	3c 0a                	cmp    $0xa,%al
 172:	74 04                	je     178 <gets+0x42>
 174:	3c 0d                	cmp    $0xd,%al
 176:	75 cf                	jne    147 <gets+0x11>
  for(i=0; i+1 < max; ){
 178:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 181:	8d 65 f4             	lea    -0xc(%ebp),%esp
 184:	5b                   	pop    %ebx
 185:	5e                   	pop    %esi
 186:	5f                   	pop    %edi
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    

00000189 <stat>:

int
stat(const char *n, struct stat *st)
{
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
 18c:	56                   	push   %esi
 18d:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18e:	83 ec 08             	sub    $0x8,%esp
 191:	6a 00                	push   $0x0
 193:	ff 75 08             	pushl  0x8(%ebp)
 196:	e8 db 00 00 00       	call   276 <open>
  if(fd < 0)
 19b:	83 c4 10             	add    $0x10,%esp
 19e:	85 c0                	test   %eax,%eax
 1a0:	78 24                	js     1c6 <stat+0x3d>
 1a2:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a4:	83 ec 08             	sub    $0x8,%esp
 1a7:	ff 75 0c             	pushl  0xc(%ebp)
 1aa:	50                   	push   %eax
 1ab:	e8 de 00 00 00       	call   28e <fstat>
 1b0:	89 c6                	mov    %eax,%esi
  close(fd);
 1b2:	89 1c 24             	mov    %ebx,(%esp)
 1b5:	e8 a4 00 00 00       	call   25e <close>
  return r;
 1ba:	83 c4 10             	add    $0x10,%esp
}
 1bd:	89 f0                	mov    %esi,%eax
 1bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c2:	5b                   	pop    %ebx
 1c3:	5e                   	pop    %esi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    
    return -1;
 1c6:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1cb:	eb f0                	jmp    1bd <stat+0x34>

000001cd <atoi>:

int
atoi(const char *s)
{
 1cd:	55                   	push   %ebp
 1ce:	89 e5                	mov    %esp,%ebp
 1d0:	53                   	push   %ebx
 1d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d4:	0f b6 11             	movzbl (%ecx),%edx
 1d7:	8d 42 d0             	lea    -0x30(%edx),%eax
 1da:	3c 09                	cmp    $0x9,%al
 1dc:	77 20                	ja     1fe <atoi+0x31>
  n = 0;
 1de:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 1e3:	83 c1 01             	add    $0x1,%ecx
 1e6:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1e9:	0f be d2             	movsbl %dl,%edx
 1ec:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 1f0:	0f b6 11             	movzbl (%ecx),%edx
 1f3:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1f6:	80 fb 09             	cmp    $0x9,%bl
 1f9:	76 e8                	jbe    1e3 <atoi+0x16>
  return n;
}
 1fb:	5b                   	pop    %ebx
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    
  n = 0;
 1fe:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 203:	eb f6                	jmp    1fb <atoi+0x2e>

00000205 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 205:	55                   	push   %ebp
 206:	89 e5                	mov    %esp,%ebp
 208:	56                   	push   %esi
 209:	53                   	push   %ebx
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	8b 75 0c             	mov    0xc(%ebp),%esi
 210:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 213:	85 db                	test   %ebx,%ebx
 215:	7e 13                	jle    22a <memmove+0x25>
 217:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 21c:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 220:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 223:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 226:	39 d3                	cmp    %edx,%ebx
 228:	75 f2                	jne    21c <memmove+0x17>
  return vdst;
}
 22a:	5b                   	pop    %ebx
 22b:	5e                   	pop    %esi
 22c:	5d                   	pop    %ebp
 22d:	c3                   	ret    

0000022e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 22e:	b8 01 00 00 00       	mov    $0x1,%eax
 233:	cd 40                	int    $0x40
 235:	c3                   	ret    

00000236 <exit>:
SYSCALL(exit)
 236:	b8 02 00 00 00       	mov    $0x2,%eax
 23b:	cd 40                	int    $0x40
 23d:	c3                   	ret    

0000023e <wait>:
SYSCALL(wait)
 23e:	b8 03 00 00 00       	mov    $0x3,%eax
 243:	cd 40                	int    $0x40
 245:	c3                   	ret    

00000246 <pipe>:
SYSCALL(pipe)
 246:	b8 04 00 00 00       	mov    $0x4,%eax
 24b:	cd 40                	int    $0x40
 24d:	c3                   	ret    

0000024e <read>:
SYSCALL(read)
 24e:	b8 05 00 00 00       	mov    $0x5,%eax
 253:	cd 40                	int    $0x40
 255:	c3                   	ret    

00000256 <write>:
SYSCALL(write)
 256:	b8 10 00 00 00       	mov    $0x10,%eax
 25b:	cd 40                	int    $0x40
 25d:	c3                   	ret    

0000025e <close>:
SYSCALL(close)
 25e:	b8 15 00 00 00       	mov    $0x15,%eax
 263:	cd 40                	int    $0x40
 265:	c3                   	ret    

00000266 <kill>:
SYSCALL(kill)
 266:	b8 06 00 00 00       	mov    $0x6,%eax
 26b:	cd 40                	int    $0x40
 26d:	c3                   	ret    

0000026e <exec>:
SYSCALL(exec)
 26e:	b8 07 00 00 00       	mov    $0x7,%eax
 273:	cd 40                	int    $0x40
 275:	c3                   	ret    

00000276 <open>:
SYSCALL(open)
 276:	b8 0f 00 00 00       	mov    $0xf,%eax
 27b:	cd 40                	int    $0x40
 27d:	c3                   	ret    

0000027e <mknod>:
SYSCALL(mknod)
 27e:	b8 11 00 00 00       	mov    $0x11,%eax
 283:	cd 40                	int    $0x40
 285:	c3                   	ret    

00000286 <unlink>:
SYSCALL(unlink)
 286:	b8 12 00 00 00       	mov    $0x12,%eax
 28b:	cd 40                	int    $0x40
 28d:	c3                   	ret    

0000028e <fstat>:
SYSCALL(fstat)
 28e:	b8 08 00 00 00       	mov    $0x8,%eax
 293:	cd 40                	int    $0x40
 295:	c3                   	ret    

00000296 <link>:
SYSCALL(link)
 296:	b8 13 00 00 00       	mov    $0x13,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <mkdir>:
SYSCALL(mkdir)
 29e:	b8 14 00 00 00       	mov    $0x14,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <chdir>:
SYSCALL(chdir)
 2a6:	b8 09 00 00 00       	mov    $0x9,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <dup>:
SYSCALL(dup)
 2ae:	b8 0a 00 00 00       	mov    $0xa,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <getpid>:
SYSCALL(getpid)
 2b6:	b8 0b 00 00 00       	mov    $0xb,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <sbrk>:
SYSCALL(sbrk)
 2be:	b8 0c 00 00 00       	mov    $0xc,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <sleep>:
SYSCALL(sleep)
 2c6:	b8 0d 00 00 00       	mov    $0xd,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <uptime>:
SYSCALL(uptime)
 2ce:	b8 0e 00 00 00       	mov    $0xe,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d6:	55                   	push   %ebp
 2d7:	89 e5                	mov    %esp,%ebp
 2d9:	57                   	push   %edi
 2da:	56                   	push   %esi
 2db:	53                   	push   %ebx
 2dc:	83 ec 3c             	sub    $0x3c,%esp
 2df:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2e5:	74 14                	je     2fb <printint+0x25>
 2e7:	85 d2                	test   %edx,%edx
 2e9:	79 10                	jns    2fb <printint+0x25>
    neg = 1;
    x = -xx;
 2eb:	f7 da                	neg    %edx
    neg = 1;
 2ed:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2f4:	bf 00 00 00 00       	mov    $0x0,%edi
 2f9:	eb 0b                	jmp    306 <printint+0x30>
  neg = 0;
 2fb:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 302:	eb f0                	jmp    2f4 <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 304:	89 df                	mov    %ebx,%edi
 306:	8d 5f 01             	lea    0x1(%edi),%ebx
 309:	89 d0                	mov    %edx,%eax
 30b:	ba 00 00 00 00       	mov    $0x0,%edx
 310:	f7 f1                	div    %ecx
 312:	0f b6 92 ac 06 00 00 	movzbl 0x6ac(%edx),%edx
 319:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 31d:	89 c2                	mov    %eax,%edx
 31f:	85 c0                	test   %eax,%eax
 321:	75 e1                	jne    304 <printint+0x2e>
  if(neg)
 323:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 327:	74 08                	je     331 <printint+0x5b>
    buf[i++] = '-';
 329:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 32e:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 331:	83 eb 01             	sub    $0x1,%ebx
 334:	78 22                	js     358 <printint+0x82>
  write(fd, &c, 1);
 336:	8d 7d d7             	lea    -0x29(%ebp),%edi
 339:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 33e:	88 45 d7             	mov    %al,-0x29(%ebp)
 341:	83 ec 04             	sub    $0x4,%esp
 344:	6a 01                	push   $0x1
 346:	57                   	push   %edi
 347:	56                   	push   %esi
 348:	e8 09 ff ff ff       	call   256 <write>
  while(--i >= 0)
 34d:	83 eb 01             	sub    $0x1,%ebx
 350:	83 c4 10             	add    $0x10,%esp
 353:	83 fb ff             	cmp    $0xffffffff,%ebx
 356:	75 e1                	jne    339 <printint+0x63>
    putc(fd, buf[i]);
}
 358:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35b:	5b                   	pop    %ebx
 35c:	5e                   	pop    %esi
 35d:	5f                   	pop    %edi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 369:	8b 75 0c             	mov    0xc(%ebp),%esi
 36c:	0f b6 1e             	movzbl (%esi),%ebx
 36f:	84 db                	test   %bl,%bl
 371:	0f 84 b1 01 00 00    	je     528 <printf+0x1c8>
 377:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 37a:	8d 45 10             	lea    0x10(%ebp),%eax
 37d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 380:	bf 00 00 00 00       	mov    $0x0,%edi
 385:	eb 2d                	jmp    3b4 <printf+0x54>
 387:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 38a:	83 ec 04             	sub    $0x4,%esp
 38d:	6a 01                	push   $0x1
 38f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 392:	50                   	push   %eax
 393:	ff 75 08             	pushl  0x8(%ebp)
 396:	e8 bb fe ff ff       	call   256 <write>
 39b:	83 c4 10             	add    $0x10,%esp
 39e:	eb 05                	jmp    3a5 <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3a0:	83 ff 25             	cmp    $0x25,%edi
 3a3:	74 22                	je     3c7 <printf+0x67>
 3a5:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 3a8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 3ac:	84 db                	test   %bl,%bl
 3ae:	0f 84 74 01 00 00    	je     528 <printf+0x1c8>
    c = fmt[i] & 0xff;
 3b4:	0f be d3             	movsbl %bl,%edx
 3b7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3ba:	85 ff                	test   %edi,%edi
 3bc:	75 e2                	jne    3a0 <printf+0x40>
      if(c == '%'){
 3be:	83 f8 25             	cmp    $0x25,%eax
 3c1:	75 c4                	jne    387 <printf+0x27>
        state = '%';
 3c3:	89 c7                	mov    %eax,%edi
 3c5:	eb de                	jmp    3a5 <printf+0x45>
      if(c == 'd'){
 3c7:	83 f8 64             	cmp    $0x64,%eax
 3ca:	74 59                	je     425 <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3cc:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3d2:	83 fa 70             	cmp    $0x70,%edx
 3d5:	74 7a                	je     451 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3d7:	83 f8 73             	cmp    $0x73,%eax
 3da:	0f 84 9d 00 00 00    	je     47d <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3e0:	83 f8 63             	cmp    $0x63,%eax
 3e3:	0f 84 f2 00 00 00    	je     4db <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3e9:	83 f8 25             	cmp    $0x25,%eax
 3ec:	0f 84 15 01 00 00    	je     507 <printf+0x1a7>
 3f2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3f6:	83 ec 04             	sub    $0x4,%esp
 3f9:	6a 01                	push   $0x1
 3fb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3fe:	50                   	push   %eax
 3ff:	ff 75 08             	pushl  0x8(%ebp)
 402:	e8 4f fe ff ff       	call   256 <write>
 407:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 40a:	83 c4 0c             	add    $0xc,%esp
 40d:	6a 01                	push   $0x1
 40f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 412:	50                   	push   %eax
 413:	ff 75 08             	pushl  0x8(%ebp)
 416:	e8 3b fe ff ff       	call   256 <write>
 41b:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 41e:	bf 00 00 00 00       	mov    $0x0,%edi
 423:	eb 80                	jmp    3a5 <printf+0x45>
        printint(fd, *ap, 10, 1);
 425:	83 ec 0c             	sub    $0xc,%esp
 428:	6a 01                	push   $0x1
 42a:	b9 0a 00 00 00       	mov    $0xa,%ecx
 42f:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 432:	8b 17                	mov    (%edi),%edx
 434:	8b 45 08             	mov    0x8(%ebp),%eax
 437:	e8 9a fe ff ff       	call   2d6 <printint>
        ap++;
 43c:	89 f8                	mov    %edi,%eax
 43e:	83 c0 04             	add    $0x4,%eax
 441:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 444:	83 c4 10             	add    $0x10,%esp
      state = 0;
 447:	bf 00 00 00 00       	mov    $0x0,%edi
 44c:	e9 54 ff ff ff       	jmp    3a5 <printf+0x45>
        printint(fd, *ap, 16, 0);
 451:	83 ec 0c             	sub    $0xc,%esp
 454:	6a 00                	push   $0x0
 456:	b9 10 00 00 00       	mov    $0x10,%ecx
 45b:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 45e:	8b 17                	mov    (%edi),%edx
 460:	8b 45 08             	mov    0x8(%ebp),%eax
 463:	e8 6e fe ff ff       	call   2d6 <printint>
        ap++;
 468:	89 f8                	mov    %edi,%eax
 46a:	83 c0 04             	add    $0x4,%eax
 46d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 470:	83 c4 10             	add    $0x10,%esp
      state = 0;
 473:	bf 00 00 00 00       	mov    $0x0,%edi
 478:	e9 28 ff ff ff       	jmp    3a5 <printf+0x45>
        s = (char*)*ap;
 47d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 480:	8b 01                	mov    (%ecx),%eax
        ap++;
 482:	83 c1 04             	add    $0x4,%ecx
 485:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 488:	85 c0                	test   %eax,%eax
 48a:	74 13                	je     49f <printf+0x13f>
        s = (char*)*ap;
 48c:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 48e:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 491:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 496:	84 c0                	test   %al,%al
 498:	75 0f                	jne    4a9 <printf+0x149>
 49a:	e9 06 ff ff ff       	jmp    3a5 <printf+0x45>
          s = "(null)";
 49f:	bb a5 06 00 00       	mov    $0x6a5,%ebx
        while(*s != 0){
 4a4:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 4a9:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 4ac:	89 75 d0             	mov    %esi,-0x30(%ebp)
 4af:	8b 75 08             	mov    0x8(%ebp),%esi
 4b2:	88 45 e3             	mov    %al,-0x1d(%ebp)
 4b5:	83 ec 04             	sub    $0x4,%esp
 4b8:	6a 01                	push   $0x1
 4ba:	57                   	push   %edi
 4bb:	56                   	push   %esi
 4bc:	e8 95 fd ff ff       	call   256 <write>
          s++;
 4c1:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4c4:	0f b6 03             	movzbl (%ebx),%eax
 4c7:	83 c4 10             	add    $0x10,%esp
 4ca:	84 c0                	test   %al,%al
 4cc:	75 e4                	jne    4b2 <printf+0x152>
 4ce:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 4d1:	bf 00 00 00 00       	mov    $0x0,%edi
 4d6:	e9 ca fe ff ff       	jmp    3a5 <printf+0x45>
        putc(fd, *ap);
 4db:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4de:	8b 07                	mov    (%edi),%eax
 4e0:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4e3:	83 ec 04             	sub    $0x4,%esp
 4e6:	6a 01                	push   $0x1
 4e8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4eb:	50                   	push   %eax
 4ec:	ff 75 08             	pushl  0x8(%ebp)
 4ef:	e8 62 fd ff ff       	call   256 <write>
        ap++;
 4f4:	83 c7 04             	add    $0x4,%edi
 4f7:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 4fa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4fd:	bf 00 00 00 00       	mov    $0x0,%edi
 502:	e9 9e fe ff ff       	jmp    3a5 <printf+0x45>
 507:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 50a:	83 ec 04             	sub    $0x4,%esp
 50d:	6a 01                	push   $0x1
 50f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 512:	50                   	push   %eax
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	e8 3b fd ff ff       	call   256 <write>
 51b:	83 c4 10             	add    $0x10,%esp
      state = 0;
 51e:	bf 00 00 00 00       	mov    $0x0,%edi
 523:	e9 7d fe ff ff       	jmp    3a5 <printf+0x45>
    }
  }
}
 528:	8d 65 f4             	lea    -0xc(%ebp),%esp
 52b:	5b                   	pop    %ebx
 52c:	5e                   	pop    %esi
 52d:	5f                   	pop    %edi
 52e:	5d                   	pop    %ebp
 52f:	c3                   	ret    

00000530 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 539:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 53c:	a1 20 09 00 00       	mov    0x920,%eax
 541:	eb 0c                	jmp    54f <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 543:	8b 10                	mov    (%eax),%edx
 545:	39 c2                	cmp    %eax,%edx
 547:	77 04                	ja     54d <free+0x1d>
 549:	39 ca                	cmp    %ecx,%edx
 54b:	77 10                	ja     55d <free+0x2d>
{
 54d:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 54f:	39 c8                	cmp    %ecx,%eax
 551:	73 f0                	jae    543 <free+0x13>
 553:	8b 10                	mov    (%eax),%edx
 555:	39 ca                	cmp    %ecx,%edx
 557:	77 04                	ja     55d <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 559:	39 c2                	cmp    %eax,%edx
 55b:	77 f0                	ja     54d <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 55d:	8b 73 fc             	mov    -0x4(%ebx),%esi
 560:	8b 10                	mov    (%eax),%edx
 562:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 565:	39 fa                	cmp    %edi,%edx
 567:	74 19                	je     582 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 569:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 56c:	8b 50 04             	mov    0x4(%eax),%edx
 56f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 572:	39 f1                	cmp    %esi,%ecx
 574:	74 1b                	je     591 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 576:	89 08                	mov    %ecx,(%eax)
  freep = p;
 578:	a3 20 09 00 00       	mov    %eax,0x920
}
 57d:	5b                   	pop    %ebx
 57e:	5e                   	pop    %esi
 57f:	5f                   	pop    %edi
 580:	5d                   	pop    %ebp
 581:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 582:	03 72 04             	add    0x4(%edx),%esi
 585:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 588:	8b 10                	mov    (%eax),%edx
 58a:	8b 12                	mov    (%edx),%edx
 58c:	89 53 f8             	mov    %edx,-0x8(%ebx)
 58f:	eb db                	jmp    56c <free+0x3c>
    p->s.size += bp->s.size;
 591:	03 53 fc             	add    -0x4(%ebx),%edx
 594:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 597:	8b 53 f8             	mov    -0x8(%ebx),%edx
 59a:	89 10                	mov    %edx,(%eax)
 59c:	eb da                	jmp    578 <free+0x48>

0000059e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 59e:	55                   	push   %ebp
 59f:	89 e5                	mov    %esp,%ebp
 5a1:	57                   	push   %edi
 5a2:	56                   	push   %esi
 5a3:	53                   	push   %ebx
 5a4:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5a7:	8b 45 08             	mov    0x8(%ebp),%eax
 5aa:	8d 58 07             	lea    0x7(%eax),%ebx
 5ad:	c1 eb 03             	shr    $0x3,%ebx
 5b0:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5b3:	8b 15 20 09 00 00    	mov    0x920,%edx
 5b9:	85 d2                	test   %edx,%edx
 5bb:	74 20                	je     5dd <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5bd:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5bf:	8b 48 04             	mov    0x4(%eax),%ecx
 5c2:	39 cb                	cmp    %ecx,%ebx
 5c4:	76 3c                	jbe    602 <malloc+0x64>
 5c6:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5cc:	be 00 10 00 00       	mov    $0x1000,%esi
 5d1:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5d4:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 5db:	eb 70                	jmp    64d <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 5dd:	c7 05 20 09 00 00 24 	movl   $0x924,0x920
 5e4:	09 00 00 
 5e7:	c7 05 24 09 00 00 24 	movl   $0x924,0x924
 5ee:	09 00 00 
    base.s.size = 0;
 5f1:	c7 05 28 09 00 00 00 	movl   $0x0,0x928
 5f8:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5fb:	ba 24 09 00 00       	mov    $0x924,%edx
 600:	eb bb                	jmp    5bd <malloc+0x1f>
      if(p->s.size == nunits)
 602:	39 cb                	cmp    %ecx,%ebx
 604:	74 1c                	je     622 <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 606:	29 d9                	sub    %ebx,%ecx
 608:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 60b:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 60e:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 611:	89 15 20 09 00 00    	mov    %edx,0x920
      return (void*)(p + 1);
 617:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 61a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 61d:	5b                   	pop    %ebx
 61e:	5e                   	pop    %esi
 61f:	5f                   	pop    %edi
 620:	5d                   	pop    %ebp
 621:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 622:	8b 08                	mov    (%eax),%ecx
 624:	89 0a                	mov    %ecx,(%edx)
 626:	eb e9                	jmp    611 <malloc+0x73>
  hp->s.size = nu;
 628:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 62b:	83 ec 0c             	sub    $0xc,%esp
 62e:	83 c0 08             	add    $0x8,%eax
 631:	50                   	push   %eax
 632:	e8 f9 fe ff ff       	call   530 <free>
  return freep;
 637:	8b 15 20 09 00 00    	mov    0x920,%edx
      if((p = morecore(nunits)) == 0)
 63d:	83 c4 10             	add    $0x10,%esp
 640:	85 d2                	test   %edx,%edx
 642:	74 2b                	je     66f <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 644:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 646:	8b 48 04             	mov    0x4(%eax),%ecx
 649:	39 d9                	cmp    %ebx,%ecx
 64b:	73 b5                	jae    602 <malloc+0x64>
 64d:	89 c2                	mov    %eax,%edx
    if(p == freep)
 64f:	39 05 20 09 00 00    	cmp    %eax,0x920
 655:	75 ed                	jne    644 <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 657:	83 ec 0c             	sub    $0xc,%esp
 65a:	57                   	push   %edi
 65b:	e8 5e fc ff ff       	call   2be <sbrk>
  if(p == (char*)-1)
 660:	83 c4 10             	add    $0x10,%esp
 663:	83 f8 ff             	cmp    $0xffffffff,%eax
 666:	75 c0                	jne    628 <malloc+0x8a>
        return 0;
 668:	b8 00 00 00 00       	mov    $0x0,%eax
 66d:	eb ab                	jmp    61a <malloc+0x7c>
 66f:	b8 00 00 00 00       	mov    $0x0,%eax
 674:	eb a4                	jmp    61a <malloc+0x7c>

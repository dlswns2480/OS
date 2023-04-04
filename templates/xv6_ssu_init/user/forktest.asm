
user/_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <print>:

#define N  1000

void
print(int fd, const char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 10             	sub    $0x10,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	53                   	push   %ebx
   b:	e8 33 01 00 00       	call   143 <strlen>
  10:	83 c4 0c             	add    $0xc,%esp
  13:	50                   	push   %eax
  14:	53                   	push   %ebx
  15:	ff 75 08             	pushl  0x8(%ebp)
  18:	e8 b7 02 00 00       	call   2d4 <write>
}
  1d:	83 c4 10             	add    $0x10,%esp
  20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  23:	c9                   	leave  
  24:	c3                   	ret    

00000025 <forktest>:

void
forktest(void)
{
  25:	55                   	push   %ebp
  26:	89 e5                	mov    %esp,%ebp
  28:	53                   	push   %ebx
  29:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  print(1, "fork test\n");
  2c:	68 f4 06 00 00       	push   $0x6f4
  31:	6a 01                	push   $0x1
  33:	e8 c8 ff ff ff       	call   0 <print>
  38:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  3b:	bb 00 00 00 00       	mov    $0x0,%ebx
    pid = fork();
  40:	e8 67 02 00 00       	call   2ac <fork>
    if(pid < 0)
  45:	85 c0                	test   %eax,%eax
  47:	78 2d                	js     76 <forktest+0x51>
      break;
    if(pid == 0)
  49:	85 c0                	test   %eax,%eax
  4b:	74 24                	je     71 <forktest+0x4c>
  for(n=0; n<N; n++){
  4d:	83 c3 01             	add    $0x1,%ebx
  50:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  56:	75 e8                	jne    40 <forktest+0x1b>
      exit();
  }

  if(n == N){
    print(1, "fork claimed to work N times!\n", N);
  58:	83 ec 04             	sub    $0x4,%esp
  5b:	68 e8 03 00 00       	push   $0x3e8
  60:	68 34 07 00 00       	push   $0x734
  65:	6a 01                	push   $0x1
  67:	e8 94 ff ff ff       	call   0 <print>
    exit();
  6c:	e8 43 02 00 00       	call   2b4 <exit>
      exit();
  71:	e8 3e 02 00 00       	call   2b4 <exit>
  if(n == N){
  76:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  7c:	74 da                	je     58 <forktest+0x33>
  }

  for(; n > 0; n--){
  7e:	85 db                	test   %ebx,%ebx
  80:	7e 0e                	jle    90 <forktest+0x6b>
    if(wait() < 0){
  82:	e8 35 02 00 00       	call   2bc <wait>
  87:	85 c0                	test   %eax,%eax
  89:	78 26                	js     b1 <forktest+0x8c>
  for(; n > 0; n--){
  8b:	83 eb 01             	sub    $0x1,%ebx
  8e:	75 f2                	jne    82 <forktest+0x5d>
      print(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
  90:	e8 27 02 00 00       	call   2bc <wait>
  95:	83 f8 ff             	cmp    $0xffffffff,%eax
  98:	75 2b                	jne    c5 <forktest+0xa0>
    print(1, "wait got too many\n");
    exit();
  }

  print(1, "fork test OK\n");
  9a:	83 ec 08             	sub    $0x8,%esp
  9d:	68 26 07 00 00       	push   $0x726
  a2:	6a 01                	push   $0x1
  a4:	e8 57 ff ff ff       	call   0 <print>
}
  a9:	83 c4 10             	add    $0x10,%esp
  ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  af:	c9                   	leave  
  b0:	c3                   	ret    
      print(1, "wait stopped early\n");
  b1:	83 ec 08             	sub    $0x8,%esp
  b4:	68 ff 06 00 00       	push   $0x6ff
  b9:	6a 01                	push   $0x1
  bb:	e8 40 ff ff ff       	call   0 <print>
      exit();
  c0:	e8 ef 01 00 00       	call   2b4 <exit>
    print(1, "wait got too many\n");
  c5:	83 ec 08             	sub    $0x8,%esp
  c8:	68 13 07 00 00       	push   $0x713
  cd:	6a 01                	push   $0x1
  cf:	e8 2c ff ff ff       	call   0 <print>
    exit();
  d4:	e8 db 01 00 00       	call   2b4 <exit>

000000d9 <main>:

int
main(void)
{
  d9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  dd:	83 e4 f0             	and    $0xfffffff0,%esp
  e0:	ff 71 fc             	pushl  -0x4(%ecx)
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	51                   	push   %ecx
  e7:	83 ec 04             	sub    $0x4,%esp
  forktest();
  ea:	e8 36 ff ff ff       	call   25 <forktest>
  exit();
  ef:	e8 c0 01 00 00       	call   2b4 <exit>

000000f4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	8b 45 08             	mov    0x8(%ebp),%eax
  fb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fe:	89 c2                	mov    %eax,%edx
 100:	83 c1 01             	add    $0x1,%ecx
 103:	83 c2 01             	add    $0x1,%edx
 106:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 10a:	88 5a ff             	mov    %bl,-0x1(%edx)
 10d:	84 db                	test   %bl,%bl
 10f:	75 ef                	jne    100 <strcpy+0xc>
    ;
  return os;
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    

00000114 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11a:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 11d:	0f b6 01             	movzbl (%ecx),%eax
 120:	84 c0                	test   %al,%al
 122:	74 15                	je     139 <strcmp+0x25>
 124:	3a 02                	cmp    (%edx),%al
 126:	75 11                	jne    139 <strcmp+0x25>
    p++, q++;
 128:	83 c1 01             	add    $0x1,%ecx
 12b:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 12e:	0f b6 01             	movzbl (%ecx),%eax
 131:	84 c0                	test   %al,%al
 133:	74 04                	je     139 <strcmp+0x25>
 135:	3a 02                	cmp    (%edx),%al
 137:	74 ef                	je     128 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 139:	0f b6 c0             	movzbl %al,%eax
 13c:	0f b6 12             	movzbl (%edx),%edx
 13f:	29 d0                	sub    %edx,%eax
}
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    

00000143 <strlen>:

uint
strlen(const char *s)
{
 143:	55                   	push   %ebp
 144:	89 e5                	mov    %esp,%ebp
 146:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 149:	80 39 00             	cmpb   $0x0,(%ecx)
 14c:	74 12                	je     160 <strlen+0x1d>
 14e:	ba 00 00 00 00       	mov    $0x0,%edx
 153:	83 c2 01             	add    $0x1,%edx
 156:	89 d0                	mov    %edx,%eax
 158:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 15c:	75 f5                	jne    153 <strlen+0x10>
    ;
  return n;
}
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    
  for(n = 0; s[n]; n++)
 160:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 165:	eb f7                	jmp    15e <strlen+0x1b>

00000167 <memset>:

void*
memset(void *dst, int c, uint n)
{
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	57                   	push   %edi
 16b:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 16e:	89 d7                	mov    %edx,%edi
 170:	8b 4d 10             	mov    0x10(%ebp),%ecx
 173:	8b 45 0c             	mov    0xc(%ebp),%eax
 176:	fc                   	cld    
 177:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 179:	89 d0                	mov    %edx,%eax
 17b:	5f                   	pop    %edi
 17c:	5d                   	pop    %ebp
 17d:	c3                   	ret    

0000017e <strchr>:

char*
strchr(const char *s, char c)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	53                   	push   %ebx
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 188:	0f b6 10             	movzbl (%eax),%edx
 18b:	84 d2                	test   %dl,%dl
 18d:	74 1e                	je     1ad <strchr+0x2f>
 18f:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 191:	38 d3                	cmp    %dl,%bl
 193:	74 15                	je     1aa <strchr+0x2c>
  for(; *s; s++)
 195:	83 c0 01             	add    $0x1,%eax
 198:	0f b6 10             	movzbl (%eax),%edx
 19b:	84 d2                	test   %dl,%dl
 19d:	74 06                	je     1a5 <strchr+0x27>
    if(*s == c)
 19f:	38 ca                	cmp    %cl,%dl
 1a1:	75 f2                	jne    195 <strchr+0x17>
 1a3:	eb 05                	jmp    1aa <strchr+0x2c>
      return (char*)s;
  return 0;
 1a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1aa:	5b                   	pop    %ebx
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
  return 0;
 1ad:	b8 00 00 00 00       	mov    $0x0,%eax
 1b2:	eb f6                	jmp    1aa <strchr+0x2c>

000001b4 <gets>:

char*
gets(char *buf, int max)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	56                   	push   %esi
 1b9:	53                   	push   %ebx
 1ba:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bd:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 1c2:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1c5:	8d 5e 01             	lea    0x1(%esi),%ebx
 1c8:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1cb:	7d 2b                	jge    1f8 <gets+0x44>
    cc = read(0, &c, 1);
 1cd:	83 ec 04             	sub    $0x4,%esp
 1d0:	6a 01                	push   $0x1
 1d2:	57                   	push   %edi
 1d3:	6a 00                	push   $0x0
 1d5:	e8 f2 00 00 00       	call   2cc <read>
    if(cc < 1)
 1da:	83 c4 10             	add    $0x10,%esp
 1dd:	85 c0                	test   %eax,%eax
 1df:	7e 17                	jle    1f8 <gets+0x44>
      break;
    buf[i++] = c;
 1e1:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1e5:	8b 55 08             	mov    0x8(%ebp),%edx
 1e8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 1ec:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1ee:	3c 0a                	cmp    $0xa,%al
 1f0:	74 04                	je     1f6 <gets+0x42>
 1f2:	3c 0d                	cmp    $0xd,%al
 1f4:	75 cf                	jne    1c5 <gets+0x11>
  for(i=0; i+1 < max; ){
 1f6:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 202:	5b                   	pop    %ebx
 203:	5e                   	pop    %esi
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    

00000207 <stat>:

int
stat(const char *n, struct stat *st)
{
 207:	55                   	push   %ebp
 208:	89 e5                	mov    %esp,%ebp
 20a:	56                   	push   %esi
 20b:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20c:	83 ec 08             	sub    $0x8,%esp
 20f:	6a 00                	push   $0x0
 211:	ff 75 08             	pushl  0x8(%ebp)
 214:	e8 db 00 00 00       	call   2f4 <open>
  if(fd < 0)
 219:	83 c4 10             	add    $0x10,%esp
 21c:	85 c0                	test   %eax,%eax
 21e:	78 24                	js     244 <stat+0x3d>
 220:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 222:	83 ec 08             	sub    $0x8,%esp
 225:	ff 75 0c             	pushl  0xc(%ebp)
 228:	50                   	push   %eax
 229:	e8 de 00 00 00       	call   30c <fstat>
 22e:	89 c6                	mov    %eax,%esi
  close(fd);
 230:	89 1c 24             	mov    %ebx,(%esp)
 233:	e8 a4 00 00 00       	call   2dc <close>
  return r;
 238:	83 c4 10             	add    $0x10,%esp
}
 23b:	89 f0                	mov    %esi,%eax
 23d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 240:	5b                   	pop    %ebx
 241:	5e                   	pop    %esi
 242:	5d                   	pop    %ebp
 243:	c3                   	ret    
    return -1;
 244:	be ff ff ff ff       	mov    $0xffffffff,%esi
 249:	eb f0                	jmp    23b <stat+0x34>

0000024b <atoi>:

int
atoi(const char *s)
{
 24b:	55                   	push   %ebp
 24c:	89 e5                	mov    %esp,%ebp
 24e:	53                   	push   %ebx
 24f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 252:	0f b6 11             	movzbl (%ecx),%edx
 255:	8d 42 d0             	lea    -0x30(%edx),%eax
 258:	3c 09                	cmp    $0x9,%al
 25a:	77 20                	ja     27c <atoi+0x31>
  n = 0;
 25c:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 261:	83 c1 01             	add    $0x1,%ecx
 264:	8d 04 80             	lea    (%eax,%eax,4),%eax
 267:	0f be d2             	movsbl %dl,%edx
 26a:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 26e:	0f b6 11             	movzbl (%ecx),%edx
 271:	8d 5a d0             	lea    -0x30(%edx),%ebx
 274:	80 fb 09             	cmp    $0x9,%bl
 277:	76 e8                	jbe    261 <atoi+0x16>
  return n;
}
 279:	5b                   	pop    %ebx
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret    
  n = 0;
 27c:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 281:	eb f6                	jmp    279 <atoi+0x2e>

00000283 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 283:	55                   	push   %ebp
 284:	89 e5                	mov    %esp,%ebp
 286:	56                   	push   %esi
 287:	53                   	push   %ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
 28e:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 291:	85 db                	test   %ebx,%ebx
 293:	7e 13                	jle    2a8 <memmove+0x25>
 295:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 29a:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2a1:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2a4:	39 d3                	cmp    %edx,%ebx
 2a6:	75 f2                	jne    29a <memmove+0x17>
  return vdst;
}
 2a8:	5b                   	pop    %ebx
 2a9:	5e                   	pop    %esi
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret    

000002ac <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ac:	b8 01 00 00 00       	mov    $0x1,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <exit>:
SYSCALL(exit)
 2b4:	b8 02 00 00 00       	mov    $0x2,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <wait>:
SYSCALL(wait)
 2bc:	b8 03 00 00 00       	mov    $0x3,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <pipe>:
SYSCALL(pipe)
 2c4:	b8 04 00 00 00       	mov    $0x4,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <read>:
SYSCALL(read)
 2cc:	b8 05 00 00 00       	mov    $0x5,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <write>:
SYSCALL(write)
 2d4:	b8 10 00 00 00       	mov    $0x10,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <close>:
SYSCALL(close)
 2dc:	b8 15 00 00 00       	mov    $0x15,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <kill>:
SYSCALL(kill)
 2e4:	b8 06 00 00 00       	mov    $0x6,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <exec>:
SYSCALL(exec)
 2ec:	b8 07 00 00 00       	mov    $0x7,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <open>:
SYSCALL(open)
 2f4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <mknod>:
SYSCALL(mknod)
 2fc:	b8 11 00 00 00       	mov    $0x11,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <unlink>:
SYSCALL(unlink)
 304:	b8 12 00 00 00       	mov    $0x12,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <fstat>:
SYSCALL(fstat)
 30c:	b8 08 00 00 00       	mov    $0x8,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <link>:
SYSCALL(link)
 314:	b8 13 00 00 00       	mov    $0x13,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <mkdir>:
SYSCALL(mkdir)
 31c:	b8 14 00 00 00       	mov    $0x14,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <chdir>:
SYSCALL(chdir)
 324:	b8 09 00 00 00       	mov    $0x9,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <dup>:
SYSCALL(dup)
 32c:	b8 0a 00 00 00       	mov    $0xa,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <getpid>:
SYSCALL(getpid)
 334:	b8 0b 00 00 00       	mov    $0xb,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <sbrk>:
SYSCALL(sbrk)
 33c:	b8 0c 00 00 00       	mov    $0xc,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <sleep>:
SYSCALL(sleep)
 344:	b8 0d 00 00 00       	mov    $0xd,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <uptime>:
SYSCALL(uptime)
 34c:	b8 0e 00 00 00       	mov    $0xe,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	57                   	push   %edi
 358:	56                   	push   %esi
 359:	53                   	push   %ebx
 35a:	83 ec 3c             	sub    $0x3c,%esp
 35d:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 35f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 363:	74 14                	je     379 <printint+0x25>
 365:	85 d2                	test   %edx,%edx
 367:	79 10                	jns    379 <printint+0x25>
    neg = 1;
    x = -xx;
 369:	f7 da                	neg    %edx
    neg = 1;
 36b:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 372:	bf 00 00 00 00       	mov    $0x0,%edi
 377:	eb 0b                	jmp    384 <printint+0x30>
  neg = 0;
 379:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 380:	eb f0                	jmp    372 <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 382:	89 df                	mov    %ebx,%edi
 384:	8d 5f 01             	lea    0x1(%edi),%ebx
 387:	89 d0                	mov    %edx,%eax
 389:	ba 00 00 00 00       	mov    $0x0,%edx
 38e:	f7 f1                	div    %ecx
 390:	0f b6 92 5c 07 00 00 	movzbl 0x75c(%edx),%edx
 397:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 39b:	89 c2                	mov    %eax,%edx
 39d:	85 c0                	test   %eax,%eax
 39f:	75 e1                	jne    382 <printint+0x2e>
  if(neg)
 3a1:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 3a5:	74 08                	je     3af <printint+0x5b>
    buf[i++] = '-';
 3a7:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3ac:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 3af:	83 eb 01             	sub    $0x1,%ebx
 3b2:	78 22                	js     3d6 <printint+0x82>
  write(fd, &c, 1);
 3b4:	8d 7d d7             	lea    -0x29(%ebp),%edi
 3b7:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 3bc:	88 45 d7             	mov    %al,-0x29(%ebp)
 3bf:	83 ec 04             	sub    $0x4,%esp
 3c2:	6a 01                	push   $0x1
 3c4:	57                   	push   %edi
 3c5:	56                   	push   %esi
 3c6:	e8 09 ff ff ff       	call   2d4 <write>
  while(--i >= 0)
 3cb:	83 eb 01             	sub    $0x1,%ebx
 3ce:	83 c4 10             	add    $0x10,%esp
 3d1:	83 fb ff             	cmp    $0xffffffff,%ebx
 3d4:	75 e1                	jne    3b7 <printint+0x63>
    putc(fd, buf[i]);
}
 3d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d9:	5b                   	pop    %ebx
 3da:	5e                   	pop    %esi
 3db:	5f                   	pop    %edi
 3dc:	5d                   	pop    %ebp
 3dd:	c3                   	ret    

000003de <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3de:	55                   	push   %ebp
 3df:	89 e5                	mov    %esp,%ebp
 3e1:	57                   	push   %edi
 3e2:	56                   	push   %esi
 3e3:	53                   	push   %ebx
 3e4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e7:	8b 75 0c             	mov    0xc(%ebp),%esi
 3ea:	0f b6 1e             	movzbl (%esi),%ebx
 3ed:	84 db                	test   %bl,%bl
 3ef:	0f 84 b1 01 00 00    	je     5a6 <printf+0x1c8>
 3f5:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 3f8:	8d 45 10             	lea    0x10(%ebp),%eax
 3fb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 3fe:	bf 00 00 00 00       	mov    $0x0,%edi
 403:	eb 2d                	jmp    432 <printf+0x54>
 405:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 408:	83 ec 04             	sub    $0x4,%esp
 40b:	6a 01                	push   $0x1
 40d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 410:	50                   	push   %eax
 411:	ff 75 08             	pushl  0x8(%ebp)
 414:	e8 bb fe ff ff       	call   2d4 <write>
 419:	83 c4 10             	add    $0x10,%esp
 41c:	eb 05                	jmp    423 <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 41e:	83 ff 25             	cmp    $0x25,%edi
 421:	74 22                	je     445 <printf+0x67>
 423:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 426:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 42a:	84 db                	test   %bl,%bl
 42c:	0f 84 74 01 00 00    	je     5a6 <printf+0x1c8>
    c = fmt[i] & 0xff;
 432:	0f be d3             	movsbl %bl,%edx
 435:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 438:	85 ff                	test   %edi,%edi
 43a:	75 e2                	jne    41e <printf+0x40>
      if(c == '%'){
 43c:	83 f8 25             	cmp    $0x25,%eax
 43f:	75 c4                	jne    405 <printf+0x27>
        state = '%';
 441:	89 c7                	mov    %eax,%edi
 443:	eb de                	jmp    423 <printf+0x45>
      if(c == 'd'){
 445:	83 f8 64             	cmp    $0x64,%eax
 448:	74 59                	je     4a3 <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 44a:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 450:	83 fa 70             	cmp    $0x70,%edx
 453:	74 7a                	je     4cf <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 455:	83 f8 73             	cmp    $0x73,%eax
 458:	0f 84 9d 00 00 00    	je     4fb <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 45e:	83 f8 63             	cmp    $0x63,%eax
 461:	0f 84 f2 00 00 00    	je     559 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 467:	83 f8 25             	cmp    $0x25,%eax
 46a:	0f 84 15 01 00 00    	je     585 <printf+0x1a7>
 470:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 474:	83 ec 04             	sub    $0x4,%esp
 477:	6a 01                	push   $0x1
 479:	8d 45 e7             	lea    -0x19(%ebp),%eax
 47c:	50                   	push   %eax
 47d:	ff 75 08             	pushl  0x8(%ebp)
 480:	e8 4f fe ff ff       	call   2d4 <write>
 485:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 488:	83 c4 0c             	add    $0xc,%esp
 48b:	6a 01                	push   $0x1
 48d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 490:	50                   	push   %eax
 491:	ff 75 08             	pushl  0x8(%ebp)
 494:	e8 3b fe ff ff       	call   2d4 <write>
 499:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 49c:	bf 00 00 00 00       	mov    $0x0,%edi
 4a1:	eb 80                	jmp    423 <printf+0x45>
        printint(fd, *ap, 10, 1);
 4a3:	83 ec 0c             	sub    $0xc,%esp
 4a6:	6a 01                	push   $0x1
 4a8:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4ad:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4b0:	8b 17                	mov    (%edi),%edx
 4b2:	8b 45 08             	mov    0x8(%ebp),%eax
 4b5:	e8 9a fe ff ff       	call   354 <printint>
        ap++;
 4ba:	89 f8                	mov    %edi,%eax
 4bc:	83 c0 04             	add    $0x4,%eax
 4bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4c2:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4c5:	bf 00 00 00 00       	mov    $0x0,%edi
 4ca:	e9 54 ff ff ff       	jmp    423 <printf+0x45>
        printint(fd, *ap, 16, 0);
 4cf:	83 ec 0c             	sub    $0xc,%esp
 4d2:	6a 00                	push   $0x0
 4d4:	b9 10 00 00 00       	mov    $0x10,%ecx
 4d9:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4dc:	8b 17                	mov    (%edi),%edx
 4de:	8b 45 08             	mov    0x8(%ebp),%eax
 4e1:	e8 6e fe ff ff       	call   354 <printint>
        ap++;
 4e6:	89 f8                	mov    %edi,%eax
 4e8:	83 c0 04             	add    $0x4,%eax
 4eb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4ee:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4f1:	bf 00 00 00 00       	mov    $0x0,%edi
 4f6:	e9 28 ff ff ff       	jmp    423 <printf+0x45>
        s = (char*)*ap;
 4fb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 4fe:	8b 01                	mov    (%ecx),%eax
        ap++;
 500:	83 c1 04             	add    $0x4,%ecx
 503:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 506:	85 c0                	test   %eax,%eax
 508:	74 13                	je     51d <printf+0x13f>
        s = (char*)*ap;
 50a:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 50c:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 50f:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 514:	84 c0                	test   %al,%al
 516:	75 0f                	jne    527 <printf+0x149>
 518:	e9 06 ff ff ff       	jmp    423 <printf+0x45>
          s = "(null)";
 51d:	bb 54 07 00 00       	mov    $0x754,%ebx
        while(*s != 0){
 522:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 527:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 52a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 52d:	8b 75 08             	mov    0x8(%ebp),%esi
 530:	88 45 e3             	mov    %al,-0x1d(%ebp)
 533:	83 ec 04             	sub    $0x4,%esp
 536:	6a 01                	push   $0x1
 538:	57                   	push   %edi
 539:	56                   	push   %esi
 53a:	e8 95 fd ff ff       	call   2d4 <write>
          s++;
 53f:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 542:	0f b6 03             	movzbl (%ebx),%eax
 545:	83 c4 10             	add    $0x10,%esp
 548:	84 c0                	test   %al,%al
 54a:	75 e4                	jne    530 <printf+0x152>
 54c:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 54f:	bf 00 00 00 00       	mov    $0x0,%edi
 554:	e9 ca fe ff ff       	jmp    423 <printf+0x45>
        putc(fd, *ap);
 559:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 55c:	8b 07                	mov    (%edi),%eax
 55e:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 561:	83 ec 04             	sub    $0x4,%esp
 564:	6a 01                	push   $0x1
 566:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 569:	50                   	push   %eax
 56a:	ff 75 08             	pushl  0x8(%ebp)
 56d:	e8 62 fd ff ff       	call   2d4 <write>
        ap++;
 572:	83 c7 04             	add    $0x4,%edi
 575:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 578:	83 c4 10             	add    $0x10,%esp
      state = 0;
 57b:	bf 00 00 00 00       	mov    $0x0,%edi
 580:	e9 9e fe ff ff       	jmp    423 <printf+0x45>
 585:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 588:	83 ec 04             	sub    $0x4,%esp
 58b:	6a 01                	push   $0x1
 58d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 590:	50                   	push   %eax
 591:	ff 75 08             	pushl  0x8(%ebp)
 594:	e8 3b fd ff ff       	call   2d4 <write>
 599:	83 c4 10             	add    $0x10,%esp
      state = 0;
 59c:	bf 00 00 00 00       	mov    $0x0,%edi
 5a1:	e9 7d fe ff ff       	jmp    423 <printf+0x45>
    }
  }
}
 5a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a9:	5b                   	pop    %ebx
 5aa:	5e                   	pop    %esi
 5ab:	5f                   	pop    %edi
 5ac:	5d                   	pop    %ebp
 5ad:	c3                   	ret    

000005ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ae:	55                   	push   %ebp
 5af:	89 e5                	mov    %esp,%ebp
 5b1:	57                   	push   %edi
 5b2:	56                   	push   %esi
 5b3:	53                   	push   %ebx
 5b4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b7:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ba:	a1 10 0a 00 00       	mov    0xa10,%eax
 5bf:	eb 0c                	jmp    5cd <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c1:	8b 10                	mov    (%eax),%edx
 5c3:	39 c2                	cmp    %eax,%edx
 5c5:	77 04                	ja     5cb <free+0x1d>
 5c7:	39 ca                	cmp    %ecx,%edx
 5c9:	77 10                	ja     5db <free+0x2d>
{
 5cb:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5cd:	39 c8                	cmp    %ecx,%eax
 5cf:	73 f0                	jae    5c1 <free+0x13>
 5d1:	8b 10                	mov    (%eax),%edx
 5d3:	39 ca                	cmp    %ecx,%edx
 5d5:	77 04                	ja     5db <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d7:	39 c2                	cmp    %eax,%edx
 5d9:	77 f0                	ja     5cb <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5db:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5de:	8b 10                	mov    (%eax),%edx
 5e0:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5e3:	39 fa                	cmp    %edi,%edx
 5e5:	74 19                	je     600 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5e7:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5ea:	8b 50 04             	mov    0x4(%eax),%edx
 5ed:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f0:	39 f1                	cmp    %esi,%ecx
 5f2:	74 1b                	je     60f <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5f4:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5f6:	a3 10 0a 00 00       	mov    %eax,0xa10
}
 5fb:	5b                   	pop    %ebx
 5fc:	5e                   	pop    %esi
 5fd:	5f                   	pop    %edi
 5fe:	5d                   	pop    %ebp
 5ff:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 600:	03 72 04             	add    0x4(%edx),%esi
 603:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 606:	8b 10                	mov    (%eax),%edx
 608:	8b 12                	mov    (%edx),%edx
 60a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 60d:	eb db                	jmp    5ea <free+0x3c>
    p->s.size += bp->s.size;
 60f:	03 53 fc             	add    -0x4(%ebx),%edx
 612:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 615:	8b 53 f8             	mov    -0x8(%ebx),%edx
 618:	89 10                	mov    %edx,(%eax)
 61a:	eb da                	jmp    5f6 <free+0x48>

0000061c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 61c:	55                   	push   %ebp
 61d:	89 e5                	mov    %esp,%ebp
 61f:	57                   	push   %edi
 620:	56                   	push   %esi
 621:	53                   	push   %ebx
 622:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 625:	8b 45 08             	mov    0x8(%ebp),%eax
 628:	8d 58 07             	lea    0x7(%eax),%ebx
 62b:	c1 eb 03             	shr    $0x3,%ebx
 62e:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 631:	8b 15 10 0a 00 00    	mov    0xa10,%edx
 637:	85 d2                	test   %edx,%edx
 639:	74 20                	je     65b <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 63b:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 63d:	8b 48 04             	mov    0x4(%eax),%ecx
 640:	39 cb                	cmp    %ecx,%ebx
 642:	76 3c                	jbe    680 <malloc+0x64>
 644:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 64a:	be 00 10 00 00       	mov    $0x1000,%esi
 64f:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 652:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 659:	eb 70                	jmp    6cb <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 65b:	c7 05 10 0a 00 00 14 	movl   $0xa14,0xa10
 662:	0a 00 00 
 665:	c7 05 14 0a 00 00 14 	movl   $0xa14,0xa14
 66c:	0a 00 00 
    base.s.size = 0;
 66f:	c7 05 18 0a 00 00 00 	movl   $0x0,0xa18
 676:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 679:	ba 14 0a 00 00       	mov    $0xa14,%edx
 67e:	eb bb                	jmp    63b <malloc+0x1f>
      if(p->s.size == nunits)
 680:	39 cb                	cmp    %ecx,%ebx
 682:	74 1c                	je     6a0 <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 684:	29 d9                	sub    %ebx,%ecx
 686:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 689:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 68c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 68f:	89 15 10 0a 00 00    	mov    %edx,0xa10
      return (void*)(p + 1);
 695:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 698:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69b:	5b                   	pop    %ebx
 69c:	5e                   	pop    %esi
 69d:	5f                   	pop    %edi
 69e:	5d                   	pop    %ebp
 69f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6a0:	8b 08                	mov    (%eax),%ecx
 6a2:	89 0a                	mov    %ecx,(%edx)
 6a4:	eb e9                	jmp    68f <malloc+0x73>
  hp->s.size = nu;
 6a6:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6a9:	83 ec 0c             	sub    $0xc,%esp
 6ac:	83 c0 08             	add    $0x8,%eax
 6af:	50                   	push   %eax
 6b0:	e8 f9 fe ff ff       	call   5ae <free>
  return freep;
 6b5:	8b 15 10 0a 00 00    	mov    0xa10,%edx
      if((p = morecore(nunits)) == 0)
 6bb:	83 c4 10             	add    $0x10,%esp
 6be:	85 d2                	test   %edx,%edx
 6c0:	74 2b                	je     6ed <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c2:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6c4:	8b 48 04             	mov    0x4(%eax),%ecx
 6c7:	39 d9                	cmp    %ebx,%ecx
 6c9:	73 b5                	jae    680 <malloc+0x64>
 6cb:	89 c2                	mov    %eax,%edx
    if(p == freep)
 6cd:	39 05 10 0a 00 00    	cmp    %eax,0xa10
 6d3:	75 ed                	jne    6c2 <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 6d5:	83 ec 0c             	sub    $0xc,%esp
 6d8:	57                   	push   %edi
 6d9:	e8 5e fc ff ff       	call   33c <sbrk>
  if(p == (char*)-1)
 6de:	83 c4 10             	add    $0x10,%esp
 6e1:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e4:	75 c0                	jne    6a6 <malloc+0x8a>
        return 0;
 6e6:	b8 00 00 00 00       	mov    $0x0,%eax
 6eb:	eb ab                	jmp    698 <malloc+0x7c>
 6ed:	b8 00 00 00 00       	mov    $0x0,%eax
 6f2:	eb a4                	jmp    698 <malloc+0x7c>

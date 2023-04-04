
user/_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 e0 06 00 00       	push   $0x6e0
  19:	e8 c1 02 00 00       	call   2df <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	78 1b                	js     40 <main+0x40>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  25:	83 ec 0c             	sub    $0xc,%esp
  28:	6a 00                	push   $0x0
  2a:	e8 e8 02 00 00       	call   317 <dup>
  dup(0);  // stderr
  2f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  36:	e8 dc 02 00 00       	call   317 <dup>
  3b:	83 c4 10             	add    $0x10,%esp
  3e:	eb 58                	jmp    98 <main+0x98>
    mknod("console", 1, 1);
  40:	83 ec 04             	sub    $0x4,%esp
  43:	6a 01                	push   $0x1
  45:	6a 01                	push   $0x1
  47:	68 e0 06 00 00       	push   $0x6e0
  4c:	e8 96 02 00 00       	call   2e7 <mknod>
    open("console", O_RDWR);
  51:	83 c4 08             	add    $0x8,%esp
  54:	6a 02                	push   $0x2
  56:	68 e0 06 00 00       	push   $0x6e0
  5b:	e8 7f 02 00 00       	call   2df <open>
  60:	83 c4 10             	add    $0x10,%esp
  63:	eb c0                	jmp    25 <main+0x25>

  for(;;){
    printf(1, "init: starting sh\nID : 20192935\nName: Injun Choi\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  65:	83 ec 08             	sub    $0x8,%esp
  68:	68 e8 06 00 00       	push   $0x6e8
  6d:	6a 01                	push   $0x1
  6f:	e8 55 03 00 00       	call   3c9 <printf>
      exit();
  74:	e8 26 02 00 00       	call   29f <exit>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  79:	83 ec 08             	sub    $0x8,%esp
  7c:	68 14 07 00 00       	push   $0x714
  81:	6a 01                	push   $0x1
  83:	e8 41 03 00 00       	call   3c9 <printf>
  88:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
  8b:	e8 17 02 00 00       	call   2a7 <wait>
  90:	39 c3                	cmp    %eax,%ebx
  92:	74 04                	je     98 <main+0x98>
  94:	85 c0                	test   %eax,%eax
  96:	79 e1                	jns    79 <main+0x79>
    printf(1, "init: starting sh\nID : 20192935\nName: Injun Choi\n");
  98:	83 ec 08             	sub    $0x8,%esp
  9b:	68 20 07 00 00       	push   $0x720
  a0:	6a 01                	push   $0x1
  a2:	e8 22 03 00 00       	call   3c9 <printf>
    pid = fork();
  a7:	e8 eb 01 00 00       	call   297 <fork>
  ac:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	85 c0                	test   %eax,%eax
  b3:	78 b0                	js     65 <main+0x65>
    if(pid == 0){
  b5:	85 c0                	test   %eax,%eax
  b7:	75 d2                	jne    8b <main+0x8b>
      exec("sh", argv);
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 c8 09 00 00       	push   $0x9c8
  c1:	68 fb 06 00 00       	push   $0x6fb
  c6:	e8 0c 02 00 00       	call   2d7 <exec>
      printf(1, "init: exec sh failed\n");
  cb:	83 c4 08             	add    $0x8,%esp
  ce:	68 fe 06 00 00       	push   $0x6fe
  d3:	6a 01                	push   $0x1
  d5:	e8 ef 02 00 00       	call   3c9 <printf>
      exit();
  da:	e8 c0 01 00 00       	call   29f <exit>

000000df <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  df:	55                   	push   %ebp
  e0:	89 e5                	mov    %esp,%ebp
  e2:	53                   	push   %ebx
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e9:	89 c2                	mov    %eax,%edx
  eb:	83 c1 01             	add    $0x1,%ecx
  ee:	83 c2 01             	add    $0x1,%edx
  f1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  f5:	88 5a ff             	mov    %bl,-0x1(%edx)
  f8:	84 db                	test   %bl,%bl
  fa:	75 ef                	jne    eb <strcpy+0xc>
    ;
  return os;
}
  fc:	5b                   	pop    %ebx
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    

000000ff <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ff:	55                   	push   %ebp
 100:	89 e5                	mov    %esp,%ebp
 102:	8b 4d 08             	mov    0x8(%ebp),%ecx
 105:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 108:	0f b6 01             	movzbl (%ecx),%eax
 10b:	84 c0                	test   %al,%al
 10d:	74 15                	je     124 <strcmp+0x25>
 10f:	3a 02                	cmp    (%edx),%al
 111:	75 11                	jne    124 <strcmp+0x25>
    p++, q++;
 113:	83 c1 01             	add    $0x1,%ecx
 116:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 119:	0f b6 01             	movzbl (%ecx),%eax
 11c:	84 c0                	test   %al,%al
 11e:	74 04                	je     124 <strcmp+0x25>
 120:	3a 02                	cmp    (%edx),%al
 122:	74 ef                	je     113 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 124:	0f b6 c0             	movzbl %al,%eax
 127:	0f b6 12             	movzbl (%edx),%edx
 12a:	29 d0                	sub    %edx,%eax
}
 12c:	5d                   	pop    %ebp
 12d:	c3                   	ret    

0000012e <strlen>:

uint
strlen(const char *s)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
 131:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 134:	80 39 00             	cmpb   $0x0,(%ecx)
 137:	74 12                	je     14b <strlen+0x1d>
 139:	ba 00 00 00 00       	mov    $0x0,%edx
 13e:	83 c2 01             	add    $0x1,%edx
 141:	89 d0                	mov    %edx,%eax
 143:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 147:	75 f5                	jne    13e <strlen+0x10>
    ;
  return n;
}
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    
  for(n = 0; s[n]; n++)
 14b:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 150:	eb f7                	jmp    149 <strlen+0x1b>

00000152 <memset>:

void*
memset(void *dst, int c, uint n)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	57                   	push   %edi
 156:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 159:	89 d7                	mov    %edx,%edi
 15b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15e:	8b 45 0c             	mov    0xc(%ebp),%eax
 161:	fc                   	cld    
 162:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 164:	89 d0                	mov    %edx,%eax
 166:	5f                   	pop    %edi
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    

00000169 <strchr>:

char*
strchr(const char *s, char c)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
 16c:	53                   	push   %ebx
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 173:	0f b6 10             	movzbl (%eax),%edx
 176:	84 d2                	test   %dl,%dl
 178:	74 1e                	je     198 <strchr+0x2f>
 17a:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 17c:	38 d3                	cmp    %dl,%bl
 17e:	74 15                	je     195 <strchr+0x2c>
  for(; *s; s++)
 180:	83 c0 01             	add    $0x1,%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	84 d2                	test   %dl,%dl
 188:	74 06                	je     190 <strchr+0x27>
    if(*s == c)
 18a:	38 ca                	cmp    %cl,%dl
 18c:	75 f2                	jne    180 <strchr+0x17>
 18e:	eb 05                	jmp    195 <strchr+0x2c>
      return (char*)s;
  return 0;
 190:	b8 00 00 00 00       	mov    $0x0,%eax
}
 195:	5b                   	pop    %ebx
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    
  return 0;
 198:	b8 00 00 00 00       	mov    $0x0,%eax
 19d:	eb f6                	jmp    195 <strchr+0x2c>

0000019f <gets>:

char*
gets(char *buf, int max)
{
 19f:	55                   	push   %ebp
 1a0:	89 e5                	mov    %esp,%ebp
 1a2:	57                   	push   %edi
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a8:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 1ad:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1b0:	8d 5e 01             	lea    0x1(%esi),%ebx
 1b3:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b6:	7d 2b                	jge    1e3 <gets+0x44>
    cc = read(0, &c, 1);
 1b8:	83 ec 04             	sub    $0x4,%esp
 1bb:	6a 01                	push   $0x1
 1bd:	57                   	push   %edi
 1be:	6a 00                	push   $0x0
 1c0:	e8 f2 00 00 00       	call   2b7 <read>
    if(cc < 1)
 1c5:	83 c4 10             	add    $0x10,%esp
 1c8:	85 c0                	test   %eax,%eax
 1ca:	7e 17                	jle    1e3 <gets+0x44>
      break;
    buf[i++] = c;
 1cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d0:	8b 55 08             	mov    0x8(%ebp),%edx
 1d3:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 1d7:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1d9:	3c 0a                	cmp    $0xa,%al
 1db:	74 04                	je     1e1 <gets+0x42>
 1dd:	3c 0d                	cmp    $0xd,%al
 1df:	75 cf                	jne    1b0 <gets+0x11>
  for(i=0; i+1 < max; ){
 1e1:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ed:	5b                   	pop    %ebx
 1ee:	5e                   	pop    %esi
 1ef:	5f                   	pop    %edi
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret    

000001f2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	56                   	push   %esi
 1f6:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f7:	83 ec 08             	sub    $0x8,%esp
 1fa:	6a 00                	push   $0x0
 1fc:	ff 75 08             	pushl  0x8(%ebp)
 1ff:	e8 db 00 00 00       	call   2df <open>
  if(fd < 0)
 204:	83 c4 10             	add    $0x10,%esp
 207:	85 c0                	test   %eax,%eax
 209:	78 24                	js     22f <stat+0x3d>
 20b:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 20d:	83 ec 08             	sub    $0x8,%esp
 210:	ff 75 0c             	pushl  0xc(%ebp)
 213:	50                   	push   %eax
 214:	e8 de 00 00 00       	call   2f7 <fstat>
 219:	89 c6                	mov    %eax,%esi
  close(fd);
 21b:	89 1c 24             	mov    %ebx,(%esp)
 21e:	e8 a4 00 00 00       	call   2c7 <close>
  return r;
 223:	83 c4 10             	add    $0x10,%esp
}
 226:	89 f0                	mov    %esi,%eax
 228:	8d 65 f8             	lea    -0x8(%ebp),%esp
 22b:	5b                   	pop    %ebx
 22c:	5e                   	pop    %esi
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
    return -1;
 22f:	be ff ff ff ff       	mov    $0xffffffff,%esi
 234:	eb f0                	jmp    226 <stat+0x34>

00000236 <atoi>:

int
atoi(const char *s)
{
 236:	55                   	push   %ebp
 237:	89 e5                	mov    %esp,%ebp
 239:	53                   	push   %ebx
 23a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23d:	0f b6 11             	movzbl (%ecx),%edx
 240:	8d 42 d0             	lea    -0x30(%edx),%eax
 243:	3c 09                	cmp    $0x9,%al
 245:	77 20                	ja     267 <atoi+0x31>
  n = 0;
 247:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 24c:	83 c1 01             	add    $0x1,%ecx
 24f:	8d 04 80             	lea    (%eax,%eax,4),%eax
 252:	0f be d2             	movsbl %dl,%edx
 255:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 259:	0f b6 11             	movzbl (%ecx),%edx
 25c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25f:	80 fb 09             	cmp    $0x9,%bl
 262:	76 e8                	jbe    24c <atoi+0x16>
  return n;
}
 264:	5b                   	pop    %ebx
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
  n = 0;
 267:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 26c:	eb f6                	jmp    264 <atoi+0x2e>

0000026e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26e:	55                   	push   %ebp
 26f:	89 e5                	mov    %esp,%ebp
 271:	56                   	push   %esi
 272:	53                   	push   %ebx
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	8b 75 0c             	mov    0xc(%ebp),%esi
 279:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27c:	85 db                	test   %ebx,%ebx
 27e:	7e 13                	jle    293 <memmove+0x25>
 280:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 285:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 289:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28c:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 28f:	39 d3                	cmp    %edx,%ebx
 291:	75 f2                	jne    285 <memmove+0x17>
  return vdst;
}
 293:	5b                   	pop    %ebx
 294:	5e                   	pop    %esi
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    

00000297 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 297:	b8 01 00 00 00       	mov    $0x1,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <exit>:
SYSCALL(exit)
 29f:	b8 02 00 00 00       	mov    $0x2,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <wait>:
SYSCALL(wait)
 2a7:	b8 03 00 00 00       	mov    $0x3,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <pipe>:
SYSCALL(pipe)
 2af:	b8 04 00 00 00       	mov    $0x4,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <read>:
SYSCALL(read)
 2b7:	b8 05 00 00 00       	mov    $0x5,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <write>:
SYSCALL(write)
 2bf:	b8 10 00 00 00       	mov    $0x10,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <close>:
SYSCALL(close)
 2c7:	b8 15 00 00 00       	mov    $0x15,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <kill>:
SYSCALL(kill)
 2cf:	b8 06 00 00 00       	mov    $0x6,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <exec>:
SYSCALL(exec)
 2d7:	b8 07 00 00 00       	mov    $0x7,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <open>:
SYSCALL(open)
 2df:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <mknod>:
SYSCALL(mknod)
 2e7:	b8 11 00 00 00       	mov    $0x11,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <unlink>:
SYSCALL(unlink)
 2ef:	b8 12 00 00 00       	mov    $0x12,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <fstat>:
SYSCALL(fstat)
 2f7:	b8 08 00 00 00       	mov    $0x8,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <link>:
SYSCALL(link)
 2ff:	b8 13 00 00 00       	mov    $0x13,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <mkdir>:
SYSCALL(mkdir)
 307:	b8 14 00 00 00       	mov    $0x14,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <chdir>:
SYSCALL(chdir)
 30f:	b8 09 00 00 00       	mov    $0x9,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <dup>:
SYSCALL(dup)
 317:	b8 0a 00 00 00       	mov    $0xa,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <getpid>:
SYSCALL(getpid)
 31f:	b8 0b 00 00 00       	mov    $0xb,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <sbrk>:
SYSCALL(sbrk)
 327:	b8 0c 00 00 00       	mov    $0xc,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <sleep>:
SYSCALL(sleep)
 32f:	b8 0d 00 00 00       	mov    $0xd,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <uptime>:
SYSCALL(uptime)
 337:	b8 0e 00 00 00       	mov    $0xe,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 33f:	55                   	push   %ebp
 340:	89 e5                	mov    %esp,%ebp
 342:	57                   	push   %edi
 343:	56                   	push   %esi
 344:	53                   	push   %ebx
 345:	83 ec 3c             	sub    $0x3c,%esp
 348:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 34e:	74 14                	je     364 <printint+0x25>
 350:	85 d2                	test   %edx,%edx
 352:	79 10                	jns    364 <printint+0x25>
    neg = 1;
    x = -xx;
 354:	f7 da                	neg    %edx
    neg = 1;
 356:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 35d:	bf 00 00 00 00       	mov    $0x0,%edi
 362:	eb 0b                	jmp    36f <printint+0x30>
  neg = 0;
 364:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 36b:	eb f0                	jmp    35d <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 36d:	89 df                	mov    %ebx,%edi
 36f:	8d 5f 01             	lea    0x1(%edi),%ebx
 372:	89 d0                	mov    %edx,%eax
 374:	ba 00 00 00 00       	mov    $0x0,%edx
 379:	f7 f1                	div    %ecx
 37b:	0f b6 92 5c 07 00 00 	movzbl 0x75c(%edx),%edx
 382:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 386:	89 c2                	mov    %eax,%edx
 388:	85 c0                	test   %eax,%eax
 38a:	75 e1                	jne    36d <printint+0x2e>
  if(neg)
 38c:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 390:	74 08                	je     39a <printint+0x5b>
    buf[i++] = '-';
 392:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 397:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 39a:	83 eb 01             	sub    $0x1,%ebx
 39d:	78 22                	js     3c1 <printint+0x82>
  write(fd, &c, 1);
 39f:	8d 7d d7             	lea    -0x29(%ebp),%edi
 3a2:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 3a7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3aa:	83 ec 04             	sub    $0x4,%esp
 3ad:	6a 01                	push   $0x1
 3af:	57                   	push   %edi
 3b0:	56                   	push   %esi
 3b1:	e8 09 ff ff ff       	call   2bf <write>
  while(--i >= 0)
 3b6:	83 eb 01             	sub    $0x1,%ebx
 3b9:	83 c4 10             	add    $0x10,%esp
 3bc:	83 fb ff             	cmp    $0xffffffff,%ebx
 3bf:	75 e1                	jne    3a2 <printint+0x63>
    putc(fd, buf[i]);
}
 3c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3c4:	5b                   	pop    %ebx
 3c5:	5e                   	pop    %esi
 3c6:	5f                   	pop    %edi
 3c7:	5d                   	pop    %ebp
 3c8:	c3                   	ret    

000003c9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3c9:	55                   	push   %ebp
 3ca:	89 e5                	mov    %esp,%ebp
 3cc:	57                   	push   %edi
 3cd:	56                   	push   %esi
 3ce:	53                   	push   %ebx
 3cf:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d2:	8b 75 0c             	mov    0xc(%ebp),%esi
 3d5:	0f b6 1e             	movzbl (%esi),%ebx
 3d8:	84 db                	test   %bl,%bl
 3da:	0f 84 b1 01 00 00    	je     591 <printf+0x1c8>
 3e0:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 3e3:	8d 45 10             	lea    0x10(%ebp),%eax
 3e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 3e9:	bf 00 00 00 00       	mov    $0x0,%edi
 3ee:	eb 2d                	jmp    41d <printf+0x54>
 3f0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 3f3:	83 ec 04             	sub    $0x4,%esp
 3f6:	6a 01                	push   $0x1
 3f8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3fb:	50                   	push   %eax
 3fc:	ff 75 08             	pushl  0x8(%ebp)
 3ff:	e8 bb fe ff ff       	call   2bf <write>
 404:	83 c4 10             	add    $0x10,%esp
 407:	eb 05                	jmp    40e <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 409:	83 ff 25             	cmp    $0x25,%edi
 40c:	74 22                	je     430 <printf+0x67>
 40e:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 411:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 415:	84 db                	test   %bl,%bl
 417:	0f 84 74 01 00 00    	je     591 <printf+0x1c8>
    c = fmt[i] & 0xff;
 41d:	0f be d3             	movsbl %bl,%edx
 420:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 423:	85 ff                	test   %edi,%edi
 425:	75 e2                	jne    409 <printf+0x40>
      if(c == '%'){
 427:	83 f8 25             	cmp    $0x25,%eax
 42a:	75 c4                	jne    3f0 <printf+0x27>
        state = '%';
 42c:	89 c7                	mov    %eax,%edi
 42e:	eb de                	jmp    40e <printf+0x45>
      if(c == 'd'){
 430:	83 f8 64             	cmp    $0x64,%eax
 433:	74 59                	je     48e <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 435:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 43b:	83 fa 70             	cmp    $0x70,%edx
 43e:	74 7a                	je     4ba <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 440:	83 f8 73             	cmp    $0x73,%eax
 443:	0f 84 9d 00 00 00    	je     4e6 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 449:	83 f8 63             	cmp    $0x63,%eax
 44c:	0f 84 f2 00 00 00    	je     544 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 452:	83 f8 25             	cmp    $0x25,%eax
 455:	0f 84 15 01 00 00    	je     570 <printf+0x1a7>
 45b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 45f:	83 ec 04             	sub    $0x4,%esp
 462:	6a 01                	push   $0x1
 464:	8d 45 e7             	lea    -0x19(%ebp),%eax
 467:	50                   	push   %eax
 468:	ff 75 08             	pushl  0x8(%ebp)
 46b:	e8 4f fe ff ff       	call   2bf <write>
 470:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 473:	83 c4 0c             	add    $0xc,%esp
 476:	6a 01                	push   $0x1
 478:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 47b:	50                   	push   %eax
 47c:	ff 75 08             	pushl  0x8(%ebp)
 47f:	e8 3b fe ff ff       	call   2bf <write>
 484:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 487:	bf 00 00 00 00       	mov    $0x0,%edi
 48c:	eb 80                	jmp    40e <printf+0x45>
        printint(fd, *ap, 10, 1);
 48e:	83 ec 0c             	sub    $0xc,%esp
 491:	6a 01                	push   $0x1
 493:	b9 0a 00 00 00       	mov    $0xa,%ecx
 498:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 49b:	8b 17                	mov    (%edi),%edx
 49d:	8b 45 08             	mov    0x8(%ebp),%eax
 4a0:	e8 9a fe ff ff       	call   33f <printint>
        ap++;
 4a5:	89 f8                	mov    %edi,%eax
 4a7:	83 c0 04             	add    $0x4,%eax
 4aa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4ad:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4b0:	bf 00 00 00 00       	mov    $0x0,%edi
 4b5:	e9 54 ff ff ff       	jmp    40e <printf+0x45>
        printint(fd, *ap, 16, 0);
 4ba:	83 ec 0c             	sub    $0xc,%esp
 4bd:	6a 00                	push   $0x0
 4bf:	b9 10 00 00 00       	mov    $0x10,%ecx
 4c4:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c7:	8b 17                	mov    (%edi),%edx
 4c9:	8b 45 08             	mov    0x8(%ebp),%eax
 4cc:	e8 6e fe ff ff       	call   33f <printint>
        ap++;
 4d1:	89 f8                	mov    %edi,%eax
 4d3:	83 c0 04             	add    $0x4,%eax
 4d6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4d9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4dc:	bf 00 00 00 00       	mov    $0x0,%edi
 4e1:	e9 28 ff ff ff       	jmp    40e <printf+0x45>
        s = (char*)*ap;
 4e6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 4e9:	8b 01                	mov    (%ecx),%eax
        ap++;
 4eb:	83 c1 04             	add    $0x4,%ecx
 4ee:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 4f1:	85 c0                	test   %eax,%eax
 4f3:	74 13                	je     508 <printf+0x13f>
        s = (char*)*ap;
 4f5:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 4f7:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 4fa:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 4ff:	84 c0                	test   %al,%al
 501:	75 0f                	jne    512 <printf+0x149>
 503:	e9 06 ff ff ff       	jmp    40e <printf+0x45>
          s = "(null)";
 508:	bb 54 07 00 00       	mov    $0x754,%ebx
        while(*s != 0){
 50d:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 512:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 515:	89 75 d0             	mov    %esi,-0x30(%ebp)
 518:	8b 75 08             	mov    0x8(%ebp),%esi
 51b:	88 45 e3             	mov    %al,-0x1d(%ebp)
 51e:	83 ec 04             	sub    $0x4,%esp
 521:	6a 01                	push   $0x1
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	e8 95 fd ff ff       	call   2bf <write>
          s++;
 52a:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 52d:	0f b6 03             	movzbl (%ebx),%eax
 530:	83 c4 10             	add    $0x10,%esp
 533:	84 c0                	test   %al,%al
 535:	75 e4                	jne    51b <printf+0x152>
 537:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 53a:	bf 00 00 00 00       	mov    $0x0,%edi
 53f:	e9 ca fe ff ff       	jmp    40e <printf+0x45>
        putc(fd, *ap);
 544:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 547:	8b 07                	mov    (%edi),%eax
 549:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 54c:	83 ec 04             	sub    $0x4,%esp
 54f:	6a 01                	push   $0x1
 551:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 554:	50                   	push   %eax
 555:	ff 75 08             	pushl  0x8(%ebp)
 558:	e8 62 fd ff ff       	call   2bf <write>
        ap++;
 55d:	83 c7 04             	add    $0x4,%edi
 560:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 563:	83 c4 10             	add    $0x10,%esp
      state = 0;
 566:	bf 00 00 00 00       	mov    $0x0,%edi
 56b:	e9 9e fe ff ff       	jmp    40e <printf+0x45>
 570:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 573:	83 ec 04             	sub    $0x4,%esp
 576:	6a 01                	push   $0x1
 578:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 57b:	50                   	push   %eax
 57c:	ff 75 08             	pushl  0x8(%ebp)
 57f:	e8 3b fd ff ff       	call   2bf <write>
 584:	83 c4 10             	add    $0x10,%esp
      state = 0;
 587:	bf 00 00 00 00       	mov    $0x0,%edi
 58c:	e9 7d fe ff ff       	jmp    40e <printf+0x45>
    }
  }
}
 591:	8d 65 f4             	lea    -0xc(%ebp),%esp
 594:	5b                   	pop    %ebx
 595:	5e                   	pop    %esi
 596:	5f                   	pop    %edi
 597:	5d                   	pop    %ebp
 598:	c3                   	ret    

00000599 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 599:	55                   	push   %ebp
 59a:	89 e5                	mov    %esp,%ebp
 59c:	57                   	push   %edi
 59d:	56                   	push   %esi
 59e:	53                   	push   %ebx
 59f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a2:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a5:	a1 d0 09 00 00       	mov    0x9d0,%eax
 5aa:	eb 0c                	jmp    5b8 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ac:	8b 10                	mov    (%eax),%edx
 5ae:	39 c2                	cmp    %eax,%edx
 5b0:	77 04                	ja     5b6 <free+0x1d>
 5b2:	39 ca                	cmp    %ecx,%edx
 5b4:	77 10                	ja     5c6 <free+0x2d>
{
 5b6:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b8:	39 c8                	cmp    %ecx,%eax
 5ba:	73 f0                	jae    5ac <free+0x13>
 5bc:	8b 10                	mov    (%eax),%edx
 5be:	39 ca                	cmp    %ecx,%edx
 5c0:	77 04                	ja     5c6 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c2:	39 c2                	cmp    %eax,%edx
 5c4:	77 f0                	ja     5b6 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c9:	8b 10                	mov    (%eax),%edx
 5cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ce:	39 fa                	cmp    %edi,%edx
 5d0:	74 19                	je     5eb <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5d5:	8b 50 04             	mov    0x4(%eax),%edx
 5d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5db:	39 f1                	cmp    %esi,%ecx
 5dd:	74 1b                	je     5fa <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5df:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5e1:	a3 d0 09 00 00       	mov    %eax,0x9d0
}
 5e6:	5b                   	pop    %ebx
 5e7:	5e                   	pop    %esi
 5e8:	5f                   	pop    %edi
 5e9:	5d                   	pop    %ebp
 5ea:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5eb:	03 72 04             	add    0x4(%edx),%esi
 5ee:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5f1:	8b 10                	mov    (%eax),%edx
 5f3:	8b 12                	mov    (%edx),%edx
 5f5:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5f8:	eb db                	jmp    5d5 <free+0x3c>
    p->s.size += bp->s.size;
 5fa:	03 53 fc             	add    -0x4(%ebx),%edx
 5fd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 600:	8b 53 f8             	mov    -0x8(%ebx),%edx
 603:	89 10                	mov    %edx,(%eax)
 605:	eb da                	jmp    5e1 <free+0x48>

00000607 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 607:	55                   	push   %ebp
 608:	89 e5                	mov    %esp,%ebp
 60a:	57                   	push   %edi
 60b:	56                   	push   %esi
 60c:	53                   	push   %ebx
 60d:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 610:	8b 45 08             	mov    0x8(%ebp),%eax
 613:	8d 58 07             	lea    0x7(%eax),%ebx
 616:	c1 eb 03             	shr    $0x3,%ebx
 619:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 61c:	8b 15 d0 09 00 00    	mov    0x9d0,%edx
 622:	85 d2                	test   %edx,%edx
 624:	74 20                	je     646 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 626:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 628:	8b 48 04             	mov    0x4(%eax),%ecx
 62b:	39 cb                	cmp    %ecx,%ebx
 62d:	76 3c                	jbe    66b <malloc+0x64>
 62f:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 635:	be 00 10 00 00       	mov    $0x1000,%esi
 63a:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 63d:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 644:	eb 70                	jmp    6b6 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 646:	c7 05 d0 09 00 00 d4 	movl   $0x9d4,0x9d0
 64d:	09 00 00 
 650:	c7 05 d4 09 00 00 d4 	movl   $0x9d4,0x9d4
 657:	09 00 00 
    base.s.size = 0;
 65a:	c7 05 d8 09 00 00 00 	movl   $0x0,0x9d8
 661:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 664:	ba d4 09 00 00       	mov    $0x9d4,%edx
 669:	eb bb                	jmp    626 <malloc+0x1f>
      if(p->s.size == nunits)
 66b:	39 cb                	cmp    %ecx,%ebx
 66d:	74 1c                	je     68b <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 66f:	29 d9                	sub    %ebx,%ecx
 671:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 674:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 677:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 67a:	89 15 d0 09 00 00    	mov    %edx,0x9d0
      return (void*)(p + 1);
 680:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 683:	8d 65 f4             	lea    -0xc(%ebp),%esp
 686:	5b                   	pop    %ebx
 687:	5e                   	pop    %esi
 688:	5f                   	pop    %edi
 689:	5d                   	pop    %ebp
 68a:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 68b:	8b 08                	mov    (%eax),%ecx
 68d:	89 0a                	mov    %ecx,(%edx)
 68f:	eb e9                	jmp    67a <malloc+0x73>
  hp->s.size = nu;
 691:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 694:	83 ec 0c             	sub    $0xc,%esp
 697:	83 c0 08             	add    $0x8,%eax
 69a:	50                   	push   %eax
 69b:	e8 f9 fe ff ff       	call   599 <free>
  return freep;
 6a0:	8b 15 d0 09 00 00    	mov    0x9d0,%edx
      if((p = morecore(nunits)) == 0)
 6a6:	83 c4 10             	add    $0x10,%esp
 6a9:	85 d2                	test   %edx,%edx
 6ab:	74 2b                	je     6d8 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6ad:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6af:	8b 48 04             	mov    0x4(%eax),%ecx
 6b2:	39 d9                	cmp    %ebx,%ecx
 6b4:	73 b5                	jae    66b <malloc+0x64>
 6b6:	89 c2                	mov    %eax,%edx
    if(p == freep)
 6b8:	39 05 d0 09 00 00    	cmp    %eax,0x9d0
 6be:	75 ed                	jne    6ad <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 6c0:	83 ec 0c             	sub    $0xc,%esp
 6c3:	57                   	push   %edi
 6c4:	e8 5e fc ff ff       	call   327 <sbrk>
  if(p == (char*)-1)
 6c9:	83 c4 10             	add    $0x10,%esp
 6cc:	83 f8 ff             	cmp    $0xffffffff,%eax
 6cf:	75 c0                	jne    691 <malloc+0x8a>
        return 0;
 6d1:	b8 00 00 00 00       	mov    $0x0,%eax
 6d6:	eb ab                	jmp    683 <malloc+0x7c>
 6d8:	b8 00 00 00 00       	mov    $0x0,%eax
 6dd:	eb a4                	jmp    683 <malloc+0x7c>

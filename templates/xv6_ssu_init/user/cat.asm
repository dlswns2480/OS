
user/_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   8:	83 ec 04             	sub    $0x4,%esp
   b:	68 00 02 00 00       	push   $0x200
  10:	68 00 0a 00 00       	push   $0xa00
  15:	56                   	push   %esi
  16:	e8 b8 02 00 00       	call   2d3 <read>
  1b:	89 c3                	mov    %eax,%ebx
  1d:	83 c4 10             	add    $0x10,%esp
  20:	85 c0                	test   %eax,%eax
  22:	7e 2b                	jle    4f <cat+0x4f>
    if (write(1, buf, n) != n) {
  24:	83 ec 04             	sub    $0x4,%esp
  27:	53                   	push   %ebx
  28:	68 00 0a 00 00       	push   $0xa00
  2d:	6a 01                	push   $0x1
  2f:	e8 a7 02 00 00       	call   2db <write>
  34:	83 c4 10             	add    $0x10,%esp
  37:	39 d8                	cmp    %ebx,%eax
  39:	74 cd                	je     8 <cat+0x8>
      printf(1, "cat: write error\n");
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	68 fc 06 00 00       	push   $0x6fc
  43:	6a 01                	push   $0x1
  45:	e8 9b 03 00 00       	call   3e5 <printf>
      exit();
  4a:	e8 6c 02 00 00       	call   2bb <exit>
    }
  }
  if(n < 0){
  4f:	85 c0                	test   %eax,%eax
  51:	78 07                	js     5a <cat+0x5a>
    printf(1, "cat: read error\n");
    exit();
  }
}
  53:	8d 65 f8             	lea    -0x8(%ebp),%esp
  56:	5b                   	pop    %ebx
  57:	5e                   	pop    %esi
  58:	5d                   	pop    %ebp
  59:	c3                   	ret    
    printf(1, "cat: read error\n");
  5a:	83 ec 08             	sub    $0x8,%esp
  5d:	68 0e 07 00 00       	push   $0x70e
  62:	6a 01                	push   $0x1
  64:	e8 7c 03 00 00       	call   3e5 <printf>
    exit();
  69:	e8 4d 02 00 00       	call   2bb <exit>

0000006e <main>:

int
main(int argc, char *argv[])
{
  6e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  72:	83 e4 f0             	and    $0xfffffff0,%esp
  75:	ff 71 fc             	pushl  -0x4(%ecx)
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	57                   	push   %edi
  7c:	56                   	push   %esi
  7d:	53                   	push   %ebx
  7e:	51                   	push   %ecx
  7f:	83 ec 18             	sub    $0x18,%esp
  82:	8b 01                	mov    (%ecx),%eax
  84:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  87:	8b 59 04             	mov    0x4(%ecx),%ebx
  8a:	83 c3 04             	add    $0x4,%ebx
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  8d:	bf 01 00 00 00       	mov    $0x1,%edi
  if(argc <= 1){
  92:	83 f8 01             	cmp    $0x1,%eax
  95:	7e 3c                	jle    d3 <main+0x65>
    if((fd = open(argv[i], 0)) < 0){
  97:	89 5d e0             	mov    %ebx,-0x20(%ebp)
  9a:	83 ec 08             	sub    $0x8,%esp
  9d:	6a 00                	push   $0x0
  9f:	ff 33                	pushl  (%ebx)
  a1:	e8 55 02 00 00       	call   2fb <open>
  a6:	89 c6                	mov    %eax,%esi
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	85 c0                	test   %eax,%eax
  ad:	78 33                	js     e2 <main+0x74>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  af:	83 ec 0c             	sub    $0xc,%esp
  b2:	50                   	push   %eax
  b3:	e8 48 ff ff ff       	call   0 <cat>
    close(fd);
  b8:	89 34 24             	mov    %esi,(%esp)
  bb:	e8 23 02 00 00       	call   2e3 <close>
  for(i = 1; i < argc; i++){
  c0:	83 c7 01             	add    $0x1,%edi
  c3:	83 c3 04             	add    $0x4,%ebx
  c6:	83 c4 10             	add    $0x10,%esp
  c9:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  cc:	75 c9                	jne    97 <main+0x29>
  }
  exit();
  ce:	e8 e8 01 00 00       	call   2bb <exit>
    cat(0);
  d3:	83 ec 0c             	sub    $0xc,%esp
  d6:	6a 00                	push   $0x0
  d8:	e8 23 ff ff ff       	call   0 <cat>
    exit();
  dd:	e8 d9 01 00 00       	call   2bb <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  e2:	83 ec 04             	sub    $0x4,%esp
  e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  e8:	ff 30                	pushl  (%eax)
  ea:	68 1f 07 00 00       	push   $0x71f
  ef:	6a 01                	push   $0x1
  f1:	e8 ef 02 00 00       	call   3e5 <printf>
      exit();
  f6:	e8 c0 01 00 00       	call   2bb <exit>

000000fb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  fb:	55                   	push   %ebp
  fc:	89 e5                	mov    %esp,%ebp
  fe:	53                   	push   %ebx
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 105:	89 c2                	mov    %eax,%edx
 107:	83 c1 01             	add    $0x1,%ecx
 10a:	83 c2 01             	add    $0x1,%edx
 10d:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 111:	88 5a ff             	mov    %bl,-0x1(%edx)
 114:	84 db                	test   %bl,%bl
 116:	75 ef                	jne    107 <strcpy+0xc>
    ;
  return os;
}
 118:	5b                   	pop    %ebx
 119:	5d                   	pop    %ebp
 11a:	c3                   	ret    

0000011b <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	8b 4d 08             	mov    0x8(%ebp),%ecx
 121:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 124:	0f b6 01             	movzbl (%ecx),%eax
 127:	84 c0                	test   %al,%al
 129:	74 15                	je     140 <strcmp+0x25>
 12b:	3a 02                	cmp    (%edx),%al
 12d:	75 11                	jne    140 <strcmp+0x25>
    p++, q++;
 12f:	83 c1 01             	add    $0x1,%ecx
 132:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 135:	0f b6 01             	movzbl (%ecx),%eax
 138:	84 c0                	test   %al,%al
 13a:	74 04                	je     140 <strcmp+0x25>
 13c:	3a 02                	cmp    (%edx),%al
 13e:	74 ef                	je     12f <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 140:	0f b6 c0             	movzbl %al,%eax
 143:	0f b6 12             	movzbl (%edx),%edx
 146:	29 d0                	sub    %edx,%eax
}
 148:	5d                   	pop    %ebp
 149:	c3                   	ret    

0000014a <strlen>:

uint
strlen(const char *s)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 150:	80 39 00             	cmpb   $0x0,(%ecx)
 153:	74 12                	je     167 <strlen+0x1d>
 155:	ba 00 00 00 00       	mov    $0x0,%edx
 15a:	83 c2 01             	add    $0x1,%edx
 15d:	89 d0                	mov    %edx,%eax
 15f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 163:	75 f5                	jne    15a <strlen+0x10>
    ;
  return n;
}
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
  for(n = 0; s[n]; n++)
 167:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 16c:	eb f7                	jmp    165 <strlen+0x1b>

0000016e <memset>:

void*
memset(void *dst, int c, uint n)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	57                   	push   %edi
 172:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 175:	89 d7                	mov    %edx,%edi
 177:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17a:	8b 45 0c             	mov    0xc(%ebp),%eax
 17d:	fc                   	cld    
 17e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 180:	89 d0                	mov    %edx,%eax
 182:	5f                   	pop    %edi
 183:	5d                   	pop    %ebp
 184:	c3                   	ret    

00000185 <strchr>:

char*
strchr(const char *s, char c)
{
 185:	55                   	push   %ebp
 186:	89 e5                	mov    %esp,%ebp
 188:	53                   	push   %ebx
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 18f:	0f b6 10             	movzbl (%eax),%edx
 192:	84 d2                	test   %dl,%dl
 194:	74 1e                	je     1b4 <strchr+0x2f>
 196:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 198:	38 d3                	cmp    %dl,%bl
 19a:	74 15                	je     1b1 <strchr+0x2c>
  for(; *s; s++)
 19c:	83 c0 01             	add    $0x1,%eax
 19f:	0f b6 10             	movzbl (%eax),%edx
 1a2:	84 d2                	test   %dl,%dl
 1a4:	74 06                	je     1ac <strchr+0x27>
    if(*s == c)
 1a6:	38 ca                	cmp    %cl,%dl
 1a8:	75 f2                	jne    19c <strchr+0x17>
 1aa:	eb 05                	jmp    1b1 <strchr+0x2c>
      return (char*)s;
  return 0;
 1ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b1:	5b                   	pop    %ebx
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
  return 0;
 1b4:	b8 00 00 00 00       	mov    $0x0,%eax
 1b9:	eb f6                	jmp    1b1 <strchr+0x2c>

000001bb <gets>:

char*
gets(char *buf, int max)
{
 1bb:	55                   	push   %ebp
 1bc:	89 e5                	mov    %esp,%ebp
 1be:	57                   	push   %edi
 1bf:	56                   	push   %esi
 1c0:	53                   	push   %ebx
 1c1:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c4:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 1c9:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1cc:	8d 5e 01             	lea    0x1(%esi),%ebx
 1cf:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d2:	7d 2b                	jge    1ff <gets+0x44>
    cc = read(0, &c, 1);
 1d4:	83 ec 04             	sub    $0x4,%esp
 1d7:	6a 01                	push   $0x1
 1d9:	57                   	push   %edi
 1da:	6a 00                	push   $0x0
 1dc:	e8 f2 00 00 00       	call   2d3 <read>
    if(cc < 1)
 1e1:	83 c4 10             	add    $0x10,%esp
 1e4:	85 c0                	test   %eax,%eax
 1e6:	7e 17                	jle    1ff <gets+0x44>
      break;
    buf[i++] = c;
 1e8:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1ec:	8b 55 08             	mov    0x8(%ebp),%edx
 1ef:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 1f3:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1f5:	3c 0a                	cmp    $0xa,%al
 1f7:	74 04                	je     1fd <gets+0x42>
 1f9:	3c 0d                	cmp    $0xd,%al
 1fb:	75 cf                	jne    1cc <gets+0x11>
  for(i=0; i+1 < max; ){
 1fd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
 202:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 206:	8d 65 f4             	lea    -0xc(%ebp),%esp
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5f                   	pop    %edi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    

0000020e <stat>:

int
stat(const char *n, struct stat *st)
{
 20e:	55                   	push   %ebp
 20f:	89 e5                	mov    %esp,%ebp
 211:	56                   	push   %esi
 212:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 213:	83 ec 08             	sub    $0x8,%esp
 216:	6a 00                	push   $0x0
 218:	ff 75 08             	pushl  0x8(%ebp)
 21b:	e8 db 00 00 00       	call   2fb <open>
  if(fd < 0)
 220:	83 c4 10             	add    $0x10,%esp
 223:	85 c0                	test   %eax,%eax
 225:	78 24                	js     24b <stat+0x3d>
 227:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	50                   	push   %eax
 230:	e8 de 00 00 00       	call   313 <fstat>
 235:	89 c6                	mov    %eax,%esi
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
 23a:	e8 a4 00 00 00       	call   2e3 <close>
  return r;
 23f:	83 c4 10             	add    $0x10,%esp
}
 242:	89 f0                	mov    %esi,%eax
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	5b                   	pop    %ebx
 248:	5e                   	pop    %esi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
    return -1;
 24b:	be ff ff ff ff       	mov    $0xffffffff,%esi
 250:	eb f0                	jmp    242 <stat+0x34>

00000252 <atoi>:

int
atoi(const char *s)
{
 252:	55                   	push   %ebp
 253:	89 e5                	mov    %esp,%ebp
 255:	53                   	push   %ebx
 256:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 259:	0f b6 11             	movzbl (%ecx),%edx
 25c:	8d 42 d0             	lea    -0x30(%edx),%eax
 25f:	3c 09                	cmp    $0x9,%al
 261:	77 20                	ja     283 <atoi+0x31>
  n = 0;
 263:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 268:	83 c1 01             	add    $0x1,%ecx
 26b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 26e:	0f be d2             	movsbl %dl,%edx
 271:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 275:	0f b6 11             	movzbl (%ecx),%edx
 278:	8d 5a d0             	lea    -0x30(%edx),%ebx
 27b:	80 fb 09             	cmp    $0x9,%bl
 27e:	76 e8                	jbe    268 <atoi+0x16>
  return n;
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
  n = 0;
 283:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 288:	eb f6                	jmp    280 <atoi+0x2e>

0000028a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 28a:	55                   	push   %ebp
 28b:	89 e5                	mov    %esp,%ebp
 28d:	56                   	push   %esi
 28e:	53                   	push   %ebx
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	8b 75 0c             	mov    0xc(%ebp),%esi
 295:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 298:	85 db                	test   %ebx,%ebx
 29a:	7e 13                	jle    2af <memmove+0x25>
 29c:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 2a1:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2a5:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2a8:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2ab:	39 d3                	cmp    %edx,%ebx
 2ad:	75 f2                	jne    2a1 <memmove+0x17>
  return vdst;
}
 2af:	5b                   	pop    %ebx
 2b0:	5e                   	pop    %esi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    

000002b3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b3:	b8 01 00 00 00       	mov    $0x1,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <exit>:
SYSCALL(exit)
 2bb:	b8 02 00 00 00       	mov    $0x2,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <wait>:
SYSCALL(wait)
 2c3:	b8 03 00 00 00       	mov    $0x3,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <pipe>:
SYSCALL(pipe)
 2cb:	b8 04 00 00 00       	mov    $0x4,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <read>:
SYSCALL(read)
 2d3:	b8 05 00 00 00       	mov    $0x5,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <write>:
SYSCALL(write)
 2db:	b8 10 00 00 00       	mov    $0x10,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <close>:
SYSCALL(close)
 2e3:	b8 15 00 00 00       	mov    $0x15,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <kill>:
SYSCALL(kill)
 2eb:	b8 06 00 00 00       	mov    $0x6,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <exec>:
SYSCALL(exec)
 2f3:	b8 07 00 00 00       	mov    $0x7,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <open>:
SYSCALL(open)
 2fb:	b8 0f 00 00 00       	mov    $0xf,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <mknod>:
SYSCALL(mknod)
 303:	b8 11 00 00 00       	mov    $0x11,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <unlink>:
SYSCALL(unlink)
 30b:	b8 12 00 00 00       	mov    $0x12,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <fstat>:
SYSCALL(fstat)
 313:	b8 08 00 00 00       	mov    $0x8,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <link>:
SYSCALL(link)
 31b:	b8 13 00 00 00       	mov    $0x13,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <mkdir>:
SYSCALL(mkdir)
 323:	b8 14 00 00 00       	mov    $0x14,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <chdir>:
SYSCALL(chdir)
 32b:	b8 09 00 00 00       	mov    $0x9,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <dup>:
SYSCALL(dup)
 333:	b8 0a 00 00 00       	mov    $0xa,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <getpid>:
SYSCALL(getpid)
 33b:	b8 0b 00 00 00       	mov    $0xb,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <sbrk>:
SYSCALL(sbrk)
 343:	b8 0c 00 00 00       	mov    $0xc,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <sleep>:
SYSCALL(sleep)
 34b:	b8 0d 00 00 00       	mov    $0xd,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <uptime>:
SYSCALL(uptime)
 353:	b8 0e 00 00 00       	mov    $0xe,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 35b:	55                   	push   %ebp
 35c:	89 e5                	mov    %esp,%ebp
 35e:	57                   	push   %edi
 35f:	56                   	push   %esi
 360:	53                   	push   %ebx
 361:	83 ec 3c             	sub    $0x3c,%esp
 364:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 366:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 36a:	74 14                	je     380 <printint+0x25>
 36c:	85 d2                	test   %edx,%edx
 36e:	79 10                	jns    380 <printint+0x25>
    neg = 1;
    x = -xx;
 370:	f7 da                	neg    %edx
    neg = 1;
 372:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 379:	bf 00 00 00 00       	mov    $0x0,%edi
 37e:	eb 0b                	jmp    38b <printint+0x30>
  neg = 0;
 380:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 387:	eb f0                	jmp    379 <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 389:	89 df                	mov    %ebx,%edi
 38b:	8d 5f 01             	lea    0x1(%edi),%ebx
 38e:	89 d0                	mov    %edx,%eax
 390:	ba 00 00 00 00       	mov    $0x0,%edx
 395:	f7 f1                	div    %ecx
 397:	0f b6 92 3c 07 00 00 	movzbl 0x73c(%edx),%edx
 39e:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 3a2:	89 c2                	mov    %eax,%edx
 3a4:	85 c0                	test   %eax,%eax
 3a6:	75 e1                	jne    389 <printint+0x2e>
  if(neg)
 3a8:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 3ac:	74 08                	je     3b6 <printint+0x5b>
    buf[i++] = '-';
 3ae:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3b3:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 3b6:	83 eb 01             	sub    $0x1,%ebx
 3b9:	78 22                	js     3dd <printint+0x82>
  write(fd, &c, 1);
 3bb:	8d 7d d7             	lea    -0x29(%ebp),%edi
 3be:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 3c3:	88 45 d7             	mov    %al,-0x29(%ebp)
 3c6:	83 ec 04             	sub    $0x4,%esp
 3c9:	6a 01                	push   $0x1
 3cb:	57                   	push   %edi
 3cc:	56                   	push   %esi
 3cd:	e8 09 ff ff ff       	call   2db <write>
  while(--i >= 0)
 3d2:	83 eb 01             	sub    $0x1,%ebx
 3d5:	83 c4 10             	add    $0x10,%esp
 3d8:	83 fb ff             	cmp    $0xffffffff,%ebx
 3db:	75 e1                	jne    3be <printint+0x63>
    putc(fd, buf[i]);
}
 3dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e0:	5b                   	pop    %ebx
 3e1:	5e                   	pop    %esi
 3e2:	5f                   	pop    %edi
 3e3:	5d                   	pop    %ebp
 3e4:	c3                   	ret    

000003e5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3e5:	55                   	push   %ebp
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	57                   	push   %edi
 3e9:	56                   	push   %esi
 3ea:	53                   	push   %ebx
 3eb:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ee:	8b 75 0c             	mov    0xc(%ebp),%esi
 3f1:	0f b6 1e             	movzbl (%esi),%ebx
 3f4:	84 db                	test   %bl,%bl
 3f6:	0f 84 b1 01 00 00    	je     5ad <printf+0x1c8>
 3fc:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 3ff:	8d 45 10             	lea    0x10(%ebp),%eax
 402:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 405:	bf 00 00 00 00       	mov    $0x0,%edi
 40a:	eb 2d                	jmp    439 <printf+0x54>
 40c:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 40f:	83 ec 04             	sub    $0x4,%esp
 412:	6a 01                	push   $0x1
 414:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 417:	50                   	push   %eax
 418:	ff 75 08             	pushl  0x8(%ebp)
 41b:	e8 bb fe ff ff       	call   2db <write>
 420:	83 c4 10             	add    $0x10,%esp
 423:	eb 05                	jmp    42a <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 425:	83 ff 25             	cmp    $0x25,%edi
 428:	74 22                	je     44c <printf+0x67>
 42a:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 42d:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 431:	84 db                	test   %bl,%bl
 433:	0f 84 74 01 00 00    	je     5ad <printf+0x1c8>
    c = fmt[i] & 0xff;
 439:	0f be d3             	movsbl %bl,%edx
 43c:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 43f:	85 ff                	test   %edi,%edi
 441:	75 e2                	jne    425 <printf+0x40>
      if(c == '%'){
 443:	83 f8 25             	cmp    $0x25,%eax
 446:	75 c4                	jne    40c <printf+0x27>
        state = '%';
 448:	89 c7                	mov    %eax,%edi
 44a:	eb de                	jmp    42a <printf+0x45>
      if(c == 'd'){
 44c:	83 f8 64             	cmp    $0x64,%eax
 44f:	74 59                	je     4aa <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 451:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 457:	83 fa 70             	cmp    $0x70,%edx
 45a:	74 7a                	je     4d6 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 45c:	83 f8 73             	cmp    $0x73,%eax
 45f:	0f 84 9d 00 00 00    	je     502 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 465:	83 f8 63             	cmp    $0x63,%eax
 468:	0f 84 f2 00 00 00    	je     560 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 46e:	83 f8 25             	cmp    $0x25,%eax
 471:	0f 84 15 01 00 00    	je     58c <printf+0x1a7>
 477:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 47b:	83 ec 04             	sub    $0x4,%esp
 47e:	6a 01                	push   $0x1
 480:	8d 45 e7             	lea    -0x19(%ebp),%eax
 483:	50                   	push   %eax
 484:	ff 75 08             	pushl  0x8(%ebp)
 487:	e8 4f fe ff ff       	call   2db <write>
 48c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 48f:	83 c4 0c             	add    $0xc,%esp
 492:	6a 01                	push   $0x1
 494:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 497:	50                   	push   %eax
 498:	ff 75 08             	pushl  0x8(%ebp)
 49b:	e8 3b fe ff ff       	call   2db <write>
 4a0:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a3:	bf 00 00 00 00       	mov    $0x0,%edi
 4a8:	eb 80                	jmp    42a <printf+0x45>
        printint(fd, *ap, 10, 1);
 4aa:	83 ec 0c             	sub    $0xc,%esp
 4ad:	6a 01                	push   $0x1
 4af:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4b4:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4b7:	8b 17                	mov    (%edi),%edx
 4b9:	8b 45 08             	mov    0x8(%ebp),%eax
 4bc:	e8 9a fe ff ff       	call   35b <printint>
        ap++;
 4c1:	89 f8                	mov    %edi,%eax
 4c3:	83 c0 04             	add    $0x4,%eax
 4c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4c9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4cc:	bf 00 00 00 00       	mov    $0x0,%edi
 4d1:	e9 54 ff ff ff       	jmp    42a <printf+0x45>
        printint(fd, *ap, 16, 0);
 4d6:	83 ec 0c             	sub    $0xc,%esp
 4d9:	6a 00                	push   $0x0
 4db:	b9 10 00 00 00       	mov    $0x10,%ecx
 4e0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4e3:	8b 17                	mov    (%edi),%edx
 4e5:	8b 45 08             	mov    0x8(%ebp),%eax
 4e8:	e8 6e fe ff ff       	call   35b <printint>
        ap++;
 4ed:	89 f8                	mov    %edi,%eax
 4ef:	83 c0 04             	add    $0x4,%eax
 4f2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4f5:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4f8:	bf 00 00 00 00       	mov    $0x0,%edi
 4fd:	e9 28 ff ff ff       	jmp    42a <printf+0x45>
        s = (char*)*ap;
 502:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 505:	8b 01                	mov    (%ecx),%eax
        ap++;
 507:	83 c1 04             	add    $0x4,%ecx
 50a:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 50d:	85 c0                	test   %eax,%eax
 50f:	74 13                	je     524 <printf+0x13f>
        s = (char*)*ap;
 511:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 513:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 516:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 51b:	84 c0                	test   %al,%al
 51d:	75 0f                	jne    52e <printf+0x149>
 51f:	e9 06 ff ff ff       	jmp    42a <printf+0x45>
          s = "(null)";
 524:	bb 34 07 00 00       	mov    $0x734,%ebx
        while(*s != 0){
 529:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 52e:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 531:	89 75 d0             	mov    %esi,-0x30(%ebp)
 534:	8b 75 08             	mov    0x8(%ebp),%esi
 537:	88 45 e3             	mov    %al,-0x1d(%ebp)
 53a:	83 ec 04             	sub    $0x4,%esp
 53d:	6a 01                	push   $0x1
 53f:	57                   	push   %edi
 540:	56                   	push   %esi
 541:	e8 95 fd ff ff       	call   2db <write>
          s++;
 546:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 549:	0f b6 03             	movzbl (%ebx),%eax
 54c:	83 c4 10             	add    $0x10,%esp
 54f:	84 c0                	test   %al,%al
 551:	75 e4                	jne    537 <printf+0x152>
 553:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 556:	bf 00 00 00 00       	mov    $0x0,%edi
 55b:	e9 ca fe ff ff       	jmp    42a <printf+0x45>
        putc(fd, *ap);
 560:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 563:	8b 07                	mov    (%edi),%eax
 565:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 568:	83 ec 04             	sub    $0x4,%esp
 56b:	6a 01                	push   $0x1
 56d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 570:	50                   	push   %eax
 571:	ff 75 08             	pushl  0x8(%ebp)
 574:	e8 62 fd ff ff       	call   2db <write>
        ap++;
 579:	83 c7 04             	add    $0x4,%edi
 57c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 57f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 582:	bf 00 00 00 00       	mov    $0x0,%edi
 587:	e9 9e fe ff ff       	jmp    42a <printf+0x45>
 58c:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 58f:	83 ec 04             	sub    $0x4,%esp
 592:	6a 01                	push   $0x1
 594:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 597:	50                   	push   %eax
 598:	ff 75 08             	pushl  0x8(%ebp)
 59b:	e8 3b fd ff ff       	call   2db <write>
 5a0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5a3:	bf 00 00 00 00       	mov    $0x0,%edi
 5a8:	e9 7d fe ff ff       	jmp    42a <printf+0x45>
    }
  }
}
 5ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b0:	5b                   	pop    %ebx
 5b1:	5e                   	pop    %esi
 5b2:	5f                   	pop    %edi
 5b3:	5d                   	pop    %ebp
 5b4:	c3                   	ret    

000005b5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b5:	55                   	push   %ebp
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	57                   	push   %edi
 5b9:	56                   	push   %esi
 5ba:	53                   	push   %ebx
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	a1 e0 09 00 00       	mov    0x9e0,%eax
 5c6:	eb 0c                	jmp    5d4 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c8:	8b 10                	mov    (%eax),%edx
 5ca:	39 c2                	cmp    %eax,%edx
 5cc:	77 04                	ja     5d2 <free+0x1d>
 5ce:	39 ca                	cmp    %ecx,%edx
 5d0:	77 10                	ja     5e2 <free+0x2d>
{
 5d2:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d4:	39 c8                	cmp    %ecx,%eax
 5d6:	73 f0                	jae    5c8 <free+0x13>
 5d8:	8b 10                	mov    (%eax),%edx
 5da:	39 ca                	cmp    %ecx,%edx
 5dc:	77 04                	ja     5e2 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5de:	39 c2                	cmp    %eax,%edx
 5e0:	77 f0                	ja     5d2 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5e2:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5e5:	8b 10                	mov    (%eax),%edx
 5e7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ea:	39 fa                	cmp    %edi,%edx
 5ec:	74 19                	je     607 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ee:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5f1:	8b 50 04             	mov    0x4(%eax),%edx
 5f4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f7:	39 f1                	cmp    %esi,%ecx
 5f9:	74 1b                	je     616 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5fb:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5fd:	a3 e0 09 00 00       	mov    %eax,0x9e0
}
 602:	5b                   	pop    %ebx
 603:	5e                   	pop    %esi
 604:	5f                   	pop    %edi
 605:	5d                   	pop    %ebp
 606:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 607:	03 72 04             	add    0x4(%edx),%esi
 60a:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 60d:	8b 10                	mov    (%eax),%edx
 60f:	8b 12                	mov    (%edx),%edx
 611:	89 53 f8             	mov    %edx,-0x8(%ebx)
 614:	eb db                	jmp    5f1 <free+0x3c>
    p->s.size += bp->s.size;
 616:	03 53 fc             	add    -0x4(%ebx),%edx
 619:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 61c:	8b 53 f8             	mov    -0x8(%ebx),%edx
 61f:	89 10                	mov    %edx,(%eax)
 621:	eb da                	jmp    5fd <free+0x48>

00000623 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 623:	55                   	push   %ebp
 624:	89 e5                	mov    %esp,%ebp
 626:	57                   	push   %edi
 627:	56                   	push   %esi
 628:	53                   	push   %ebx
 629:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	8d 58 07             	lea    0x7(%eax),%ebx
 632:	c1 eb 03             	shr    $0x3,%ebx
 635:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 638:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
 63e:	85 d2                	test   %edx,%edx
 640:	74 20                	je     662 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 642:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 644:	8b 48 04             	mov    0x4(%eax),%ecx
 647:	39 cb                	cmp    %ecx,%ebx
 649:	76 3c                	jbe    687 <malloc+0x64>
 64b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 651:	be 00 10 00 00       	mov    $0x1000,%esi
 656:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 659:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 660:	eb 70                	jmp    6d2 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 662:	c7 05 e0 09 00 00 e4 	movl   $0x9e4,0x9e0
 669:	09 00 00 
 66c:	c7 05 e4 09 00 00 e4 	movl   $0x9e4,0x9e4
 673:	09 00 00 
    base.s.size = 0;
 676:	c7 05 e8 09 00 00 00 	movl   $0x0,0x9e8
 67d:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 680:	ba e4 09 00 00       	mov    $0x9e4,%edx
 685:	eb bb                	jmp    642 <malloc+0x1f>
      if(p->s.size == nunits)
 687:	39 cb                	cmp    %ecx,%ebx
 689:	74 1c                	je     6a7 <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 68b:	29 d9                	sub    %ebx,%ecx
 68d:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 690:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 693:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 696:	89 15 e0 09 00 00    	mov    %edx,0x9e0
      return (void*)(p + 1);
 69c:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 69f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6a2:	5b                   	pop    %ebx
 6a3:	5e                   	pop    %esi
 6a4:	5f                   	pop    %edi
 6a5:	5d                   	pop    %ebp
 6a6:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6a7:	8b 08                	mov    (%eax),%ecx
 6a9:	89 0a                	mov    %ecx,(%edx)
 6ab:	eb e9                	jmp    696 <malloc+0x73>
  hp->s.size = nu;
 6ad:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	83 c0 08             	add    $0x8,%eax
 6b6:	50                   	push   %eax
 6b7:	e8 f9 fe ff ff       	call   5b5 <free>
  return freep;
 6bc:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
      if((p = morecore(nunits)) == 0)
 6c2:	83 c4 10             	add    $0x10,%esp
 6c5:	85 d2                	test   %edx,%edx
 6c7:	74 2b                	je     6f4 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c9:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6cb:	8b 48 04             	mov    0x4(%eax),%ecx
 6ce:	39 d9                	cmp    %ebx,%ecx
 6d0:	73 b5                	jae    687 <malloc+0x64>
 6d2:	89 c2                	mov    %eax,%edx
    if(p == freep)
 6d4:	39 05 e0 09 00 00    	cmp    %eax,0x9e0
 6da:	75 ed                	jne    6c9 <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 6dc:	83 ec 0c             	sub    $0xc,%esp
 6df:	57                   	push   %edi
 6e0:	e8 5e fc ff ff       	call   343 <sbrk>
  if(p == (char*)-1)
 6e5:	83 c4 10             	add    $0x10,%esp
 6e8:	83 f8 ff             	cmp    $0xffffffff,%eax
 6eb:	75 c0                	jne    6ad <malloc+0x8a>
        return 0;
 6ed:	b8 00 00 00 00       	mov    $0x0,%eax
 6f2:	eb ab                	jmp    69f <malloc+0x7c>
 6f4:	b8 00 00 00 00       	mov    $0x0,%eax
 6f9:	eb a4                	jmp    69f <malloc+0x7c>

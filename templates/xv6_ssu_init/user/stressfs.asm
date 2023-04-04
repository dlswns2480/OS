
user/_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

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
  11:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  17:	c7 45 de 73 74 72 65 	movl   $0x65727473,-0x22(%ebp)
  1e:	c7 45 e2 73 73 66 73 	movl   $0x73667373,-0x1e(%ebp)
  25:	66 c7 45 e6 30 00    	movw   $0x30,-0x1a(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  2b:	68 14 07 00 00       	push   $0x714
  30:	6a 01                	push   $0x1
  32:	e8 c4 03 00 00       	call   3fb <printf>
  memset(data, 'a', sizeof(data));
  37:	83 c4 0c             	add    $0xc,%esp
  3a:	68 00 02 00 00       	push   $0x200
  3f:	6a 61                	push   $0x61
  41:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  47:	50                   	push   %eax
  48:	e8 37 01 00 00       	call   184 <memset>
  4d:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  50:	bb 00 00 00 00       	mov    $0x0,%ebx
    if(fork() > 0)
  55:	e8 6f 02 00 00       	call   2c9 <fork>
  5a:	85 c0                	test   %eax,%eax
  5c:	7f 08                	jg     66 <main+0x66>
  for(i = 0; i < 4; i++)
  5e:	83 c3 01             	add    $0x1,%ebx
  61:	83 fb 04             	cmp    $0x4,%ebx
  64:	75 ef                	jne    55 <main+0x55>
      break;

  printf(1, "write %d\n", i);
  66:	83 ec 04             	sub    $0x4,%esp
  69:	53                   	push   %ebx
  6a:	68 27 07 00 00       	push   $0x727
  6f:	6a 01                	push   $0x1
  71:	e8 85 03 00 00       	call   3fb <printf>

  path[8] += i;
  76:	00 5d e6             	add    %bl,-0x1a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  79:	83 c4 08             	add    $0x8,%esp
  7c:	68 02 02 00 00       	push   $0x202
  81:	8d 45 de             	lea    -0x22(%ebp),%eax
  84:	50                   	push   %eax
  85:	e8 87 02 00 00       	call   311 <open>
  8a:	89 c6                	mov    %eax,%esi
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	bb 14 00 00 00       	mov    $0x14,%ebx
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  94:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  9a:	83 ec 04             	sub    $0x4,%esp
  9d:	68 00 02 00 00       	push   $0x200
  a2:	57                   	push   %edi
  a3:	56                   	push   %esi
  a4:	e8 48 02 00 00       	call   2f1 <write>
  for(i = 0; i < 20; i++)
  a9:	83 c4 10             	add    $0x10,%esp
  ac:	83 eb 01             	sub    $0x1,%ebx
  af:	75 e9                	jne    9a <main+0x9a>
  close(fd);
  b1:	83 ec 0c             	sub    $0xc,%esp
  b4:	56                   	push   %esi
  b5:	e8 3f 02 00 00       	call   2f9 <close>

  printf(1, "read\n");
  ba:	83 c4 08             	add    $0x8,%esp
  bd:	68 31 07 00 00       	push   $0x731
  c2:	6a 01                	push   $0x1
  c4:	e8 32 03 00 00       	call   3fb <printf>

  fd = open(path, O_RDONLY);
  c9:	83 c4 08             	add    $0x8,%esp
  cc:	6a 00                	push   $0x0
  ce:	8d 45 de             	lea    -0x22(%ebp),%eax
  d1:	50                   	push   %eax
  d2:	e8 3a 02 00 00       	call   311 <open>
  d7:	89 c6                	mov    %eax,%esi
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	bb 14 00 00 00       	mov    $0x14,%ebx
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e1:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  e7:	83 ec 04             	sub    $0x4,%esp
  ea:	68 00 02 00 00       	push   $0x200
  ef:	57                   	push   %edi
  f0:	56                   	push   %esi
  f1:	e8 f3 01 00 00       	call   2e9 <read>
  for (i = 0; i < 20; i++)
  f6:	83 c4 10             	add    $0x10,%esp
  f9:	83 eb 01             	sub    $0x1,%ebx
  fc:	75 e9                	jne    e7 <main+0xe7>
  close(fd);
  fe:	83 ec 0c             	sub    $0xc,%esp
 101:	56                   	push   %esi
 102:	e8 f2 01 00 00       	call   2f9 <close>

  wait();
 107:	e8 cd 01 00 00       	call   2d9 <wait>

  exit();
 10c:	e8 c0 01 00 00       	call   2d1 <exit>

00000111 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 111:	55                   	push   %ebp
 112:	89 e5                	mov    %esp,%ebp
 114:	53                   	push   %ebx
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11b:	89 c2                	mov    %eax,%edx
 11d:	83 c1 01             	add    $0x1,%ecx
 120:	83 c2 01             	add    $0x1,%edx
 123:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 127:	88 5a ff             	mov    %bl,-0x1(%edx)
 12a:	84 db                	test   %bl,%bl
 12c:	75 ef                	jne    11d <strcpy+0xc>
    ;
  return os;
}
 12e:	5b                   	pop    %ebx
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    

00000131 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
 134:	8b 4d 08             	mov    0x8(%ebp),%ecx
 137:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 13a:	0f b6 01             	movzbl (%ecx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	74 15                	je     156 <strcmp+0x25>
 141:	3a 02                	cmp    (%edx),%al
 143:	75 11                	jne    156 <strcmp+0x25>
    p++, q++;
 145:	83 c1 01             	add    $0x1,%ecx
 148:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 14b:	0f b6 01             	movzbl (%ecx),%eax
 14e:	84 c0                	test   %al,%al
 150:	74 04                	je     156 <strcmp+0x25>
 152:	3a 02                	cmp    (%edx),%al
 154:	74 ef                	je     145 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 156:	0f b6 c0             	movzbl %al,%eax
 159:	0f b6 12             	movzbl (%edx),%edx
 15c:	29 d0                	sub    %edx,%eax
}
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 166:	80 39 00             	cmpb   $0x0,(%ecx)
 169:	74 12                	je     17d <strlen+0x1d>
 16b:	ba 00 00 00 00       	mov    $0x0,%edx
 170:	83 c2 01             	add    $0x1,%edx
 173:	89 d0                	mov    %edx,%eax
 175:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 179:	75 f5                	jne    170 <strlen+0x10>
    ;
  return n;
}
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 17d:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 182:	eb f7                	jmp    17b <strlen+0x1b>

00000184 <memset>:

void*
memset(void *dst, int c, uint n)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18b:	89 d7                	mov    %edx,%edi
 18d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 190:	8b 45 0c             	mov    0xc(%ebp),%eax
 193:	fc                   	cld    
 194:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 196:	89 d0                	mov    %edx,%eax
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    

0000019b <strchr>:

char*
strchr(const char *s, char c)
{
 19b:	55                   	push   %ebp
 19c:	89 e5                	mov    %esp,%ebp
 19e:	53                   	push   %ebx
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1a5:	0f b6 10             	movzbl (%eax),%edx
 1a8:	84 d2                	test   %dl,%dl
 1aa:	74 1e                	je     1ca <strchr+0x2f>
 1ac:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 1ae:	38 d3                	cmp    %dl,%bl
 1b0:	74 15                	je     1c7 <strchr+0x2c>
  for(; *s; s++)
 1b2:	83 c0 01             	add    $0x1,%eax
 1b5:	0f b6 10             	movzbl (%eax),%edx
 1b8:	84 d2                	test   %dl,%dl
 1ba:	74 06                	je     1c2 <strchr+0x27>
    if(*s == c)
 1bc:	38 ca                	cmp    %cl,%dl
 1be:	75 f2                	jne    1b2 <strchr+0x17>
 1c0:	eb 05                	jmp    1c7 <strchr+0x2c>
      return (char*)s;
  return 0;
 1c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1c7:	5b                   	pop    %ebx
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    
  return 0;
 1ca:	b8 00 00 00 00       	mov    $0x0,%eax
 1cf:	eb f6                	jmp    1c7 <strchr+0x2c>

000001d1 <gets>:

char*
gets(char *buf, int max)
{
 1d1:	55                   	push   %ebp
 1d2:	89 e5                	mov    %esp,%ebp
 1d4:	57                   	push   %edi
 1d5:	56                   	push   %esi
 1d6:	53                   	push   %ebx
 1d7:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1da:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 1df:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1e2:	8d 5e 01             	lea    0x1(%esi),%ebx
 1e5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1e8:	7d 2b                	jge    215 <gets+0x44>
    cc = read(0, &c, 1);
 1ea:	83 ec 04             	sub    $0x4,%esp
 1ed:	6a 01                	push   $0x1
 1ef:	57                   	push   %edi
 1f0:	6a 00                	push   $0x0
 1f2:	e8 f2 00 00 00       	call   2e9 <read>
    if(cc < 1)
 1f7:	83 c4 10             	add    $0x10,%esp
 1fa:	85 c0                	test   %eax,%eax
 1fc:	7e 17                	jle    215 <gets+0x44>
      break;
    buf[i++] = c;
 1fe:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 202:	8b 55 08             	mov    0x8(%ebp),%edx
 205:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 209:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 20b:	3c 0a                	cmp    $0xa,%al
 20d:	74 04                	je     213 <gets+0x42>
 20f:	3c 0d                	cmp    $0xd,%al
 211:	75 cf                	jne    1e2 <gets+0x11>
  for(i=0; i+1 < max; ){
 213:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 21c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 21f:	5b                   	pop    %ebx
 220:	5e                   	pop    %esi
 221:	5f                   	pop    %edi
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    

00000224 <stat>:

int
stat(const char *n, struct stat *st)
{
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	56                   	push   %esi
 228:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	6a 00                	push   $0x0
 22e:	ff 75 08             	pushl  0x8(%ebp)
 231:	e8 db 00 00 00       	call   311 <open>
  if(fd < 0)
 236:	83 c4 10             	add    $0x10,%esp
 239:	85 c0                	test   %eax,%eax
 23b:	78 24                	js     261 <stat+0x3d>
 23d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 23f:	83 ec 08             	sub    $0x8,%esp
 242:	ff 75 0c             	pushl  0xc(%ebp)
 245:	50                   	push   %eax
 246:	e8 de 00 00 00       	call   329 <fstat>
 24b:	89 c6                	mov    %eax,%esi
  close(fd);
 24d:	89 1c 24             	mov    %ebx,(%esp)
 250:	e8 a4 00 00 00       	call   2f9 <close>
  return r;
 255:	83 c4 10             	add    $0x10,%esp
}
 258:	89 f0                	mov    %esi,%eax
 25a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 25d:	5b                   	pop    %ebx
 25e:	5e                   	pop    %esi
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
    return -1;
 261:	be ff ff ff ff       	mov    $0xffffffff,%esi
 266:	eb f0                	jmp    258 <stat+0x34>

00000268 <atoi>:

int
atoi(const char *s)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	53                   	push   %ebx
 26c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26f:	0f b6 11             	movzbl (%ecx),%edx
 272:	8d 42 d0             	lea    -0x30(%edx),%eax
 275:	3c 09                	cmp    $0x9,%al
 277:	77 20                	ja     299 <atoi+0x31>
  n = 0;
 279:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 27e:	83 c1 01             	add    $0x1,%ecx
 281:	8d 04 80             	lea    (%eax,%eax,4),%eax
 284:	0f be d2             	movsbl %dl,%edx
 287:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28b:	0f b6 11             	movzbl (%ecx),%edx
 28e:	8d 5a d0             	lea    -0x30(%edx),%ebx
 291:	80 fb 09             	cmp    $0x9,%bl
 294:	76 e8                	jbe    27e <atoi+0x16>
  return n;
}
 296:	5b                   	pop    %ebx
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    
  n = 0;
 299:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 29e:	eb f6                	jmp    296 <atoi+0x2e>

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	8b 75 0c             	mov    0xc(%ebp),%esi
 2ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 13                	jle    2c5 <memmove+0x25>
 2b2:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 2b7:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2be:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2c1:	39 d3                	cmp    %edx,%ebx
 2c3:	75 f2                	jne    2b7 <memmove+0x17>
  return vdst;
}
 2c5:	5b                   	pop    %ebx
 2c6:	5e                   	pop    %esi
 2c7:	5d                   	pop    %ebp
 2c8:	c3                   	ret    

000002c9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c9:	b8 01 00 00 00       	mov    $0x1,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <exit>:
SYSCALL(exit)
 2d1:	b8 02 00 00 00       	mov    $0x2,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <wait>:
SYSCALL(wait)
 2d9:	b8 03 00 00 00       	mov    $0x3,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <pipe>:
SYSCALL(pipe)
 2e1:	b8 04 00 00 00       	mov    $0x4,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <read>:
SYSCALL(read)
 2e9:	b8 05 00 00 00       	mov    $0x5,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <write>:
SYSCALL(write)
 2f1:	b8 10 00 00 00       	mov    $0x10,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <close>:
SYSCALL(close)
 2f9:	b8 15 00 00 00       	mov    $0x15,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <kill>:
SYSCALL(kill)
 301:	b8 06 00 00 00       	mov    $0x6,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <exec>:
SYSCALL(exec)
 309:	b8 07 00 00 00       	mov    $0x7,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <open>:
SYSCALL(open)
 311:	b8 0f 00 00 00       	mov    $0xf,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <mknod>:
SYSCALL(mknod)
 319:	b8 11 00 00 00       	mov    $0x11,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <unlink>:
SYSCALL(unlink)
 321:	b8 12 00 00 00       	mov    $0x12,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <fstat>:
SYSCALL(fstat)
 329:	b8 08 00 00 00       	mov    $0x8,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <link>:
SYSCALL(link)
 331:	b8 13 00 00 00       	mov    $0x13,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <mkdir>:
SYSCALL(mkdir)
 339:	b8 14 00 00 00       	mov    $0x14,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <chdir>:
SYSCALL(chdir)
 341:	b8 09 00 00 00       	mov    $0x9,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <dup>:
SYSCALL(dup)
 349:	b8 0a 00 00 00       	mov    $0xa,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <getpid>:
SYSCALL(getpid)
 351:	b8 0b 00 00 00       	mov    $0xb,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <sbrk>:
SYSCALL(sbrk)
 359:	b8 0c 00 00 00       	mov    $0xc,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <sleep>:
SYSCALL(sleep)
 361:	b8 0d 00 00 00       	mov    $0xd,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <uptime>:
SYSCALL(uptime)
 369:	b8 0e 00 00 00       	mov    $0xe,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 371:	55                   	push   %ebp
 372:	89 e5                	mov    %esp,%ebp
 374:	57                   	push   %edi
 375:	56                   	push   %esi
 376:	53                   	push   %ebx
 377:	83 ec 3c             	sub    $0x3c,%esp
 37a:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 380:	74 14                	je     396 <printint+0x25>
 382:	85 d2                	test   %edx,%edx
 384:	79 10                	jns    396 <printint+0x25>
    neg = 1;
    x = -xx;
 386:	f7 da                	neg    %edx
    neg = 1;
 388:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 38f:	bf 00 00 00 00       	mov    $0x0,%edi
 394:	eb 0b                	jmp    3a1 <printint+0x30>
  neg = 0;
 396:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 39d:	eb f0                	jmp    38f <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 39f:	89 df                	mov    %ebx,%edi
 3a1:	8d 5f 01             	lea    0x1(%edi),%ebx
 3a4:	89 d0                	mov    %edx,%eax
 3a6:	ba 00 00 00 00       	mov    $0x0,%edx
 3ab:	f7 f1                	div    %ecx
 3ad:	0f b6 92 40 07 00 00 	movzbl 0x740(%edx),%edx
 3b4:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 3b8:	89 c2                	mov    %eax,%edx
 3ba:	85 c0                	test   %eax,%eax
 3bc:	75 e1                	jne    39f <printint+0x2e>
  if(neg)
 3be:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 3c2:	74 08                	je     3cc <printint+0x5b>
    buf[i++] = '-';
 3c4:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3c9:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 3cc:	83 eb 01             	sub    $0x1,%ebx
 3cf:	78 22                	js     3f3 <printint+0x82>
  write(fd, &c, 1);
 3d1:	8d 7d d7             	lea    -0x29(%ebp),%edi
 3d4:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 3d9:	88 45 d7             	mov    %al,-0x29(%ebp)
 3dc:	83 ec 04             	sub    $0x4,%esp
 3df:	6a 01                	push   $0x1
 3e1:	57                   	push   %edi
 3e2:	56                   	push   %esi
 3e3:	e8 09 ff ff ff       	call   2f1 <write>
  while(--i >= 0)
 3e8:	83 eb 01             	sub    $0x1,%ebx
 3eb:	83 c4 10             	add    $0x10,%esp
 3ee:	83 fb ff             	cmp    $0xffffffff,%ebx
 3f1:	75 e1                	jne    3d4 <printint+0x63>
    putc(fd, buf[i]);
}
 3f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f6:	5b                   	pop    %ebx
 3f7:	5e                   	pop    %esi
 3f8:	5f                   	pop    %edi
 3f9:	5d                   	pop    %ebp
 3fa:	c3                   	ret    

000003fb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3fb:	55                   	push   %ebp
 3fc:	89 e5                	mov    %esp,%ebp
 3fe:	57                   	push   %edi
 3ff:	56                   	push   %esi
 400:	53                   	push   %ebx
 401:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 404:	8b 75 0c             	mov    0xc(%ebp),%esi
 407:	0f b6 1e             	movzbl (%esi),%ebx
 40a:	84 db                	test   %bl,%bl
 40c:	0f 84 b1 01 00 00    	je     5c3 <printf+0x1c8>
 412:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 415:	8d 45 10             	lea    0x10(%ebp),%eax
 418:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 41b:	bf 00 00 00 00       	mov    $0x0,%edi
 420:	eb 2d                	jmp    44f <printf+0x54>
 422:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 425:	83 ec 04             	sub    $0x4,%esp
 428:	6a 01                	push   $0x1
 42a:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 42d:	50                   	push   %eax
 42e:	ff 75 08             	pushl  0x8(%ebp)
 431:	e8 bb fe ff ff       	call   2f1 <write>
 436:	83 c4 10             	add    $0x10,%esp
 439:	eb 05                	jmp    440 <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 43b:	83 ff 25             	cmp    $0x25,%edi
 43e:	74 22                	je     462 <printf+0x67>
 440:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 443:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 447:	84 db                	test   %bl,%bl
 449:	0f 84 74 01 00 00    	je     5c3 <printf+0x1c8>
    c = fmt[i] & 0xff;
 44f:	0f be d3             	movsbl %bl,%edx
 452:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 455:	85 ff                	test   %edi,%edi
 457:	75 e2                	jne    43b <printf+0x40>
      if(c == '%'){
 459:	83 f8 25             	cmp    $0x25,%eax
 45c:	75 c4                	jne    422 <printf+0x27>
        state = '%';
 45e:	89 c7                	mov    %eax,%edi
 460:	eb de                	jmp    440 <printf+0x45>
      if(c == 'd'){
 462:	83 f8 64             	cmp    $0x64,%eax
 465:	74 59                	je     4c0 <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 467:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 46d:	83 fa 70             	cmp    $0x70,%edx
 470:	74 7a                	je     4ec <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 472:	83 f8 73             	cmp    $0x73,%eax
 475:	0f 84 9d 00 00 00    	je     518 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 47b:	83 f8 63             	cmp    $0x63,%eax
 47e:	0f 84 f2 00 00 00    	je     576 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 484:	83 f8 25             	cmp    $0x25,%eax
 487:	0f 84 15 01 00 00    	je     5a2 <printf+0x1a7>
 48d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 491:	83 ec 04             	sub    $0x4,%esp
 494:	6a 01                	push   $0x1
 496:	8d 45 e7             	lea    -0x19(%ebp),%eax
 499:	50                   	push   %eax
 49a:	ff 75 08             	pushl  0x8(%ebp)
 49d:	e8 4f fe ff ff       	call   2f1 <write>
 4a2:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4a5:	83 c4 0c             	add    $0xc,%esp
 4a8:	6a 01                	push   $0x1
 4aa:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4ad:	50                   	push   %eax
 4ae:	ff 75 08             	pushl  0x8(%ebp)
 4b1:	e8 3b fe ff ff       	call   2f1 <write>
 4b6:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4b9:	bf 00 00 00 00       	mov    $0x0,%edi
 4be:	eb 80                	jmp    440 <printf+0x45>
        printint(fd, *ap, 10, 1);
 4c0:	83 ec 0c             	sub    $0xc,%esp
 4c3:	6a 01                	push   $0x1
 4c5:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4ca:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4cd:	8b 17                	mov    (%edi),%edx
 4cf:	8b 45 08             	mov    0x8(%ebp),%eax
 4d2:	e8 9a fe ff ff       	call   371 <printint>
        ap++;
 4d7:	89 f8                	mov    %edi,%eax
 4d9:	83 c0 04             	add    $0x4,%eax
 4dc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4df:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e2:	bf 00 00 00 00       	mov    $0x0,%edi
 4e7:	e9 54 ff ff ff       	jmp    440 <printf+0x45>
        printint(fd, *ap, 16, 0);
 4ec:	83 ec 0c             	sub    $0xc,%esp
 4ef:	6a 00                	push   $0x0
 4f1:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f6:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f9:	8b 17                	mov    (%edi),%edx
 4fb:	8b 45 08             	mov    0x8(%ebp),%eax
 4fe:	e8 6e fe ff ff       	call   371 <printint>
        ap++;
 503:	89 f8                	mov    %edi,%eax
 505:	83 c0 04             	add    $0x4,%eax
 508:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 50b:	83 c4 10             	add    $0x10,%esp
      state = 0;
 50e:	bf 00 00 00 00       	mov    $0x0,%edi
 513:	e9 28 ff ff ff       	jmp    440 <printf+0x45>
        s = (char*)*ap;
 518:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 51b:	8b 01                	mov    (%ecx),%eax
        ap++;
 51d:	83 c1 04             	add    $0x4,%ecx
 520:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 523:	85 c0                	test   %eax,%eax
 525:	74 13                	je     53a <printf+0x13f>
        s = (char*)*ap;
 527:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 529:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 52c:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 531:	84 c0                	test   %al,%al
 533:	75 0f                	jne    544 <printf+0x149>
 535:	e9 06 ff ff ff       	jmp    440 <printf+0x45>
          s = "(null)";
 53a:	bb 37 07 00 00       	mov    $0x737,%ebx
        while(*s != 0){
 53f:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 544:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 547:	89 75 d0             	mov    %esi,-0x30(%ebp)
 54a:	8b 75 08             	mov    0x8(%ebp),%esi
 54d:	88 45 e3             	mov    %al,-0x1d(%ebp)
 550:	83 ec 04             	sub    $0x4,%esp
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	56                   	push   %esi
 557:	e8 95 fd ff ff       	call   2f1 <write>
          s++;
 55c:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 55f:	0f b6 03             	movzbl (%ebx),%eax
 562:	83 c4 10             	add    $0x10,%esp
 565:	84 c0                	test   %al,%al
 567:	75 e4                	jne    54d <printf+0x152>
 569:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 56c:	bf 00 00 00 00       	mov    $0x0,%edi
 571:	e9 ca fe ff ff       	jmp    440 <printf+0x45>
        putc(fd, *ap);
 576:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 579:	8b 07                	mov    (%edi),%eax
 57b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 57e:	83 ec 04             	sub    $0x4,%esp
 581:	6a 01                	push   $0x1
 583:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 586:	50                   	push   %eax
 587:	ff 75 08             	pushl  0x8(%ebp)
 58a:	e8 62 fd ff ff       	call   2f1 <write>
        ap++;
 58f:	83 c7 04             	add    $0x4,%edi
 592:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 595:	83 c4 10             	add    $0x10,%esp
      state = 0;
 598:	bf 00 00 00 00       	mov    $0x0,%edi
 59d:	e9 9e fe ff ff       	jmp    440 <printf+0x45>
 5a2:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 5a5:	83 ec 04             	sub    $0x4,%esp
 5a8:	6a 01                	push   $0x1
 5aa:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5ad:	50                   	push   %eax
 5ae:	ff 75 08             	pushl  0x8(%ebp)
 5b1:	e8 3b fd ff ff       	call   2f1 <write>
 5b6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b9:	bf 00 00 00 00       	mov    $0x0,%edi
 5be:	e9 7d fe ff ff       	jmp    440 <printf+0x45>
    }
  }
}
 5c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    

000005cb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5cb:	55                   	push   %ebp
 5cc:	89 e5                	mov    %esp,%ebp
 5ce:	57                   	push   %edi
 5cf:	56                   	push   %esi
 5d0:	53                   	push   %ebx
 5d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d7:	a1 b4 09 00 00       	mov    0x9b4,%eax
 5dc:	eb 0c                	jmp    5ea <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5de:	8b 10                	mov    (%eax),%edx
 5e0:	39 c2                	cmp    %eax,%edx
 5e2:	77 04                	ja     5e8 <free+0x1d>
 5e4:	39 ca                	cmp    %ecx,%edx
 5e6:	77 10                	ja     5f8 <free+0x2d>
{
 5e8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ea:	39 c8                	cmp    %ecx,%eax
 5ec:	73 f0                	jae    5de <free+0x13>
 5ee:	8b 10                	mov    (%eax),%edx
 5f0:	39 ca                	cmp    %ecx,%edx
 5f2:	77 04                	ja     5f8 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	39 c2                	cmp    %eax,%edx
 5f6:	77 f0                	ja     5e8 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5fb:	8b 10                	mov    (%eax),%edx
 5fd:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 600:	39 fa                	cmp    %edi,%edx
 602:	74 19                	je     61d <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 604:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 607:	8b 50 04             	mov    0x4(%eax),%edx
 60a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 60d:	39 f1                	cmp    %esi,%ecx
 60f:	74 1b                	je     62c <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 611:	89 08                	mov    %ecx,(%eax)
  freep = p;
 613:	a3 b4 09 00 00       	mov    %eax,0x9b4
}
 618:	5b                   	pop    %ebx
 619:	5e                   	pop    %esi
 61a:	5f                   	pop    %edi
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 61d:	03 72 04             	add    0x4(%edx),%esi
 620:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 623:	8b 10                	mov    (%eax),%edx
 625:	8b 12                	mov    (%edx),%edx
 627:	89 53 f8             	mov    %edx,-0x8(%ebx)
 62a:	eb db                	jmp    607 <free+0x3c>
    p->s.size += bp->s.size;
 62c:	03 53 fc             	add    -0x4(%ebx),%edx
 62f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 632:	8b 53 f8             	mov    -0x8(%ebx),%edx
 635:	89 10                	mov    %edx,(%eax)
 637:	eb da                	jmp    613 <free+0x48>

00000639 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 639:	55                   	push   %ebp
 63a:	89 e5                	mov    %esp,%ebp
 63c:	57                   	push   %edi
 63d:	56                   	push   %esi
 63e:	53                   	push   %ebx
 63f:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 642:	8b 45 08             	mov    0x8(%ebp),%eax
 645:	8d 58 07             	lea    0x7(%eax),%ebx
 648:	c1 eb 03             	shr    $0x3,%ebx
 64b:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 64e:	8b 15 b4 09 00 00    	mov    0x9b4,%edx
 654:	85 d2                	test   %edx,%edx
 656:	74 20                	je     678 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 658:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 65a:	8b 48 04             	mov    0x4(%eax),%ecx
 65d:	39 cb                	cmp    %ecx,%ebx
 65f:	76 3c                	jbe    69d <malloc+0x64>
 661:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 667:	be 00 10 00 00       	mov    $0x1000,%esi
 66c:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 66f:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 676:	eb 70                	jmp    6e8 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 678:	c7 05 b4 09 00 00 b8 	movl   $0x9b8,0x9b4
 67f:	09 00 00 
 682:	c7 05 b8 09 00 00 b8 	movl   $0x9b8,0x9b8
 689:	09 00 00 
    base.s.size = 0;
 68c:	c7 05 bc 09 00 00 00 	movl   $0x0,0x9bc
 693:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 696:	ba b8 09 00 00       	mov    $0x9b8,%edx
 69b:	eb bb                	jmp    658 <malloc+0x1f>
      if(p->s.size == nunits)
 69d:	39 cb                	cmp    %ecx,%ebx
 69f:	74 1c                	je     6bd <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6a1:	29 d9                	sub    %ebx,%ecx
 6a3:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6a6:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6a9:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6ac:	89 15 b4 09 00 00    	mov    %edx,0x9b4
      return (void*)(p + 1);
 6b2:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b8:	5b                   	pop    %ebx
 6b9:	5e                   	pop    %esi
 6ba:	5f                   	pop    %edi
 6bb:	5d                   	pop    %ebp
 6bc:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6bd:	8b 08                	mov    (%eax),%ecx
 6bf:	89 0a                	mov    %ecx,(%edx)
 6c1:	eb e9                	jmp    6ac <malloc+0x73>
  hp->s.size = nu;
 6c3:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6c6:	83 ec 0c             	sub    $0xc,%esp
 6c9:	83 c0 08             	add    $0x8,%eax
 6cc:	50                   	push   %eax
 6cd:	e8 f9 fe ff ff       	call   5cb <free>
  return freep;
 6d2:	8b 15 b4 09 00 00    	mov    0x9b4,%edx
      if((p = morecore(nunits)) == 0)
 6d8:	83 c4 10             	add    $0x10,%esp
 6db:	85 d2                	test   %edx,%edx
 6dd:	74 2b                	je     70a <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6df:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6e1:	8b 48 04             	mov    0x4(%eax),%ecx
 6e4:	39 d9                	cmp    %ebx,%ecx
 6e6:	73 b5                	jae    69d <malloc+0x64>
 6e8:	89 c2                	mov    %eax,%edx
    if(p == freep)
 6ea:	39 05 b4 09 00 00    	cmp    %eax,0x9b4
 6f0:	75 ed                	jne    6df <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 6f2:	83 ec 0c             	sub    $0xc,%esp
 6f5:	57                   	push   %edi
 6f6:	e8 5e fc ff ff       	call   359 <sbrk>
  if(p == (char*)-1)
 6fb:	83 c4 10             	add    $0x10,%esp
 6fe:	83 f8 ff             	cmp    $0xffffffff,%eax
 701:	75 c0                	jne    6c3 <malloc+0x8a>
        return 0;
 703:	b8 00 00 00 00       	mov    $0x0,%eax
 708:	eb ab                	jmp    6b5 <malloc+0x7c>
 70a:	b8 00 00 00 00       	mov    $0x0,%eax
 70f:	eb a4                	jmp    6b5 <malloc+0x7c>

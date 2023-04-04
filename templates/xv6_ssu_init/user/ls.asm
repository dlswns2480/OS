
user/_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   8:	83 ec 0c             	sub    $0xc,%esp
   b:	53                   	push   %ebx
   c:	e8 18 03 00 00       	call   329 <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	01 d8                	add    %ebx,%eax
  16:	72 11                	jb     29 <fmtname+0x29>
  18:	80 38 2f             	cmpb   $0x2f,(%eax)
  1b:	74 0c                	je     29 <fmtname+0x29>
  1d:	83 e8 01             	sub    $0x1,%eax
  20:	39 c3                	cmp    %eax,%ebx
  22:	77 05                	ja     29 <fmtname+0x29>
  24:	80 38 2f             	cmpb   $0x2f,(%eax)
  27:	75 f4                	jne    1d <fmtname+0x1d>
    ;
  p++;
  29:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2c:	83 ec 0c             	sub    $0xc,%esp
  2f:	53                   	push   %ebx
  30:	e8 f4 02 00 00       	call   329 <strlen>
  35:	83 c4 10             	add    $0x10,%esp
  38:	83 f8 0d             	cmp    $0xd,%eax
  3b:	76 09                	jbe    46 <fmtname+0x46>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  3d:	89 d8                	mov    %ebx,%eax
  3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  42:	5b                   	pop    %ebx
  43:	5e                   	pop    %esi
  44:	5d                   	pop    %ebp
  45:	c3                   	ret    
  memmove(buf, p, strlen(p));
  46:	83 ec 0c             	sub    $0xc,%esp
  49:	53                   	push   %ebx
  4a:	e8 da 02 00 00       	call   329 <strlen>
  4f:	83 c4 0c             	add    $0xc,%esp
  52:	50                   	push   %eax
  53:	53                   	push   %ebx
  54:	68 fc 0b 00 00       	push   $0xbfc
  59:	e8 0b 04 00 00       	call   469 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  5e:	89 1c 24             	mov    %ebx,(%esp)
  61:	e8 c3 02 00 00       	call   329 <strlen>
  66:	89 c6                	mov    %eax,%esi
  68:	89 1c 24             	mov    %ebx,(%esp)
  6b:	e8 b9 02 00 00       	call   329 <strlen>
  70:	83 c4 0c             	add    $0xc,%esp
  73:	ba 0e 00 00 00       	mov    $0xe,%edx
  78:	29 f2                	sub    %esi,%edx
  7a:	52                   	push   %edx
  7b:	6a 20                	push   $0x20
  7d:	05 fc 0b 00 00       	add    $0xbfc,%eax
  82:	50                   	push   %eax
  83:	e8 c5 02 00 00       	call   34d <memset>
  return buf;
  88:	83 c4 10             	add    $0x10,%esp
  8b:	bb fc 0b 00 00       	mov    $0xbfc,%ebx
  90:	eb ab                	jmp    3d <fmtname+0x3d>

00000092 <ls>:

void
ls(char *path)
{
  92:	55                   	push   %ebp
  93:	89 e5                	mov    %esp,%ebp
  95:	57                   	push   %edi
  96:	56                   	push   %esi
  97:	53                   	push   %ebx
  98:	81 ec 54 02 00 00    	sub    $0x254,%esp
  9e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  a1:	6a 00                	push   $0x0
  a3:	53                   	push   %ebx
  a4:	e8 31 04 00 00       	call   4da <open>
  a9:	83 c4 10             	add    $0x10,%esp
  ac:	85 c0                	test   %eax,%eax
  ae:	78 7b                	js     12b <ls+0x99>
  b0:	89 c6                	mov    %eax,%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b2:	83 ec 08             	sub    $0x8,%esp
  b5:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
  bb:	50                   	push   %eax
  bc:	56                   	push   %esi
  bd:	e8 30 04 00 00       	call   4f2 <fstat>
  c2:	83 c4 10             	add    $0x10,%esp
  c5:	85 c0                	test   %eax,%eax
  c7:	78 77                	js     140 <ls+0xae>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c9:	0f b7 85 c4 fd ff ff 	movzwl -0x23c(%ebp),%eax
  d0:	66 83 f8 01          	cmp    $0x1,%ax
  d4:	0f 84 83 00 00 00    	je     15d <ls+0xcb>
  da:	66 83 f8 02          	cmp    $0x2,%ax
  de:	75 37                	jne    117 <ls+0x85>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  e0:	8b bd d4 fd ff ff    	mov    -0x22c(%ebp),%edi
  e6:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
  ec:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
  f2:	83 ec 0c             	sub    $0xc,%esp
  f5:	53                   	push   %ebx
  f6:	e8 05 ff ff ff       	call   0 <fmtname>
  fb:	83 c4 08             	add    $0x8,%esp
  fe:	57                   	push   %edi
  ff:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 105:	6a 02                	push   $0x2
 107:	50                   	push   %eax
 108:	68 04 09 00 00       	push   $0x904
 10d:	6a 01                	push   $0x1
 10f:	e8 b0 04 00 00       	call   5c4 <printf>
    break;
 114:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	56                   	push   %esi
 11b:	e8 a2 03 00 00       	call   4c2 <close>
 120:	83 c4 10             	add    $0x10,%esp
}
 123:	8d 65 f4             	lea    -0xc(%ebp),%esp
 126:	5b                   	pop    %ebx
 127:	5e                   	pop    %esi
 128:	5f                   	pop    %edi
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    
    printf(2, "ls: cannot open %s\n", path);
 12b:	83 ec 04             	sub    $0x4,%esp
 12e:	53                   	push   %ebx
 12f:	68 dc 08 00 00       	push   $0x8dc
 134:	6a 02                	push   $0x2
 136:	e8 89 04 00 00       	call   5c4 <printf>
    return;
 13b:	83 c4 10             	add    $0x10,%esp
 13e:	eb e3                	jmp    123 <ls+0x91>
    printf(2, "ls: cannot stat %s\n", path);
 140:	83 ec 04             	sub    $0x4,%esp
 143:	53                   	push   %ebx
 144:	68 f0 08 00 00       	push   $0x8f0
 149:	6a 02                	push   $0x2
 14b:	e8 74 04 00 00       	call   5c4 <printf>
    close(fd);
 150:	89 34 24             	mov    %esi,(%esp)
 153:	e8 6a 03 00 00       	call   4c2 <close>
    return;
 158:	83 c4 10             	add    $0x10,%esp
 15b:	eb c6                	jmp    123 <ls+0x91>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 15d:	83 ec 0c             	sub    $0xc,%esp
 160:	53                   	push   %ebx
 161:	e8 c3 01 00 00       	call   329 <strlen>
 166:	83 c0 10             	add    $0x10,%eax
 169:	83 c4 10             	add    $0x10,%esp
 16c:	3d 00 02 00 00       	cmp    $0x200,%eax
 171:	76 14                	jbe    187 <ls+0xf5>
      printf(1, "ls: path too long\n");
 173:	83 ec 08             	sub    $0x8,%esp
 176:	68 11 09 00 00       	push   $0x911
 17b:	6a 01                	push   $0x1
 17d:	e8 42 04 00 00       	call   5c4 <printf>
      break;
 182:	83 c4 10             	add    $0x10,%esp
 185:	eb 90                	jmp    117 <ls+0x85>
    strcpy(buf, path);
 187:	83 ec 08             	sub    $0x8,%esp
 18a:	53                   	push   %ebx
 18b:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 191:	57                   	push   %edi
 192:	e8 43 01 00 00       	call   2da <strcpy>
    p = buf+strlen(buf);
 197:	89 3c 24             	mov    %edi,(%esp)
 19a:	e8 8a 01 00 00       	call   329 <strlen>
 19f:	01 c7                	add    %eax,%edi
    *p++ = '/';
 1a1:	8d 47 01             	lea    0x1(%edi),%eax
 1a4:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
 1aa:	c6 07 2f             	movb   $0x2f,(%edi)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ad:	83 c4 10             	add    $0x10,%esp
 1b0:	8d 9d d8 fd ff ff    	lea    -0x228(%ebp),%ebx
 1b6:	83 ec 04             	sub    $0x4,%esp
 1b9:	6a 10                	push   $0x10
 1bb:	53                   	push   %ebx
 1bc:	56                   	push   %esi
 1bd:	e8 f0 02 00 00       	call   4b2 <read>
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	83 f8 10             	cmp    $0x10,%eax
 1c8:	0f 85 49 ff ff ff    	jne    117 <ls+0x85>
      if(de.inum == 0)
 1ce:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
 1d5:	00 
 1d6:	74 de                	je     1b6 <ls+0x124>
      memmove(p, de.name, DIRSIZ);
 1d8:	83 ec 04             	sub    $0x4,%esp
 1db:	6a 0e                	push   $0xe
 1dd:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
 1e3:	50                   	push   %eax
 1e4:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 1ea:	e8 7a 02 00 00       	call   469 <memmove>
      p[DIRSIZ] = 0;
 1ef:	c6 47 0f 00          	movb   $0x0,0xf(%edi)
      if(stat(buf, &st) < 0){
 1f3:	83 c4 08             	add    $0x8,%esp
 1f6:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 1fc:	50                   	push   %eax
 1fd:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 203:	50                   	push   %eax
 204:	e8 e4 01 00 00       	call   3ed <stat>
 209:	83 c4 10             	add    $0x10,%esp
 20c:	85 c0                	test   %eax,%eax
 20e:	78 5e                	js     26e <ls+0x1dc>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 210:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
 216:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 21c:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
 222:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 228:	0f bf 8d c4 fd ff ff 	movswl -0x23c(%ebp),%ecx
 22f:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 235:	83 ec 0c             	sub    $0xc,%esp
 238:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 23e:	50                   	push   %eax
 23f:	e8 bc fd ff ff       	call   0 <fmtname>
 244:	83 c4 08             	add    $0x8,%esp
 247:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 24d:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 253:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 259:	50                   	push   %eax
 25a:	68 04 09 00 00       	push   $0x904
 25f:	6a 01                	push   $0x1
 261:	e8 5e 03 00 00       	call   5c4 <printf>
 266:	83 c4 20             	add    $0x20,%esp
 269:	e9 48 ff ff ff       	jmp    1b6 <ls+0x124>
        printf(1, "ls: cannot stat %s\n", buf);
 26e:	83 ec 04             	sub    $0x4,%esp
 271:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 277:	50                   	push   %eax
 278:	68 f0 08 00 00       	push   $0x8f0
 27d:	6a 01                	push   $0x1
 27f:	e8 40 03 00 00       	call   5c4 <printf>
        continue;
 284:	83 c4 10             	add    $0x10,%esp
 287:	e9 2a ff ff ff       	jmp    1b6 <ls+0x124>

0000028c <main>:

int
main(int argc, char *argv[])
{
 28c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 290:	83 e4 f0             	and    $0xfffffff0,%esp
 293:	ff 71 fc             	pushl  -0x4(%ecx)
 296:	55                   	push   %ebp
 297:	89 e5                	mov    %esp,%ebp
 299:	56                   	push   %esi
 29a:	53                   	push   %ebx
 29b:	51                   	push   %ecx
 29c:	83 ec 0c             	sub    $0xc,%esp
 29f:	8b 01                	mov    (%ecx),%eax
 2a1:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
 2a4:	83 f8 01             	cmp    $0x1,%eax
 2a7:	7e 1f                	jle    2c8 <main+0x3c>
 2a9:	8d 5a 04             	lea    0x4(%edx),%ebx
 2ac:	8d 34 82             	lea    (%edx,%eax,4),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2af:	83 ec 0c             	sub    $0xc,%esp
 2b2:	ff 33                	pushl  (%ebx)
 2b4:	e8 d9 fd ff ff       	call   92 <ls>
 2b9:	83 c3 04             	add    $0x4,%ebx
  for(i=1; i<argc; i++)
 2bc:	83 c4 10             	add    $0x10,%esp
 2bf:	39 f3                	cmp    %esi,%ebx
 2c1:	75 ec                	jne    2af <main+0x23>
  exit();
 2c3:	e8 d2 01 00 00       	call   49a <exit>
    ls(".");
 2c8:	83 ec 0c             	sub    $0xc,%esp
 2cb:	68 24 09 00 00       	push   $0x924
 2d0:	e8 bd fd ff ff       	call   92 <ls>
    exit();
 2d5:	e8 c0 01 00 00       	call   49a <exit>

000002da <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2da:	55                   	push   %ebp
 2db:	89 e5                	mov    %esp,%ebp
 2dd:	53                   	push   %ebx
 2de:	8b 45 08             	mov    0x8(%ebp),%eax
 2e1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e4:	89 c2                	mov    %eax,%edx
 2e6:	83 c1 01             	add    $0x1,%ecx
 2e9:	83 c2 01             	add    $0x1,%edx
 2ec:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2f0:	88 5a ff             	mov    %bl,-0x1(%edx)
 2f3:	84 db                	test   %bl,%bl
 2f5:	75 ef                	jne    2e6 <strcpy+0xc>
    ;
  return os;
}
 2f7:	5b                   	pop    %ebx
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret    

000002fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2fa:	55                   	push   %ebp
 2fb:	89 e5                	mov    %esp,%ebp
 2fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 300:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 303:	0f b6 01             	movzbl (%ecx),%eax
 306:	84 c0                	test   %al,%al
 308:	74 15                	je     31f <strcmp+0x25>
 30a:	3a 02                	cmp    (%edx),%al
 30c:	75 11                	jne    31f <strcmp+0x25>
    p++, q++;
 30e:	83 c1 01             	add    $0x1,%ecx
 311:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 314:	0f b6 01             	movzbl (%ecx),%eax
 317:	84 c0                	test   %al,%al
 319:	74 04                	je     31f <strcmp+0x25>
 31b:	3a 02                	cmp    (%edx),%al
 31d:	74 ef                	je     30e <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 31f:	0f b6 c0             	movzbl %al,%eax
 322:	0f b6 12             	movzbl (%edx),%edx
 325:	29 d0                	sub    %edx,%eax
}
 327:	5d                   	pop    %ebp
 328:	c3                   	ret    

00000329 <strlen>:

uint
strlen(const char *s)
{
 329:	55                   	push   %ebp
 32a:	89 e5                	mov    %esp,%ebp
 32c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 32f:	80 39 00             	cmpb   $0x0,(%ecx)
 332:	74 12                	je     346 <strlen+0x1d>
 334:	ba 00 00 00 00       	mov    $0x0,%edx
 339:	83 c2 01             	add    $0x1,%edx
 33c:	89 d0                	mov    %edx,%eax
 33e:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 342:	75 f5                	jne    339 <strlen+0x10>
    ;
  return n;
}
 344:	5d                   	pop    %ebp
 345:	c3                   	ret    
  for(n = 0; s[n]; n++)
 346:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 34b:	eb f7                	jmp    344 <strlen+0x1b>

0000034d <memset>:

void*
memset(void *dst, int c, uint n)
{
 34d:	55                   	push   %ebp
 34e:	89 e5                	mov    %esp,%ebp
 350:	57                   	push   %edi
 351:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 354:	89 d7                	mov    %edx,%edi
 356:	8b 4d 10             	mov    0x10(%ebp),%ecx
 359:	8b 45 0c             	mov    0xc(%ebp),%eax
 35c:	fc                   	cld    
 35d:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 35f:	89 d0                	mov    %edx,%eax
 361:	5f                   	pop    %edi
 362:	5d                   	pop    %ebp
 363:	c3                   	ret    

00000364 <strchr>:

char*
strchr(const char *s, char c)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	53                   	push   %ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 36e:	0f b6 10             	movzbl (%eax),%edx
 371:	84 d2                	test   %dl,%dl
 373:	74 1e                	je     393 <strchr+0x2f>
 375:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 377:	38 d3                	cmp    %dl,%bl
 379:	74 15                	je     390 <strchr+0x2c>
  for(; *s; s++)
 37b:	83 c0 01             	add    $0x1,%eax
 37e:	0f b6 10             	movzbl (%eax),%edx
 381:	84 d2                	test   %dl,%dl
 383:	74 06                	je     38b <strchr+0x27>
    if(*s == c)
 385:	38 ca                	cmp    %cl,%dl
 387:	75 f2                	jne    37b <strchr+0x17>
 389:	eb 05                	jmp    390 <strchr+0x2c>
      return (char*)s;
  return 0;
 38b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 390:	5b                   	pop    %ebx
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
  return 0;
 393:	b8 00 00 00 00       	mov    $0x0,%eax
 398:	eb f6                	jmp    390 <strchr+0x2c>

0000039a <gets>:

char*
gets(char *buf, int max)
{
 39a:	55                   	push   %ebp
 39b:	89 e5                	mov    %esp,%ebp
 39d:	57                   	push   %edi
 39e:	56                   	push   %esi
 39f:	53                   	push   %ebx
 3a0:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a3:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 3a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 3ab:	8d 5e 01             	lea    0x1(%esi),%ebx
 3ae:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3b1:	7d 2b                	jge    3de <gets+0x44>
    cc = read(0, &c, 1);
 3b3:	83 ec 04             	sub    $0x4,%esp
 3b6:	6a 01                	push   $0x1
 3b8:	57                   	push   %edi
 3b9:	6a 00                	push   $0x0
 3bb:	e8 f2 00 00 00       	call   4b2 <read>
    if(cc < 1)
 3c0:	83 c4 10             	add    $0x10,%esp
 3c3:	85 c0                	test   %eax,%eax
 3c5:	7e 17                	jle    3de <gets+0x44>
      break;
    buf[i++] = c;
 3c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3cb:	8b 55 08             	mov    0x8(%ebp),%edx
 3ce:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 3d2:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3d4:	3c 0a                	cmp    $0xa,%al
 3d6:	74 04                	je     3dc <gets+0x42>
 3d8:	3c 0d                	cmp    $0xd,%al
 3da:	75 cf                	jne    3ab <gets+0x11>
  for(i=0; i+1 < max; ){
 3dc:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3de:	8b 45 08             	mov    0x8(%ebp),%eax
 3e1:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e8:	5b                   	pop    %ebx
 3e9:	5e                   	pop    %esi
 3ea:	5f                   	pop    %edi
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    

000003ed <stat>:

int
stat(const char *n, struct stat *st)
{
 3ed:	55                   	push   %ebp
 3ee:	89 e5                	mov    %esp,%ebp
 3f0:	56                   	push   %esi
 3f1:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f2:	83 ec 08             	sub    $0x8,%esp
 3f5:	6a 00                	push   $0x0
 3f7:	ff 75 08             	pushl  0x8(%ebp)
 3fa:	e8 db 00 00 00       	call   4da <open>
  if(fd < 0)
 3ff:	83 c4 10             	add    $0x10,%esp
 402:	85 c0                	test   %eax,%eax
 404:	78 24                	js     42a <stat+0x3d>
 406:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 408:	83 ec 08             	sub    $0x8,%esp
 40b:	ff 75 0c             	pushl  0xc(%ebp)
 40e:	50                   	push   %eax
 40f:	e8 de 00 00 00       	call   4f2 <fstat>
 414:	89 c6                	mov    %eax,%esi
  close(fd);
 416:	89 1c 24             	mov    %ebx,(%esp)
 419:	e8 a4 00 00 00       	call   4c2 <close>
  return r;
 41e:	83 c4 10             	add    $0x10,%esp
}
 421:	89 f0                	mov    %esi,%eax
 423:	8d 65 f8             	lea    -0x8(%ebp),%esp
 426:	5b                   	pop    %ebx
 427:	5e                   	pop    %esi
 428:	5d                   	pop    %ebp
 429:	c3                   	ret    
    return -1;
 42a:	be ff ff ff ff       	mov    $0xffffffff,%esi
 42f:	eb f0                	jmp    421 <stat+0x34>

00000431 <atoi>:

int
atoi(const char *s)
{
 431:	55                   	push   %ebp
 432:	89 e5                	mov    %esp,%ebp
 434:	53                   	push   %ebx
 435:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 438:	0f b6 11             	movzbl (%ecx),%edx
 43b:	8d 42 d0             	lea    -0x30(%edx),%eax
 43e:	3c 09                	cmp    $0x9,%al
 440:	77 20                	ja     462 <atoi+0x31>
  n = 0;
 442:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 447:	83 c1 01             	add    $0x1,%ecx
 44a:	8d 04 80             	lea    (%eax,%eax,4),%eax
 44d:	0f be d2             	movsbl %dl,%edx
 450:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 454:	0f b6 11             	movzbl (%ecx),%edx
 457:	8d 5a d0             	lea    -0x30(%edx),%ebx
 45a:	80 fb 09             	cmp    $0x9,%bl
 45d:	76 e8                	jbe    447 <atoi+0x16>
  return n;
}
 45f:	5b                   	pop    %ebx
 460:	5d                   	pop    %ebp
 461:	c3                   	ret    
  n = 0;
 462:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 467:	eb f6                	jmp    45f <atoi+0x2e>

00000469 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 469:	55                   	push   %ebp
 46a:	89 e5                	mov    %esp,%ebp
 46c:	56                   	push   %esi
 46d:	53                   	push   %ebx
 46e:	8b 45 08             	mov    0x8(%ebp),%eax
 471:	8b 75 0c             	mov    0xc(%ebp),%esi
 474:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 477:	85 db                	test   %ebx,%ebx
 479:	7e 13                	jle    48e <memmove+0x25>
 47b:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 480:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 484:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 487:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 48a:	39 d3                	cmp    %edx,%ebx
 48c:	75 f2                	jne    480 <memmove+0x17>
  return vdst;
}
 48e:	5b                   	pop    %ebx
 48f:	5e                   	pop    %esi
 490:	5d                   	pop    %ebp
 491:	c3                   	ret    

00000492 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 492:	b8 01 00 00 00       	mov    $0x1,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <exit>:
SYSCALL(exit)
 49a:	b8 02 00 00 00       	mov    $0x2,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <wait>:
SYSCALL(wait)
 4a2:	b8 03 00 00 00       	mov    $0x3,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <pipe>:
SYSCALL(pipe)
 4aa:	b8 04 00 00 00       	mov    $0x4,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <read>:
SYSCALL(read)
 4b2:	b8 05 00 00 00       	mov    $0x5,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <write>:
SYSCALL(write)
 4ba:	b8 10 00 00 00       	mov    $0x10,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <close>:
SYSCALL(close)
 4c2:	b8 15 00 00 00       	mov    $0x15,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <kill>:
SYSCALL(kill)
 4ca:	b8 06 00 00 00       	mov    $0x6,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <exec>:
SYSCALL(exec)
 4d2:	b8 07 00 00 00       	mov    $0x7,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <open>:
SYSCALL(open)
 4da:	b8 0f 00 00 00       	mov    $0xf,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <mknod>:
SYSCALL(mknod)
 4e2:	b8 11 00 00 00       	mov    $0x11,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <unlink>:
SYSCALL(unlink)
 4ea:	b8 12 00 00 00       	mov    $0x12,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <fstat>:
SYSCALL(fstat)
 4f2:	b8 08 00 00 00       	mov    $0x8,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <link>:
SYSCALL(link)
 4fa:	b8 13 00 00 00       	mov    $0x13,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <mkdir>:
SYSCALL(mkdir)
 502:	b8 14 00 00 00       	mov    $0x14,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <chdir>:
SYSCALL(chdir)
 50a:	b8 09 00 00 00       	mov    $0x9,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <dup>:
SYSCALL(dup)
 512:	b8 0a 00 00 00       	mov    $0xa,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <getpid>:
SYSCALL(getpid)
 51a:	b8 0b 00 00 00       	mov    $0xb,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <sbrk>:
SYSCALL(sbrk)
 522:	b8 0c 00 00 00       	mov    $0xc,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <sleep>:
SYSCALL(sleep)
 52a:	b8 0d 00 00 00       	mov    $0xd,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <uptime>:
SYSCALL(uptime)
 532:	b8 0e 00 00 00       	mov    $0xe,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 53a:	55                   	push   %ebp
 53b:	89 e5                	mov    %esp,%ebp
 53d:	57                   	push   %edi
 53e:	56                   	push   %esi
 53f:	53                   	push   %ebx
 540:	83 ec 3c             	sub    $0x3c,%esp
 543:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 545:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 549:	74 14                	je     55f <printint+0x25>
 54b:	85 d2                	test   %edx,%edx
 54d:	79 10                	jns    55f <printint+0x25>
    neg = 1;
    x = -xx;
 54f:	f7 da                	neg    %edx
    neg = 1;
 551:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 558:	bf 00 00 00 00       	mov    $0x0,%edi
 55d:	eb 0b                	jmp    56a <printint+0x30>
  neg = 0;
 55f:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 566:	eb f0                	jmp    558 <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 568:	89 df                	mov    %ebx,%edi
 56a:	8d 5f 01             	lea    0x1(%edi),%ebx
 56d:	89 d0                	mov    %edx,%eax
 56f:	ba 00 00 00 00       	mov    $0x0,%edx
 574:	f7 f1                	div    %ecx
 576:	0f b6 92 30 09 00 00 	movzbl 0x930(%edx),%edx
 57d:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 581:	89 c2                	mov    %eax,%edx
 583:	85 c0                	test   %eax,%eax
 585:	75 e1                	jne    568 <printint+0x2e>
  if(neg)
 587:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 58b:	74 08                	je     595 <printint+0x5b>
    buf[i++] = '-';
 58d:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 592:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 595:	83 eb 01             	sub    $0x1,%ebx
 598:	78 22                	js     5bc <printint+0x82>
  write(fd, &c, 1);
 59a:	8d 7d d7             	lea    -0x29(%ebp),%edi
 59d:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 5a2:	88 45 d7             	mov    %al,-0x29(%ebp)
 5a5:	83 ec 04             	sub    $0x4,%esp
 5a8:	6a 01                	push   $0x1
 5aa:	57                   	push   %edi
 5ab:	56                   	push   %esi
 5ac:	e8 09 ff ff ff       	call   4ba <write>
  while(--i >= 0)
 5b1:	83 eb 01             	sub    $0x1,%ebx
 5b4:	83 c4 10             	add    $0x10,%esp
 5b7:	83 fb ff             	cmp    $0xffffffff,%ebx
 5ba:	75 e1                	jne    59d <printint+0x63>
    putc(fd, buf[i]);
}
 5bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bf:	5b                   	pop    %ebx
 5c0:	5e                   	pop    %esi
 5c1:	5f                   	pop    %edi
 5c2:	5d                   	pop    %ebp
 5c3:	c3                   	ret    

000005c4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5c4:	55                   	push   %ebp
 5c5:	89 e5                	mov    %esp,%ebp
 5c7:	57                   	push   %edi
 5c8:	56                   	push   %esi
 5c9:	53                   	push   %ebx
 5ca:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5cd:	8b 75 0c             	mov    0xc(%ebp),%esi
 5d0:	0f b6 1e             	movzbl (%esi),%ebx
 5d3:	84 db                	test   %bl,%bl
 5d5:	0f 84 b1 01 00 00    	je     78c <printf+0x1c8>
 5db:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 5de:	8d 45 10             	lea    0x10(%ebp),%eax
 5e1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 5e4:	bf 00 00 00 00       	mov    $0x0,%edi
 5e9:	eb 2d                	jmp    618 <printf+0x54>
 5eb:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 5ee:	83 ec 04             	sub    $0x4,%esp
 5f1:	6a 01                	push   $0x1
 5f3:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5f6:	50                   	push   %eax
 5f7:	ff 75 08             	pushl  0x8(%ebp)
 5fa:	e8 bb fe ff ff       	call   4ba <write>
 5ff:	83 c4 10             	add    $0x10,%esp
 602:	eb 05                	jmp    609 <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 604:	83 ff 25             	cmp    $0x25,%edi
 607:	74 22                	je     62b <printf+0x67>
 609:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 60c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 610:	84 db                	test   %bl,%bl
 612:	0f 84 74 01 00 00    	je     78c <printf+0x1c8>
    c = fmt[i] & 0xff;
 618:	0f be d3             	movsbl %bl,%edx
 61b:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 61e:	85 ff                	test   %edi,%edi
 620:	75 e2                	jne    604 <printf+0x40>
      if(c == '%'){
 622:	83 f8 25             	cmp    $0x25,%eax
 625:	75 c4                	jne    5eb <printf+0x27>
        state = '%';
 627:	89 c7                	mov    %eax,%edi
 629:	eb de                	jmp    609 <printf+0x45>
      if(c == 'd'){
 62b:	83 f8 64             	cmp    $0x64,%eax
 62e:	74 59                	je     689 <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 630:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 636:	83 fa 70             	cmp    $0x70,%edx
 639:	74 7a                	je     6b5 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 63b:	83 f8 73             	cmp    $0x73,%eax
 63e:	0f 84 9d 00 00 00    	je     6e1 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 644:	83 f8 63             	cmp    $0x63,%eax
 647:	0f 84 f2 00 00 00    	je     73f <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 64d:	83 f8 25             	cmp    $0x25,%eax
 650:	0f 84 15 01 00 00    	je     76b <printf+0x1a7>
 656:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 65a:	83 ec 04             	sub    $0x4,%esp
 65d:	6a 01                	push   $0x1
 65f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 662:	50                   	push   %eax
 663:	ff 75 08             	pushl  0x8(%ebp)
 666:	e8 4f fe ff ff       	call   4ba <write>
 66b:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 66e:	83 c4 0c             	add    $0xc,%esp
 671:	6a 01                	push   $0x1
 673:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 676:	50                   	push   %eax
 677:	ff 75 08             	pushl  0x8(%ebp)
 67a:	e8 3b fe ff ff       	call   4ba <write>
 67f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 682:	bf 00 00 00 00       	mov    $0x0,%edi
 687:	eb 80                	jmp    609 <printf+0x45>
        printint(fd, *ap, 10, 1);
 689:	83 ec 0c             	sub    $0xc,%esp
 68c:	6a 01                	push   $0x1
 68e:	b9 0a 00 00 00       	mov    $0xa,%ecx
 693:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 696:	8b 17                	mov    (%edi),%edx
 698:	8b 45 08             	mov    0x8(%ebp),%eax
 69b:	e8 9a fe ff ff       	call   53a <printint>
        ap++;
 6a0:	89 f8                	mov    %edi,%eax
 6a2:	83 c0 04             	add    $0x4,%eax
 6a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ab:	bf 00 00 00 00       	mov    $0x0,%edi
 6b0:	e9 54 ff ff ff       	jmp    609 <printf+0x45>
        printint(fd, *ap, 16, 0);
 6b5:	83 ec 0c             	sub    $0xc,%esp
 6b8:	6a 00                	push   $0x0
 6ba:	b9 10 00 00 00       	mov    $0x10,%ecx
 6bf:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6c2:	8b 17                	mov    (%edi),%edx
 6c4:	8b 45 08             	mov    0x8(%ebp),%eax
 6c7:	e8 6e fe ff ff       	call   53a <printint>
        ap++;
 6cc:	89 f8                	mov    %edi,%eax
 6ce:	83 c0 04             	add    $0x4,%eax
 6d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6d4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6d7:	bf 00 00 00 00       	mov    $0x0,%edi
 6dc:	e9 28 ff ff ff       	jmp    609 <printf+0x45>
        s = (char*)*ap;
 6e1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 6e4:	8b 01                	mov    (%ecx),%eax
        ap++;
 6e6:	83 c1 04             	add    $0x4,%ecx
 6e9:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 6ec:	85 c0                	test   %eax,%eax
 6ee:	74 13                	je     703 <printf+0x13f>
        s = (char*)*ap;
 6f0:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 6f2:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 6f5:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 6fa:	84 c0                	test   %al,%al
 6fc:	75 0f                	jne    70d <printf+0x149>
 6fe:	e9 06 ff ff ff       	jmp    609 <printf+0x45>
          s = "(null)";
 703:	bb 26 09 00 00       	mov    $0x926,%ebx
        while(*s != 0){
 708:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 70d:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 710:	89 75 d0             	mov    %esi,-0x30(%ebp)
 713:	8b 75 08             	mov    0x8(%ebp),%esi
 716:	88 45 e3             	mov    %al,-0x1d(%ebp)
 719:	83 ec 04             	sub    $0x4,%esp
 71c:	6a 01                	push   $0x1
 71e:	57                   	push   %edi
 71f:	56                   	push   %esi
 720:	e8 95 fd ff ff       	call   4ba <write>
          s++;
 725:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 728:	0f b6 03             	movzbl (%ebx),%eax
 72b:	83 c4 10             	add    $0x10,%esp
 72e:	84 c0                	test   %al,%al
 730:	75 e4                	jne    716 <printf+0x152>
 732:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 735:	bf 00 00 00 00       	mov    $0x0,%edi
 73a:	e9 ca fe ff ff       	jmp    609 <printf+0x45>
        putc(fd, *ap);
 73f:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 742:	8b 07                	mov    (%edi),%eax
 744:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 747:	83 ec 04             	sub    $0x4,%esp
 74a:	6a 01                	push   $0x1
 74c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 74f:	50                   	push   %eax
 750:	ff 75 08             	pushl  0x8(%ebp)
 753:	e8 62 fd ff ff       	call   4ba <write>
        ap++;
 758:	83 c7 04             	add    $0x4,%edi
 75b:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 75e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 761:	bf 00 00 00 00       	mov    $0x0,%edi
 766:	e9 9e fe ff ff       	jmp    609 <printf+0x45>
 76b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 76e:	83 ec 04             	sub    $0x4,%esp
 771:	6a 01                	push   $0x1
 773:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 776:	50                   	push   %eax
 777:	ff 75 08             	pushl  0x8(%ebp)
 77a:	e8 3b fd ff ff       	call   4ba <write>
 77f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 782:	bf 00 00 00 00       	mov    $0x0,%edi
 787:	e9 7d fe ff ff       	jmp    609 <printf+0x45>
    }
  }
}
 78c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 78f:	5b                   	pop    %ebx
 790:	5e                   	pop    %esi
 791:	5f                   	pop    %edi
 792:	5d                   	pop    %ebp
 793:	c3                   	ret    

00000794 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 794:	55                   	push   %ebp
 795:	89 e5                	mov    %esp,%ebp
 797:	57                   	push   %edi
 798:	56                   	push   %esi
 799:	53                   	push   %ebx
 79a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	a1 0c 0c 00 00       	mov    0xc0c,%eax
 7a5:	eb 0c                	jmp    7b3 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a7:	8b 10                	mov    (%eax),%edx
 7a9:	39 c2                	cmp    %eax,%edx
 7ab:	77 04                	ja     7b1 <free+0x1d>
 7ad:	39 ca                	cmp    %ecx,%edx
 7af:	77 10                	ja     7c1 <free+0x2d>
{
 7b1:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	39 c8                	cmp    %ecx,%eax
 7b5:	73 f0                	jae    7a7 <free+0x13>
 7b7:	8b 10                	mov    (%eax),%edx
 7b9:	39 ca                	cmp    %ecx,%edx
 7bb:	77 04                	ja     7c1 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bd:	39 c2                	cmp    %eax,%edx
 7bf:	77 f0                	ja     7b1 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c1:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7c4:	8b 10                	mov    (%eax),%edx
 7c6:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7c9:	39 fa                	cmp    %edi,%edx
 7cb:	74 19                	je     7e6 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7cd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7d0:	8b 50 04             	mov    0x4(%eax),%edx
 7d3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d6:	39 f1                	cmp    %esi,%ecx
 7d8:	74 1b                	je     7f5 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7da:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7dc:	a3 0c 0c 00 00       	mov    %eax,0xc0c
}
 7e1:	5b                   	pop    %ebx
 7e2:	5e                   	pop    %esi
 7e3:	5f                   	pop    %edi
 7e4:	5d                   	pop    %ebp
 7e5:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 7e6:	03 72 04             	add    0x4(%edx),%esi
 7e9:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ec:	8b 10                	mov    (%eax),%edx
 7ee:	8b 12                	mov    (%edx),%edx
 7f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7f3:	eb db                	jmp    7d0 <free+0x3c>
    p->s.size += bp->s.size;
 7f5:	03 53 fc             	add    -0x4(%ebx),%edx
 7f8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fb:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7fe:	89 10                	mov    %edx,(%eax)
 800:	eb da                	jmp    7dc <free+0x48>

00000802 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 802:	55                   	push   %ebp
 803:	89 e5                	mov    %esp,%ebp
 805:	57                   	push   %edi
 806:	56                   	push   %esi
 807:	53                   	push   %ebx
 808:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80b:	8b 45 08             	mov    0x8(%ebp),%eax
 80e:	8d 58 07             	lea    0x7(%eax),%ebx
 811:	c1 eb 03             	shr    $0x3,%ebx
 814:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 817:	8b 15 0c 0c 00 00    	mov    0xc0c,%edx
 81d:	85 d2                	test   %edx,%edx
 81f:	74 20                	je     841 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 821:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 823:	8b 48 04             	mov    0x4(%eax),%ecx
 826:	39 cb                	cmp    %ecx,%ebx
 828:	76 3c                	jbe    866 <malloc+0x64>
 82a:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 830:	be 00 10 00 00       	mov    $0x1000,%esi
 835:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 838:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 83f:	eb 70                	jmp    8b1 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 841:	c7 05 0c 0c 00 00 10 	movl   $0xc10,0xc0c
 848:	0c 00 00 
 84b:	c7 05 10 0c 00 00 10 	movl   $0xc10,0xc10
 852:	0c 00 00 
    base.s.size = 0;
 855:	c7 05 14 0c 00 00 00 	movl   $0x0,0xc14
 85c:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 85f:	ba 10 0c 00 00       	mov    $0xc10,%edx
 864:	eb bb                	jmp    821 <malloc+0x1f>
      if(p->s.size == nunits)
 866:	39 cb                	cmp    %ecx,%ebx
 868:	74 1c                	je     886 <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 86a:	29 d9                	sub    %ebx,%ecx
 86c:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 86f:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 872:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 875:	89 15 0c 0c 00 00    	mov    %edx,0xc0c
      return (void*)(p + 1);
 87b:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 87e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 881:	5b                   	pop    %ebx
 882:	5e                   	pop    %esi
 883:	5f                   	pop    %edi
 884:	5d                   	pop    %ebp
 885:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 886:	8b 08                	mov    (%eax),%ecx
 888:	89 0a                	mov    %ecx,(%edx)
 88a:	eb e9                	jmp    875 <malloc+0x73>
  hp->s.size = nu;
 88c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 88f:	83 ec 0c             	sub    $0xc,%esp
 892:	83 c0 08             	add    $0x8,%eax
 895:	50                   	push   %eax
 896:	e8 f9 fe ff ff       	call   794 <free>
  return freep;
 89b:	8b 15 0c 0c 00 00    	mov    0xc0c,%edx
      if((p = morecore(nunits)) == 0)
 8a1:	83 c4 10             	add    $0x10,%esp
 8a4:	85 d2                	test   %edx,%edx
 8a6:	74 2b                	je     8d3 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8aa:	8b 48 04             	mov    0x4(%eax),%ecx
 8ad:	39 d9                	cmp    %ebx,%ecx
 8af:	73 b5                	jae    866 <malloc+0x64>
 8b1:	89 c2                	mov    %eax,%edx
    if(p == freep)
 8b3:	39 05 0c 0c 00 00    	cmp    %eax,0xc0c
 8b9:	75 ed                	jne    8a8 <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 8bb:	83 ec 0c             	sub    $0xc,%esp
 8be:	57                   	push   %edi
 8bf:	e8 5e fc ff ff       	call   522 <sbrk>
  if(p == (char*)-1)
 8c4:	83 c4 10             	add    $0x10,%esp
 8c7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ca:	75 c0                	jne    88c <malloc+0x8a>
        return 0;
 8cc:	b8 00 00 00 00       	mov    $0x0,%eax
 8d1:	eb ab                	jmp    87e <malloc+0x7c>
 8d3:	b8 00 00 00 00       	mov    $0x0,%eax
 8d8:	eb a4                	jmp    87e <malloc+0x7c>

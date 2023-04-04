
user/_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	8b 75 08             	mov    0x8(%ebp),%esi
   c:	8b 7d 0c             	mov    0xc(%ebp),%edi
   f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  12:	83 ec 08             	sub    $0x8,%esp
  15:	53                   	push   %ebx
  16:	57                   	push   %edi
  17:	e8 2c 00 00 00       	call   48 <matchhere>
  1c:	83 c4 10             	add    $0x10,%esp
  1f:	85 c0                	test   %eax,%eax
  21:	75 18                	jne    3b <matchstar+0x3b>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  23:	0f b6 13             	movzbl (%ebx),%edx
  26:	84 d2                	test   %dl,%dl
  28:	74 16                	je     40 <matchstar+0x40>
  2a:	83 c3 01             	add    $0x1,%ebx
  2d:	83 fe 2e             	cmp    $0x2e,%esi
  30:	74 e0                	je     12 <matchstar+0x12>
  32:	0f be d2             	movsbl %dl,%edx
  35:	39 f2                	cmp    %esi,%edx
  37:	74 d9                	je     12 <matchstar+0x12>
  39:	eb 05                	jmp    40 <matchstar+0x40>
      return 1;
  3b:	b8 01 00 00 00       	mov    $0x1,%eax
  return 0;
}
  40:	8d 65 f4             	lea    -0xc(%ebp),%esp
  43:	5b                   	pop    %ebx
  44:	5e                   	pop    %esi
  45:	5f                   	pop    %edi
  46:	5d                   	pop    %ebp
  47:	c3                   	ret    

00000048 <matchhere>:
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	53                   	push   %ebx
  4c:	83 ec 04             	sub    $0x4,%esp
  4f:	8b 55 08             	mov    0x8(%ebp),%edx
  if(re[0] == '\0')
  52:	0f b6 0a             	movzbl (%edx),%ecx
    return 1;
  55:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '\0')
  5a:	84 c9                	test   %cl,%cl
  5c:	74 29                	je     87 <matchhere+0x3f>
  if(re[1] == '*')
  5e:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  62:	3c 2a                	cmp    $0x2a,%al
  64:	74 26                	je     8c <matchhere+0x44>
  if(re[0] == '$' && re[1] == '\0')
  66:	84 c0                	test   %al,%al
  68:	75 05                	jne    6f <matchhere+0x27>
  6a:	80 f9 24             	cmp    $0x24,%cl
  6d:	74 35                	je     a4 <matchhere+0x5c>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  72:	0f b6 18             	movzbl (%eax),%ebx
  return 0;
  75:	b8 00 00 00 00       	mov    $0x0,%eax
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  7a:	84 db                	test   %bl,%bl
  7c:	74 09                	je     87 <matchhere+0x3f>
  7e:	38 d9                	cmp    %bl,%cl
  80:	74 30                	je     b2 <matchhere+0x6a>
  82:	80 f9 2e             	cmp    $0x2e,%cl
  85:	74 2b                	je     b2 <matchhere+0x6a>
}
  87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8a:	c9                   	leave  
  8b:	c3                   	ret    
    return matchstar(re[0], re+2, text);
  8c:	83 ec 04             	sub    $0x4,%esp
  8f:	ff 75 0c             	pushl  0xc(%ebp)
  92:	83 c2 02             	add    $0x2,%edx
  95:	52                   	push   %edx
  96:	0f be c9             	movsbl %cl,%ecx
  99:	51                   	push   %ecx
  9a:	e8 61 ff ff ff       	call   0 <matchstar>
  9f:	83 c4 10             	add    $0x10,%esp
  a2:	eb e3                	jmp    87 <matchhere+0x3f>
    return *text == '\0';
  a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  a7:	80 38 00             	cmpb   $0x0,(%eax)
  aa:	0f 94 c0             	sete   %al
  ad:	0f b6 c0             	movzbl %al,%eax
  b0:	eb d5                	jmp    87 <matchhere+0x3f>
    return matchhere(re+1, text+1);
  b2:	83 ec 08             	sub    $0x8,%esp
  b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  b8:	83 c0 01             	add    $0x1,%eax
  bb:	50                   	push   %eax
  bc:	83 c2 01             	add    $0x1,%edx
  bf:	52                   	push   %edx
  c0:	e8 83 ff ff ff       	call   48 <matchhere>
  c5:	83 c4 10             	add    $0x10,%esp
  c8:	eb bd                	jmp    87 <matchhere+0x3f>

000000ca <match>:
{
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  cd:	56                   	push   %esi
  ce:	53                   	push   %ebx
  cf:	8b 75 08             	mov    0x8(%ebp),%esi
  d2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
  d5:	80 3e 5e             	cmpb   $0x5e,(%esi)
  d8:	74 1c                	je     f6 <match+0x2c>
    if(matchhere(re, text))
  da:	83 ec 08             	sub    $0x8,%esp
  dd:	53                   	push   %ebx
  de:	56                   	push   %esi
  df:	e8 64 ff ff ff       	call   48 <matchhere>
  e4:	83 c4 10             	add    $0x10,%esp
  e7:	85 c0                	test   %eax,%eax
  e9:	75 1d                	jne    108 <match+0x3e>
  }while(*text++ != '\0');
  eb:	83 c3 01             	add    $0x1,%ebx
  ee:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
  f2:	75 e6                	jne    da <match+0x10>
  f4:	eb 17                	jmp    10d <match+0x43>
    return matchhere(re+1, text);
  f6:	83 ec 08             	sub    $0x8,%esp
  f9:	53                   	push   %ebx
  fa:	83 c6 01             	add    $0x1,%esi
  fd:	56                   	push   %esi
  fe:	e8 45 ff ff ff       	call   48 <matchhere>
 103:	83 c4 10             	add    $0x10,%esp
 106:	eb 05                	jmp    10d <match+0x43>
      return 1;
 108:	b8 01 00 00 00       	mov    $0x1,%eax
}
 10d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 110:	5b                   	pop    %ebx
 111:	5e                   	pop    %esi
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    

00000114 <grep>:
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	83 ec 1c             	sub    $0x1c,%esp
  m = 0;
 11d:	bf 00 00 00 00       	mov    $0x0,%edi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 122:	eb 53                	jmp    177 <grep+0x63>
      p = q+1;
 124:	8d 73 01             	lea    0x1(%ebx),%esi
    while((q = strchr(p, '\n')) != 0){
 127:	83 ec 08             	sub    $0x8,%esp
 12a:	6a 0a                	push   $0xa
 12c:	56                   	push   %esi
 12d:	e8 e6 01 00 00       	call   318 <strchr>
 132:	89 c3                	mov    %eax,%ebx
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	74 2d                	je     168 <grep+0x54>
      *q = 0;
 13b:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 13e:	83 ec 08             	sub    $0x8,%esp
 141:	56                   	push   %esi
 142:	57                   	push   %edi
 143:	e8 82 ff ff ff       	call   ca <match>
 148:	83 c4 10             	add    $0x10,%esp
 14b:	85 c0                	test   %eax,%eax
 14d:	74 d5                	je     124 <grep+0x10>
        *q = '\n';
 14f:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 152:	83 ec 04             	sub    $0x4,%esp
 155:	8d 43 01             	lea    0x1(%ebx),%eax
 158:	29 f0                	sub    %esi,%eax
 15a:	50                   	push   %eax
 15b:	56                   	push   %esi
 15c:	6a 01                	push   $0x1
 15e:	e8 0b 03 00 00       	call   46e <write>
 163:	83 c4 10             	add    $0x10,%esp
 166:	eb bc                	jmp    124 <grep+0x10>
 168:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    if(p == buf)
 16b:	81 fe 20 0c 00 00    	cmp    $0xc20,%esi
 171:	74 5b                	je     1ce <grep+0xba>
    if(m > 0){
 173:	85 ff                	test   %edi,%edi
 175:	7f 3a                	jg     1b1 <grep+0x9d>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 177:	83 ec 04             	sub    $0x4,%esp
 17a:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 17f:	29 f8                	sub    %edi,%eax
 181:	50                   	push   %eax
 182:	8d 87 20 0c 00 00    	lea    0xc20(%edi),%eax
 188:	50                   	push   %eax
 189:	ff 75 0c             	pushl  0xc(%ebp)
 18c:	e8 d5 02 00 00       	call   466 <read>
 191:	83 c4 10             	add    $0x10,%esp
 194:	85 c0                	test   %eax,%eax
 196:	7e 3d                	jle    1d5 <grep+0xc1>
    m += n;
 198:	01 c7                	add    %eax,%edi
    buf[m] = '\0';
 19a:	c6 87 20 0c 00 00 00 	movb   $0x0,0xc20(%edi)
    p = buf;
 1a1:	be 20 0c 00 00       	mov    $0xc20,%esi
 1a6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 1a9:	8b 7d 08             	mov    0x8(%ebp),%edi
    while((q = strchr(p, '\n')) != 0){
 1ac:	e9 76 ff ff ff       	jmp    127 <grep+0x13>
      m -= p - buf;
 1b1:	89 f0                	mov    %esi,%eax
 1b3:	2d 20 0c 00 00       	sub    $0xc20,%eax
 1b8:	29 c7                	sub    %eax,%edi
      memmove(buf, p, m);
 1ba:	83 ec 04             	sub    $0x4,%esp
 1bd:	57                   	push   %edi
 1be:	56                   	push   %esi
 1bf:	68 20 0c 00 00       	push   $0xc20
 1c4:	e8 54 02 00 00       	call   41d <memmove>
 1c9:	83 c4 10             	add    $0x10,%esp
 1cc:	eb a9                	jmp    177 <grep+0x63>
      m = 0;
 1ce:	bf 00 00 00 00       	mov    $0x0,%edi
 1d3:	eb a2                	jmp    177 <grep+0x63>
}
 1d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1d8:	5b                   	pop    %ebx
 1d9:	5e                   	pop    %esi
 1da:	5f                   	pop    %edi
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    

000001dd <main>:
{
 1dd:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1e1:	83 e4 f0             	and    $0xfffffff0,%esp
 1e4:	ff 71 fc             	pushl  -0x4(%ecx)
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	57                   	push   %edi
 1eb:	56                   	push   %esi
 1ec:	53                   	push   %ebx
 1ed:	51                   	push   %ecx
 1ee:	83 ec 18             	sub    $0x18,%esp
 1f1:	8b 01                	mov    (%ecx),%eax
 1f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 1f6:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc <= 1){
 1f9:	83 f8 01             	cmp    $0x1,%eax
 1fc:	7e 53                	jle    251 <main+0x74>
  pattern = argv[1];
 1fe:	8b 43 04             	mov    0x4(%ebx),%eax
 201:	89 45 e0             	mov    %eax,-0x20(%ebp)
 204:	83 c3 08             	add    $0x8,%ebx
  for(i = 2; i < argc; i++){
 207:	bf 02 00 00 00       	mov    $0x2,%edi
  if(argc <= 2){
 20c:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
 210:	7e 53                	jle    265 <main+0x88>
    if((fd = open(argv[i], 0)) < 0){
 212:	89 5d dc             	mov    %ebx,-0x24(%ebp)
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 33                	pushl  (%ebx)
 21c:	e8 6d 02 00 00       	call   48e <open>
 221:	89 c6                	mov    %eax,%esi
 223:	83 c4 10             	add    $0x10,%esp
 226:	85 c0                	test   %eax,%eax
 228:	78 4b                	js     275 <main+0x98>
    grep(pattern, fd);
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	50                   	push   %eax
 22e:	ff 75 e0             	pushl  -0x20(%ebp)
 231:	e8 de fe ff ff       	call   114 <grep>
    close(fd);
 236:	89 34 24             	mov    %esi,(%esp)
 239:	e8 38 02 00 00       	call   476 <close>
  for(i = 2; i < argc; i++){
 23e:	83 c7 01             	add    $0x1,%edi
 241:	83 c3 04             	add    $0x4,%ebx
 244:	83 c4 10             	add    $0x10,%esp
 247:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 24a:	75 c6                	jne    212 <main+0x35>
  exit();
 24c:	e8 fd 01 00 00       	call   44e <exit>
    printf(2, "usage: grep pattern [file ...]\n");
 251:	83 ec 08             	sub    $0x8,%esp
 254:	68 90 08 00 00       	push   $0x890
 259:	6a 02                	push   $0x2
 25b:	e8 18 03 00 00       	call   578 <printf>
    exit();
 260:	e8 e9 01 00 00       	call   44e <exit>
    grep(pattern, 0);
 265:	83 ec 08             	sub    $0x8,%esp
 268:	6a 00                	push   $0x0
 26a:	50                   	push   %eax
 26b:	e8 a4 fe ff ff       	call   114 <grep>
    exit();
 270:	e8 d9 01 00 00       	call   44e <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
 275:	83 ec 04             	sub    $0x4,%esp
 278:	8b 45 dc             	mov    -0x24(%ebp),%eax
 27b:	ff 30                	pushl  (%eax)
 27d:	68 b0 08 00 00       	push   $0x8b0
 282:	6a 01                	push   $0x1
 284:	e8 ef 02 00 00       	call   578 <printf>
      exit();
 289:	e8 c0 01 00 00       	call   44e <exit>

0000028e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 28e:	55                   	push   %ebp
 28f:	89 e5                	mov    %esp,%ebp
 291:	53                   	push   %ebx
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 298:	89 c2                	mov    %eax,%edx
 29a:	83 c1 01             	add    $0x1,%ecx
 29d:	83 c2 01             	add    $0x1,%edx
 2a0:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2a4:	88 5a ff             	mov    %bl,-0x1(%edx)
 2a7:	84 db                	test   %bl,%bl
 2a9:	75 ef                	jne    29a <strcpy+0xc>
    ;
  return os;
}
 2ab:	5b                   	pop    %ebx
 2ac:	5d                   	pop    %ebp
 2ad:	c3                   	ret    

000002ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ae:	55                   	push   %ebp
 2af:	89 e5                	mov    %esp,%ebp
 2b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 2b7:	0f b6 01             	movzbl (%ecx),%eax
 2ba:	84 c0                	test   %al,%al
 2bc:	74 15                	je     2d3 <strcmp+0x25>
 2be:	3a 02                	cmp    (%edx),%al
 2c0:	75 11                	jne    2d3 <strcmp+0x25>
    p++, q++;
 2c2:	83 c1 01             	add    $0x1,%ecx
 2c5:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2c8:	0f b6 01             	movzbl (%ecx),%eax
 2cb:	84 c0                	test   %al,%al
 2cd:	74 04                	je     2d3 <strcmp+0x25>
 2cf:	3a 02                	cmp    (%edx),%al
 2d1:	74 ef                	je     2c2 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 2d3:	0f b6 c0             	movzbl %al,%eax
 2d6:	0f b6 12             	movzbl (%edx),%edx
 2d9:	29 d0                	sub    %edx,%eax
}
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    

000002dd <strlen>:

uint
strlen(const char *s)
{
 2dd:	55                   	push   %ebp
 2de:	89 e5                	mov    %esp,%ebp
 2e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2e3:	80 39 00             	cmpb   $0x0,(%ecx)
 2e6:	74 12                	je     2fa <strlen+0x1d>
 2e8:	ba 00 00 00 00       	mov    $0x0,%edx
 2ed:	83 c2 01             	add    $0x1,%edx
 2f0:	89 d0                	mov    %edx,%eax
 2f2:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2f6:	75 f5                	jne    2ed <strlen+0x10>
    ;
  return n;
}
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret    
  for(n = 0; s[n]; n++)
 2fa:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 2ff:	eb f7                	jmp    2f8 <strlen+0x1b>

00000301 <memset>:

void*
memset(void *dst, int c, uint n)
{
 301:	55                   	push   %ebp
 302:	89 e5                	mov    %esp,%ebp
 304:	57                   	push   %edi
 305:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 308:	89 d7                	mov    %edx,%edi
 30a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 30d:	8b 45 0c             	mov    0xc(%ebp),%eax
 310:	fc                   	cld    
 311:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 313:	89 d0                	mov    %edx,%eax
 315:	5f                   	pop    %edi
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    

00000318 <strchr>:

char*
strchr(const char *s, char c)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	53                   	push   %ebx
 31c:	8b 45 08             	mov    0x8(%ebp),%eax
 31f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 322:	0f b6 10             	movzbl (%eax),%edx
 325:	84 d2                	test   %dl,%dl
 327:	74 1e                	je     347 <strchr+0x2f>
 329:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 32b:	38 d3                	cmp    %dl,%bl
 32d:	74 15                	je     344 <strchr+0x2c>
  for(; *s; s++)
 32f:	83 c0 01             	add    $0x1,%eax
 332:	0f b6 10             	movzbl (%eax),%edx
 335:	84 d2                	test   %dl,%dl
 337:	74 06                	je     33f <strchr+0x27>
    if(*s == c)
 339:	38 ca                	cmp    %cl,%dl
 33b:	75 f2                	jne    32f <strchr+0x17>
 33d:	eb 05                	jmp    344 <strchr+0x2c>
      return (char*)s;
  return 0;
 33f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 344:	5b                   	pop    %ebx
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
  return 0;
 347:	b8 00 00 00 00       	mov    $0x0,%eax
 34c:	eb f6                	jmp    344 <strchr+0x2c>

0000034e <gets>:

char*
gets(char *buf, int max)
{
 34e:	55                   	push   %ebp
 34f:	89 e5                	mov    %esp,%ebp
 351:	57                   	push   %edi
 352:	56                   	push   %esi
 353:	53                   	push   %ebx
 354:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 357:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 35c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 35f:	8d 5e 01             	lea    0x1(%esi),%ebx
 362:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 365:	7d 2b                	jge    392 <gets+0x44>
    cc = read(0, &c, 1);
 367:	83 ec 04             	sub    $0x4,%esp
 36a:	6a 01                	push   $0x1
 36c:	57                   	push   %edi
 36d:	6a 00                	push   $0x0
 36f:	e8 f2 00 00 00       	call   466 <read>
    if(cc < 1)
 374:	83 c4 10             	add    $0x10,%esp
 377:	85 c0                	test   %eax,%eax
 379:	7e 17                	jle    392 <gets+0x44>
      break;
    buf[i++] = c;
 37b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 37f:	8b 55 08             	mov    0x8(%ebp),%edx
 382:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
  for(i=0; i+1 < max; ){
 386:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 388:	3c 0a                	cmp    $0xa,%al
 38a:	74 04                	je     390 <gets+0x42>
 38c:	3c 0d                	cmp    $0xd,%al
 38e:	75 cf                	jne    35f <gets+0x11>
  for(i=0; i+1 < max; ){
 390:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 392:	8b 45 08             	mov    0x8(%ebp),%eax
 395:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 399:	8d 65 f4             	lea    -0xc(%ebp),%esp
 39c:	5b                   	pop    %ebx
 39d:	5e                   	pop    %esi
 39e:	5f                   	pop    %edi
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret    

000003a1 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a1:	55                   	push   %ebp
 3a2:	89 e5                	mov    %esp,%ebp
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a6:	83 ec 08             	sub    $0x8,%esp
 3a9:	6a 00                	push   $0x0
 3ab:	ff 75 08             	pushl  0x8(%ebp)
 3ae:	e8 db 00 00 00       	call   48e <open>
  if(fd < 0)
 3b3:	83 c4 10             	add    $0x10,%esp
 3b6:	85 c0                	test   %eax,%eax
 3b8:	78 24                	js     3de <stat+0x3d>
 3ba:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3bc:	83 ec 08             	sub    $0x8,%esp
 3bf:	ff 75 0c             	pushl  0xc(%ebp)
 3c2:	50                   	push   %eax
 3c3:	e8 de 00 00 00       	call   4a6 <fstat>
 3c8:	89 c6                	mov    %eax,%esi
  close(fd);
 3ca:	89 1c 24             	mov    %ebx,(%esp)
 3cd:	e8 a4 00 00 00       	call   476 <close>
  return r;
 3d2:	83 c4 10             	add    $0x10,%esp
}
 3d5:	89 f0                	mov    %esi,%eax
 3d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3da:	5b                   	pop    %ebx
 3db:	5e                   	pop    %esi
 3dc:	5d                   	pop    %ebp
 3dd:	c3                   	ret    
    return -1;
 3de:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3e3:	eb f0                	jmp    3d5 <stat+0x34>

000003e5 <atoi>:

int
atoi(const char *s)
{
 3e5:	55                   	push   %ebp
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	53                   	push   %ebx
 3e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ec:	0f b6 11             	movzbl (%ecx),%edx
 3ef:	8d 42 d0             	lea    -0x30(%edx),%eax
 3f2:	3c 09                	cmp    $0x9,%al
 3f4:	77 20                	ja     416 <atoi+0x31>
  n = 0;
 3f6:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 3fb:	83 c1 01             	add    $0x1,%ecx
 3fe:	8d 04 80             	lea    (%eax,%eax,4),%eax
 401:	0f be d2             	movsbl %dl,%edx
 404:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 408:	0f b6 11             	movzbl (%ecx),%edx
 40b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 40e:	80 fb 09             	cmp    $0x9,%bl
 411:	76 e8                	jbe    3fb <atoi+0x16>
  return n;
}
 413:	5b                   	pop    %ebx
 414:	5d                   	pop    %ebp
 415:	c3                   	ret    
  n = 0;
 416:	b8 00 00 00 00       	mov    $0x0,%eax
  return n;
 41b:	eb f6                	jmp    413 <atoi+0x2e>

0000041d <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 41d:	55                   	push   %ebp
 41e:	89 e5                	mov    %esp,%ebp
 420:	56                   	push   %esi
 421:	53                   	push   %ebx
 422:	8b 45 08             	mov    0x8(%ebp),%eax
 425:	8b 75 0c             	mov    0xc(%ebp),%esi
 428:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 42b:	85 db                	test   %ebx,%ebx
 42d:	7e 13                	jle    442 <memmove+0x25>
 42f:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 434:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 438:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 43b:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 43e:	39 d3                	cmp    %edx,%ebx
 440:	75 f2                	jne    434 <memmove+0x17>
  return vdst;
}
 442:	5b                   	pop    %ebx
 443:	5e                   	pop    %esi
 444:	5d                   	pop    %ebp
 445:	c3                   	ret    

00000446 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 446:	b8 01 00 00 00       	mov    $0x1,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret    

0000044e <exit>:
SYSCALL(exit)
 44e:	b8 02 00 00 00       	mov    $0x2,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <wait>:
SYSCALL(wait)
 456:	b8 03 00 00 00       	mov    $0x3,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret    

0000045e <pipe>:
SYSCALL(pipe)
 45e:	b8 04 00 00 00       	mov    $0x4,%eax
 463:	cd 40                	int    $0x40
 465:	c3                   	ret    

00000466 <read>:
SYSCALL(read)
 466:	b8 05 00 00 00       	mov    $0x5,%eax
 46b:	cd 40                	int    $0x40
 46d:	c3                   	ret    

0000046e <write>:
SYSCALL(write)
 46e:	b8 10 00 00 00       	mov    $0x10,%eax
 473:	cd 40                	int    $0x40
 475:	c3                   	ret    

00000476 <close>:
SYSCALL(close)
 476:	b8 15 00 00 00       	mov    $0x15,%eax
 47b:	cd 40                	int    $0x40
 47d:	c3                   	ret    

0000047e <kill>:
SYSCALL(kill)
 47e:	b8 06 00 00 00       	mov    $0x6,%eax
 483:	cd 40                	int    $0x40
 485:	c3                   	ret    

00000486 <exec>:
SYSCALL(exec)
 486:	b8 07 00 00 00       	mov    $0x7,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <open>:
SYSCALL(open)
 48e:	b8 0f 00 00 00       	mov    $0xf,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <mknod>:
SYSCALL(mknod)
 496:	b8 11 00 00 00       	mov    $0x11,%eax
 49b:	cd 40                	int    $0x40
 49d:	c3                   	ret    

0000049e <unlink>:
SYSCALL(unlink)
 49e:	b8 12 00 00 00       	mov    $0x12,%eax
 4a3:	cd 40                	int    $0x40
 4a5:	c3                   	ret    

000004a6 <fstat>:
SYSCALL(fstat)
 4a6:	b8 08 00 00 00       	mov    $0x8,%eax
 4ab:	cd 40                	int    $0x40
 4ad:	c3                   	ret    

000004ae <link>:
SYSCALL(link)
 4ae:	b8 13 00 00 00       	mov    $0x13,%eax
 4b3:	cd 40                	int    $0x40
 4b5:	c3                   	ret    

000004b6 <mkdir>:
SYSCALL(mkdir)
 4b6:	b8 14 00 00 00       	mov    $0x14,%eax
 4bb:	cd 40                	int    $0x40
 4bd:	c3                   	ret    

000004be <chdir>:
SYSCALL(chdir)
 4be:	b8 09 00 00 00       	mov    $0x9,%eax
 4c3:	cd 40                	int    $0x40
 4c5:	c3                   	ret    

000004c6 <dup>:
SYSCALL(dup)
 4c6:	b8 0a 00 00 00       	mov    $0xa,%eax
 4cb:	cd 40                	int    $0x40
 4cd:	c3                   	ret    

000004ce <getpid>:
SYSCALL(getpid)
 4ce:	b8 0b 00 00 00       	mov    $0xb,%eax
 4d3:	cd 40                	int    $0x40
 4d5:	c3                   	ret    

000004d6 <sbrk>:
SYSCALL(sbrk)
 4d6:	b8 0c 00 00 00       	mov    $0xc,%eax
 4db:	cd 40                	int    $0x40
 4dd:	c3                   	ret    

000004de <sleep>:
SYSCALL(sleep)
 4de:	b8 0d 00 00 00       	mov    $0xd,%eax
 4e3:	cd 40                	int    $0x40
 4e5:	c3                   	ret    

000004e6 <uptime>:
SYSCALL(uptime)
 4e6:	b8 0e 00 00 00       	mov    $0xe,%eax
 4eb:	cd 40                	int    $0x40
 4ed:	c3                   	ret    

000004ee <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4ee:	55                   	push   %ebp
 4ef:	89 e5                	mov    %esp,%ebp
 4f1:	57                   	push   %edi
 4f2:	56                   	push   %esi
 4f3:	53                   	push   %ebx
 4f4:	83 ec 3c             	sub    $0x3c,%esp
 4f7:	89 c6                	mov    %eax,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 4fd:	74 14                	je     513 <printint+0x25>
 4ff:	85 d2                	test   %edx,%edx
 501:	79 10                	jns    513 <printint+0x25>
    neg = 1;
    x = -xx;
 503:	f7 da                	neg    %edx
    neg = 1;
 505:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 50c:	bf 00 00 00 00       	mov    $0x0,%edi
 511:	eb 0b                	jmp    51e <printint+0x30>
  neg = 0;
 513:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 51a:	eb f0                	jmp    50c <printint+0x1e>
  do{
    buf[i++] = digits[x % base];
 51c:	89 df                	mov    %ebx,%edi
 51e:	8d 5f 01             	lea    0x1(%edi),%ebx
 521:	89 d0                	mov    %edx,%eax
 523:	ba 00 00 00 00       	mov    $0x0,%edx
 528:	f7 f1                	div    %ecx
 52a:	0f b6 92 d0 08 00 00 	movzbl 0x8d0(%edx),%edx
 531:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 535:	89 c2                	mov    %eax,%edx
 537:	85 c0                	test   %eax,%eax
 539:	75 e1                	jne    51c <printint+0x2e>
  if(neg)
 53b:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
 53f:	74 08                	je     549 <printint+0x5b>
    buf[i++] = '-';
 541:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 546:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 549:	83 eb 01             	sub    $0x1,%ebx
 54c:	78 22                	js     570 <printint+0x82>
  write(fd, &c, 1);
 54e:	8d 7d d7             	lea    -0x29(%ebp),%edi
 551:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 556:	88 45 d7             	mov    %al,-0x29(%ebp)
 559:	83 ec 04             	sub    $0x4,%esp
 55c:	6a 01                	push   $0x1
 55e:	57                   	push   %edi
 55f:	56                   	push   %esi
 560:	e8 09 ff ff ff       	call   46e <write>
  while(--i >= 0)
 565:	83 eb 01             	sub    $0x1,%ebx
 568:	83 c4 10             	add    $0x10,%esp
 56b:	83 fb ff             	cmp    $0xffffffff,%ebx
 56e:	75 e1                	jne    551 <printint+0x63>
    putc(fd, buf[i]);
}
 570:	8d 65 f4             	lea    -0xc(%ebp),%esp
 573:	5b                   	pop    %ebx
 574:	5e                   	pop    %esi
 575:	5f                   	pop    %edi
 576:	5d                   	pop    %ebp
 577:	c3                   	ret    

00000578 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 578:	55                   	push   %ebp
 579:	89 e5                	mov    %esp,%ebp
 57b:	57                   	push   %edi
 57c:	56                   	push   %esi
 57d:	53                   	push   %ebx
 57e:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 581:	8b 75 0c             	mov    0xc(%ebp),%esi
 584:	0f b6 1e             	movzbl (%esi),%ebx
 587:	84 db                	test   %bl,%bl
 589:	0f 84 b1 01 00 00    	je     740 <printf+0x1c8>
 58f:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 592:	8d 45 10             	lea    0x10(%ebp),%eax
 595:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 598:	bf 00 00 00 00       	mov    $0x0,%edi
 59d:	eb 2d                	jmp    5cc <printf+0x54>
 59f:	88 5d e2             	mov    %bl,-0x1e(%ebp)
  write(fd, &c, 1);
 5a2:	83 ec 04             	sub    $0x4,%esp
 5a5:	6a 01                	push   $0x1
 5a7:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	pushl  0x8(%ebp)
 5ae:	e8 bb fe ff ff       	call   46e <write>
 5b3:	83 c4 10             	add    $0x10,%esp
 5b6:	eb 05                	jmp    5bd <printf+0x45>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b8:	83 ff 25             	cmp    $0x25,%edi
 5bb:	74 22                	je     5df <printf+0x67>
 5bd:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5c0:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5c4:	84 db                	test   %bl,%bl
 5c6:	0f 84 74 01 00 00    	je     740 <printf+0x1c8>
    c = fmt[i] & 0xff;
 5cc:	0f be d3             	movsbl %bl,%edx
 5cf:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5d2:	85 ff                	test   %edi,%edi
 5d4:	75 e2                	jne    5b8 <printf+0x40>
      if(c == '%'){
 5d6:	83 f8 25             	cmp    $0x25,%eax
 5d9:	75 c4                	jne    59f <printf+0x27>
        state = '%';
 5db:	89 c7                	mov    %eax,%edi
 5dd:	eb de                	jmp    5bd <printf+0x45>
      if(c == 'd'){
 5df:	83 f8 64             	cmp    $0x64,%eax
 5e2:	74 59                	je     63d <printf+0xc5>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5e4:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 5ea:	83 fa 70             	cmp    $0x70,%edx
 5ed:	74 7a                	je     669 <printf+0xf1>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5ef:	83 f8 73             	cmp    $0x73,%eax
 5f2:	0f 84 9d 00 00 00    	je     695 <printf+0x11d>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f8:	83 f8 63             	cmp    $0x63,%eax
 5fb:	0f 84 f2 00 00 00    	je     6f3 <printf+0x17b>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 601:	83 f8 25             	cmp    $0x25,%eax
 604:	0f 84 15 01 00 00    	je     71f <printf+0x1a7>
 60a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 60e:	83 ec 04             	sub    $0x4,%esp
 611:	6a 01                	push   $0x1
 613:	8d 45 e7             	lea    -0x19(%ebp),%eax
 616:	50                   	push   %eax
 617:	ff 75 08             	pushl  0x8(%ebp)
 61a:	e8 4f fe ff ff       	call   46e <write>
 61f:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 622:	83 c4 0c             	add    $0xc,%esp
 625:	6a 01                	push   $0x1
 627:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 62a:	50                   	push   %eax
 62b:	ff 75 08             	pushl  0x8(%ebp)
 62e:	e8 3b fe ff ff       	call   46e <write>
 633:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 636:	bf 00 00 00 00       	mov    $0x0,%edi
 63b:	eb 80                	jmp    5bd <printf+0x45>
        printint(fd, *ap, 10, 1);
 63d:	83 ec 0c             	sub    $0xc,%esp
 640:	6a 01                	push   $0x1
 642:	b9 0a 00 00 00       	mov    $0xa,%ecx
 647:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 64a:	8b 17                	mov    (%edi),%edx
 64c:	8b 45 08             	mov    0x8(%ebp),%eax
 64f:	e8 9a fe ff ff       	call   4ee <printint>
        ap++;
 654:	89 f8                	mov    %edi,%eax
 656:	83 c0 04             	add    $0x4,%eax
 659:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 65c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65f:	bf 00 00 00 00       	mov    $0x0,%edi
 664:	e9 54 ff ff ff       	jmp    5bd <printf+0x45>
        printint(fd, *ap, 16, 0);
 669:	83 ec 0c             	sub    $0xc,%esp
 66c:	6a 00                	push   $0x0
 66e:	b9 10 00 00 00       	mov    $0x10,%ecx
 673:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 676:	8b 17                	mov    (%edi),%edx
 678:	8b 45 08             	mov    0x8(%ebp),%eax
 67b:	e8 6e fe ff ff       	call   4ee <printint>
        ap++;
 680:	89 f8                	mov    %edi,%eax
 682:	83 c0 04             	add    $0x4,%eax
 685:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 688:	83 c4 10             	add    $0x10,%esp
      state = 0;
 68b:	bf 00 00 00 00       	mov    $0x0,%edi
 690:	e9 28 ff ff ff       	jmp    5bd <printf+0x45>
        s = (char*)*ap;
 695:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 698:	8b 01                	mov    (%ecx),%eax
        ap++;
 69a:	83 c1 04             	add    $0x4,%ecx
 69d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 6a0:	85 c0                	test   %eax,%eax
 6a2:	74 13                	je     6b7 <printf+0x13f>
        s = (char*)*ap;
 6a4:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 6a6:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 6a9:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 6ae:	84 c0                	test   %al,%al
 6b0:	75 0f                	jne    6c1 <printf+0x149>
 6b2:	e9 06 ff ff ff       	jmp    5bd <printf+0x45>
          s = "(null)";
 6b7:	bb c6 08 00 00       	mov    $0x8c6,%ebx
        while(*s != 0){
 6bc:	b8 28 00 00 00       	mov    $0x28,%eax
  write(fd, &c, 1);
 6c1:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 6c4:	89 75 d0             	mov    %esi,-0x30(%ebp)
 6c7:	8b 75 08             	mov    0x8(%ebp),%esi
 6ca:	88 45 e3             	mov    %al,-0x1d(%ebp)
 6cd:	83 ec 04             	sub    $0x4,%esp
 6d0:	6a 01                	push   $0x1
 6d2:	57                   	push   %edi
 6d3:	56                   	push   %esi
 6d4:	e8 95 fd ff ff       	call   46e <write>
          s++;
 6d9:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 6dc:	0f b6 03             	movzbl (%ebx),%eax
 6df:	83 c4 10             	add    $0x10,%esp
 6e2:	84 c0                	test   %al,%al
 6e4:	75 e4                	jne    6ca <printf+0x152>
 6e6:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 6e9:	bf 00 00 00 00       	mov    $0x0,%edi
 6ee:	e9 ca fe ff ff       	jmp    5bd <printf+0x45>
        putc(fd, *ap);
 6f3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6f6:	8b 07                	mov    (%edi),%eax
 6f8:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6fb:	83 ec 04             	sub    $0x4,%esp
 6fe:	6a 01                	push   $0x1
 700:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 703:	50                   	push   %eax
 704:	ff 75 08             	pushl  0x8(%ebp)
 707:	e8 62 fd ff ff       	call   46e <write>
        ap++;
 70c:	83 c7 04             	add    $0x4,%edi
 70f:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 712:	83 c4 10             	add    $0x10,%esp
      state = 0;
 715:	bf 00 00 00 00       	mov    $0x0,%edi
 71a:	e9 9e fe ff ff       	jmp    5bd <printf+0x45>
 71f:	88 5d e5             	mov    %bl,-0x1b(%ebp)
  write(fd, &c, 1);
 722:	83 ec 04             	sub    $0x4,%esp
 725:	6a 01                	push   $0x1
 727:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 72a:	50                   	push   %eax
 72b:	ff 75 08             	pushl  0x8(%ebp)
 72e:	e8 3b fd ff ff       	call   46e <write>
 733:	83 c4 10             	add    $0x10,%esp
      state = 0;
 736:	bf 00 00 00 00       	mov    $0x0,%edi
 73b:	e9 7d fe ff ff       	jmp    5bd <printf+0x45>
    }
  }
}
 740:	8d 65 f4             	lea    -0xc(%ebp),%esp
 743:	5b                   	pop    %ebx
 744:	5e                   	pop    %esi
 745:	5f                   	pop    %edi
 746:	5d                   	pop    %ebp
 747:	c3                   	ret    

00000748 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 748:	55                   	push   %ebp
 749:	89 e5                	mov    %esp,%ebp
 74b:	57                   	push   %edi
 74c:	56                   	push   %esi
 74d:	53                   	push   %ebx
 74e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 751:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 754:	a1 00 0c 00 00       	mov    0xc00,%eax
 759:	eb 0c                	jmp    767 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75b:	8b 10                	mov    (%eax),%edx
 75d:	39 c2                	cmp    %eax,%edx
 75f:	77 04                	ja     765 <free+0x1d>
 761:	39 ca                	cmp    %ecx,%edx
 763:	77 10                	ja     775 <free+0x2d>
{
 765:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 767:	39 c8                	cmp    %ecx,%eax
 769:	73 f0                	jae    75b <free+0x13>
 76b:	8b 10                	mov    (%eax),%edx
 76d:	39 ca                	cmp    %ecx,%edx
 76f:	77 04                	ja     775 <free+0x2d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 771:	39 c2                	cmp    %eax,%edx
 773:	77 f0                	ja     765 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 775:	8b 73 fc             	mov    -0x4(%ebx),%esi
 778:	8b 10                	mov    (%eax),%edx
 77a:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 77d:	39 fa                	cmp    %edi,%edx
 77f:	74 19                	je     79a <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 781:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 784:	8b 50 04             	mov    0x4(%eax),%edx
 787:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 78a:	39 f1                	cmp    %esi,%ecx
 78c:	74 1b                	je     7a9 <free+0x61>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 78e:	89 08                	mov    %ecx,(%eax)
  freep = p;
 790:	a3 00 0c 00 00       	mov    %eax,0xc00
}
 795:	5b                   	pop    %ebx
 796:	5e                   	pop    %esi
 797:	5f                   	pop    %edi
 798:	5d                   	pop    %ebp
 799:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 79a:	03 72 04             	add    0x4(%edx),%esi
 79d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a0:	8b 10                	mov    (%eax),%edx
 7a2:	8b 12                	mov    (%edx),%edx
 7a4:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7a7:	eb db                	jmp    784 <free+0x3c>
    p->s.size += bp->s.size;
 7a9:	03 53 fc             	add    -0x4(%ebx),%edx
 7ac:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7af:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7b2:	89 10                	mov    %edx,(%eax)
 7b4:	eb da                	jmp    790 <free+0x48>

000007b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b6:	55                   	push   %ebp
 7b7:	89 e5                	mov    %esp,%ebp
 7b9:	57                   	push   %edi
 7ba:	56                   	push   %esi
 7bb:	53                   	push   %ebx
 7bc:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7bf:	8b 45 08             	mov    0x8(%ebp),%eax
 7c2:	8d 58 07             	lea    0x7(%eax),%ebx
 7c5:	c1 eb 03             	shr    $0x3,%ebx
 7c8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 7cb:	8b 15 00 0c 00 00    	mov    0xc00,%edx
 7d1:	85 d2                	test   %edx,%edx
 7d3:	74 20                	je     7f5 <malloc+0x3f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d5:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7d7:	8b 48 04             	mov    0x4(%eax),%ecx
 7da:	39 cb                	cmp    %ecx,%ebx
 7dc:	76 3c                	jbe    81a <malloc+0x64>
 7de:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 7e4:	be 00 10 00 00       	mov    $0x1000,%esi
 7e9:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 7ec:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 7f3:	eb 70                	jmp    865 <malloc+0xaf>
    base.s.ptr = freep = prevp = &base;
 7f5:	c7 05 00 0c 00 00 04 	movl   $0xc04,0xc00
 7fc:	0c 00 00 
 7ff:	c7 05 04 0c 00 00 04 	movl   $0xc04,0xc04
 806:	0c 00 00 
    base.s.size = 0;
 809:	c7 05 08 0c 00 00 00 	movl   $0x0,0xc08
 810:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 813:	ba 04 0c 00 00       	mov    $0xc04,%edx
 818:	eb bb                	jmp    7d5 <malloc+0x1f>
      if(p->s.size == nunits)
 81a:	39 cb                	cmp    %ecx,%ebx
 81c:	74 1c                	je     83a <malloc+0x84>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 81e:	29 d9                	sub    %ebx,%ecx
 820:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 823:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 826:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 829:	89 15 00 0c 00 00    	mov    %edx,0xc00
      return (void*)(p + 1);
 82f:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 832:	8d 65 f4             	lea    -0xc(%ebp),%esp
 835:	5b                   	pop    %ebx
 836:	5e                   	pop    %esi
 837:	5f                   	pop    %edi
 838:	5d                   	pop    %ebp
 839:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 83a:	8b 08                	mov    (%eax),%ecx
 83c:	89 0a                	mov    %ecx,(%edx)
 83e:	eb e9                	jmp    829 <malloc+0x73>
  hp->s.size = nu;
 840:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 843:	83 ec 0c             	sub    $0xc,%esp
 846:	83 c0 08             	add    $0x8,%eax
 849:	50                   	push   %eax
 84a:	e8 f9 fe ff ff       	call   748 <free>
  return freep;
 84f:	8b 15 00 0c 00 00    	mov    0xc00,%edx
      if((p = morecore(nunits)) == 0)
 855:	83 c4 10             	add    $0x10,%esp
 858:	85 d2                	test   %edx,%edx
 85a:	74 2b                	je     887 <malloc+0xd1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 85e:	8b 48 04             	mov    0x4(%eax),%ecx
 861:	39 d9                	cmp    %ebx,%ecx
 863:	73 b5                	jae    81a <malloc+0x64>
 865:	89 c2                	mov    %eax,%edx
    if(p == freep)
 867:	39 05 00 0c 00 00    	cmp    %eax,0xc00
 86d:	75 ed                	jne    85c <malloc+0xa6>
  p = sbrk(nu * sizeof(Header));
 86f:	83 ec 0c             	sub    $0xc,%esp
 872:	57                   	push   %edi
 873:	e8 5e fc ff ff       	call   4d6 <sbrk>
  if(p == (char*)-1)
 878:	83 c4 10             	add    $0x10,%esp
 87b:	83 f8 ff             	cmp    $0xffffffff,%eax
 87e:	75 c0                	jne    840 <malloc+0x8a>
        return 0;
 880:	b8 00 00 00 00       	mov    $0x0,%eax
 885:	eb ab                	jmp    832 <malloc+0x7c>
 887:	b8 00 00 00 00       	mov    $0x0,%eax
 88c:	eb a4                	jmp    832 <malloc+0x7c>


_INIT:     file format elf32-i386


Disassembly of section .text:

000000b4 <fork>:
  b4:	f3 0f 1e fb          	endbr32 
  b8:	b8 01 00 00 00       	mov    $0x1,%eax
  bd:	8b 1c 24             	mov    (%esp),%ebx
  c0:	cd 80                	int    $0x80
  c2:	85 c0                	test   %eax,%eax
  c4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c9:	0f 48 c2             	cmovs  %edx,%eax
  cc:	c3                   	ret    

000000cd <exit>:
  cd:	f3 0f 1e fb          	endbr32 
  d1:	b8 00 00 00 00       	mov    $0x0,%eax
  d6:	8b 1c 24             	mov    (%esp),%ebx
  d9:	cd 80                	int    $0x80

000000db <wait>:
  db:	f3 0f 1e fb          	endbr32 
  df:	b8 02 00 00 00       	mov    $0x2,%eax
  e4:	8b 1c 24             	mov    (%esp),%ebx
  e7:	cd 80                	int    $0x80
  e9:	85 c0                	test   %eax,%eax
  eb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  f0:	0f 48 c2             	cmovs  %edx,%eax
  f3:	c3                   	ret    

000000f4 <yield>:
  f4:	f3 0f 1e fb          	endbr32 
  f8:	b8 03 00 00 00       	mov    $0x3,%eax
  fd:	8b 1c 24             	mov    (%esp),%ebx
 100:	cd 80                	int    $0x80
 102:	85 c0                	test   %eax,%eax
 104:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 109:	0f 48 c2             	cmovs  %edx,%eax
 10c:	c3                   	ret    

0000010d <time>:
 10d:	f3 0f 1e fb          	endbr32 
 111:	b8 05 00 00 00       	mov    $0x5,%eax
 116:	8b 1c 24             	mov    (%esp),%ebx
 119:	cd 80                	int    $0x80
 11b:	85 c0                	test   %eax,%eax
 11d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 122:	0f 48 c2             	cmovs  %edx,%eax
 125:	c3                   	ret    

00000126 <getpid>:
 126:	f3 0f 1e fb          	endbr32 
 12a:	b8 06 00 00 00       	mov    $0x6,%eax
 12f:	8b 1c 24             	mov    (%esp),%ebx
 132:	cd 80                	int    $0x80
 134:	85 c0                	test   %eax,%eax
 136:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 13b:	0f 48 c2             	cmovs  %edx,%eax
 13e:	c3                   	ret    

0000013f <sleep>:
 13f:	f3 0f 1e fb          	endbr32 
 143:	53                   	push   %ebx
 144:	b8 07 00 00 00       	mov    $0x7,%eax
 149:	8b 5c 24 08          	mov    0x8(%esp),%ebx
 14d:	cd 80                	int    $0x80
 14f:	85 c0                	test   %eax,%eax
 151:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 156:	0f 48 c2             	cmovs  %edx,%eax
 159:	5b                   	pop    %ebx
 15a:	c3                   	ret    

0000015b <printf>:
 15b:	f3 0f 1e fb          	endbr32 
 15f:	53                   	push   %ebx
 160:	b8 08 00 00 00       	mov    $0x8,%eax
 165:	8b 5c 24 08          	mov    0x8(%esp),%ebx
 169:	cd 80                	int    $0x80
 16b:	85 c0                	test   %eax,%eax
 16d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 172:	0f 48 c2             	cmovs  %edx,%eax
 175:	5b                   	pop    %ebx
 176:	c3                   	ret    

00000177 <exec>:
 177:	f3 0f 1e fb          	endbr32 
 17b:	53                   	push   %ebx
 17c:	b8 04 00 00 00       	mov    $0x4,%eax
 181:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
 185:	8b 5c 24 08          	mov    0x8(%esp),%ebx
 189:	cd 80                	int    $0x80
 18b:	85 c0                	test   %eax,%eax
 18d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 192:	0f 48 c2             	cmovs  %edx,%eax
 195:	5b                   	pop    %ebx
 196:	c3                   	ret    

00000197 <main>:
 197:	f3 0f 1e fb          	endbr32 
 19b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 19f:	83 e4 f0             	and    $0xfffffff0,%esp
 1a2:	ff 71 fc             	pushl  -0x4(%ecx)
 1a5:	55                   	push   %ebp
 1a6:	89 e5                	mov    %esp,%ebp
 1a8:	53                   	push   %ebx
 1a9:	51                   	push   %ecx
 1aa:	e8 05 ff ff ff       	call   b4 <fork>
 1af:	89 c3                	mov    %eax,%ebx
 1b1:	85 c0                	test   %eax,%eax
 1b3:	7e 1c                	jle    1d1 <main+0x3a>
 1b5:	83 ec 0c             	sub    $0xc,%esp
 1b8:	6a 01                	push   $0x1
 1ba:	e8 80 ff ff ff       	call   13f <sleep>
 1bf:	89 1c 24             	mov    %ebx,(%esp)
 1c2:	e8 94 ff ff ff       	call   15b <printf>
 1c7:	e8 28 ff ff ff       	call   f4 <yield>
 1cc:	83 c4 10             	add    $0x10,%esp
 1cf:	eb e4                	jmp    1b5 <main+0x1e>
 1d1:	75 20                	jne    1f3 <main+0x5c>
 1d3:	83 ec 0c             	sub    $0xc,%esp
 1d6:	6a 01                	push   $0x1
 1d8:	e8 62 ff ff ff       	call   13f <sleep>
 1dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1e4:	e8 72 ff ff ff       	call   15b <printf>
 1e9:	e8 06 ff ff ff       	call   f4 <yield>
 1ee:	83 c4 10             	add    $0x10,%esp
 1f1:	eb e0                	jmp    1d3 <main+0x3c>
 1f3:	eb fe                	jmp    1f3 <main+0x5c>

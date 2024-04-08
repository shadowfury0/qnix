
kernel.o:     file format elf32-i386


Disassembly of section .text:

80100074 <vgaputc>:
80100074:	f3 0f 1e fb          	endbr32 
80100078:	57                   	push   %edi
80100079:	56                   	push   %esi
8010007a:	53                   	push   %ebx
8010007b:	8b 5c 24 10          	mov    0x10(%esp),%ebx
8010007f:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100084:	b8 0e 00 00 00       	mov    $0xe,%eax
80100089:	89 fa                	mov    %edi,%edx
8010008b:	ee                   	out    %al,(%dx)
8010008c:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100091:	89 ca                	mov    %ecx,%edx
80100093:	ec                   	in     (%dx),%al
80100094:	0f b6 c0             	movzbl %al,%eax
80100097:	c1 e0 08             	shl    $0x8,%eax
8010009a:	89 c6                	mov    %eax,%esi
8010009c:	b8 0f 00 00 00       	mov    $0xf,%eax
801000a1:	89 fa                	mov    %edi,%edx
801000a3:	ee                   	out    %al,(%dx)
801000a4:	89 ca                	mov    %ecx,%edx
801000a6:	ec                   	in     (%dx),%al
801000a7:	0f b6 c0             	movzbl %al,%eax
801000aa:	09 f0                	or     %esi,%eax
801000ac:	80 fb 0a             	cmp    $0xa,%bl
801000af:	74 23                	je     801000d4 <vgaputc+0x60>
801000b1:	8d 70 ff             	lea    -0x1(%eax),%esi
801000b4:	80 fb 08             	cmp    $0x8,%bl
801000b7:	74 2e                	je     801000e7 <vgaputc+0x73>
801000b9:	8d 70 04             	lea    0x4(%eax),%esi
801000bc:	80 fb 09             	cmp    $0x9,%bl
801000bf:	74 26                	je     801000e7 <vgaputc+0x73>
801000c1:	8d 70 01             	lea    0x1(%eax),%esi
801000c4:	0f b6 db             	movzbl %bl,%ebx
801000c7:	80 cf 07             	or     $0x7,%bh
801000ca:	66 89 9c 00 00 80 0b 	mov    %bx,0xb8000(%eax,%eax,1)
801000d1:	00 
801000d2:	eb 13                	jmp    801000e7 <vgaputc+0x73>
801000d4:	ba 67 66 66 66       	mov    $0x66666667,%edx
801000d9:	f7 ea                	imul   %edx
801000db:	c1 fa 05             	sar    $0x5,%edx
801000de:	8d 04 92             	lea    (%edx,%edx,4),%eax
801000e1:	c1 e0 04             	shl    $0x4,%eax
801000e4:	8d 70 50             	lea    0x50(%eax),%esi
801000e7:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
801000ed:	7f 43                	jg     80100132 <vgaputc+0xbe>
801000ef:	81 fe d1 07 00 00    	cmp    $0x7d1,%esi
801000f5:	b8 00 00 00 00       	mov    $0x0,%eax
801000fa:	0f 43 f0             	cmovae %eax,%esi
801000fd:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100102:	b8 0e 00 00 00       	mov    $0xe,%eax
80100107:	89 da                	mov    %ebx,%edx
80100109:	ee                   	out    %al,(%dx)
8010010a:	89 f0                	mov    %esi,%eax
8010010c:	c1 f8 08             	sar    $0x8,%eax
8010010f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100114:	89 ca                	mov    %ecx,%edx
80100116:	ee                   	out    %al,(%dx)
80100117:	b8 0f 00 00 00       	mov    $0xf,%eax
8010011c:	89 da                	mov    %ebx,%edx
8010011e:	ee                   	out    %al,(%dx)
8010011f:	89 f0                	mov    %esi,%eax
80100121:	89 ca                	mov    %ecx,%edx
80100123:	ee                   	out    %al,(%dx)
80100124:	66 c7 84 36 00 80 0b 	movw   $0x720,0xb8000(%esi,%esi,1)
8010012b:	00 20 07 
8010012e:	5b                   	pop    %ebx
8010012f:	5e                   	pop    %esi
80100130:	5f                   	pop    %edi
80100131:	c3                   	ret    
80100132:	83 ec 04             	sub    $0x4,%esp
80100135:	68 60 0e 00 00       	push   $0xe60
8010013a:	68 a0 80 0b 00       	push   $0xb80a0
8010013f:	68 00 80 0b 00       	push   $0xb8000
80100144:	e8 7c 06 00 00       	call   801007c5 <memmove>
80100149:	83 ee 50             	sub    $0x50,%esi
8010014c:	b8 80 07 00 00       	mov    $0x780,%eax
80100151:	29 f0                	sub    %esi,%eax
80100153:	01 c0                	add    %eax,%eax
80100155:	8d 94 36 00 80 0b 00 	lea    0xb8000(%esi,%esi,1),%edx
8010015c:	83 c4 0c             	add    $0xc,%esp
8010015f:	50                   	push   %eax
80100160:	6a 00                	push   $0x0
80100162:	52                   	push   %edx
80100163:	e8 b1 06 00 00       	call   80100819 <memset>
80100168:	83 c4 10             	add    $0x10,%esp
8010016b:	eb 82                	jmp    801000ef <vgaputc+0x7b>

8010016d <printint>:
8010016d:	f3 0f 1e fb          	endbr32 
80100171:	56                   	push   %esi
80100172:	53                   	push   %ebx
80100173:	83 ec 14             	sub    $0x14,%esp
80100176:	8b 54 24 20          	mov    0x20(%esp),%edx
8010017a:	8b 74 24 24          	mov    0x24(%esp),%esi
8010017e:	b9 00 00 00 00       	mov    $0x0,%ecx
80100183:	89 cb                	mov    %ecx,%ebx
80100185:	83 c1 01             	add    $0x1,%ecx
80100188:	89 d0                	mov    %edx,%eax
8010018a:	99                   	cltd   
8010018b:	f7 fe                	idiv   %esi
8010018d:	0f b6 92 88 1a 10 80 	movzbl -0x7fefe578(%edx),%edx
80100194:	88 54 0c ff          	mov    %dl,-0x1(%esp,%ecx,1)
80100198:	89 c2                	mov    %eax,%edx
8010019a:	85 c0                	test   %eax,%eax
8010019c:	75 e5                	jne    80100183 <printint+0x16>
8010019e:	85 db                	test   %ebx,%ebx
801001a0:	78 1c                	js     801001be <printint+0x51>
801001a2:	89 e6                	mov    %esp,%esi
801001a4:	01 f3                	add    %esi,%ebx
801001a6:	83 ec 0c             	sub    $0xc,%esp
801001a9:	0f b6 03             	movzbl (%ebx),%eax
801001ac:	50                   	push   %eax
801001ad:	e8 c2 fe ff ff       	call   80100074 <vgaputc>
801001b2:	89 d8                	mov    %ebx,%eax
801001b4:	83 eb 01             	sub    $0x1,%ebx
801001b7:	83 c4 10             	add    $0x10,%esp
801001ba:	39 f0                	cmp    %esi,%eax
801001bc:	75 e8                	jne    801001a6 <printint+0x39>
801001be:	83 c4 14             	add    $0x14,%esp
801001c1:	5b                   	pop    %ebx
801001c2:	5e                   	pop    %esi
801001c3:	c3                   	ret    

801001c4 <vprintf>:
801001c4:	f3 0f 1e fb          	endbr32 
801001c8:	55                   	push   %ebp
801001c9:	57                   	push   %edi
801001ca:	56                   	push   %esi
801001cb:	53                   	push   %ebx
801001cc:	83 ec 1c             	sub    $0x1c,%esp
801001cf:	8b 7c 24 30          	mov    0x30(%esp),%edi
801001d3:	85 ff                	test   %edi,%edi
801001d5:	0f 84 1c 01 00 00    	je     801002f7 <vprintf+0x133>
801001db:	0f b6 17             	movzbl (%edi),%edx
801001de:	0f b6 c2             	movzbl %dl,%eax
801001e1:	85 c0                	test   %eax,%eax
801001e3:	0f 84 0e 01 00 00    	je     801002f7 <vprintf+0x133>
801001e9:	bb 00 00 00 00       	mov    $0x0,%ebx
801001ee:	8d 6c 24 34          	lea    0x34(%esp),%ebp
801001f2:	eb 21                	jmp    80100215 <vprintf+0x51>
801001f4:	83 ec 0c             	sub    $0xc,%esp
801001f7:	0f b6 d2             	movzbl %dl,%edx
801001fa:	52                   	push   %edx
801001fb:	e8 74 fe ff ff       	call   80100074 <vgaputc>
80100200:	83 c4 10             	add    $0x10,%esp
80100203:	83 c3 01             	add    $0x1,%ebx
80100206:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
8010020a:	0f b6 c2             	movzbl %dl,%eax
8010020d:	85 c0                	test   %eax,%eax
8010020f:	0f 84 e2 00 00 00    	je     801002f7 <vprintf+0x133>
80100215:	83 f8 25             	cmp    $0x25,%eax
80100218:	75 da                	jne    801001f4 <vprintf+0x30>
8010021a:	83 c3 01             	add    $0x1,%ebx
8010021d:	0f b6 34 1f          	movzbl (%edi,%ebx,1),%esi
80100221:	89 f0                	mov    %esi,%eax
80100223:	0f b6 c0             	movzbl %al,%eax
80100226:	89 f1                	mov    %esi,%ecx
80100228:	80 f9 70             	cmp    $0x70,%cl
8010022b:	74 38                	je     80100265 <vprintf+0xa1>
8010022d:	83 f8 70             	cmp    $0x70,%eax
80100230:	7f 29                	jg     8010025b <vprintf+0x97>
80100232:	83 f8 25             	cmp    $0x25,%eax
80100235:	0f 84 8b 00 00 00    	je     801002c6 <vprintf+0x102>
8010023b:	83 f8 64             	cmp    $0x64,%eax
8010023e:	0f 85 94 00 00 00    	jne    801002d8 <vprintf+0x114>
80100244:	8d 75 04             	lea    0x4(%ebp),%esi
80100247:	83 ec 08             	sub    $0x8,%esp
8010024a:	6a 0a                	push   $0xa
8010024c:	ff 75 00             	pushl  0x0(%ebp)
8010024f:	e8 19 ff ff ff       	call   8010016d <printint>
80100254:	83 c4 10             	add    $0x10,%esp
80100257:	89 f5                	mov    %esi,%ebp
80100259:	eb a8                	jmp    80100203 <vprintf+0x3f>
8010025b:	83 f8 73             	cmp    $0x73,%eax
8010025e:	74 1c                	je     8010027c <vprintf+0xb8>
80100260:	83 f8 78             	cmp    $0x78,%eax
80100263:	75 73                	jne    801002d8 <vprintf+0x114>
80100265:	8d 75 04             	lea    0x4(%ebp),%esi
80100268:	83 ec 08             	sub    $0x8,%esp
8010026b:	6a 10                	push   $0x10
8010026d:	ff 75 00             	pushl  0x0(%ebp)
80100270:	e8 f8 fe ff ff       	call   8010016d <printint>
80100275:	83 c4 10             	add    $0x10,%esp
80100278:	89 f5                	mov    %esi,%ebp
8010027a:	eb 87                	jmp    80100203 <vprintf+0x3f>
8010027c:	8d 4d 04             	lea    0x4(%ebp),%ecx
8010027f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80100283:	8b 45 00             	mov    0x0(%ebp),%eax
80100286:	85 c0                	test   %eax,%eax
80100288:	74 10                	je     8010029a <vprintf+0xd6>
8010028a:	89 c6                	mov    %eax,%esi
8010028c:	0f b6 00             	movzbl (%eax),%eax
8010028f:	89 cd                	mov    %ecx,%ebp
80100291:	84 c0                	test   %al,%al
80100293:	75 0f                	jne    801002a4 <vprintf+0xe0>
80100295:	e9 69 ff ff ff       	jmp    80100203 <vprintf+0x3f>
8010029a:	be 80 1a 10 80       	mov    $0x80101a80,%esi
8010029f:	b8 28 00 00 00       	mov    $0x28,%eax
801002a4:	83 ec 0c             	sub    $0xc,%esp
801002a7:	0f b6 c0             	movzbl %al,%eax
801002aa:	50                   	push   %eax
801002ab:	e8 c4 fd ff ff       	call   80100074 <vgaputc>
801002b0:	83 c6 01             	add    $0x1,%esi
801002b3:	0f b6 06             	movzbl (%esi),%eax
801002b6:	83 c4 10             	add    $0x10,%esp
801002b9:	84 c0                	test   %al,%al
801002bb:	75 e7                	jne    801002a4 <vprintf+0xe0>
801002bd:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
801002c1:	e9 3d ff ff ff       	jmp    80100203 <vprintf+0x3f>
801002c6:	83 ec 0c             	sub    $0xc,%esp
801002c9:	6a 25                	push   $0x25
801002cb:	e8 a4 fd ff ff       	call   80100074 <vgaputc>
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	e9 2b ff ff ff       	jmp    80100203 <vprintf+0x3f>
801002d8:	83 ec 0c             	sub    $0xc,%esp
801002db:	6a 25                	push   $0x25
801002dd:	e8 92 fd ff ff       	call   80100074 <vgaputc>
801002e2:	89 f0                	mov    %esi,%eax
801002e4:	0f b6 f0             	movzbl %al,%esi
801002e7:	89 34 24             	mov    %esi,(%esp)
801002ea:	e8 85 fd ff ff       	call   80100074 <vgaputc>
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	e9 0c ff ff ff       	jmp    80100203 <vprintf+0x3f>
801002f7:	83 c4 1c             	add    $0x1c,%esp
801002fa:	5b                   	pop    %ebx
801002fb:	5e                   	pop    %esi
801002fc:	5f                   	pop    %edi
801002fd:	5d                   	pop    %ebp
801002fe:	c3                   	ret    

801002ff <cpuid>:
801002ff:	f3 0f 1e fb          	endbr32 
80100303:	57                   	push   %edi
80100304:	56                   	push   %esi
80100305:	53                   	push   %ebx
80100306:	8b 74 24 14          	mov    0x14(%esp),%esi
8010030a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
8010030e:	8b 44 24 10          	mov    0x10(%esp),%eax
80100312:	89 06                	mov    %eax,(%esi)
80100314:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
8010031a:	8b 06                	mov    (%esi),%eax
8010031c:	b9 00 00 00 00       	mov    $0x0,%ecx
80100321:	0f a2                	cpuid  
80100323:	89 06                	mov    %eax,(%esi)
80100325:	8b 44 24 18          	mov    0x18(%esp),%eax
80100329:	89 18                	mov    %ebx,(%eax)
8010032b:	89 0f                	mov    %ecx,(%edi)
8010032d:	8b 44 24 20          	mov    0x20(%esp),%eax
80100331:	89 10                	mov    %edx,(%eax)
80100333:	5b                   	pop    %ebx
80100334:	5e                   	pop    %esi
80100335:	5f                   	pop    %edi
80100336:	c3                   	ret    

80100337 <cpuinfo>:
80100337:	f3 0f 1e fb          	endbr32 
8010033b:	57                   	push   %edi
8010033c:	56                   	push   %esi
8010033d:	53                   	push   %ebx
8010033e:	83 ec 18             	sub    $0x18,%esp
80100341:	c6 44 24 17 00       	movb   $0x0,0x17(%esp)
80100346:	c7 44 24 0f 00 00 00 	movl   $0x0,0xf(%esp)
8010034d:	00 
8010034e:	bf 00 00 00 00       	mov    $0x0,%edi
80100353:	89 f8                	mov    %edi,%eax
80100355:	89 f9                	mov    %edi,%ecx
80100357:	0f a2                	cpuid  
80100359:	89 5c 24 0b          	mov    %ebx,0xb(%esp)
8010035d:	89 4c 24 0f          	mov    %ecx,0xf(%esp)
80100361:	89 54 24 13          	mov    %edx,0x13(%esp)
80100365:	8d 74 24 0b          	lea    0xb(%esp),%esi
80100369:	56                   	push   %esi
8010036a:	68 99 1a 10 80       	push   $0x80101a99
8010036f:	e8 50 fe ff ff       	call   801001c4 <vprintf>
80100374:	c7 44 24 17 00 00 00 	movl   $0x0,0x17(%esp)
8010037b:	00 
8010037c:	b8 02 00 00 80       	mov    $0x80000002,%eax
80100381:	89 f9                	mov    %edi,%ecx
80100383:	0f a2                	cpuid  
80100385:	89 5c 24 13          	mov    %ebx,0x13(%esp)
80100389:	89 4c 24 17          	mov    %ecx,0x17(%esp)
8010038d:	89 54 24 1b          	mov    %edx,0x1b(%esp)
80100391:	83 c4 08             	add    $0x8,%esp
80100394:	56                   	push   %esi
80100395:	68 99 1a 10 80       	push   $0x80101a99
8010039a:	e8 25 fe ff ff       	call   801001c4 <vprintf>
8010039f:	c7 44 24 17 00 00 00 	movl   $0x0,0x17(%esp)
801003a6:	00 
801003a7:	b8 03 00 00 80       	mov    $0x80000003,%eax
801003ac:	89 f9                	mov    %edi,%ecx
801003ae:	0f a2                	cpuid  
801003b0:	89 5c 24 13          	mov    %ebx,0x13(%esp)
801003b4:	89 4c 24 17          	mov    %ecx,0x17(%esp)
801003b8:	89 54 24 1b          	mov    %edx,0x1b(%esp)
801003bc:	83 c4 08             	add    $0x8,%esp
801003bf:	56                   	push   %esi
801003c0:	68 7c 1d 10 80       	push   $0x80101d7c
801003c5:	e8 fa fd ff ff       	call   801001c4 <vprintf>
801003ca:	83 c4 20             	add    $0x20,%esp
801003cd:	5b                   	pop    %ebx
801003ce:	5e                   	pop    %esi
801003cf:	5f                   	pop    %edi
801003d0:	c3                   	ret    

801003d1 <exec>:
801003d1:	f3 0f 1e fb          	endbr32 
801003d5:	83 ec 14             	sub    $0x14,%esp
801003d8:	ff 74 24 18          	pushl  0x18(%esp)
801003dc:	68 9d 1a 10 80       	push   $0x80101a9d
801003e1:	e8 de fd ff ff       	call   801001c4 <vprintf>
801003e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801003eb:	83 c4 1c             	add    $0x1c,%esp
801003ee:	c3                   	ret    

801003ef <do_int0>:
801003ef:	68 c0 0f 10 80       	push   $0x80100fc0

801003f4 <no_error>:
801003f4:	87 04 24             	xchg   %eax,(%esp)
801003f7:	53                   	push   %ebx
801003f8:	51                   	push   %ecx
801003f9:	52                   	push   %edx
801003fa:	57                   	push   %edi
801003fb:	56                   	push   %esi
801003fc:	55                   	push   %ebp
801003fd:	1e                   	push   %ds
801003fe:	06                   	push   %es
801003ff:	0f a0                	push   %fs
80100401:	8d 54 24 28          	lea    0x28(%esp),%edx
80100405:	52                   	push   %edx
80100406:	ba 08 00 00 00       	mov    $0x8,%edx
8010040b:	8e da                	mov    %edx,%ds
8010040d:	8e c2                	mov    %edx,%es
8010040f:	8e e2                	mov    %edx,%fs
80100411:	ff d0                	call   *%eax
80100413:	83 c4 04             	add    $0x4,%esp
80100416:	0f a1                	pop    %fs
80100418:	07                   	pop    %es
80100419:	1f                   	pop    %ds
8010041a:	5d                   	pop    %ebp
8010041b:	5e                   	pop    %esi
8010041c:	5f                   	pop    %edi
8010041d:	5a                   	pop    %edx
8010041e:	59                   	pop    %ecx
8010041f:	5b                   	pop    %ebx
80100420:	58                   	pop    %eax
80100421:	cf                   	iret   

80100422 <do_int1>:
80100422:	68 c0 0f 10 80       	push   $0x80100fc0
80100427:	eb cb                	jmp    801003f4 <no_error>

80100429 <do_int2>:
80100429:	68 d5 0f 10 80       	push   $0x80100fd5
8010042e:	eb c4                	jmp    801003f4 <no_error>

80100430 <do_int3>:
80100430:	68 ea 0f 10 80       	push   $0x80100fea
80100435:	eb bd                	jmp    801003f4 <no_error>

80100437 <do_int4>:
80100437:	68 44 10 10 80       	push   $0x80101044
8010043c:	eb b6                	jmp    801003f4 <no_error>

8010043e <do_int5>:
8010043e:	68 59 10 10 80       	push   $0x80101059
80100443:	eb af                	jmp    801003f4 <no_error>

80100445 <do_int6>:
80100445:	68 6e 10 10 80       	push   $0x8010106e
8010044a:	eb a8                	jmp    801003f4 <no_error>

8010044c <do_int7>:
8010044c:	68 83 10 10 80       	push   $0x80101083
80100451:	eb a1                	jmp    801003f4 <no_error>

80100453 <do_int8>:
80100453:	68 98 10 10 80       	push   $0x80101098
80100458:	eb 9a                	jmp    801003f4 <no_error>

8010045a <do_int9>:
8010045a:	68 ad 10 10 80       	push   $0x801010ad
8010045f:	eb 93                	jmp    801003f4 <no_error>

80100461 <do_int10>:
80100461:	68 c2 10 10 80       	push   $0x801010c2
80100466:	eb 8c                	jmp    801003f4 <no_error>

80100468 <do_int11>:
80100468:	68 d7 10 10 80       	push   $0x801010d7
8010046d:	eb 85                	jmp    801003f4 <no_error>

8010046f <do_int12>:
8010046f:	68 ec 10 10 80       	push   $0x801010ec
80100474:	e9 7b ff ff ff       	jmp    801003f4 <no_error>

80100479 <do_int13>:
80100479:	68 01 11 10 80       	push   $0x80101101
8010047e:	e9 71 ff ff ff       	jmp    801003f4 <no_error>

80100483 <do_int14>:
80100483:	68 16 11 10 80       	push   $0x80101116
80100488:	e9 67 ff ff ff       	jmp    801003f4 <no_error>

8010048d <do_int16>:
8010048d:	68 2b 11 10 80       	push   $0x8010112b
80100492:	e9 5d ff ff ff       	jmp    801003f4 <no_error>

80100497 <do_other>:
80100497:	68 ab 0f 10 80       	push   $0x80100fab
8010049c:	e9 53 ff ff ff       	jmp    801003f4 <no_error>

801004a1 <keyboard_interrupt>:
801004a1:	68 c8 06 10 80       	push   $0x801006c8
801004a6:	e9 49 ff ff ff       	jmp    801003f4 <no_error>

801004ab <rtc_interrupt>:
801004ab:	68 8f 0e 10 80       	push   $0x80100e8f
801004b0:	e9 3f ff ff ff       	jmp    801003f4 <no_error>

801004b5 <init_welcome>:
801004b5:	f3 0f 1e fb          	endbr32 
801004b9:	83 ec 18             	sub    $0x18,%esp
801004bc:	ff 35 00 40 10 80    	pushl  0x80104000
801004c2:	e8 fd fc ff ff       	call   801001c4 <vprintf>
801004c7:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801004ce:	e8 a1 fb ff ff       	call   80100074 <vgaputc>
801004d3:	83 c4 1c             	add    $0x1c,%esp
801004d6:	c3                   	ret    

801004d7 <main>:
801004d7:	f3 0f 1e fb          	endbr32 
801004db:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801004df:	83 e4 f0             	and    $0xfffffff0,%esp
801004e2:	ff 71 fc             	pushl  -0x4(%ecx)
801004e5:	55                   	push   %ebp
801004e6:	89 e5                	mov    %esp,%ebp
801004e8:	51                   	push   %ecx
801004e9:	83 ec 0c             	sub    $0xc,%esp
801004ec:	68 00 00 40 80       	push   $0x80400000
801004f1:	68 74 54 10 80       	push   $0x80105474
801004f6:	e8 25 01 00 00       	call   80100620 <kminit>
801004fb:	e8 1f 12 00 00       	call   8010171f <kvminit>
80100500:	e8 74 11 00 00       	call   80101679 <seginit>
80100505:	e8 20 04 00 00       	call   8010092a <proc_init>
8010050a:	e8 31 0c 00 00       	call   80101140 <init_idt>
8010050f:	e8 02 0f 00 00       	call   80101416 <init_pic>
80100514:	e8 60 01 00 00       	call   80100679 <init_keyboard>
80100519:	e8 03 08 00 00       	call   80100d21 <init_rtc>
8010051e:	e8 92 ff ff ff       	call   801004b5 <init_welcome>
80100523:	e8 0f fe ff ff       	call   80100337 <cpuinfo>
80100528:	c7 04 24 a9 1a 10 80 	movl   $0x80101aa9,(%esp)
8010052f:	e8 90 fc ff ff       	call   801001c4 <vprintf>
80100534:	e8 e0 04 00 00       	call   80100a19 <user_init>
80100539:	fb                   	sti    
8010053a:	e8 51 03 00 00       	call   80100890 <schedule>
8010053f:	83 c4 10             	add    $0x10,%esp
80100542:	8b 4d fc             	mov    -0x4(%ebp),%ecx
80100545:	c9                   	leave  
80100546:	8d 61 fc             	lea    -0x4(%ecx),%esp
80100549:	c3                   	ret    

8010054a <kfree>:
8010054a:	f3 0f 1e fb          	endbr32 
8010054e:	57                   	push   %edi
8010054f:	53                   	push   %ebx
80100550:	83 ec 04             	sub    $0x4,%esp
80100553:	8b 5c 24 10          	mov    0x10(%esp),%ebx
80100557:	c7 03 01 01 01 01    	movl   $0x1010101,(%ebx)
8010055d:	c7 83 fc 0f 00 00 01 	movl   $0x1010101,0xffc(%ebx)
80100564:	01 01 01 
80100567:	8d 7b 04             	lea    0x4(%ebx),%edi
8010056a:	83 e7 fc             	and    $0xfffffffc,%edi
8010056d:	89 d9                	mov    %ebx,%ecx
8010056f:	29 f9                	sub    %edi,%ecx
80100571:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80100577:	c1 e9 02             	shr    $0x2,%ecx
8010057a:	b8 01 01 01 01       	mov    $0x1010101,%eax
8010057f:	f3 ab                	rep stos %eax,%es:(%edi)
80100581:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80100587:	75 15                	jne    8010059e <kfree+0x54>
80100589:	81 fb 74 54 10 80    	cmp    $0x80105474,%ebx
8010058f:	72 0d                	jb     8010059e <kfree+0x54>
80100591:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80100597:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
8010059c:	76 10                	jbe    801005ae <kfree+0x64>
8010059e:	83 ec 0c             	sub    $0xc,%esp
801005a1:	68 48 1c 10 80       	push   $0x80101c48
801005a6:	e8 cd 02 00 00       	call   80100878 <panic>
801005ab:	83 c4 10             	add    $0x10,%esp
801005ae:	a1 24 40 10 80       	mov    0x80104024,%eax
801005b3:	89 03                	mov    %eax,(%ebx)
801005b5:	89 1d 24 40 10 80    	mov    %ebx,0x80104024
801005bb:	83 c4 04             	add    $0x4,%esp
801005be:	5b                   	pop    %ebx
801005bf:	5f                   	pop    %edi
801005c0:	c3                   	ret    

801005c1 <freerange>:
801005c1:	f3 0f 1e fb          	endbr32 
801005c5:	56                   	push   %esi
801005c6:	53                   	push   %ebx
801005c7:	83 ec 04             	sub    $0x4,%esp
801005ca:	8b 74 24 14          	mov    0x14(%esp),%esi
801005ce:	8b 44 24 10          	mov    0x10(%esp),%eax
801005d2:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801005d8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801005de:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801005e4:	39 de                	cmp    %ebx,%esi
801005e6:	72 1c                	jb     80100604 <freerange+0x43>
801005e8:	83 ec 0c             	sub    $0xc,%esp
801005eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801005f1:	50                   	push   %eax
801005f2:	e8 53 ff ff ff       	call   8010054a <kfree>
801005f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801005fd:	83 c4 10             	add    $0x10,%esp
80100600:	39 f3                	cmp    %esi,%ebx
80100602:	76 e4                	jbe    801005e8 <freerange+0x27>
80100604:	83 c4 04             	add    $0x4,%esp
80100607:	5b                   	pop    %ebx
80100608:	5e                   	pop    %esi
80100609:	c3                   	ret    

8010060a <kalloc>:
8010060a:	f3 0f 1e fb          	endbr32 
8010060e:	a1 24 40 10 80       	mov    0x80104024,%eax
80100613:	85 c0                	test   %eax,%eax
80100615:	74 08                	je     8010061f <kalloc+0x15>
80100617:	8b 10                	mov    (%eax),%edx
80100619:	89 15 24 40 10 80    	mov    %edx,0x80104024
8010061f:	c3                   	ret    

80100620 <kminit>:
80100620:	f3 0f 1e fb          	endbr32 
80100624:	83 ec 14             	sub    $0x14,%esp
80100627:	c7 05 24 40 10 80 00 	movl   $0x0,0x80104024
8010062e:	00 00 00 
80100631:	ff 74 24 1c          	pushl  0x1c(%esp)
80100635:	ff 74 24 1c          	pushl  0x1c(%esp)
80100639:	e8 83 ff ff ff       	call   801005c1 <freerange>
8010063e:	83 c4 1c             	add    $0x1c,%esp
80100641:	c3                   	ret    

80100642 <entry>:
80100642:	0f 20 e0             	mov    %cr4,%eax
80100645:	83 c8 10             	or     $0x10,%eax
80100648:	0f 22 e0             	mov    %eax,%cr4
8010064b:	b8 00 30 10 00       	mov    $0x103000,%eax
80100650:	0f 22 d8             	mov    %eax,%cr3
80100653:	0f 20 c0             	mov    %cr0,%eax
80100656:	0d 00 00 01 80       	or     $0x80010000,%eax
8010065b:	0f 22 c0             	mov    %eax,%cr0
8010065e:	bc 30 50 10 80       	mov    $0x80105030,%esp
80100663:	b8 d7 04 10 80       	mov    $0x801004d7,%eax
80100668:	ff e0                	jmp    *%eax

8010066a <wait_kybc_sendready>:
8010066a:	f3 0f 1e fb          	endbr32 
8010066e:	ba 64 00 00 00       	mov    $0x64,%edx
80100673:	ec                   	in     (%dx),%al
80100674:	a8 02                	test   $0x2,%al
80100676:	75 fb                	jne    80100673 <wait_kybc_sendready+0x9>
80100678:	c3                   	ret    

80100679 <init_keyboard>:
80100679:	f3 0f 1e fb          	endbr32 
8010067d:	53                   	push   %ebx
8010067e:	e8 e7 ff ff ff       	call   8010066a <wait_kybc_sendready>
80100683:	bb 64 00 00 00       	mov    $0x64,%ebx
80100688:	b8 60 00 00 00       	mov    $0x60,%eax
8010068d:	89 da                	mov    %ebx,%edx
8010068f:	ee                   	out    %al,(%dx)
80100690:	e8 d5 ff ff ff       	call   8010066a <wait_kybc_sendready>
80100695:	b8 47 00 00 00       	mov    $0x47,%eax
8010069a:	89 da                	mov    %ebx,%edx
8010069c:	ee                   	out    %al,(%dx)
8010069d:	c7 05 60 50 10 80 00 	movl   $0x0,0x80105060
801006a4:	00 00 00 
801006a7:	c7 05 64 50 10 80 00 	movl   $0x0,0x80105064
801006ae:	00 00 00 
801006b1:	c6 05 41 50 10 80 00 	movb   $0x0,0x80105041
801006b8:	c6 05 42 50 10 80 00 	movb   $0x0,0x80105042
801006bf:	c6 05 40 50 10 80 00 	movb   $0x0,0x80105040
801006c6:	5b                   	pop    %ebx
801006c7:	c3                   	ret    

801006c8 <keygetc>:
801006c8:	f3 0f 1e fb          	endbr32 
801006cc:	83 ec 0c             	sub    $0xc,%esp
801006cf:	fa                   	cli    
801006d0:	a1 64 50 10 80       	mov    0x80105064,%eax
801006d5:	8b 15 60 50 10 80    	mov    0x80105060,%edx
801006db:	83 e8 01             	sub    $0x1,%eax
801006de:	29 d0                	sub    %edx,%eax
801006e0:	a8 1f                	test   $0x1f,%al
801006e2:	74 1f                	je     80100703 <keygetc+0x3b>
801006e4:	8b 0d 60 50 10 80    	mov    0x80105060,%ecx
801006ea:	ba 60 00 00 00       	mov    $0x60,%edx
801006ef:	ec                   	in     (%dx),%al
801006f0:	88 81 68 50 10 80    	mov    %al,-0x7fefaf98(%ecx)
801006f6:	a1 60 50 10 80       	mov    0x80105060,%eax
801006fb:	83 c0 01             	add    $0x1,%eax
801006fe:	a3 60 50 10 80       	mov    %eax,0x80105060
80100703:	e8 78 0d 00 00       	call   80101480 <piceoi>
80100708:	fb                   	sti    
80100709:	83 c4 0c             	add    $0xc,%esp
8010070c:	c3                   	ret    

8010070d <keyputc>:
8010070d:	f3 0f 1e fb          	endbr32 
80100711:	8b 15 60 50 10 80    	mov    0x80105060,%edx
80100717:	a1 64 50 10 80       	mov    0x80105064,%eax
8010071c:	39 c2                	cmp    %eax,%edx
8010071e:	74 4e                	je     8010076e <keyputc+0x61>
80100720:	a1 64 50 10 80       	mov    0x80105064,%eax
80100725:	0f b6 80 68 50 10 80 	movzbl -0x7fefaf98(%eax),%eax
8010072c:	8b 15 64 50 10 80    	mov    0x80105064,%edx
80100732:	83 c2 01             	add    $0x1,%edx
80100735:	89 15 64 50 10 80    	mov    %edx,0x80105064
8010073b:	3c 2a                	cmp    $0x2a,%al
8010073d:	74 24                	je     80100763 <keyputc+0x56>
8010073f:	3c 36                	cmp    $0x36,%al
80100741:	74 20                	je     80100763 <keyputc+0x56>
80100743:	3c aa                	cmp    $0xaa,%al
80100745:	74 28                	je     8010076f <keyputc+0x62>
80100747:	3c b6                	cmp    $0xb6,%al
80100749:	74 24                	je     8010076f <keyputc+0x62>
8010074b:	3c 1d                	cmp    $0x1d,%al
8010074d:	74 29                	je     80100778 <keyputc+0x6b>
8010074f:	3c 9d                	cmp    $0x9d,%al
80100751:	74 55                	je     801007a8 <keyputc+0x9b>
80100753:	3c 38                	cmp    $0x38,%al
80100755:	74 59                	je     801007b0 <keyputc+0xa3>
80100757:	3c b8                	cmp    $0xb8,%al
80100759:	75 0f                	jne    8010076a <keyputc+0x5d>
8010075b:	c6 05 42 50 10 80 00 	movb   $0x0,0x80105042
80100762:	c3                   	ret    
80100763:	c6 05 41 50 10 80 01 	movb   $0x1,0x80105041
8010076a:	3c 58                	cmp    $0x58,%al
8010076c:	76 11                	jbe    8010077f <keyputc+0x72>
8010076e:	c3                   	ret    
8010076f:	c6 05 41 50 10 80 00 	movb   $0x0,0x80105041
80100776:	eb f2                	jmp    8010076a <keyputc+0x5d>
80100778:	c6 05 40 50 10 80 01 	movb   $0x1,0x80105040
8010077f:	0f b6 15 41 50 10 80 	movzbl 0x80105041,%edx
80100786:	84 d2                	test   %dl,%dl
80100788:	74 2f                	je     801007b9 <keyputc+0xac>
8010078a:	0f b6 c0             	movzbl %al,%eax
8010078d:	0f b6 80 60 1c 10 80 	movzbl -0x7fefe3a0(%eax),%eax
80100794:	84 c0                	test   %al,%al
80100796:	74 d6                	je     8010076e <keyputc+0x61>
80100798:	83 ec 18             	sub    $0x18,%esp
8010079b:	0f b6 c0             	movzbl %al,%eax
8010079e:	50                   	push   %eax
8010079f:	e8 d0 f8 ff ff       	call   80100074 <vgaputc>
801007a4:	83 c4 1c             	add    $0x1c,%esp
801007a7:	c3                   	ret    
801007a8:	c6 05 40 50 10 80 00 	movb   $0x0,0x80105040
801007af:	c3                   	ret    
801007b0:	c6 05 42 50 10 80 01 	movb   $0x1,0x80105042
801007b7:	eb c6                	jmp    8010077f <keyputc+0x72>
801007b9:	0f b6 c0             	movzbl %al,%eax
801007bc:	0f b6 80 c0 1c 10 80 	movzbl -0x7fefe340(%eax),%eax
801007c3:	eb cf                	jmp    80100794 <keyputc+0x87>

801007c5 <memmove>:
801007c5:	f3 0f 1e fb          	endbr32 
801007c9:	56                   	push   %esi
801007ca:	53                   	push   %ebx
801007cb:	8b 74 24 0c          	mov    0xc(%esp),%esi
801007cf:	8b 44 24 10          	mov    0x10(%esp),%eax
801007d3:	8b 4c 24 14          	mov    0x14(%esp),%ecx
801007d7:	39 f0                	cmp    %esi,%eax
801007d9:	72 1f                	jb     801007fa <memmove+0x35>
801007db:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
801007de:	89 f2                	mov    %esi,%edx
801007e0:	85 c9                	test   %ecx,%ecx
801007e2:	74 11                	je     801007f5 <memmove+0x30>
801007e4:	83 c0 01             	add    $0x1,%eax
801007e7:	83 c2 01             	add    $0x1,%edx
801007ea:	0f b6 48 ff          	movzbl -0x1(%eax),%ecx
801007ee:	88 4a ff             	mov    %cl,-0x1(%edx)
801007f1:	39 d8                	cmp    %ebx,%eax
801007f3:	75 ef                	jne    801007e4 <memmove+0x1f>
801007f5:	89 f0                	mov    %esi,%eax
801007f7:	5b                   	pop    %ebx
801007f8:	5e                   	pop    %esi
801007f9:	c3                   	ret    
801007fa:	8d 14 08             	lea    (%eax,%ecx,1),%edx
801007fd:	39 d6                	cmp    %edx,%esi
801007ff:	73 da                	jae    801007db <memmove+0x16>
80100801:	8d 51 ff             	lea    -0x1(%ecx),%edx
80100804:	85 c9                	test   %ecx,%ecx
80100806:	74 ed                	je     801007f5 <memmove+0x30>
80100808:	0f b6 0c 10          	movzbl (%eax,%edx,1),%ecx
8010080c:	88 0c 16             	mov    %cl,(%esi,%edx,1)
8010080f:	83 ea 01             	sub    $0x1,%edx
80100812:	83 fa ff             	cmp    $0xffffffff,%edx
80100815:	75 f1                	jne    80100808 <memmove+0x43>
80100817:	eb dc                	jmp    801007f5 <memmove+0x30>

80100819 <memset>:
80100819:	f3 0f 1e fb          	endbr32 
8010081d:	57                   	push   %edi
8010081e:	53                   	push   %ebx
8010081f:	8b 54 24 0c          	mov    0xc(%esp),%edx
80100823:	8b 44 24 10          	mov    0x10(%esp),%eax
80100827:	8b 4c 24 14          	mov    0x14(%esp),%ecx
8010082b:	89 d7                	mov    %edx,%edi
8010082d:	09 cf                	or     %ecx,%edi
8010082f:	f7 c7 03 00 00 00    	test   $0x3,%edi
80100835:	75 1e                	jne    80100855 <memset+0x3c>
80100837:	0f b6 f8             	movzbl %al,%edi
8010083a:	c1 e9 02             	shr    $0x2,%ecx
8010083d:	c1 e0 18             	shl    $0x18,%eax
80100840:	89 fb                	mov    %edi,%ebx
80100842:	c1 e3 10             	shl    $0x10,%ebx
80100845:	09 d8                	or     %ebx,%eax
80100847:	09 f8                	or     %edi,%eax
80100849:	c1 e7 08             	shl    $0x8,%edi
8010084c:	09 f8                	or     %edi,%eax
8010084e:	89 d7                	mov    %edx,%edi
80100850:	fc                   	cld    
80100851:	f3 ab                	rep stos %eax,%es:(%edi)
80100853:	eb 05                	jmp    8010085a <memset+0x41>
80100855:	89 d7                	mov    %edx,%edi
80100857:	fc                   	cld    
80100858:	f3 aa                	rep stos %al,%es:(%edi)
8010085a:	89 d0                	mov    %edx,%eax
8010085c:	5b                   	pop    %ebx
8010085d:	5f                   	pop    %edi
8010085e:	c3                   	ret    

8010085f <memcpy>:
8010085f:	f3 0f 1e fb          	endbr32 
80100863:	ff 74 24 0c          	pushl  0xc(%esp)
80100867:	ff 74 24 0c          	pushl  0xc(%esp)
8010086b:	ff 74 24 0c          	pushl  0xc(%esp)
8010086f:	e8 51 ff ff ff       	call   801007c5 <memmove>
80100874:	83 c4 0c             	add    $0xc,%esp
80100877:	c3                   	ret    

80100878 <panic>:
80100878:	f3 0f 1e fb          	endbr32 
8010087c:	56                   	push   %esi
8010087d:	5e                   	pop    %esi
8010087e:	83 ec 18             	sub    $0x18,%esp
80100881:	ff 74 24 1c          	pushl  0x1c(%esp)
80100885:	e8 3a f9 ff ff       	call   801001c4 <vprintf>
8010088a:	fa                   	cli    
8010088b:	83 c4 10             	add    $0x10,%esp
8010088e:	eb fe                	jmp    8010088e <panic+0x16>

80100890 <schedule>:
80100890:	f3 0f 1e fb          	endbr32 
80100894:	53                   	push   %ebx
80100895:	83 ec 08             	sub    $0x8,%esp
80100898:	bb c0 50 10 80       	mov    $0x801050c0,%ebx
8010089d:	eb 11                	jmp    801008b0 <schedule+0x20>
8010089f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
801008a5:	83 c3 74             	add    $0x74,%ebx
801008a8:	81 fb 60 54 10 80    	cmp    $0x80105460,%ebx
801008ae:	74 2b                	je     801008db <schedule+0x4b>
801008b0:	8b 03                	mov    (%ebx),%eax
801008b2:	83 f8 01             	cmp    $0x1,%eax
801008b5:	74 e8                	je     8010089f <schedule+0xf>
801008b7:	8b 03                	mov    (%ebx),%eax
801008b9:	83 f8 03             	cmp    $0x3,%eax
801008bc:	75 e7                	jne    801008a5 <schedule+0x15>
801008be:	89 1d a0 50 10 80    	mov    %ebx,0x801050a0
801008c4:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
801008ca:	83 ec 0c             	sub    $0xc,%esp
801008cd:	8d 43 0c             	lea    0xc(%ebx),%eax
801008d0:	50                   	push   %eax
801008d1:	e8 5f 06 00 00       	call   80100f35 <swtch>
801008d6:	83 c4 10             	add    $0x10,%esp
801008d9:	eb ca                	jmp    801008a5 <schedule+0x15>
801008db:	bb c0 50 10 80       	mov    $0x801050c0,%ebx
801008e0:	eb 0b                	jmp    801008ed <schedule+0x5d>
801008e2:	83 c3 74             	add    $0x74,%ebx
801008e5:	81 fb 60 54 10 80    	cmp    $0x80105460,%ebx
801008eb:	74 ab                	je     80100898 <schedule+0x8>
801008ed:	8b 03                	mov    (%ebx),%eax
801008ef:	83 f8 05             	cmp    $0x5,%eax
801008f2:	75 ee                	jne    801008e2 <schedule+0x52>
801008f4:	8b 43 08             	mov    0x8(%ebx),%eax
801008f7:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
801008fd:	8b 43 44             	mov    0x44(%ebx),%eax
80100900:	83 ec 0c             	sub    $0xc,%esp
80100903:	83 e8 01             	sub    $0x1,%eax
80100906:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010090b:	50                   	push   %eax
8010090c:	e8 39 fc ff ff       	call   8010054a <kfree>
80100911:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100917:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
8010091e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
80100925:	83 c4 10             	add    $0x10,%esp
80100928:	eb b8                	jmp    801008e2 <schedule+0x52>

8010092a <proc_init>:
8010092a:	f3 0f 1e fb          	endbr32 
8010092e:	c7 05 20 40 10 80 00 	movl   $0x0,0x80104020
80100935:	00 00 00 
80100938:	c7 05 a0 50 10 80 00 	movl   $0x0,0x801050a0
8010093f:	00 00 00 
80100942:	ba 18 00 00 00       	mov    $0x18,%edx
80100947:	89 d0                	mov    %edx,%eax
80100949:	03 05 6c 54 10 80    	add    0x8010546c,%eax
8010094f:	66 c7 00 00 00       	movw   $0x0,(%eax)
80100954:	66 c7 40 02 00 00    	movw   $0x0,0x2(%eax)
8010095a:	c6 40 04 00          	movb   $0x0,0x4(%eax)
8010095e:	c6 40 05 90          	movb   $0x90,0x5(%eax)
80100962:	c6 40 06 c0          	movb   $0xc0,0x6(%eax)
80100966:	c6 40 07 00          	movb   $0x0,0x7(%eax)
8010096a:	83 c2 08             	add    $0x8,%edx
8010096d:	83 fa 40             	cmp    $0x40,%edx
80100970:	75 d5                	jne    80100947 <proc_init+0x1d>
80100972:	c3                   	ret    

80100973 <allocproc>:
80100973:	f3 0f 1e fb          	endbr32 
80100977:	53                   	push   %ebx
80100978:	83 ec 08             	sub    $0x8,%esp
8010097b:	bb c0 50 10 80       	mov    $0x801050c0,%ebx
80100980:	8b 03                	mov    (%ebx),%eax
80100982:	85 c0                	test   %eax,%eax
80100984:	74 29                	je     801009af <allocproc+0x3c>
80100986:	83 c3 74             	add    $0x74,%ebx
80100989:	81 fb 60 54 10 80    	cmp    $0x80105460,%ebx
8010098f:	75 ef                	jne    80100980 <allocproc+0xd>
80100991:	83 ec 08             	sub    $0x8,%esp
80100994:	6a 08                	push   $0x8
80100996:	68 1c 1d 10 80       	push   $0x80101d1c
8010099b:	e8 24 f8 ff ff       	call   801001c4 <vprintf>
801009a0:	83 c4 10             	add    $0x10,%esp
801009a3:	bb 00 00 00 00       	mov    $0x0,%ebx
801009a8:	89 d8                	mov    %ebx,%eax
801009aa:	83 c4 08             	add    $0x8,%esp
801009ad:	5b                   	pop    %ebx
801009ae:	c3                   	ret    
801009af:	e8 56 fc ff ff       	call   8010060a <kalloc>
801009b4:	89 43 44             	mov    %eax,0x44(%ebx)
801009b7:	85 c0                	test   %eax,%eax
801009b9:	74 51                	je     80100a0c <allocproc+0x99>
801009bb:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
801009c1:	8b 15 20 40 10 80    	mov    0x80104020,%edx
801009c7:	8d 4a 01             	lea    0x1(%edx),%ecx
801009ca:	89 0d 20 40 10 80    	mov    %ecx,0x80104020
801009d0:	83 e2 0f             	and    $0xf,%edx
801009d3:	89 53 04             	mov    %edx,0x4(%ebx)
801009d6:	05 00 10 00 00       	add    $0x1000,%eax
801009db:	89 43 44             	mov    %eax,0x44(%ebx)
801009de:	a1 a0 50 10 80       	mov    0x801050a0,%eax
801009e3:	89 43 08             	mov    %eax,0x8(%ebx)
801009e6:	66 c7 43 54 10 00    	movw   $0x10,0x54(%ebx)
801009ec:	66 c7 43 58 08 00    	movw   $0x8,0x58(%ebx)
801009f2:	66 c7 43 5c 10 00    	movw   $0x10,0x5c(%ebx)
801009f8:	66 c7 43 60 10 00    	movw   $0x10,0x60(%ebx)
801009fe:	66 c7 43 64 10 00    	movw   $0x10,0x64(%ebx)
80100a04:	66 c7 43 68 10 00    	movw   $0x10,0x68(%ebx)
80100a0a:	eb 9c                	jmp    801009a8 <allocproc+0x35>
80100a0c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100a12:	bb 00 00 00 00       	mov    $0x0,%ebx
80100a17:	eb 8f                	jmp    801009a8 <allocproc+0x35>

80100a19 <user_init>:
80100a19:	f3 0f 1e fb          	endbr32 
80100a1d:	53                   	push   %ebx
80100a1e:	83 ec 08             	sub    $0x8,%esp
80100a21:	e8 4d ff ff ff       	call   80100973 <allocproc>
80100a26:	89 c3                	mov    %eax,%ebx
80100a28:	85 c0                	test   %eax,%eax
80100a2a:	74 1b                	je     80100a47 <user_init+0x2e>
80100a2c:	c7 43 2c ed 14 10 80 	movl   $0x801014ed,0x2c(%ebx)
80100a33:	89 1d a0 50 10 80    	mov    %ebx,0x801050a0
80100a39:	89 5b 08             	mov    %ebx,0x8(%ebx)
80100a3c:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
80100a42:	83 c4 08             	add    $0x8,%esp
80100a45:	5b                   	pop    %ebx
80100a46:	c3                   	ret    
80100a47:	83 ec 0c             	sub    $0xc,%esp
80100a4a:	68 4b 1d 10 80       	push   $0x80101d4b
80100a4f:	e8 24 fe ff ff       	call   80100878 <panic>
80100a54:	83 c4 10             	add    $0x10,%esp
80100a57:	eb d3                	jmp    80100a2c <user_init+0x13>

80100a59 <fork1>:
80100a59:	f3 0f 1e fb          	endbr32 
80100a5d:	57                   	push   %edi
80100a5e:	56                   	push   %esi
80100a5f:	83 ec 04             	sub    $0x4,%esp
80100a62:	e8 0c ff ff ff       	call   80100973 <allocproc>
80100a67:	85 c0                	test   %eax,%eax
80100a69:	0f 84 83 00 00 00    	je     80100af2 <fork1+0x99>
80100a6f:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
80100a75:	8b 54 24 28          	mov    0x28(%esp),%edx
80100a79:	89 50 2c             	mov    %edx,0x2c(%eax)
80100a7c:	8b 15 a0 50 10 80    	mov    0x801050a0,%edx
80100a82:	8b 72 44             	mov    0x44(%edx),%esi
80100a85:	8b 78 44             	mov    0x44(%eax),%edi
80100a88:	8d 57 ff             	lea    -0x1(%edi),%edx
80100a8b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80100a91:	83 ee 01             	sub    $0x1,%esi
80100a94:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100a9a:	b9 00 04 00 00       	mov    $0x400,%ecx
80100a9f:	89 d7                	mov    %edx,%edi
80100aa1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80100aa3:	c7 40 34 00 00 00 00 	movl   $0x0,0x34(%eax)
80100aaa:	8b 15 a0 50 10 80    	mov    0x801050a0,%edx
80100ab0:	8b 52 44             	mov    0x44(%edx),%edx
80100ab3:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
80100ab7:	29 d1                	sub    %edx,%ecx
80100ab9:	8d 51 04             	lea    0x4(%ecx),%edx
80100abc:	01 50 44             	add    %edx,0x44(%eax)
80100abf:	8b 54 24 24          	mov    0x24(%esp),%edx
80100ac3:	89 50 38             	mov    %edx,0x38(%eax)
80100ac6:	8b 54 24 20          	mov    0x20(%esp),%edx
80100aca:	89 50 3c             	mov    %edx,0x3c(%eax)
80100acd:	8b 54 24 1c          	mov    0x1c(%esp),%edx
80100ad1:	89 50 40             	mov    %edx,0x40(%eax)
80100ad4:	8b 54 24 18          	mov    0x18(%esp),%edx
80100ad8:	89 50 48             	mov    %edx,0x48(%eax)
80100adb:	8b 54 24 14          	mov    0x14(%esp),%edx
80100adf:	89 50 4c             	mov    %edx,0x4c(%eax)
80100ae2:	8b 54 24 10          	mov    0x10(%esp),%edx
80100ae6:	89 50 50             	mov    %edx,0x50(%eax)
80100ae9:	8b 40 04             	mov    0x4(%eax),%eax
80100aec:	83 c4 04             	add    $0x4,%esp
80100aef:	5e                   	pop    %esi
80100af0:	5f                   	pop    %edi
80100af1:	c3                   	ret    
80100af2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100af7:	eb f3                	jmp    80100aec <fork1+0x93>

80100af9 <kill>:
80100af9:	f3 0f 1e fb          	endbr32 
80100afd:	8b 54 24 04          	mov    0x4(%esp),%edx
80100b01:	b8 c0 50 10 80       	mov    $0x801050c0,%eax
80100b06:	39 50 04             	cmp    %edx,0x4(%eax)
80100b09:	74 10                	je     80100b1b <kill+0x22>
80100b0b:	83 c0 74             	add    $0x74,%eax
80100b0e:	3d 60 54 10 80       	cmp    $0x80105460,%eax
80100b13:	75 f1                	jne    80100b06 <kill+0xd>
80100b15:	b8 01 00 00 00       	mov    $0x1,%eax
80100b1a:	c3                   	ret    
80100b1b:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
80100b21:	b8 00 00 00 00       	mov    $0x0,%eax
80100b26:	c3                   	ret    

80100b27 <wakeup>:
80100b27:	f3 0f 1e fb          	endbr32 
80100b2b:	8b 44 24 04          	mov    0x4(%esp),%eax
80100b2f:	8b 10                	mov    (%eax),%edx
80100b31:	83 fa 02             	cmp    $0x2,%edx
80100b34:	74 01                	je     80100b37 <wakeup+0x10>
80100b36:	c3                   	ret    
80100b37:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
80100b3d:	eb f7                	jmp    80100b36 <wakeup+0xf>

80100b3f <exit>:
80100b3f:	f3 0f 1e fb          	endbr32 
80100b43:	53                   	push   %ebx
80100b44:	83 ec 08             	sub    $0x8,%esp
80100b47:	8b 1d a0 50 10 80    	mov    0x801050a0,%ebx
80100b4d:	39 5b 08             	cmp    %ebx,0x8(%ebx)
80100b50:	74 28                	je     80100b7a <exit+0x3b>
80100b52:	83 ec 0c             	sub    $0xc,%esp
80100b55:	ff 73 08             	pushl  0x8(%ebx)
80100b58:	e8 ca ff ff ff       	call   80100b27 <wakeup>
80100b5d:	c7 43 2c 90 08 10 80 	movl   $0x80100890,0x2c(%ebx)
80100b64:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
80100b6a:	83 c3 0c             	add    $0xc,%ebx
80100b6d:	89 1c 24             	mov    %ebx,(%esp)
80100b70:	e8 c0 03 00 00       	call   80100f35 <swtch>
80100b75:	83 c4 18             	add    $0x18,%esp
80100b78:	5b                   	pop    %ebx
80100b79:	c3                   	ret    
80100b7a:	83 ec 0c             	sub    $0xc,%esp
80100b7d:	68 5b 1d 10 80       	push   $0x80101d5b
80100b82:	e8 f1 fc ff ff       	call   80100878 <panic>
80100b87:	83 c4 10             	add    $0x10,%esp
80100b8a:	eb c6                	jmp    80100b52 <exit+0x13>

80100b8c <wait1>:
80100b8c:	f3 0f 1e fb          	endbr32 
80100b90:	83 ec 0c             	sub    $0xc,%esp
80100b93:	83 3d a0 50 10 80 00 	cmpl   $0x0,0x801050a0
80100b9a:	74 7f                	je     80100c1b <wait1+0x8f>
80100b9c:	8b 0d c8 50 10 80    	mov    0x801050c8,%ecx
80100ba2:	a1 a0 50 10 80       	mov    0x801050a0,%eax
80100ba7:	3d c0 50 10 80       	cmp    $0x801050c0,%eax
80100bac:	74 09                	je     80100bb7 <wait1+0x2b>
80100bae:	ba c0 50 10 80       	mov    $0x801050c0,%edx
80100bb3:	39 c1                	cmp    %eax,%ecx
80100bb5:	74 10                	je     80100bc7 <wait1+0x3b>
80100bb7:	ba 34 51 10 80       	mov    $0x80105134,%edx
80100bbc:	8b 4a 08             	mov    0x8(%edx),%ecx
80100bbf:	39 d0                	cmp    %edx,%eax
80100bc1:	74 6d                	je     80100c30 <wait1+0xa4>
80100bc3:	39 c1                	cmp    %eax,%ecx
80100bc5:	75 69                	jne    80100c30 <wait1+0xa4>
80100bc7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
80100bcd:	a1 a0 50 10 80       	mov    0x801050a0,%eax
80100bd2:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
80100bd6:	89 48 2c             	mov    %ecx,0x2c(%eax)
80100bd9:	8b 4c 24 30          	mov    0x30(%esp),%ecx
80100bdd:	83 c1 04             	add    $0x4,%ecx
80100be0:	89 48 44             	mov    %ecx,0x44(%eax)
80100be3:	8b 4c 24 28          	mov    0x28(%esp),%ecx
80100be7:	89 48 34             	mov    %ecx,0x34(%eax)
80100bea:	8b 4c 24 24          	mov    0x24(%esp),%ecx
80100bee:	89 48 38             	mov    %ecx,0x38(%eax)
80100bf1:	8b 4c 24 20          	mov    0x20(%esp),%ecx
80100bf5:	89 48 3c             	mov    %ecx,0x3c(%eax)
80100bf8:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
80100bfc:	89 48 40             	mov    %ecx,0x40(%eax)
80100bff:	8b 4c 24 18          	mov    0x18(%esp),%ecx
80100c03:	89 48 48             	mov    %ecx,0x48(%eax)
80100c06:	8b 4c 24 10          	mov    0x10(%esp),%ecx
80100c0a:	89 48 50             	mov    %ecx,0x50(%eax)
80100c0d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
80100c11:	89 48 4c             	mov    %ecx,0x4c(%eax)
80100c14:	8b 42 04             	mov    0x4(%edx),%eax
80100c17:	83 c4 0c             	add    $0xc,%esp
80100c1a:	c3                   	ret    
80100c1b:	83 ec 0c             	sub    $0xc,%esp
80100c1e:	68 68 1d 10 80       	push   $0x80101d68
80100c23:	e8 50 fc ff ff       	call   80100878 <panic>
80100c28:	83 c4 10             	add    $0x10,%esp
80100c2b:	e9 6c ff ff ff       	jmp    80100b9c <wait1+0x10>
80100c30:	83 c2 74             	add    $0x74,%edx
80100c33:	81 fa 60 54 10 80    	cmp    $0x80105460,%edx
80100c39:	75 81                	jne    80100bbc <wait1+0x30>
80100c3b:	b8 00 00 00 00       	mov    $0x0,%eax
80100c40:	eb d5                	jmp    80100c17 <wait1+0x8b>

80100c42 <yield1>:
80100c42:	f3 0f 1e fb          	endbr32 
80100c46:	a1 a0 50 10 80       	mov    0x801050a0,%eax
80100c4b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80100c51:	a1 a0 50 10 80       	mov    0x801050a0,%eax
80100c56:	8b 54 24 20          	mov    0x20(%esp),%edx
80100c5a:	89 50 2c             	mov    %edx,0x2c(%eax)
80100c5d:	8b 4c 24 24          	mov    0x24(%esp),%ecx
80100c61:	8d 51 04             	lea    0x4(%ecx),%edx
80100c64:	89 50 44             	mov    %edx,0x44(%eax)
80100c67:	8b 54 24 0c          	mov    0xc(%esp),%edx
80100c6b:	89 50 48             	mov    %edx,0x48(%eax)
80100c6e:	8b 54 24 04          	mov    0x4(%esp),%edx
80100c72:	89 50 50             	mov    %edx,0x50(%eax)
80100c75:	8b 54 24 08          	mov    0x8(%esp),%edx
80100c79:	89 50 4c             	mov    %edx,0x4c(%eax)
80100c7c:	8b 54 24 1c          	mov    0x1c(%esp),%edx
80100c80:	89 50 34             	mov    %edx,0x34(%eax)
80100c83:	8b 54 24 18          	mov    0x18(%esp),%edx
80100c87:	89 50 38             	mov    %edx,0x38(%eax)
80100c8a:	8b 54 24 14          	mov    0x14(%esp),%edx
80100c8e:	89 50 3c             	mov    %edx,0x3c(%eax)
80100c91:	8b 54 24 10          	mov    0x10(%esp),%edx
80100c95:	89 50 40             	mov    %edx,0x40(%eax)
80100c98:	c3                   	ret    

80100c99 <procdump>:
80100c99:	f3 0f 1e fb          	endbr32 
80100c9d:	56                   	push   %esi
80100c9e:	53                   	push   %ebx
80100c9f:	83 ec 04             	sub    $0x4,%esp
80100ca2:	bb c0 50 10 80       	mov    $0x801050c0,%ebx
80100ca7:	be 6e 1d 10 80       	mov    $0x80101d6e,%esi
80100cac:	eb 22                	jmp    80100cd0 <procdump+0x37>
80100cae:	50                   	push   %eax
80100caf:	8b 43 08             	mov    0x8(%ebx),%eax
80100cb2:	ff 70 04             	pushl  0x4(%eax)
80100cb5:	ff 73 04             	pushl  0x4(%ebx)
80100cb8:	68 72 1d 10 80       	push   $0x80101d72
80100cbd:	e8 02 f5 ff ff       	call   801001c4 <vprintf>
80100cc2:	83 c4 10             	add    $0x10,%esp
80100cc5:	83 c3 74             	add    $0x74,%ebx
80100cc8:	81 fb 60 54 10 80    	cmp    $0x80105460,%ebx
80100cce:	74 28                	je     80100cf8 <procdump+0x5f>
80100cd0:	8b 03                	mov    (%ebx),%eax
80100cd2:	85 c0                	test   %eax,%eax
80100cd4:	74 ef                	je     80100cc5 <procdump+0x2c>
80100cd6:	8b 03                	mov    (%ebx),%eax
80100cd8:	8b 13                	mov    (%ebx),%edx
80100cda:	89 f0                	mov    %esi,%eax
80100cdc:	83 fa 05             	cmp    $0x5,%edx
80100cdf:	77 cd                	ja     80100cae <procdump+0x15>
80100ce1:	8b 13                	mov    (%ebx),%edx
80100ce3:	83 3c 95 b0 1d 10 80 	cmpl   $0x0,-0x7fefe250(,%edx,4)
80100cea:	00 
80100ceb:	74 c1                	je     80100cae <procdump+0x15>
80100ced:	8b 03                	mov    (%ebx),%eax
80100cef:	8b 04 85 b0 1d 10 80 	mov    -0x7fefe250(,%eax,4),%eax
80100cf6:	eb b6                	jmp    80100cae <procdump+0x15>
80100cf8:	83 c4 04             	add    $0x4,%esp
80100cfb:	5b                   	pop    %ebx
80100cfc:	5e                   	pop    %esi
80100cfd:	c3                   	ret    

80100cfe <getpid>:
80100cfe:	f3 0f 1e fb          	endbr32 
80100d02:	a1 a0 50 10 80       	mov    0x801050a0,%eax
80100d07:	8b 40 04             	mov    0x4(%eax),%eax
80100d0a:	c3                   	ret    

80100d0b <rtc_dump>:
80100d0b:	f3 0f 1e fb          	endbr32 
80100d0f:	b8 0c 00 00 00       	mov    $0xc,%eax
80100d14:	ba 70 00 00 00       	mov    $0x70,%edx
80100d19:	ee                   	out    %al,(%dx)
80100d1a:	ba 71 00 00 00       	mov    $0x71,%edx
80100d1f:	ec                   	in     (%dx),%al
80100d20:	c3                   	ret    

80100d21 <init_rtc>:
80100d21:	f3 0f 1e fb          	endbr32 
80100d25:	c7 05 68 54 10 80 00 	movl   $0x0,0x80105468
80100d2c:	00 00 00 
80100d2f:	b8 8b ff ff ff       	mov    $0xffffff8b,%eax
80100d34:	ba 70 00 00 00       	mov    $0x70,%edx
80100d39:	ee                   	out    %al,(%dx)
80100d3a:	ba 71 00 00 00       	mov    $0x71,%edx
80100d3f:	ec                   	in     (%dx),%al
80100d40:	83 c8 40             	or     $0x40,%eax
80100d43:	ee                   	out    %al,(%dx)
80100d44:	b8 12 00 00 00       	mov    $0x12,%eax
80100d49:	ee                   	out    %al,(%dx)
80100d4a:	e8 bc ff ff ff       	call   80100d0b <rtc_dump>
80100d4f:	c3                   	ret    

80100d50 <rtc_date>:
80100d50:	f3 0f 1e fb          	endbr32 
80100d54:	55                   	push   %ebp
80100d55:	57                   	push   %edi
80100d56:	56                   	push   %esi
80100d57:	53                   	push   %ebx
80100d58:	83 ec 08             	sub    $0x8,%esp
80100d5b:	bb 70 00 00 00       	mov    $0x70,%ebx
80100d60:	b8 00 00 00 00       	mov    $0x0,%eax
80100d65:	89 da                	mov    %ebx,%edx
80100d67:	ee                   	out    %al,(%dx)
80100d68:	b9 71 00 00 00       	mov    $0x71,%ecx
80100d6d:	89 ca                	mov    %ecx,%edx
80100d6f:	ec                   	in     (%dx),%al
80100d70:	89 c5                	mov    %eax,%ebp
80100d72:	a2 60 54 10 80       	mov    %al,0x80105460
80100d77:	b8 02 00 00 00       	mov    $0x2,%eax
80100d7c:	89 da                	mov    %ebx,%edx
80100d7e:	ee                   	out    %al,(%dx)
80100d7f:	89 ca                	mov    %ecx,%edx
80100d81:	ec                   	in     (%dx),%al
80100d82:	89 c7                	mov    %eax,%edi
80100d84:	a2 61 54 10 80       	mov    %al,0x80105461
80100d89:	b8 04 00 00 00       	mov    $0x4,%eax
80100d8e:	89 da                	mov    %ebx,%edx
80100d90:	ee                   	out    %al,(%dx)
80100d91:	89 ca                	mov    %ecx,%edx
80100d93:	ec                   	in     (%dx),%al
80100d94:	88 44 24 03          	mov    %al,0x3(%esp)
80100d98:	a2 62 54 10 80       	mov    %al,0x80105462
80100d9d:	b8 07 00 00 00       	mov    $0x7,%eax
80100da2:	89 da                	mov    %ebx,%edx
80100da4:	ee                   	out    %al,(%dx)
80100da5:	89 ca                	mov    %ecx,%edx
80100da7:	ec                   	in     (%dx),%al
80100da8:	88 44 24 04          	mov    %al,0x4(%esp)
80100dac:	a2 63 54 10 80       	mov    %al,0x80105463
80100db1:	b8 08 00 00 00       	mov    $0x8,%eax
80100db6:	89 da                	mov    %ebx,%edx
80100db8:	ee                   	out    %al,(%dx)
80100db9:	89 ca                	mov    %ecx,%edx
80100dbb:	ec                   	in     (%dx),%al
80100dbc:	88 44 24 05          	mov    %al,0x5(%esp)
80100dc0:	a2 64 54 10 80       	mov    %al,0x80105464
80100dc5:	b8 09 00 00 00       	mov    $0x9,%eax
80100dca:	89 da                	mov    %ebx,%edx
80100dcc:	ee                   	out    %al,(%dx)
80100dcd:	89 ca                	mov    %ecx,%edx
80100dcf:	ec                   	in     (%dx),%al
80100dd0:	88 44 24 06          	mov    %al,0x6(%esp)
80100dd4:	0f b6 f0             	movzbl %al,%esi
80100dd7:	66 89 35 66 54 10 80 	mov    %si,0x80105466
80100dde:	b8 0b 00 00 00       	mov    $0xb,%eax
80100de3:	89 da                	mov    %ebx,%edx
80100de5:	ee                   	out    %al,(%dx)
80100de6:	89 ca                	mov    %ecx,%edx
80100de8:	ec                   	in     (%dx),%al
80100de9:	a8 04                	test   $0x4,%al
80100deb:	0f 85 96 00 00 00    	jne    80100e87 <rtc_date+0x137>
80100df1:	89 eb                	mov    %ebp,%ebx
80100df3:	c0 eb 04             	shr    $0x4,%bl
80100df6:	89 d8                	mov    %ebx,%eax
80100df8:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100dfb:	83 e5 0f             	and    $0xf,%ebp
80100dfe:	8d 44 45 00          	lea    0x0(%ebp,%eax,2),%eax
80100e02:	a2 60 54 10 80       	mov    %al,0x80105460
80100e07:	89 fb                	mov    %edi,%ebx
80100e09:	c0 eb 04             	shr    $0x4,%bl
80100e0c:	89 d8                	mov    %ebx,%eax
80100e0e:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100e11:	83 e7 0f             	and    $0xf,%edi
80100e14:	8d 04 47             	lea    (%edi,%eax,2),%eax
80100e17:	a2 61 54 10 80       	mov    %al,0x80105461
80100e1c:	0f b6 4c 24 03       	movzbl 0x3(%esp),%ecx
80100e21:	89 ca                	mov    %ecx,%edx
80100e23:	c0 ea 04             	shr    $0x4,%dl
80100e26:	8d 14 92             	lea    (%edx,%edx,4),%edx
80100e29:	83 e1 0f             	and    $0xf,%ecx
80100e2c:	89 c8                	mov    %ecx,%eax
80100e2e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80100e31:	a2 62 54 10 80       	mov    %al,0x80105462
80100e36:	0f b6 5c 24 04       	movzbl 0x4(%esp),%ebx
80100e3b:	89 da                	mov    %ebx,%edx
80100e3d:	c0 ea 04             	shr    $0x4,%dl
80100e40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80100e43:	83 e3 0f             	and    $0xf,%ebx
80100e46:	89 d8                	mov    %ebx,%eax
80100e48:	8d 04 50             	lea    (%eax,%edx,2),%eax
80100e4b:	a2 63 54 10 80       	mov    %al,0x80105463
80100e50:	0f b6 4c 24 05       	movzbl 0x5(%esp),%ecx
80100e55:	89 ca                	mov    %ecx,%edx
80100e57:	c0 ea 04             	shr    $0x4,%dl
80100e5a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80100e5d:	83 e1 0f             	and    $0xf,%ecx
80100e60:	89 c8                	mov    %ecx,%eax
80100e62:	8d 04 50             	lea    (%eax,%edx,2),%eax
80100e65:	a2 64 54 10 80       	mov    %al,0x80105464
80100e6a:	66 c1 ee 04          	shr    $0x4,%si
80100e6e:	8d 34 b6             	lea    (%esi,%esi,4),%esi
80100e71:	0f b7 44 24 06       	movzwl 0x6(%esp),%eax
80100e76:	83 e0 0f             	and    $0xf,%eax
80100e79:	8d b4 70 d0 07 00 00 	lea    0x7d0(%eax,%esi,2),%esi
80100e80:	66 89 35 66 54 10 80 	mov    %si,0x80105466
80100e87:	83 c4 08             	add    $0x8,%esp
80100e8a:	5b                   	pop    %ebx
80100e8b:	5e                   	pop    %esi
80100e8c:	5f                   	pop    %edi
80100e8d:	5d                   	pop    %ebp
80100e8e:	c3                   	ret    

80100e8f <rtctrap>:
80100e8f:	f3 0f 1e fb          	endbr32 
80100e93:	53                   	push   %ebx
80100e94:	83 ec 08             	sub    $0x8,%esp
80100e97:	fa                   	cli    
80100e98:	bb 8a ff ff ff       	mov    $0xffffff8a,%ebx
80100e9d:	b9 70 00 00 00       	mov    $0x70,%ecx
80100ea2:	89 d8                	mov    %ebx,%eax
80100ea4:	89 ca                	mov    %ecx,%edx
80100ea6:	ee                   	out    %al,(%dx)
80100ea7:	ba 71 00 00 00       	mov    $0x71,%edx
80100eac:	ec                   	in     (%dx),%al
80100ead:	84 c0                	test   %al,%al
80100eaf:	78 f1                	js     80100ea2 <rtctrap+0x13>
80100eb1:	a1 68 54 10 80       	mov    0x80105468,%eax
80100eb6:	83 c0 01             	add    $0x1,%eax
80100eb9:	a3 68 54 10 80       	mov    %eax,0x80105468
80100ebe:	e8 8d fe ff ff       	call   80100d50 <rtc_date>
80100ec3:	e8 43 fe ff ff       	call   80100d0b <rtc_dump>
80100ec8:	e8 b3 05 00 00       	call   80101480 <piceoi>
80100ecd:	fb                   	sti    
80100ece:	e8 bf 00 00 00       	call   80100f92 <yield>
80100ed3:	83 c4 08             	add    $0x8,%esp
80100ed6:	5b                   	pop    %ebx
80100ed7:	c3                   	ret    

80100ed8 <sleep>:
80100ed8:	f3 0f 1e fb          	endbr32 
80100edc:	8b 15 68 54 10 80    	mov    0x80105468,%edx
80100ee2:	03 54 24 04          	add    0x4(%esp),%edx
80100ee6:	a1 68 54 10 80       	mov    0x80105468,%eax
80100eeb:	39 c2                	cmp    %eax,%edx
80100eed:	77 f7                	ja     80100ee6 <sleep+0xe>
80100eef:	c3                   	ret    

80100ef0 <printdate>:
80100ef0:	f3 0f 1e fb          	endbr32 
80100ef4:	83 ec 10             	sub    $0x10,%esp
80100ef7:	0f b6 05 60 54 10 80 	movzbl 0x80105460,%eax
80100efe:	50                   	push   %eax
80100eff:	0f b6 05 61 54 10 80 	movzbl 0x80105461,%eax
80100f06:	50                   	push   %eax
80100f07:	0f b6 05 62 54 10 80 	movzbl 0x80105462,%eax
80100f0e:	50                   	push   %eax
80100f0f:	0f b6 05 63 54 10 80 	movzbl 0x80105463,%eax
80100f16:	50                   	push   %eax
80100f17:	0f b6 05 64 54 10 80 	movzbl 0x80105464,%eax
80100f1e:	50                   	push   %eax
80100f1f:	0f b7 05 66 54 10 80 	movzwl 0x80105466,%eax
80100f26:	50                   	push   %eax
80100f27:	68 c8 1d 10 80       	push   $0x80101dc8
80100f2c:	e8 93 f2 ff ff       	call   801001c4 <vprintf>
80100f31:	83 c4 2c             	add    $0x2c,%esp
80100f34:	c3                   	ret    

80100f35 <swtch>:
80100f35:	8b 04 24             	mov    (%esp),%eax
80100f38:	8b 54 24 04          	mov    0x4(%esp),%edx
80100f3c:	83 c4 08             	add    $0x8,%esp
80100f3f:	8b 62 38             	mov    0x38(%edx),%esp
80100f42:	ff 72 20             	pushl  0x20(%edx)
80100f45:	89 42 20             	mov    %eax,0x20(%edx)
80100f48:	8b 42 28             	mov    0x28(%edx),%eax
80100f4b:	8b 4a 2c             	mov    0x2c(%edx),%ecx
80100f4e:	8b 5a 34             	mov    0x34(%edx),%ebx
80100f51:	8b 6a 3c             	mov    0x3c(%edx),%ebp
80100f54:	8b 7a 40             	mov    0x40(%edx),%edi
80100f57:	8b 72 44             	mov    0x44(%edx),%esi
80100f5a:	87 52 30             	xchg   %edx,0x30(%edx)
80100f5d:	c3                   	ret    

80100f5e <fork>:
80100f5e:	54                   	push   %esp
80100f5f:	ff 74 24 04          	pushl  0x4(%esp)
80100f63:	51                   	push   %ecx
80100f64:	52                   	push   %edx
80100f65:	53                   	push   %ebx
80100f66:	55                   	push   %ebp
80100f67:	56                   	push   %esi
80100f68:	57                   	push   %edi
80100f69:	e8 eb fa ff ff       	call   80100a59 <fork1>
80100f6e:	5f                   	pop    %edi
80100f6f:	5e                   	pop    %esi
80100f70:	5d                   	pop    %ebp
80100f71:	5b                   	pop    %ebx
80100f72:	5a                   	pop    %edx
80100f73:	59                   	pop    %ecx
80100f74:	83 c4 04             	add    $0x4,%esp
80100f77:	5c                   	pop    %esp
80100f78:	c3                   	ret    

80100f79 <wait>:
80100f79:	54                   	push   %esp
80100f7a:	ff 74 24 04          	pushl  0x4(%esp)
80100f7e:	50                   	push   %eax
80100f7f:	51                   	push   %ecx
80100f80:	52                   	push   %edx
80100f81:	53                   	push   %ebx
80100f82:	55                   	push   %ebp
80100f83:	56                   	push   %esi
80100f84:	57                   	push   %edi
80100f85:	e8 02 fc ff ff       	call   80100b8c <wait1>
80100f8a:	83 c4 28             	add    $0x28,%esp
80100f8d:	e9 fe f8 ff ff       	jmp    80100890 <schedule>

80100f92 <yield>:
80100f92:	54                   	push   %esp
80100f93:	ff 74 24 04          	pushl  0x4(%esp)
80100f97:	50                   	push   %eax
80100f98:	51                   	push   %ecx
80100f99:	52                   	push   %edx
80100f9a:	53                   	push   %ebx
80100f9b:	55                   	push   %ebp
80100f9c:	56                   	push   %esi
80100f9d:	57                   	push   %edi
80100f9e:	e8 9f fc ff ff       	call   80100c42 <yield1>
80100fa3:	83 c4 28             	add    $0x28,%esp
80100fa6:	e9 e5 f8 ff ff       	jmp    80100890 <schedule>

80100fab <reserve_error>:
80100fab:	f3 0f 1e fb          	endbr32 
80100faf:	83 ec 18             	sub    $0x18,%esp
80100fb2:	68 dd 1d 10 80       	push   $0x80101ddd
80100fb7:	e8 bc f8 ff ff       	call   80100878 <panic>
80100fbc:	83 c4 1c             	add    $0x1c,%esp
80100fbf:	c3                   	ret    

80100fc0 <divide_error>:
80100fc0:	f3 0f 1e fb          	endbr32 
80100fc4:	83 ec 18             	sub    $0x18,%esp
80100fc7:	68 ec 1d 10 80       	push   $0x80101dec
80100fcc:	e8 a7 f8 ff ff       	call   80100878 <panic>
80100fd1:	83 c4 1c             	add    $0x1c,%esp
80100fd4:	c3                   	ret    

80100fd5 <nmi_error>:
80100fd5:	f3 0f 1e fb          	endbr32 
80100fd9:	83 ec 18             	sub    $0x18,%esp
80100fdc:	68 ff 1d 10 80       	push   $0x80101dff
80100fe1:	e8 92 f8 ff ff       	call   80100878 <panic>
80100fe6:	83 c4 1c             	add    $0x1c,%esp
80100fe9:	c3                   	ret    

80100fea <break_point>:
80100fea:	f3 0f 1e fb          	endbr32 
80100fee:	53                   	push   %ebx
80100fef:	83 ec 14             	sub    $0x14,%esp
80100ff2:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
80100ff6:	ff 74 24 38          	pushl  0x38(%esp)
80100ffa:	ff 74 24 40          	pushl  0x40(%esp)
80100ffe:	ff 74 24 48          	pushl  0x48(%esp)
80101002:	ff 74 24 50          	pushl  0x50(%esp)
80101006:	68 e4 1e 10 80       	push   $0x80101ee4
8010100b:	e8 b4 f1 ff ff       	call   801001c4 <vprintf>
80101010:	83 c4 14             	add    $0x14,%esp
80101013:	53                   	push   %ebx
80101014:	ff 74 24 30          	pushl  0x30(%esp)
80101018:	ff 74 24 3c          	pushl  0x3c(%esp)
8010101c:	ff 74 24 3c          	pushl  0x3c(%esp)
80101020:	68 08 1f 10 80       	push   $0x80101f08
80101025:	e8 9a f1 ff ff       	call   801001c4 <vprintf>
8010102a:	83 c4 20             	add    $0x20,%esp
8010102d:	ff 73 08             	pushl  0x8(%ebx)
80101030:	ff 73 04             	pushl  0x4(%ebx)
80101033:	ff 33                	pushl  (%ebx)
80101035:	68 0a 1e 10 80       	push   $0x80101e0a
8010103a:	e8 85 f1 ff ff       	call   801001c4 <vprintf>
8010103f:	83 c4 18             	add    $0x18,%esp
80101042:	5b                   	pop    %ebx
80101043:	c3                   	ret    

80101044 <overflow_error>:
80101044:	f3 0f 1e fb          	endbr32 
80101048:	83 ec 18             	sub    $0x18,%esp
8010104b:	68 25 1e 10 80       	push   $0x80101e25
80101050:	e8 23 f8 ff ff       	call   80100878 <panic>
80101055:	83 c4 1c             	add    $0x1c,%esp
80101058:	c3                   	ret    

80101059 <bound_error>:
80101059:	f3 0f 1e fb          	endbr32 
8010105d:	83 ec 18             	sub    $0x18,%esp
80101060:	68 35 1e 10 80       	push   $0x80101e35
80101065:	e8 0e f8 ff ff       	call   80100878 <panic>
8010106a:	83 c4 1c             	add    $0x1c,%esp
8010106d:	c3                   	ret    

8010106e <invalid_code>:
8010106e:	f3 0f 1e fb          	endbr32 
80101072:	83 ec 18             	sub    $0x18,%esp
80101075:	68 35 1e 10 80       	push   $0x80101e35
8010107a:	e8 f9 f7 ff ff       	call   80100878 <panic>
8010107f:	83 c4 1c             	add    $0x1c,%esp
80101082:	c3                   	ret    

80101083 <device_not_available>:
80101083:	f3 0f 1e fb          	endbr32 
80101087:	83 ec 18             	sub    $0x18,%esp
8010108a:	68 42 1e 10 80       	push   $0x80101e42
8010108f:	e8 e4 f7 ff ff       	call   80100878 <panic>
80101094:	83 c4 1c             	add    $0x1c,%esp
80101097:	c3                   	ret    

80101098 <double_fault>:
80101098:	f3 0f 1e fb          	endbr32 
8010109c:	83 ec 18             	sub    $0x18,%esp
8010109f:	68 55 1e 10 80       	push   $0x80101e55
801010a4:	e8 cf f7 ff ff       	call   80100878 <panic>
801010a9:	83 c4 1c             	add    $0x1c,%esp
801010ac:	c3                   	ret    

801010ad <coprocessor_segment_overrun>:
801010ad:	f3 0f 1e fb          	endbr32 
801010b1:	83 ec 18             	sub    $0x18,%esp
801010b4:	68 63 1e 10 80       	push   $0x80101e63
801010b9:	e8 ba f7 ff ff       	call   80100878 <panic>
801010be:	83 c4 1c             	add    $0x1c,%esp
801010c1:	c3                   	ret    

801010c2 <invalid_tss>:
801010c2:	f3 0f 1e fb          	endbr32 
801010c6:	83 ec 18             	sub    $0x18,%esp
801010c9:	68 80 1e 10 80       	push   $0x80101e80
801010ce:	e8 a5 f7 ff ff       	call   80100878 <panic>
801010d3:	83 c4 1c             	add    $0x1c,%esp
801010d6:	c3                   	ret    

801010d7 <segment_not_present>:
801010d7:	f3 0f 1e fb          	endbr32 
801010db:	83 ec 18             	sub    $0x18,%esp
801010de:	68 8d 1e 10 80       	push   $0x80101e8d
801010e3:	e8 90 f7 ff ff       	call   80100878 <panic>
801010e8:	83 c4 1c             	add    $0x1c,%esp
801010eb:	c3                   	ret    

801010ec <stack_error>:
801010ec:	f3 0f 1e fb          	endbr32 
801010f0:	83 ec 18             	sub    $0x18,%esp
801010f3:	68 a2 1e 10 80       	push   $0x80101ea2
801010f8:	e8 7b f7 ff ff       	call   80100878 <panic>
801010fd:	83 c4 1c             	add    $0x1c,%esp
80101100:	c3                   	ret    

80101101 <general_protection>:
80101101:	f3 0f 1e fb          	endbr32 
80101105:	83 ec 18             	sub    $0x18,%esp
80101108:	68 af 1e 10 80       	push   $0x80101eaf
8010110d:	e8 66 f7 ff ff       	call   80100878 <panic>
80101112:	83 c4 1c             	add    $0x1c,%esp
80101115:	c3                   	ret    

80101116 <page_error>:
80101116:	f3 0f 1e fb          	endbr32 
8010111a:	83 ec 18             	sub    $0x18,%esp
8010111d:	68 c3 1e 10 80       	push   $0x80101ec3
80101122:	e8 51 f7 ff ff       	call   80100878 <panic>
80101127:	83 c4 1c             	add    $0x1c,%esp
8010112a:	c3                   	ret    

8010112b <coprocessor_error>:
8010112b:	f3 0f 1e fb          	endbr32 
8010112f:	83 ec 18             	sub    $0x18,%esp
80101132:	68 cf 1e 10 80       	push   $0x80101ecf
80101137:	e8 3c f7 ff ff       	call   80100878 <panic>
8010113c:	83 c4 1c             	add    $0x1c,%esp
8010113f:	c3                   	ret    

80101140 <init_idt>:
80101140:	f3 0f 1e fb          	endbr32 
80101144:	83 ec 10             	sub    $0x10,%esp
80101147:	b8 80 00 00 00       	mov    $0x80,%eax
8010114c:	8b 15 04 40 10 80    	mov    0x80104004,%edx
80101152:	66 c7 04 02 00 00    	movw   $0x0,(%edx,%eax,1)
80101158:	8b 15 04 40 10 80    	mov    0x80104004,%edx
8010115e:	66 c7 44 02 02 08 00 	movw   $0x8,0x2(%edx,%eax,1)
80101165:	8b 0d 04 40 10 80    	mov    0x80104004,%ecx
8010116b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010116e:	c6 42 04 00          	movb   $0x0,0x4(%edx)
80101172:	c6 42 05 8e          	movb   $0x8e,0x5(%edx)
80101176:	66 c7 42 06 00 00    	movw   $0x0,0x6(%edx)
8010117c:	83 c0 08             	add    $0x8,%eax
8010117f:	3d 00 08 00 00       	cmp    $0x800,%eax
80101184:	75 c6                	jne    8010114c <init_idt+0xc>
80101186:	ba ef 03 10 80       	mov    $0x801003ef,%edx
8010118b:	66 89 11             	mov    %dx,(%ecx)
8010118e:	a1 04 40 10 80       	mov    0x80104004,%eax
80101193:	66 c7 40 02 08 00    	movw   $0x8,0x2(%eax)
80101199:	a1 04 40 10 80       	mov    0x80104004,%eax
8010119e:	c6 40 04 00          	movb   $0x0,0x4(%eax)
801011a2:	c6 40 05 8e          	movb   $0x8e,0x5(%eax)
801011a6:	c1 ea 10             	shr    $0x10,%edx
801011a9:	66 89 50 06          	mov    %dx,0x6(%eax)
801011ad:	ba 22 04 10 80       	mov    $0x80100422,%edx
801011b2:	66 89 50 08          	mov    %dx,0x8(%eax)
801011b6:	66 c7 40 0a 08 00    	movw   $0x8,0xa(%eax)
801011bc:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
801011c0:	c6 40 0d 8e          	movb   $0x8e,0xd(%eax)
801011c4:	c1 ea 10             	shr    $0x10,%edx
801011c7:	66 89 50 0e          	mov    %dx,0xe(%eax)
801011cb:	ba 29 04 10 80       	mov    $0x80100429,%edx
801011d0:	66 89 50 10          	mov    %dx,0x10(%eax)
801011d4:	66 c7 40 12 08 00    	movw   $0x8,0x12(%eax)
801011da:	c6 40 14 00          	movb   $0x0,0x14(%eax)
801011de:	c6 40 15 8e          	movb   $0x8e,0x15(%eax)
801011e2:	c1 ea 10             	shr    $0x10,%edx
801011e5:	66 89 50 16          	mov    %dx,0x16(%eax)
801011e9:	ba 30 04 10 80       	mov    $0x80100430,%edx
801011ee:	66 89 50 18          	mov    %dx,0x18(%eax)
801011f2:	66 c7 40 1a 08 00    	movw   $0x8,0x1a(%eax)
801011f8:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
801011fc:	c6 40 1d 8f          	movb   $0x8f,0x1d(%eax)
80101200:	c1 ea 10             	shr    $0x10,%edx
80101203:	66 89 50 1e          	mov    %dx,0x1e(%eax)
80101207:	ba 37 04 10 80       	mov    $0x80100437,%edx
8010120c:	66 89 50 20          	mov    %dx,0x20(%eax)
80101210:	66 c7 40 22 08 00    	movw   $0x8,0x22(%eax)
80101216:	c6 40 24 00          	movb   $0x0,0x24(%eax)
8010121a:	c6 40 25 8f          	movb   $0x8f,0x25(%eax)
8010121e:	c1 ea 10             	shr    $0x10,%edx
80101221:	66 89 50 26          	mov    %dx,0x26(%eax)
80101225:	ba 3e 04 10 80       	mov    $0x8010043e,%edx
8010122a:	66 89 50 28          	mov    %dx,0x28(%eax)
8010122e:	66 c7 40 2a 08 00    	movw   $0x8,0x2a(%eax)
80101234:	c6 40 2c 00          	movb   $0x0,0x2c(%eax)
80101238:	c6 40 2d 8f          	movb   $0x8f,0x2d(%eax)
8010123c:	c1 ea 10             	shr    $0x10,%edx
8010123f:	66 89 50 2e          	mov    %dx,0x2e(%eax)
80101243:	ba 45 04 10 80       	mov    $0x80100445,%edx
80101248:	66 89 50 30          	mov    %dx,0x30(%eax)
8010124c:	66 c7 40 32 08 00    	movw   $0x8,0x32(%eax)
80101252:	c6 40 34 00          	movb   $0x0,0x34(%eax)
80101256:	c6 40 35 8e          	movb   $0x8e,0x35(%eax)
8010125a:	c1 ea 10             	shr    $0x10,%edx
8010125d:	66 89 50 36          	mov    %dx,0x36(%eax)
80101261:	ba 4c 04 10 80       	mov    $0x8010044c,%edx
80101266:	66 89 50 38          	mov    %dx,0x38(%eax)
8010126a:	66 c7 40 3a 08 00    	movw   $0x8,0x3a(%eax)
80101270:	c6 40 3c 00          	movb   $0x0,0x3c(%eax)
80101274:	c6 40 3d 8e          	movb   $0x8e,0x3d(%eax)
80101278:	c1 ea 10             	shr    $0x10,%edx
8010127b:	66 89 50 3e          	mov    %dx,0x3e(%eax)
8010127f:	ba 53 04 10 80       	mov    $0x80100453,%edx
80101284:	66 89 50 40          	mov    %dx,0x40(%eax)
80101288:	66 c7 40 42 08 00    	movw   $0x8,0x42(%eax)
8010128e:	c6 40 44 00          	movb   $0x0,0x44(%eax)
80101292:	c6 40 45 8e          	movb   $0x8e,0x45(%eax)
80101296:	c1 ea 10             	shr    $0x10,%edx
80101299:	66 89 50 46          	mov    %dx,0x46(%eax)
8010129d:	ba 5a 04 10 80       	mov    $0x8010045a,%edx
801012a2:	66 89 50 48          	mov    %dx,0x48(%eax)
801012a6:	66 c7 40 4a 08 00    	movw   $0x8,0x4a(%eax)
801012ac:	c6 40 4c 00          	movb   $0x0,0x4c(%eax)
801012b0:	c6 40 4d 8e          	movb   $0x8e,0x4d(%eax)
801012b4:	c1 ea 10             	shr    $0x10,%edx
801012b7:	66 89 50 4e          	mov    %dx,0x4e(%eax)
801012bb:	ba 61 04 10 80       	mov    $0x80100461,%edx
801012c0:	66 89 50 50          	mov    %dx,0x50(%eax)
801012c4:	66 c7 40 52 08 00    	movw   $0x8,0x52(%eax)
801012ca:	c6 40 54 00          	movb   $0x0,0x54(%eax)
801012ce:	c6 40 55 8e          	movb   $0x8e,0x55(%eax)
801012d2:	c1 ea 10             	shr    $0x10,%edx
801012d5:	66 89 50 56          	mov    %dx,0x56(%eax)
801012d9:	ba 68 04 10 80       	mov    $0x80100468,%edx
801012de:	66 89 50 58          	mov    %dx,0x58(%eax)
801012e2:	66 c7 40 5a 08 00    	movw   $0x8,0x5a(%eax)
801012e8:	c6 40 5c 00          	movb   $0x0,0x5c(%eax)
801012ec:	c6 40 5d 8e          	movb   $0x8e,0x5d(%eax)
801012f0:	c1 ea 10             	shr    $0x10,%edx
801012f3:	66 89 50 5e          	mov    %dx,0x5e(%eax)
801012f7:	ba 6f 04 10 80       	mov    $0x8010046f,%edx
801012fc:	66 89 50 60          	mov    %dx,0x60(%eax)
80101300:	66 c7 40 62 08 00    	movw   $0x8,0x62(%eax)
80101306:	c6 40 64 00          	movb   $0x0,0x64(%eax)
8010130a:	c6 40 65 8e          	movb   $0x8e,0x65(%eax)
8010130e:	c1 ea 10             	shr    $0x10,%edx
80101311:	66 89 50 66          	mov    %dx,0x66(%eax)
80101315:	ba 79 04 10 80       	mov    $0x80100479,%edx
8010131a:	66 89 50 68          	mov    %dx,0x68(%eax)
8010131e:	66 c7 40 6a 08 00    	movw   $0x8,0x6a(%eax)
80101324:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
80101328:	c6 40 6d 8e          	movb   $0x8e,0x6d(%eax)
8010132c:	c1 ea 10             	shr    $0x10,%edx
8010132f:	66 89 50 6e          	mov    %dx,0x6e(%eax)
80101333:	ba 83 04 10 80       	mov    $0x80100483,%edx
80101338:	66 89 50 70          	mov    %dx,0x70(%eax)
8010133c:	66 c7 40 72 08 00    	movw   $0x8,0x72(%eax)
80101342:	c6 40 74 00          	movb   $0x0,0x74(%eax)
80101346:	c6 40 75 8e          	movb   $0x8e,0x75(%eax)
8010134a:	c1 ea 10             	shr    $0x10,%edx
8010134d:	66 89 50 76          	mov    %dx,0x76(%eax)
80101351:	ba 97 04 10 80       	mov    $0x80100497,%edx
80101356:	66 89 50 78          	mov    %dx,0x78(%eax)
8010135a:	66 c7 40 7a 08 00    	movw   $0x8,0x7a(%eax)
80101360:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80101364:	c6 40 7d 8e          	movb   $0x8e,0x7d(%eax)
80101368:	c1 ea 10             	shr    $0x10,%edx
8010136b:	66 89 50 7e          	mov    %dx,0x7e(%eax)
8010136f:	ba 8d 04 10 80       	mov    $0x8010048d,%edx
80101374:	66 89 90 80 00 00 00 	mov    %dx,0x80(%eax)
8010137b:	66 c7 80 82 00 00 00 	movw   $0x8,0x82(%eax)
80101382:	08 00 
80101384:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
8010138b:	c6 80 85 00 00 00 8e 	movb   $0x8e,0x85(%eax)
80101392:	c1 ea 10             	shr    $0x10,%edx
80101395:	66 89 90 86 00 00 00 	mov    %dx,0x86(%eax)
8010139c:	ba a1 04 10 80       	mov    $0x801004a1,%edx
801013a1:	66 89 90 08 01 00 00 	mov    %dx,0x108(%eax)
801013a8:	66 c7 80 0a 01 00 00 	movw   $0x8,0x10a(%eax)
801013af:	08 00 
801013b1:	c6 80 0c 01 00 00 00 	movb   $0x0,0x10c(%eax)
801013b8:	c6 80 0d 01 00 00 8e 	movb   $0x8e,0x10d(%eax)
801013bf:	c1 ea 10             	shr    $0x10,%edx
801013c2:	66 89 90 0e 01 00 00 	mov    %dx,0x10e(%eax)
801013c9:	ba ab 04 10 80       	mov    $0x801004ab,%edx
801013ce:	66 89 90 40 01 00 00 	mov    %dx,0x140(%eax)
801013d5:	66 c7 80 42 01 00 00 	movw   $0x8,0x142(%eax)
801013dc:	08 00 
801013de:	c6 80 44 01 00 00 00 	movb   $0x0,0x144(%eax)
801013e5:	c6 80 45 01 00 00 8e 	movb   $0x8e,0x145(%eax)
801013ec:	c1 ea 10             	shr    $0x10,%edx
801013ef:	66 89 90 46 01 00 00 	mov    %dx,0x146(%eax)
801013f6:	66 c7 44 24 0a ff 07 	movw   $0x7ff,0xa(%esp)
801013fd:	66 c7 44 24 0c 00 7e 	movw   $0x7e00,0xc(%esp)
80101404:	66 c7 44 24 0e 00 00 	movw   $0x0,0xe(%esp)
8010140b:	8d 44 24 0a          	lea    0xa(%esp),%eax
8010140f:	0f 01 18             	lidtl  (%eax)
80101412:	83 c4 10             	add    $0x10,%esp
80101415:	c3                   	ret    

80101416 <init_pic>:
80101416:	f3 0f 1e fb          	endbr32 
8010141a:	56                   	push   %esi
8010141b:	53                   	push   %ebx
8010141c:	b9 11 00 00 00       	mov    $0x11,%ecx
80101421:	ba 20 00 00 00       	mov    $0x20,%edx
80101426:	89 c8                	mov    %ecx,%eax
80101428:	ee                   	out    %al,(%dx)
80101429:	bb 21 00 00 00       	mov    $0x21,%ebx
8010142e:	b8 20 00 00 00       	mov    $0x20,%eax
80101433:	89 da                	mov    %ebx,%edx
80101435:	ee                   	out    %al,(%dx)
80101436:	b8 04 00 00 00       	mov    $0x4,%eax
8010143b:	ee                   	out    %al,(%dx)
8010143c:	be 01 00 00 00       	mov    $0x1,%esi
80101441:	89 f0                	mov    %esi,%eax
80101443:	ee                   	out    %al,(%dx)
80101444:	ba a0 00 00 00       	mov    $0xa0,%edx
80101449:	89 c8                	mov    %ecx,%eax
8010144b:	ee                   	out    %al,(%dx)
8010144c:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80101451:	b8 28 00 00 00       	mov    $0x28,%eax
80101456:	89 ca                	mov    %ecx,%edx
80101458:	ee                   	out    %al,(%dx)
80101459:	b8 02 00 00 00       	mov    $0x2,%eax
8010145e:	ee                   	out    %al,(%dx)
8010145f:	89 f0                	mov    %esi,%eax
80101461:	ee                   	out    %al,(%dx)
80101462:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101467:	89 da                	mov    %ebx,%edx
80101469:	ee                   	out    %al,(%dx)
8010146a:	89 ca                	mov    %ecx,%edx
8010146c:	ee                   	out    %al,(%dx)
8010146d:	b8 f9 ff ff ff       	mov    $0xfffffff9,%eax
80101472:	89 da                	mov    %ebx,%edx
80101474:	ee                   	out    %al,(%dx)
80101475:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
8010147a:	89 ca                	mov    %ecx,%edx
8010147c:	ee                   	out    %al,(%dx)
8010147d:	5b                   	pop    %ebx
8010147e:	5e                   	pop    %esi
8010147f:	c3                   	ret    

80101480 <piceoi>:
80101480:	f3 0f 1e fb          	endbr32 
80101484:	b8 20 00 00 00       	mov    $0x20,%eax
80101489:	ba 20 00 00 00       	mov    $0x20,%edx
8010148e:	ee                   	out    %al,(%dx)
8010148f:	ba a0 00 00 00       	mov    $0xa0,%edx
80101494:	ee                   	out    %al,(%dx)
80101495:	c3                   	ret    

80101496 <kk>:
80101496:	f3 0f 1e fb          	endbr32 
8010149a:	83 ec 0c             	sub    $0xc,%esp
8010149d:	e8 bc fa ff ff       	call   80100f5e <fork>
801014a2:	85 c0                	test   %eax,%eax
801014a4:	78 43                	js     801014e9 <kk+0x53>
801014a6:	7e 23                	jle    801014cb <kk+0x35>
801014a8:	83 ec 0c             	sub    $0xc,%esp
801014ab:	68 29 1f 10 80       	push   $0x80101f29
801014b0:	e8 0f ed ff ff       	call   801001c4 <vprintf>
801014b5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801014bc:	e8 17 fa ff ff       	call   80100ed8 <sleep>
801014c1:	e8 2a fa ff ff       	call   80100ef0 <printdate>
801014c6:	83 c4 10             	add    $0x10,%esp
801014c9:	eb dd                	jmp    801014a8 <kk+0x12>
801014cb:	83 ec 0c             	sub    $0xc,%esp
801014ce:	68 39 1f 10 80       	push   $0x80101f39
801014d3:	e8 ec ec ff ff       	call   801001c4 <vprintf>
801014d8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801014df:	e8 f4 f9 ff ff       	call   80100ed8 <sleep>
801014e4:	83 c4 10             	add    $0x10,%esp
801014e7:	eb e2                	jmp    801014cb <kk+0x35>
801014e9:	83 c4 0c             	add    $0xc,%esp
801014ec:	c3                   	ret    

801014ed <umain>:
801014ed:	f3 0f 1e fb          	endbr32 
801014f1:	56                   	push   %esi
801014f2:	5e                   	pop    %esi
801014f3:	83 ec 28             	sub    $0x28,%esp
801014f6:	68 48 1f 10 80       	push   $0x80101f48
801014fb:	e8 c4 ec ff ff       	call   801001c4 <vprintf>
80101500:	e8 59 fa ff ff       	call   80100f5e <fork>
80101505:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101509:	8b 44 24 1c          	mov    0x1c(%esp),%eax
8010150d:	83 c4 10             	add    $0x10,%esp
80101510:	85 c0                	test   %eax,%eax
80101512:	78 2b                	js     8010153f <umain+0x52>
80101514:	8b 44 24 0c          	mov    0xc(%esp),%eax
80101518:	85 c0                	test   %eax,%eax
8010151a:	75 46                	jne    80101562 <umain+0x75>
8010151c:	83 ec 08             	sub    $0x8,%esp
8010151f:	68 08 40 10 80       	push   $0x80104008
80101524:	68 71 1f 10 80       	push   $0x80101f71
80101529:	e8 a3 ee ff ff       	call   801003d1 <exec>
8010152e:	c7 04 24 74 1f 10 80 	movl   $0x80101f74,(%esp)
80101535:	e8 8a ec ff ff       	call   801001c4 <vprintf>
8010153a:	e8 00 f6 ff ff       	call   80100b3f <exit>
8010153f:	83 ec 0c             	sub    $0xc,%esp
80101542:	68 60 1f 10 80       	push   $0x80101f60
80101547:	e8 78 ec ff ff       	call   801001c4 <vprintf>
8010154c:	e8 ee f5 ff ff       	call   80100b3f <exit>
80101551:	83 ec 08             	sub    $0x8,%esp
80101554:	50                   	push   %eax
80101555:	68 84 1f 10 80       	push   $0x80101f84
8010155a:	e8 65 ec ff ff       	call   801001c4 <vprintf>
8010155f:	83 c4 10             	add    $0x10,%esp
80101562:	e8 12 fa ff ff       	call   80100f79 <wait>
80101567:	85 c0                	test   %eax,%eax
80101569:	74 f7                	je     80101562 <umain+0x75>
8010156b:	eb e4                	jmp    80101551 <umain+0x64>

8010156d <mappages>:
8010156d:	55                   	push   %ebp
8010156e:	57                   	push   %edi
8010156f:	56                   	push   %esi
80101570:	53                   	push   %ebx
80101571:	83 ec 1c             	sub    $0x1c,%esp
80101574:	89 44 24 04          	mov    %eax,0x4(%esp)
80101578:	89 d0                	mov    %edx,%eax
8010157a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010157f:	89 c5                	mov    %eax,%ebp
80101581:	8b 5c 24 30          	mov    0x30(%esp),%ebx
80101585:	8d 54 1a ff          	lea    -0x1(%edx,%ebx,1),%edx
80101589:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010158f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101593:	29 c1                	sub    %eax,%ecx
80101595:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101599:	eb 41                	jmp    801015dc <mappages+0x6f>
8010159b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801015a0:	89 e9                	mov    %ebp,%ecx
801015a2:	c1 e9 0a             	shr    $0xa,%ecx
801015a5:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801015ab:	8d b4 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%esi
801015b2:	85 f6                	test   %esi,%esi
801015b4:	0f 84 ae 00 00 00    	je     80101668 <mappages+0xfb>
801015ba:	f6 06 01             	testb  $0x1,(%esi)
801015bd:	0f 85 8b 00 00 00    	jne    8010164e <mappages+0xe1>
801015c3:	0b 5c 24 34          	or     0x34(%esp),%ebx
801015c7:	83 cb 01             	or     $0x1,%ebx
801015ca:	89 1e                	mov    %ebx,(%esi)
801015cc:	3b 6c 24 0c          	cmp    0xc(%esp),%ebp
801015d0:	0f 84 9c 00 00 00    	je     80101672 <mappages+0x105>
801015d6:	81 c5 00 10 00 00    	add    $0x1000,%ebp
801015dc:	89 2c 24             	mov    %ebp,(%esp)
801015df:	8b 44 24 08          	mov    0x8(%esp),%eax
801015e3:	8d 1c 28             	lea    (%eax,%ebp,1),%ebx
801015e6:	89 e8                	mov    %ebp,%eax
801015e8:	c1 e8 16             	shr    $0x16,%eax
801015eb:	8b 7c 24 04          	mov    0x4(%esp),%edi
801015ef:	8d 34 87             	lea    (%edi,%eax,4),%esi
801015f2:	8b 06                	mov    (%esi),%eax
801015f4:	89 c2                	mov    %eax,%edx
801015f6:	83 e2 01             	and    $0x1,%edx
801015f9:	75 a0                	jne    8010159b <mappages+0x2e>
801015fb:	e8 0a f0 ff ff       	call   8010060a <kalloc>
80101600:	89 c2                	mov    %eax,%edx
80101602:	85 c0                	test   %eax,%eax
80101604:	74 5d                	je     80101663 <mappages+0xf6>
80101606:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010160c:	c7 80 fc 0f 00 00 00 	movl   $0x0,0xffc(%eax)
80101613:	00 00 00 
80101616:	8d 78 04             	lea    0x4(%eax),%edi
80101619:	83 e7 fc             	and    $0xfffffffc,%edi
8010161c:	89 c1                	mov    %eax,%ecx
8010161e:	29 f9                	sub    %edi,%ecx
80101620:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80101626:	c1 e9 02             	shr    $0x2,%ecx
80101629:	b8 00 00 00 00       	mov    $0x0,%eax
8010162e:	f3 ab                	rep stos %eax,%es:(%edi)
80101630:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80101636:	83 c8 07             	or     $0x7,%eax
80101639:	89 06                	mov    %eax,(%esi)
8010163b:	8b 34 24             	mov    (%esp),%esi
8010163e:	c1 ee 0a             	shr    $0xa,%esi
80101641:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80101647:	01 d6                	add    %edx,%esi
80101649:	e9 6c ff ff ff       	jmp    801015ba <mappages+0x4d>
8010164e:	83 ec 0c             	sub    $0xc,%esp
80101651:	68 94 1f 10 80       	push   $0x80101f94
80101656:	e8 1d f2 ff ff       	call   80100878 <panic>
8010165b:	83 c4 10             	add    $0x10,%esp
8010165e:	e9 60 ff ff ff       	jmp    801015c3 <mappages+0x56>
80101663:	ba 01 00 00 00       	mov    $0x1,%edx
80101668:	89 d0                	mov    %edx,%eax
8010166a:	83 c4 1c             	add    $0x1c,%esp
8010166d:	5b                   	pop    %ebx
8010166e:	5e                   	pop    %esi
8010166f:	5f                   	pop    %edi
80101670:	5d                   	pop    %ebp
80101671:	c3                   	ret    
80101672:	ba 00 00 00 00       	mov    $0x0,%edx
80101677:	eb ef                	jmp    80101668 <mappages+0xfb>

80101679 <seginit>:
80101679:	f3 0f 1e fb          	endbr32 
8010167d:	83 ec 1c             	sub    $0x1c,%esp
80101680:	e8 85 ef ff ff       	call   8010060a <kalloc>
80101685:	a3 6c 54 10 80       	mov    %eax,0x8010546c
8010168a:	85 c0                	test   %eax,%eax
8010168c:	74 7c                	je     8010170a <seginit+0x91>
8010168e:	a1 6c 54 10 80       	mov    0x8010546c,%eax
80101693:	66 c7 00 00 00       	movw   $0x0,(%eax)
80101698:	66 c7 40 02 00 00    	movw   $0x0,0x2(%eax)
8010169e:	c6 40 04 00          	movb   $0x0,0x4(%eax)
801016a2:	c6 40 05 90          	movb   $0x90,0x5(%eax)
801016a6:	c6 40 06 c0          	movb   $0xc0,0x6(%eax)
801016aa:	c6 40 07 00          	movb   $0x0,0x7(%eax)
801016ae:	a1 6c 54 10 80       	mov    0x8010546c,%eax
801016b3:	66 c7 40 08 ff ff    	movw   $0xffff,0x8(%eax)
801016b9:	66 c7 40 0a 00 00    	movw   $0x0,0xa(%eax)
801016bf:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
801016c3:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
801016c7:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
801016cb:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
801016cf:	66 c7 40 10 ff ff    	movw   $0xffff,0x10(%eax)
801016d5:	66 c7 40 12 00 00    	movw   $0x0,0x12(%eax)
801016db:	c6 40 14 00          	movb   $0x0,0x14(%eax)
801016df:	c6 40 15 92          	movb   $0x92,0x15(%eax)
801016e3:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
801016e7:	c6 40 17 00          	movb   $0x0,0x17(%eax)
801016eb:	66 c7 44 24 0a ff 0f 	movw   $0xfff,0xa(%esp)
801016f2:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
801016f7:	c1 e8 10             	shr    $0x10,%eax
801016fa:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
801016ff:	8d 44 24 0a          	lea    0xa(%esp),%eax
80101703:	0f 01 10             	lgdtl  (%eax)
80101706:	83 c4 1c             	add    $0x1c,%esp
80101709:	c3                   	ret    
8010170a:	83 ec 0c             	sub    $0xc,%esp
8010170d:	68 9a 1f 10 80       	push   $0x80101f9a
80101712:	e8 61 f1 ff ff       	call   80100878 <panic>
80101717:	83 c4 10             	add    $0x10,%esp
8010171a:	e9 6f ff ff ff       	jmp    8010168e <seginit+0x15>

8010171f <kvminit>:
8010171f:	f3 0f 1e fb          	endbr32 
80101723:	55                   	push   %ebp
80101724:	57                   	push   %edi
80101725:	56                   	push   %esi
80101726:	53                   	push   %ebx
80101727:	83 ec 0c             	sub    $0xc,%esp
8010172a:	e8 db ee ff ff       	call   8010060a <kalloc>
8010172f:	85 c0                	test   %eax,%eax
80101731:	75 08                	jne    8010173b <kvminit+0x1c>
80101733:	83 c4 0c             	add    $0xc,%esp
80101736:	5b                   	pop    %ebx
80101737:	5e                   	pop    %esi
80101738:	5f                   	pop    %edi
80101739:	5d                   	pop    %ebp
8010173a:	c3                   	ret    
8010173b:	89 c6                	mov    %eax,%esi
8010173d:	89 c5                	mov    %eax,%ebp
8010173f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80101745:	c7 80 fc 0f 00 00 00 	movl   $0x0,0xffc(%eax)
8010174c:	00 00 00 
8010174f:	8d 78 04             	lea    0x4(%eax),%edi
80101752:	83 e7 fc             	and    $0xfffffffc,%edi
80101755:	89 c1                	mov    %eax,%ecx
80101757:	29 f9                	sub    %edi,%ecx
80101759:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010175f:	c1 e9 02             	shr    $0x2,%ecx
80101762:	b8 00 00 00 00       	mov    $0x0,%eax
80101767:	f3 ab                	rep stos %eax,%es:(%edi)
80101769:	83 ec 08             	sub    $0x8,%esp
8010176c:	6a 02                	push   $0x2
8010176e:	68 00 00 40 00       	push   $0x400000
80101773:	ba 00 00 00 00       	mov    $0x0,%edx
80101778:	89 f0                	mov    %esi,%eax
8010177a:	e8 ee fd ff ff       	call   8010156d <mappages>
8010177f:	83 c4 10             	add    $0x10,%esp
80101782:	85 c0                	test   %eax,%eax
80101784:	75 22                	jne    801017a8 <kvminit+0x89>
80101786:	83 ec 08             	sub    $0x8,%esp
80101789:	6a 02                	push   $0x2
8010178b:	68 00 00 40 00       	push   $0x400000
80101790:	b9 00 00 00 00       	mov    $0x0,%ecx
80101795:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010179a:	89 f0                	mov    %esi,%eax
8010179c:	e8 cc fd ff ff       	call   8010156d <mappages>
801017a1:	83 c4 10             	add    $0x10,%esp
801017a4:	85 c0                	test   %eax,%eax
801017a6:	74 10                	je     801017b8 <kvminit+0x99>
801017a8:	83 ec 0c             	sub    $0xc,%esp
801017ab:	68 b0 1f 10 80       	push   $0x80101fb0
801017b0:	e8 c3 f0 ff ff       	call   80100878 <panic>
801017b5:	83 c4 10             	add    $0x10,%esp
801017b8:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801017be:	0f 22 d8             	mov    %eax,%cr3
801017c1:	81 c6 04 08 00 00    	add    $0x804,%esi
801017c7:	bb 00 00 40 00       	mov    $0x400000,%ebx
801017cc:	eb 3e                	jmp    8010180c <kvminit+0xed>
801017ce:	83 ec 0c             	sub    $0xc,%esp
801017d1:	68 b0 1f 10 80       	push   $0x80101fb0
801017d6:	e8 9d f0 ff ff       	call   80100878 <panic>
801017db:	83 c4 10             	add    $0x10,%esp
801017de:	83 ec 08             	sub    $0x8,%esp
801017e1:	8d 83 00 00 40 80    	lea    -0x7fc00000(%ebx),%eax
801017e7:	50                   	push   %eax
801017e8:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801017ee:	50                   	push   %eax
801017ef:	e8 cd ed ff ff       	call   801005c1 <freerange>
801017f4:	81 c3 00 00 40 00    	add    $0x400000,%ebx
801017fa:	83 c6 04             	add    $0x4,%esi
801017fd:	83 c4 10             	add    $0x10,%esp
80101800:	81 fb 00 00 40 01    	cmp    $0x1400000,%ebx
80101806:	0f 84 27 ff ff ff    	je     80101733 <kvminit+0x14>
8010180c:	89 d8                	mov    %ebx,%eax
8010180e:	0c 82                	or     $0x82,%al
80101810:	89 86 00 f8 ff ff    	mov    %eax,-0x800(%esi)
80101816:	89 06                	mov    %eax,(%esi)
80101818:	83 ec 08             	sub    $0x8,%esp
8010181b:	6a 02                	push   $0x2
8010181d:	68 00 00 40 00       	push   $0x400000
80101822:	89 d9                	mov    %ebx,%ecx
80101824:	89 da                	mov    %ebx,%edx
80101826:	89 e8                	mov    %ebp,%eax
80101828:	e8 40 fd ff ff       	call   8010156d <mappages>
8010182d:	83 c4 10             	add    $0x10,%esp
80101830:	85 c0                	test   %eax,%eax
80101832:	75 9a                	jne    801017ce <kvminit+0xaf>
80101834:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010183a:	83 ec 08             	sub    $0x8,%esp
8010183d:	6a 02                	push   $0x2
8010183f:	68 00 00 40 00       	push   $0x400000
80101844:	89 d9                	mov    %ebx,%ecx
80101846:	89 e8                	mov    %ebp,%eax
80101848:	e8 20 fd ff ff       	call   8010156d <mappages>
8010184d:	83 c4 10             	add    $0x10,%esp
80101850:	85 c0                	test   %eax,%eax
80101852:	74 8a                	je     801017de <kvminit+0xbf>
80101854:	e9 75 ff ff ff       	jmp    801017ce <kvminit+0xaf>

80101859 <deallocvm>:
80101859:	f3 0f 1e fb          	endbr32 
8010185d:	55                   	push   %ebp
8010185e:	57                   	push   %edi
8010185f:	56                   	push   %esi
80101860:	53                   	push   %ebx
80101861:	83 ec 1c             	sub    $0x1c,%esp
80101864:	8b 6c 24 30          	mov    0x30(%esp),%ebp
80101868:	8b 7c 24 34          	mov    0x34(%esp),%edi
8010186c:	89 f8                	mov    %edi,%eax
8010186e:	39 7c 24 38          	cmp    %edi,0x38(%esp)
80101872:	73 18                	jae    8010188c <deallocvm+0x33>
80101874:	8b 44 24 38          	mov    0x38(%esp),%eax
80101878:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010187e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80101884:	39 df                	cmp    %ebx,%edi
80101886:	77 4c                	ja     801018d4 <deallocvm+0x7b>
80101888:	8b 44 24 38          	mov    0x38(%esp),%eax
8010188c:	83 c4 1c             	add    $0x1c,%esp
8010188f:	5b                   	pop    %ebx
80101890:	5e                   	pop    %esi
80101891:	5f                   	pop    %edi
80101892:	5d                   	pop    %ebp
80101893:	c3                   	ret    
80101894:	c1 e2 16             	shl    $0x16,%edx
80101897:	8d 9a 00 f0 3f 00    	lea    0x3ff000(%edx),%ebx
8010189d:	eb 2b                	jmp    801018ca <deallocvm+0x71>
8010189f:	83 ec 0c             	sub    $0xc,%esp
801018a2:	68 48 1c 10 80       	push   $0x80101c48
801018a7:	e8 cc ef ff ff       	call   80100878 <panic>
801018ac:	83 c4 10             	add    $0x10,%esp
801018af:	83 ec 0c             	sub    $0xc,%esp
801018b2:	8b 44 24 18          	mov    0x18(%esp),%eax
801018b6:	05 00 00 00 80       	add    $0x80000000,%eax
801018bb:	50                   	push   %eax
801018bc:	e8 89 ec ff ff       	call   8010054a <kfree>
801018c1:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018c7:	83 c4 10             	add    $0x10,%esp
801018ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801018d0:	39 df                	cmp    %ebx,%edi
801018d2:	76 b4                	jbe    80101888 <deallocvm+0x2f>
801018d4:	89 da                	mov    %ebx,%edx
801018d6:	c1 ea 16             	shr    $0x16,%edx
801018d9:	8b 44 95 00          	mov    0x0(%ebp,%edx,4),%eax
801018dd:	a8 01                	test   $0x1,%al
801018df:	74 b3                	je     80101894 <deallocvm+0x3b>
801018e1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801018e6:	89 d9                	mov    %ebx,%ecx
801018e8:	c1 e9 0a             	shr    $0xa,%ecx
801018eb:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801018f1:	8d b4 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%esi
801018f8:	85 f6                	test   %esi,%esi
801018fa:	74 98                	je     80101894 <deallocvm+0x3b>
801018fc:	8b 06                	mov    (%esi),%eax
801018fe:	a8 01                	test   $0x1,%al
80101900:	74 c8                	je     801018ca <deallocvm+0x71>
80101902:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80101907:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010190b:	75 a2                	jne    801018af <deallocvm+0x56>
8010190d:	eb 90                	jmp    8010189f <deallocvm+0x46>

8010190f <allocvm>:
8010190f:	f3 0f 1e fb          	endbr32 
80101913:	55                   	push   %ebp
80101914:	57                   	push   %edi
80101915:	56                   	push   %esi
80101916:	53                   	push   %ebx
80101917:	83 ec 0c             	sub    $0xc,%esp
8010191a:	8b 7c 24 28          	mov    0x28(%esp),%edi
8010191e:	bb 00 00 00 00       	mov    $0x0,%ebx
80101923:	81 ff 00 00 00 80    	cmp    $0x80000000,%edi
80101929:	77 74                	ja     8010199f <allocvm+0x90>
8010192b:	8b 5c 24 24          	mov    0x24(%esp),%ebx
8010192f:	3b 7c 24 24          	cmp    0x24(%esp),%edi
80101933:	72 6a                	jb     8010199f <allocvm+0x90>
80101935:	8d b7 ff 0f 00 00    	lea    0xfff(%edi),%esi
8010193b:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80101941:	39 f7                	cmp    %esi,%edi
80101943:	76 58                	jbe    8010199d <allocvm+0x8e>
80101945:	8d 47 ff             	lea    -0x1(%edi),%eax
80101948:	29 f0                	sub    %esi,%eax
8010194a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010194f:	8d ac 06 00 10 00 00 	lea    0x1000(%esi,%eax,1),%ebp
80101956:	8b 5c 24 20          	mov    0x20(%esp),%ebx
8010195a:	e8 ab ec ff ff       	call   8010060a <kalloc>
8010195f:	85 c0                	test   %eax,%eax
80101961:	74 46                	je     801019a9 <allocvm+0x9a>
80101963:	83 ec 04             	sub    $0x4,%esp
80101966:	68 00 10 00 00       	push   $0x1000
8010196b:	6a 00                	push   $0x0
8010196d:	6a 00                	push   $0x0
8010196f:	e8 a5 ee ff ff       	call   80100819 <memset>
80101974:	83 c4 08             	add    $0x8,%esp
80101977:	6a 06                	push   $0x6
80101979:	68 00 10 00 00       	push   $0x1000
8010197e:	b9 00 00 00 80       	mov    $0x80000000,%ecx
80101983:	89 f2                	mov    %esi,%edx
80101985:	89 d8                	mov    %ebx,%eax
80101987:	e8 e1 fb ff ff       	call   8010156d <mappages>
8010198c:	83 c4 10             	add    $0x10,%esp
8010198f:	85 c0                	test   %eax,%eax
80101991:	75 3b                	jne    801019ce <allocvm+0xbf>
80101993:	81 c6 00 10 00 00    	add    $0x1000,%esi
80101999:	39 ee                	cmp    %ebp,%esi
8010199b:	75 bd                	jne    8010195a <allocvm+0x4b>
8010199d:	89 fb                	mov    %edi,%ebx
8010199f:	89 d8                	mov    %ebx,%eax
801019a1:	83 c4 0c             	add    $0xc,%esp
801019a4:	5b                   	pop    %ebx
801019a5:	5e                   	pop    %esi
801019a6:	5f                   	pop    %edi
801019a7:	5d                   	pop    %ebp
801019a8:	c3                   	ret    
801019a9:	89 c3                	mov    %eax,%ebx
801019ab:	83 ec 0c             	sub    $0xc,%esp
801019ae:	68 c7 1f 10 80       	push   $0x80101fc7
801019b3:	e8 0c e8 ff ff       	call   801001c4 <vprintf>
801019b8:	83 c4 0c             	add    $0xc,%esp
801019bb:	ff 74 24 28          	pushl  0x28(%esp)
801019bf:	57                   	push   %edi
801019c0:	ff 74 24 2c          	pushl  0x2c(%esp)
801019c4:	e8 90 fe ff ff       	call   80101859 <deallocvm>
801019c9:	83 c4 10             	add    $0x10,%esp
801019cc:	eb d1                	jmp    8010199f <allocvm+0x90>
801019ce:	83 ec 0c             	sub    $0xc,%esp
801019d1:	68 df 1f 10 80       	push   $0x80101fdf
801019d6:	e8 e9 e7 ff ff       	call   801001c4 <vprintf>
801019db:	83 c4 0c             	add    $0xc,%esp
801019de:	ff 74 24 28          	pushl  0x28(%esp)
801019e2:	57                   	push   %edi
801019e3:	ff 74 24 2c          	pushl  0x2c(%esp)
801019e7:	e8 6d fe ff ff       	call   80101859 <deallocvm>
801019ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801019f3:	e8 52 eb ff ff       	call   8010054a <kfree>
801019f8:	83 c4 10             	add    $0x10,%esp
801019fb:	bb 00 00 00 00       	mov    $0x0,%ebx
80101a00:	eb 9d                	jmp    8010199f <allocvm+0x90>

80101a02 <freevm>:
80101a02:	f3 0f 1e fb          	endbr32 
80101a06:	57                   	push   %edi
80101a07:	56                   	push   %esi
80101a08:	53                   	push   %ebx
80101a09:	8b 7c 24 10          	mov    0x10(%esp),%edi
80101a0d:	85 ff                	test   %edi,%edi
80101a0f:	74 0a                	je     80101a1b <freevm+0x19>
80101a11:	89 fb                	mov    %edi,%ebx
80101a13:	8d b7 00 10 00 00    	lea    0x1000(%edi),%esi
80101a19:	eb 2f                	jmp    80101a4a <freevm+0x48>
80101a1b:	83 ec 0c             	sub    $0xc,%esp
80101a1e:	68 fb 1f 10 80       	push   $0x80101ffb
80101a23:	e8 50 ee ff ff       	call   80100878 <panic>
80101a28:	83 c4 10             	add    $0x10,%esp
80101a2b:	eb e4                	jmp    80101a11 <freevm+0xf>
80101a2d:	83 ec 0c             	sub    $0xc,%esp
80101a30:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80101a35:	05 00 00 00 80       	add    $0x80000000,%eax
80101a3a:	50                   	push   %eax
80101a3b:	e8 0a eb ff ff       	call   8010054a <kfree>
80101a40:	83 c4 10             	add    $0x10,%esp
80101a43:	83 c3 04             	add    $0x4,%ebx
80101a46:	39 f3                	cmp    %esi,%ebx
80101a48:	74 08                	je     80101a52 <freevm+0x50>
80101a4a:	8b 03                	mov    (%ebx),%eax
80101a4c:	a8 01                	test   $0x1,%al
80101a4e:	74 f3                	je     80101a43 <freevm+0x41>
80101a50:	eb db                	jmp    80101a2d <freevm+0x2b>
80101a52:	83 ec 0c             	sub    $0xc,%esp
80101a55:	57                   	push   %edi
80101a56:	e8 ef ea ff ff       	call   8010054a <kfree>
80101a5b:	83 c4 10             	add    $0x10,%esp
80101a5e:	5b                   	pop    %ebx
80101a5f:	5e                   	pop    %esi
80101a60:	5f                   	pop    %edi
80101a61:	c3                   	ret    

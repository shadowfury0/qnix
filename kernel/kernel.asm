
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
80100144:	e8 4b 06 00 00       	call   80100794 <memmove>
80100149:	83 ee 50             	sub    $0x50,%esi
8010014c:	b8 80 07 00 00       	mov    $0x780,%eax
80100151:	29 f0                	sub    %esi,%eax
80100153:	01 c0                	add    %eax,%eax
80100155:	8d 94 36 00 80 0b 00 	lea    0xb8000(%esi,%esi,1),%edx
8010015c:	83 c4 0c             	add    $0xc,%esp
8010015f:	50                   	push   %eax
80100160:	6a 00                	push   $0x0
80100162:	52                   	push   %edx
80100163:	e8 80 06 00 00       	call   801007e8 <memset>
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
8010018d:	0f b6 92 28 16 10 80 	movzbl -0x7fefe9d8(%edx),%edx
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
8010029a:	be 20 16 10 80       	mov    $0x80101620,%esi
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
8010036a:	68 39 16 10 80       	push   $0x80101639
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
80100395:	68 39 16 10 80       	push   $0x80101639
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
801003c0:	68 0f 19 10 80       	push   $0x8010190f
801003c5:	e8 fa fd ff ff       	call   801001c4 <vprintf>
801003ca:	83 c4 20             	add    $0x20,%esp
801003cd:	5b                   	pop    %ebx
801003ce:	5e                   	pop    %esi
801003cf:	5f                   	pop    %edi
801003d0:	c3                   	ret    

801003d1 <do_int0>:
801003d1:	68 08 0c 10 80       	push   $0x80100c08

801003d6 <no_error>:
801003d6:	87 04 24             	xchg   %eax,(%esp)
801003d9:	53                   	push   %ebx
801003da:	51                   	push   %ecx
801003db:	52                   	push   %edx
801003dc:	57                   	push   %edi
801003dd:	56                   	push   %esi
801003de:	55                   	push   %ebp
801003df:	1e                   	push   %ds
801003e0:	06                   	push   %es
801003e1:	0f a0                	push   %fs
801003e3:	8d 54 24 28          	lea    0x28(%esp),%edx
801003e7:	52                   	push   %edx
801003e8:	ba 08 00 00 00       	mov    $0x8,%edx
801003ed:	8e da                	mov    %edx,%ds
801003ef:	8e c2                	mov    %edx,%es
801003f1:	8e e2                	mov    %edx,%fs
801003f3:	ff d0                	call   *%eax
801003f5:	83 c4 04             	add    $0x4,%esp
801003f8:	0f a1                	pop    %fs
801003fa:	07                   	pop    %es
801003fb:	1f                   	pop    %ds
801003fc:	5d                   	pop    %ebp
801003fd:	5e                   	pop    %esi
801003fe:	5f                   	pop    %edi
801003ff:	5a                   	pop    %edx
80100400:	59                   	pop    %ecx
80100401:	5b                   	pop    %ebx
80100402:	58                   	pop    %eax
80100403:	cf                   	iret   

80100404 <do_int1>:
80100404:	68 08 0c 10 80       	push   $0x80100c08
80100409:	eb cb                	jmp    801003d6 <no_error>

8010040b <do_int2>:
8010040b:	68 1d 0c 10 80       	push   $0x80100c1d
80100410:	eb c4                	jmp    801003d6 <no_error>

80100412 <do_int3>:
80100412:	68 32 0c 10 80       	push   $0x80100c32
80100417:	eb bd                	jmp    801003d6 <no_error>

80100419 <do_int4>:
80100419:	68 8c 0c 10 80       	push   $0x80100c8c
8010041e:	eb b6                	jmp    801003d6 <no_error>

80100420 <do_int5>:
80100420:	68 a1 0c 10 80       	push   $0x80100ca1
80100425:	eb af                	jmp    801003d6 <no_error>

80100427 <do_int6>:
80100427:	68 b6 0c 10 80       	push   $0x80100cb6
8010042c:	eb a8                	jmp    801003d6 <no_error>

8010042e <do_int7>:
8010042e:	68 cb 0c 10 80       	push   $0x80100ccb
80100433:	eb a1                	jmp    801003d6 <no_error>

80100435 <do_int8>:
80100435:	68 e0 0c 10 80       	push   $0x80100ce0
8010043a:	eb 9a                	jmp    801003d6 <no_error>

8010043c <do_int9>:
8010043c:	68 f5 0c 10 80       	push   $0x80100cf5
80100441:	eb 93                	jmp    801003d6 <no_error>

80100443 <do_int10>:
80100443:	68 0a 0d 10 80       	push   $0x80100d0a
80100448:	eb 8c                	jmp    801003d6 <no_error>

8010044a <do_int11>:
8010044a:	68 1f 0d 10 80       	push   $0x80100d1f
8010044f:	eb 85                	jmp    801003d6 <no_error>

80100451 <do_int12>:
80100451:	68 34 0d 10 80       	push   $0x80100d34
80100456:	e9 7b ff ff ff       	jmp    801003d6 <no_error>

8010045b <do_int13>:
8010045b:	68 49 0d 10 80       	push   $0x80100d49
80100460:	e9 71 ff ff ff       	jmp    801003d6 <no_error>

80100465 <do_int14>:
80100465:	68 5e 0d 10 80       	push   $0x80100d5e
8010046a:	e9 67 ff ff ff       	jmp    801003d6 <no_error>

8010046f <do_int16>:
8010046f:	68 73 0d 10 80       	push   $0x80100d73
80100474:	e9 5d ff ff ff       	jmp    801003d6 <no_error>

80100479 <do_other>:
80100479:	68 f3 0b 10 80       	push   $0x80100bf3
8010047e:	e9 53 ff ff ff       	jmp    801003d6 <no_error>

80100483 <keyboard_interrupt>:
80100483:	68 9a 06 10 80       	push   $0x8010069a
80100488:	e9 49 ff ff ff       	jmp    801003d6 <no_error>

8010048d <init_welcome>:
8010048d:	f3 0f 1e fb          	endbr32 
80100491:	83 ec 18             	sub    $0x18,%esp
80100494:	ff 35 00 30 10 80    	pushl  0x80103000
8010049a:	e8 25 fd ff ff       	call   801001c4 <vprintf>
8010049f:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801004a6:	e8 c9 fb ff ff       	call   80100074 <vgaputc>
801004ab:	83 c4 1c             	add    $0x1c,%esp
801004ae:	c3                   	ret    

801004af <main>:
801004af:	f3 0f 1e fb          	endbr32 
801004b3:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801004b7:	83 e4 f0             	and    $0xfffffff0,%esp
801004ba:	ff 71 fc             	pushl  -0x4(%ecx)
801004bd:	55                   	push   %ebp
801004be:	89 e5                	mov    %esp,%ebp
801004c0:	51                   	push   %ecx
801004c1:	83 ec 0c             	sub    $0xc,%esp
801004c4:	68 00 00 40 80       	push   $0x80400000
801004c9:	68 c8 47 10 80       	push   $0x801047c8
801004ce:	e8 1f 01 00 00       	call   801005f2 <kminit>
801004d3:	e8 e6 0d 00 00       	call   801012be <kvminit>
801004d8:	e8 3b 0d 00 00       	call   80101218 <seginit>
801004dd:	e8 bb 03 00 00       	call   8010089d <proc_init>
801004e2:	e8 a1 08 00 00       	call   80100d88 <init_idt>
801004e7:	e8 45 0b 00 00       	call   80101031 <init_pic>
801004ec:	e8 5a 01 00 00       	call   8010064b <init_keyboard>
801004f1:	e8 97 ff ff ff       	call   8010048d <init_welcome>
801004f6:	e8 3c fe ff ff       	call   80100337 <cpuinfo>
801004fb:	c7 04 24 3d 16 10 80 	movl   $0x8010163d,(%esp)
80100502:	e8 bd fc ff ff       	call   801001c4 <vprintf>
80100507:	e8 83 04 00 00       	call   8010098f <user_init>
8010050c:	e8 4e 03 00 00       	call   8010085f <schedule>
80100511:	83 c4 10             	add    $0x10,%esp
80100514:	8b 4d fc             	mov    -0x4(%ebp),%ecx
80100517:	c9                   	leave  
80100518:	8d 61 fc             	lea    -0x4(%ecx),%esp
8010051b:	c3                   	ret    

8010051c <kfree>:
8010051c:	f3 0f 1e fb          	endbr32 
80100520:	57                   	push   %edi
80100521:	53                   	push   %ebx
80100522:	83 ec 04             	sub    $0x4,%esp
80100525:	8b 5c 24 10          	mov    0x10(%esp),%ebx
80100529:	c7 03 01 01 01 01    	movl   $0x1010101,(%ebx)
8010052f:	c7 83 fc 0f 00 00 01 	movl   $0x1010101,0xffc(%ebx)
80100536:	01 01 01 
80100539:	8d 7b 04             	lea    0x4(%ebx),%edi
8010053c:	83 e7 fc             	and    $0xfffffffc,%edi
8010053f:	89 d9                	mov    %ebx,%ecx
80100541:	29 f9                	sub    %edi,%ecx
80100543:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80100549:	c1 e9 02             	shr    $0x2,%ecx
8010054c:	b8 01 01 01 01       	mov    $0x1010101,%eax
80100551:	f3 ab                	rep stos %eax,%es:(%edi)
80100553:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80100559:	75 15                	jne    80100570 <kfree+0x54>
8010055b:	81 fb c8 47 10 80    	cmp    $0x801047c8,%ebx
80100561:	72 0d                	jb     80100570 <kfree+0x54>
80100563:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80100569:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
8010056e:	76 10                	jbe    80100580 <kfree+0x64>
80100570:	83 ec 0c             	sub    $0xc,%esp
80100573:	68 dc 17 10 80       	push   $0x801017dc
80100578:	e8 ca 02 00 00       	call   80100847 <panic>
8010057d:	83 c4 10             	add    $0x10,%esp
80100580:	a1 24 30 10 80       	mov    0x80103024,%eax
80100585:	89 03                	mov    %eax,(%ebx)
80100587:	89 1d 24 30 10 80    	mov    %ebx,0x80103024
8010058d:	83 c4 04             	add    $0x4,%esp
80100590:	5b                   	pop    %ebx
80100591:	5f                   	pop    %edi
80100592:	c3                   	ret    

80100593 <freerange>:
80100593:	f3 0f 1e fb          	endbr32 
80100597:	56                   	push   %esi
80100598:	53                   	push   %ebx
80100599:	83 ec 04             	sub    $0x4,%esp
8010059c:	8b 74 24 14          	mov    0x14(%esp),%esi
801005a0:	8b 44 24 10          	mov    0x10(%esp),%eax
801005a4:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801005aa:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801005b0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801005b6:	39 de                	cmp    %ebx,%esi
801005b8:	72 1c                	jb     801005d6 <freerange+0x43>
801005ba:	83 ec 0c             	sub    $0xc,%esp
801005bd:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801005c3:	50                   	push   %eax
801005c4:	e8 53 ff ff ff       	call   8010051c <kfree>
801005c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801005cf:	83 c4 10             	add    $0x10,%esp
801005d2:	39 f3                	cmp    %esi,%ebx
801005d4:	76 e4                	jbe    801005ba <freerange+0x27>
801005d6:	83 c4 04             	add    $0x4,%esp
801005d9:	5b                   	pop    %ebx
801005da:	5e                   	pop    %esi
801005db:	c3                   	ret    

801005dc <kalloc>:
801005dc:	f3 0f 1e fb          	endbr32 
801005e0:	a1 24 30 10 80       	mov    0x80103024,%eax
801005e5:	85 c0                	test   %eax,%eax
801005e7:	74 08                	je     801005f1 <kalloc+0x15>
801005e9:	8b 10                	mov    (%eax),%edx
801005eb:	89 15 24 30 10 80    	mov    %edx,0x80103024
801005f1:	c3                   	ret    

801005f2 <kminit>:
801005f2:	f3 0f 1e fb          	endbr32 
801005f6:	83 ec 14             	sub    $0x14,%esp
801005f9:	c7 05 24 30 10 80 00 	movl   $0x0,0x80103024
80100600:	00 00 00 
80100603:	ff 74 24 1c          	pushl  0x1c(%esp)
80100607:	ff 74 24 1c          	pushl  0x1c(%esp)
8010060b:	e8 83 ff ff ff       	call   80100593 <freerange>
80100610:	83 c4 1c             	add    $0x1c,%esp
80100613:	c3                   	ret    

80100614 <entry>:
80100614:	0f 20 e0             	mov    %cr4,%eax
80100617:	83 c8 10             	or     $0x10,%eax
8010061a:	0f 22 e0             	mov    %eax,%cr4
8010061d:	b8 00 20 10 00       	mov    $0x102000,%eax
80100622:	0f 22 d8             	mov    %eax,%cr3
80100625:	0f 20 c0             	mov    %cr0,%eax
80100628:	0d 00 00 01 80       	or     $0x80010000,%eax
8010062d:	0f 22 c0             	mov    %eax,%cr0
80100630:	bc 30 40 10 80       	mov    $0x80104030,%esp
80100635:	b8 af 04 10 80       	mov    $0x801004af,%eax
8010063a:	ff e0                	jmp    *%eax

8010063c <wait_kybc_sendready>:
8010063c:	f3 0f 1e fb          	endbr32 
80100640:	ba 64 00 00 00       	mov    $0x64,%edx
80100645:	ec                   	in     (%dx),%al
80100646:	a8 02                	test   $0x2,%al
80100648:	75 fb                	jne    80100645 <wait_kybc_sendready+0x9>
8010064a:	c3                   	ret    

8010064b <init_keyboard>:
8010064b:	f3 0f 1e fb          	endbr32 
8010064f:	53                   	push   %ebx
80100650:	e8 e7 ff ff ff       	call   8010063c <wait_kybc_sendready>
80100655:	bb 64 00 00 00       	mov    $0x64,%ebx
8010065a:	b8 60 00 00 00       	mov    $0x60,%eax
8010065f:	89 da                	mov    %ebx,%edx
80100661:	ee                   	out    %al,(%dx)
80100662:	e8 d5 ff ff ff       	call   8010063c <wait_kybc_sendready>
80100667:	b8 47 00 00 00       	mov    $0x47,%eax
8010066c:	89 da                	mov    %ebx,%edx
8010066e:	ee                   	out    %al,(%dx)
8010066f:	c7 05 34 40 10 80 00 	movl   $0x0,0x80104034
80100676:	00 00 00 
80100679:	c7 05 38 40 10 80 00 	movl   $0x0,0x80104038
80100680:	00 00 00 
80100683:	c6 05 31 40 10 80 00 	movb   $0x0,0x80104031
8010068a:	c6 05 32 40 10 80 00 	movb   $0x0,0x80104032
80100691:	c6 05 30 40 10 80 00 	movb   $0x0,0x80104030
80100698:	5b                   	pop    %ebx
80100699:	c3                   	ret    

8010069a <keygetc>:
8010069a:	f3 0f 1e fb          	endbr32 
8010069e:	83 ec 0c             	sub    $0xc,%esp
801006a1:	a1 38 40 10 80       	mov    0x80104038,%eax
801006a6:	8b 15 34 40 10 80    	mov    0x80104034,%edx
801006ac:	29 d0                	sub    %edx,%eax
801006ae:	83 f8 01             	cmp    $0x1,%eax
801006b1:	74 1f                	je     801006d2 <keygetc+0x38>
801006b3:	8b 0d 38 40 10 80    	mov    0x80104038,%ecx
801006b9:	ba 60 00 00 00       	mov    $0x60,%edx
801006be:	ec                   	in     (%dx),%al
801006bf:	88 81 3c 40 10 80    	mov    %al,-0x7fefbfc4(%ecx)
801006c5:	a1 38 40 10 80       	mov    0x80104038,%eax
801006ca:	83 c0 01             	add    $0x1,%eax
801006cd:	a3 38 40 10 80       	mov    %eax,0x80104038
801006d2:	e8 bc 09 00 00       	call   80101093 <piceoi>
801006d7:	83 c4 0c             	add    $0xc,%esp
801006da:	c3                   	ret    

801006db <keyputc>:
801006db:	f3 0f 1e fb          	endbr32 
801006df:	8b 15 34 40 10 80    	mov    0x80104034,%edx
801006e5:	a1 38 40 10 80       	mov    0x80104038,%eax
801006ea:	39 c2                	cmp    %eax,%edx
801006ec:	74 4f                	je     8010073d <keyputc+0x62>
801006ee:	fa                   	cli    
801006ef:	a1 34 40 10 80       	mov    0x80104034,%eax
801006f4:	0f b6 80 3c 40 10 80 	movzbl -0x7fefbfc4(%eax),%eax
801006fb:	8b 15 34 40 10 80    	mov    0x80104034,%edx
80100701:	83 c2 01             	add    $0x1,%edx
80100704:	89 15 34 40 10 80    	mov    %edx,0x80104034
8010070a:	3c 2a                	cmp    $0x2a,%al
8010070c:	74 24                	je     80100732 <keyputc+0x57>
8010070e:	3c 36                	cmp    $0x36,%al
80100710:	74 20                	je     80100732 <keyputc+0x57>
80100712:	3c aa                	cmp    $0xaa,%al
80100714:	74 28                	je     8010073e <keyputc+0x63>
80100716:	3c b6                	cmp    $0xb6,%al
80100718:	74 24                	je     8010073e <keyputc+0x63>
8010071a:	3c 1d                	cmp    $0x1d,%al
8010071c:	74 29                	je     80100747 <keyputc+0x6c>
8010071e:	3c 9d                	cmp    $0x9d,%al
80100720:	74 55                	je     80100777 <keyputc+0x9c>
80100722:	3c 38                	cmp    $0x38,%al
80100724:	74 59                	je     8010077f <keyputc+0xa4>
80100726:	3c b8                	cmp    $0xb8,%al
80100728:	75 0f                	jne    80100739 <keyputc+0x5e>
8010072a:	c6 05 32 40 10 80 00 	movb   $0x0,0x80104032
80100731:	c3                   	ret    
80100732:	c6 05 31 40 10 80 01 	movb   $0x1,0x80104031
80100739:	3c 58                	cmp    $0x58,%al
8010073b:	76 11                	jbe    8010074e <keyputc+0x73>
8010073d:	c3                   	ret    
8010073e:	c6 05 31 40 10 80 00 	movb   $0x0,0x80104031
80100745:	eb f2                	jmp    80100739 <keyputc+0x5e>
80100747:	c6 05 30 40 10 80 01 	movb   $0x1,0x80104030
8010074e:	0f b6 15 31 40 10 80 	movzbl 0x80104031,%edx
80100755:	84 d2                	test   %dl,%dl
80100757:	74 2f                	je     80100788 <keyputc+0xad>
80100759:	0f b6 c0             	movzbl %al,%eax
8010075c:	0f b6 80 00 18 10 80 	movzbl -0x7fefe800(%eax),%eax
80100763:	84 c0                	test   %al,%al
80100765:	74 d6                	je     8010073d <keyputc+0x62>
80100767:	83 ec 18             	sub    $0x18,%esp
8010076a:	0f b6 c0             	movzbl %al,%eax
8010076d:	50                   	push   %eax
8010076e:	e8 01 f9 ff ff       	call   80100074 <vgaputc>
80100773:	83 c4 1c             	add    $0x1c,%esp
80100776:	c3                   	ret    
80100777:	c6 05 30 40 10 80 00 	movb   $0x0,0x80104030
8010077e:	c3                   	ret    
8010077f:	c6 05 32 40 10 80 01 	movb   $0x1,0x80104032
80100786:	eb c6                	jmp    8010074e <keyputc+0x73>
80100788:	0f b6 c0             	movzbl %al,%eax
8010078b:	0f b6 80 60 18 10 80 	movzbl -0x7fefe7a0(%eax),%eax
80100792:	eb cf                	jmp    80100763 <keyputc+0x88>

80100794 <memmove>:
80100794:	f3 0f 1e fb          	endbr32 
80100798:	56                   	push   %esi
80100799:	53                   	push   %ebx
8010079a:	8b 74 24 0c          	mov    0xc(%esp),%esi
8010079e:	8b 44 24 10          	mov    0x10(%esp),%eax
801007a2:	8b 4c 24 14          	mov    0x14(%esp),%ecx
801007a6:	39 f0                	cmp    %esi,%eax
801007a8:	72 1f                	jb     801007c9 <memmove+0x35>
801007aa:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
801007ad:	89 f2                	mov    %esi,%edx
801007af:	85 c9                	test   %ecx,%ecx
801007b1:	74 11                	je     801007c4 <memmove+0x30>
801007b3:	83 c0 01             	add    $0x1,%eax
801007b6:	83 c2 01             	add    $0x1,%edx
801007b9:	0f b6 48 ff          	movzbl -0x1(%eax),%ecx
801007bd:	88 4a ff             	mov    %cl,-0x1(%edx)
801007c0:	39 d8                	cmp    %ebx,%eax
801007c2:	75 ef                	jne    801007b3 <memmove+0x1f>
801007c4:	89 f0                	mov    %esi,%eax
801007c6:	5b                   	pop    %ebx
801007c7:	5e                   	pop    %esi
801007c8:	c3                   	ret    
801007c9:	8d 14 08             	lea    (%eax,%ecx,1),%edx
801007cc:	39 d6                	cmp    %edx,%esi
801007ce:	73 da                	jae    801007aa <memmove+0x16>
801007d0:	8d 51 ff             	lea    -0x1(%ecx),%edx
801007d3:	85 c9                	test   %ecx,%ecx
801007d5:	74 ed                	je     801007c4 <memmove+0x30>
801007d7:	0f b6 0c 10          	movzbl (%eax,%edx,1),%ecx
801007db:	88 0c 16             	mov    %cl,(%esi,%edx,1)
801007de:	83 ea 01             	sub    $0x1,%edx
801007e1:	83 fa ff             	cmp    $0xffffffff,%edx
801007e4:	75 f1                	jne    801007d7 <memmove+0x43>
801007e6:	eb dc                	jmp    801007c4 <memmove+0x30>

801007e8 <memset>:
801007e8:	f3 0f 1e fb          	endbr32 
801007ec:	57                   	push   %edi
801007ed:	53                   	push   %ebx
801007ee:	8b 54 24 0c          	mov    0xc(%esp),%edx
801007f2:	8b 44 24 10          	mov    0x10(%esp),%eax
801007f6:	8b 4c 24 14          	mov    0x14(%esp),%ecx
801007fa:	89 d7                	mov    %edx,%edi
801007fc:	09 cf                	or     %ecx,%edi
801007fe:	f7 c7 03 00 00 00    	test   $0x3,%edi
80100804:	75 1e                	jne    80100824 <memset+0x3c>
80100806:	0f b6 f8             	movzbl %al,%edi
80100809:	c1 e9 02             	shr    $0x2,%ecx
8010080c:	c1 e0 18             	shl    $0x18,%eax
8010080f:	89 fb                	mov    %edi,%ebx
80100811:	c1 e3 10             	shl    $0x10,%ebx
80100814:	09 d8                	or     %ebx,%eax
80100816:	09 f8                	or     %edi,%eax
80100818:	c1 e7 08             	shl    $0x8,%edi
8010081b:	09 f8                	or     %edi,%eax
8010081d:	89 d7                	mov    %edx,%edi
8010081f:	fc                   	cld    
80100820:	f3 ab                	rep stos %eax,%es:(%edi)
80100822:	eb 05                	jmp    80100829 <memset+0x41>
80100824:	89 d7                	mov    %edx,%edi
80100826:	fc                   	cld    
80100827:	f3 aa                	rep stos %al,%es:(%edi)
80100829:	89 d0                	mov    %edx,%eax
8010082b:	5b                   	pop    %ebx
8010082c:	5f                   	pop    %edi
8010082d:	c3                   	ret    

8010082e <memcpy>:
8010082e:	f3 0f 1e fb          	endbr32 
80100832:	ff 74 24 0c          	pushl  0xc(%esp)
80100836:	ff 74 24 0c          	pushl  0xc(%esp)
8010083a:	ff 74 24 0c          	pushl  0xc(%esp)
8010083e:	e8 51 ff ff ff       	call   80100794 <memmove>
80100843:	83 c4 0c             	add    $0xc,%esp
80100846:	c3                   	ret    

80100847 <panic>:
80100847:	f3 0f 1e fb          	endbr32 
8010084b:	56                   	push   %esi
8010084c:	5e                   	pop    %esi
8010084d:	83 ec 18             	sub    $0x18,%esp
80100850:	ff 74 24 1c          	pushl  0x1c(%esp)
80100854:	e8 6b f9 ff ff       	call   801001c4 <vprintf>
80100859:	fa                   	cli    
8010085a:	83 c4 10             	add    $0x10,%esp
8010085d:	eb fe                	jmp    8010085d <panic+0x16>

8010085f <schedule>:
8010085f:	f3 0f 1e fb          	endbr32 
80100863:	53                   	push   %ebx
80100864:	83 ec 08             	sub    $0x8,%esp
80100867:	bb 80 40 10 80       	mov    $0x80104080,%ebx
8010086c:	eb 0b                	jmp    80100879 <schedule+0x1a>
8010086e:	83 c3 74             	add    $0x74,%ebx
80100871:	81 fb c0 47 10 80    	cmp    $0x801047c0,%ebx
80100877:	74 ee                	je     80100867 <schedule+0x8>
80100879:	8b 03                	mov    (%ebx),%eax
8010087b:	83 f8 03             	cmp    $0x3,%eax
8010087e:	75 ee                	jne    8010086e <schedule+0xf>
80100880:	89 1d 60 40 10 80    	mov    %ebx,0x80104060
80100886:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
8010088c:	83 ec 0c             	sub    $0xc,%esp
8010088f:	8d 43 0c             	lea    0xc(%ebx),%eax
80100892:	50                   	push   %eax
80100893:	e8 2d 03 00 00       	call   80100bc5 <swtch>
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb d1                	jmp    8010086e <schedule+0xf>

8010089d <proc_init>:
8010089d:	f3 0f 1e fb          	endbr32 
801008a1:	c7 05 20 30 10 80 00 	movl   $0x0,0x80103020
801008a8:	00 00 00 
801008ab:	c7 05 60 40 10 80 00 	movl   $0x0,0x80104060
801008b2:	00 00 00 
801008b5:	ba 18 00 00 00       	mov    $0x18,%edx
801008ba:	89 d0                	mov    %edx,%eax
801008bc:	03 05 c0 47 10 80    	add    0x801047c0,%eax
801008c2:	66 c7 00 00 00       	movw   $0x0,(%eax)
801008c7:	66 c7 40 02 00 00    	movw   $0x0,0x2(%eax)
801008cd:	c6 40 04 00          	movb   $0x0,0x4(%eax)
801008d1:	c6 40 05 90          	movb   $0x90,0x5(%eax)
801008d5:	c6 40 06 c0          	movb   $0xc0,0x6(%eax)
801008d9:	c6 40 07 00          	movb   $0x0,0x7(%eax)
801008dd:	83 c2 08             	add    $0x8,%edx
801008e0:	81 fa 80 00 00 00    	cmp    $0x80,%edx
801008e6:	75 d2                	jne    801008ba <proc_init+0x1d>
801008e8:	c3                   	ret    

801008e9 <allocproc>:
801008e9:	f3 0f 1e fb          	endbr32 
801008ed:	53                   	push   %ebx
801008ee:	83 ec 08             	sub    $0x8,%esp
801008f1:	bb 80 40 10 80       	mov    $0x80104080,%ebx
801008f6:	8b 03                	mov    (%ebx),%eax
801008f8:	85 c0                	test   %eax,%eax
801008fa:	74 29                	je     80100925 <allocproc+0x3c>
801008fc:	83 c3 74             	add    $0x74,%ebx
801008ff:	81 fb c0 47 10 80    	cmp    $0x801047c0,%ebx
80100905:	75 ef                	jne    801008f6 <allocproc+0xd>
80100907:	83 ec 08             	sub    $0x8,%esp
8010090a:	6a 10                	push   $0x10
8010090c:	68 bc 18 10 80       	push   $0x801018bc
80100911:	e8 ae f8 ff ff       	call   801001c4 <vprintf>
80100916:	83 c4 10             	add    $0x10,%esp
80100919:	bb 00 00 00 00       	mov    $0x0,%ebx
8010091e:	89 d8                	mov    %ebx,%eax
80100920:	83 c4 08             	add    $0x8,%esp
80100923:	5b                   	pop    %ebx
80100924:	c3                   	ret    
80100925:	e8 b2 fc ff ff       	call   801005dc <kalloc>
8010092a:	89 43 44             	mov    %eax,0x44(%ebx)
8010092d:	85 c0                	test   %eax,%eax
8010092f:	74 51                	je     80100982 <allocproc+0x99>
80100931:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80100937:	8b 15 20 30 10 80    	mov    0x80103020,%edx
8010093d:	8d 4a 01             	lea    0x1(%edx),%ecx
80100940:	89 0d 20 30 10 80    	mov    %ecx,0x80103020
80100946:	83 e2 0f             	and    $0xf,%edx
80100949:	89 53 04             	mov    %edx,0x4(%ebx)
8010094c:	05 00 10 00 00       	add    $0x1000,%eax
80100951:	89 43 44             	mov    %eax,0x44(%ebx)
80100954:	a1 60 40 10 80       	mov    0x80104060,%eax
80100959:	89 43 08             	mov    %eax,0x8(%ebx)
8010095c:	66 c7 43 54 10 00    	movw   $0x10,0x54(%ebx)
80100962:	66 c7 43 58 08 00    	movw   $0x8,0x58(%ebx)
80100968:	66 c7 43 5c 10 00    	movw   $0x10,0x5c(%ebx)
8010096e:	66 c7 43 60 10 00    	movw   $0x10,0x60(%ebx)
80100974:	66 c7 43 64 10 00    	movw   $0x10,0x64(%ebx)
8010097a:	66 c7 43 68 10 00    	movw   $0x10,0x68(%ebx)
80100980:	eb 9c                	jmp    8010091e <allocproc+0x35>
80100982:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100988:	bb 00 00 00 00       	mov    $0x0,%ebx
8010098d:	eb 8f                	jmp    8010091e <allocproc+0x35>

8010098f <user_init>:
8010098f:	f3 0f 1e fb          	endbr32 
80100993:	53                   	push   %ebx
80100994:	83 ec 08             	sub    $0x8,%esp
80100997:	e8 4d ff ff ff       	call   801008e9 <allocproc>
8010099c:	89 c3                	mov    %eax,%ebx
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 1b                	je     801009bd <user_init+0x2e>
801009a2:	c7 43 2c ae 10 10 80 	movl   $0x801010ae,0x2c(%ebx)
801009a9:	89 1d 60 40 10 80    	mov    %ebx,0x80104060
801009af:	89 5b 08             	mov    %ebx,0x8(%ebx)
801009b2:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
801009b8:	83 c4 08             	add    $0x8,%esp
801009bb:	5b                   	pop    %ebx
801009bc:	c3                   	ret    
801009bd:	83 ec 0c             	sub    $0xc,%esp
801009c0:	68 eb 18 10 80       	push   $0x801018eb
801009c5:	e8 7d fe ff ff       	call   80100847 <panic>
801009ca:	83 c4 10             	add    $0x10,%esp
801009cd:	eb d3                	jmp    801009a2 <user_init+0x13>

801009cf <fork1>:
801009cf:	f3 0f 1e fb          	endbr32 
801009d3:	53                   	push   %ebx
801009d4:	83 ec 08             	sub    $0x8,%esp
801009d7:	e8 0d ff ff ff       	call   801008e9 <allocproc>
801009dc:	85 c0                	test   %eax,%eax
801009de:	74 5e                	je     80100a3e <fork1+0x6f>
801009e0:	89 c3                	mov    %eax,%ebx
801009e2:	a1 60 40 10 80       	mov    0x80104060,%eax
801009e7:	89 43 08             	mov    %eax,0x8(%ebx)
801009ea:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
801009f0:	8b 44 24 10          	mov    0x10(%esp),%eax
801009f4:	89 43 2c             	mov    %eax,0x2c(%ebx)
801009f7:	a1 60 40 10 80       	mov    0x80104060,%eax
801009fc:	8b 40 44             	mov    0x44(%eax),%eax
801009ff:	83 ec 04             	sub    $0x4,%esp
80100a02:	68 00 10 00 00       	push   $0x1000
80100a07:	2d 00 10 00 00       	sub    $0x1000,%eax
80100a0c:	50                   	push   %eax
80100a0d:	8b 43 44             	mov    0x44(%ebx),%eax
80100a10:	2d 00 10 00 00       	sub    $0x1000,%eax
80100a15:	50                   	push   %eax
80100a16:	e8 79 fd ff ff       	call   80100794 <memmove>
80100a1b:	c7 43 34 00 00 00 00 	movl   $0x0,0x34(%ebx)
80100a22:	a1 60 40 10 80       	mov    0x80104060,%eax
80100a27:	8b 40 44             	mov    0x44(%eax),%eax
80100a2a:	8b 54 24 24          	mov    0x24(%esp),%edx
80100a2e:	29 c2                	sub    %eax,%edx
80100a30:	01 53 44             	add    %edx,0x44(%ebx)
80100a33:	8b 43 04             	mov    0x4(%ebx),%eax
80100a36:	83 c4 10             	add    $0x10,%esp
80100a39:	83 c4 08             	add    $0x8,%esp
80100a3c:	5b                   	pop    %ebx
80100a3d:	c3                   	ret    
80100a3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a43:	eb f4                	jmp    80100a39 <fork1+0x6a>

80100a45 <kill>:
80100a45:	f3 0f 1e fb          	endbr32 
80100a49:	8b 54 24 04          	mov    0x4(%esp),%edx
80100a4d:	b8 80 40 10 80       	mov    $0x80104080,%eax
80100a52:	39 50 04             	cmp    %edx,0x4(%eax)
80100a55:	74 10                	je     80100a67 <kill+0x22>
80100a57:	83 c0 74             	add    $0x74,%eax
80100a5a:	3d c0 47 10 80       	cmp    $0x801047c0,%eax
80100a5f:	75 f1                	jne    80100a52 <kill+0xd>
80100a61:	b8 01 00 00 00       	mov    $0x1,%eax
80100a66:	c3                   	ret    
80100a67:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
80100a6d:	b8 00 00 00 00       	mov    $0x0,%eax
80100a72:	c3                   	ret    

80100a73 <exit>:
80100a73:	f3 0f 1e fb          	endbr32 
80100a77:	83 ec 18             	sub    $0x18,%esp
80100a7a:	a1 60 40 10 80       	mov    0x80104060,%eax
80100a7f:	c7 40 2c 5f 08 10 80 	movl   $0x8010085f,0x2c(%eax)
80100a86:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
80100a8c:	a1 60 40 10 80       	mov    0x80104060,%eax
80100a91:	83 c0 0c             	add    $0xc,%eax
80100a94:	50                   	push   %eax
80100a95:	e8 2b 01 00 00       	call   80100bc5 <swtch>
80100a9a:	83 c4 1c             	add    $0x1c,%esp
80100a9d:	c3                   	ret    

80100a9e <sleep>:
80100a9e:	f3 0f 1e fb          	endbr32 
80100aa2:	53                   	push   %ebx
80100aa3:	83 ec 08             	sub    $0x8,%esp
80100aa6:	8b 1d 60 40 10 80    	mov    0x80104060,%ebx
80100aac:	85 db                	test   %ebx,%ebx
80100aae:	74 12                	je     80100ac2 <sleep+0x24>
80100ab0:	8b 44 24 10          	mov    0x10(%esp),%eax
80100ab4:	89 43 2c             	mov    %eax,0x2c(%ebx)
80100ab7:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
80100abd:	83 c4 08             	add    $0x8,%esp
80100ac0:	5b                   	pop    %ebx
80100ac1:	c3                   	ret    
80100ac2:	83 ec 0c             	sub    $0xc,%esp
80100ac5:	68 fb 18 10 80       	push   $0x801018fb
80100aca:	e8 78 fd ff ff       	call   80100847 <panic>
80100acf:	83 c4 10             	add    $0x10,%esp
80100ad2:	eb dc                	jmp    80100ab0 <sleep+0x12>

80100ad4 <wait1>:
80100ad4:	f3 0f 1e fb          	endbr32 
80100ad8:	56                   	push   %esi
80100ad9:	53                   	push   %ebx
80100ada:	83 ec 04             	sub    $0x4,%esp
80100add:	8b 74 24 10          	mov    0x10(%esp),%esi
80100ae1:	bb 80 40 10 80       	mov    $0x80104080,%ebx
80100ae6:	eb 48                	jmp    80100b30 <wait1+0x5c>
80100ae8:	8b 43 08             	mov    0x8(%ebx),%eax
80100aeb:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
80100af1:	8b 43 44             	mov    0x44(%ebx),%eax
80100af4:	83 ec 0c             	sub    $0xc,%esp
80100af7:	83 e8 01             	sub    $0x1,%eax
80100afa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100aff:	50                   	push   %eax
80100b00:	e8 17 fa ff ff       	call   8010051c <kfree>
80100b05:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100b0b:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80100b12:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
80100b19:	8b 43 04             	mov    0x4(%ebx),%eax
80100b1c:	83 c4 10             	add    $0x10,%esp
80100b1f:	83 c4 04             	add    $0x4,%esp
80100b22:	5b                   	pop    %ebx
80100b23:	5e                   	pop    %esi
80100b24:	c3                   	ret    
80100b25:	83 c3 74             	add    $0x74,%ebx
80100b28:	81 fb c0 47 10 80    	cmp    $0x801047c0,%ebx
80100b2e:	74 ef                	je     80100b1f <wait1+0x4b>
80100b30:	8b 53 08             	mov    0x8(%ebx),%edx
80100b33:	a1 60 40 10 80       	mov    0x80104060,%eax
80100b38:	39 d8                	cmp    %ebx,%eax
80100b3a:	74 e9                	je     80100b25 <wait1+0x51>
80100b3c:	39 c2                	cmp    %eax,%edx
80100b3e:	75 e5                	jne    80100b25 <wait1+0x51>
80100b40:	8b 03                	mov    (%ebx),%eax
80100b42:	83 f8 05             	cmp    $0x5,%eax
80100b45:	74 a1                	je     80100ae8 <wait1+0x14>
80100b47:	83 ec 0c             	sub    $0xc,%esp
80100b4a:	56                   	push   %esi
80100b4b:	e8 4e ff ff ff       	call   80100a9e <sleep>
80100b50:	8d 43 0c             	lea    0xc(%ebx),%eax
80100b53:	89 04 24             	mov    %eax,(%esp)
80100b56:	e8 6a 00 00 00       	call   80100bc5 <swtch>
80100b5b:	83 c4 10             	add    $0x10,%esp
80100b5e:	eb c5                	jmp    80100b25 <wait1+0x51>

80100b60 <procdump>:
80100b60:	f3 0f 1e fb          	endbr32 
80100b64:	56                   	push   %esi
80100b65:	53                   	push   %ebx
80100b66:	83 ec 04             	sub    $0x4,%esp
80100b69:	bb 80 40 10 80       	mov    $0x80104080,%ebx
80100b6e:	be 01 19 10 80       	mov    $0x80101901,%esi
80100b73:	eb 22                	jmp    80100b97 <procdump+0x37>
80100b75:	50                   	push   %eax
80100b76:	8b 43 08             	mov    0x8(%ebx),%eax
80100b79:	ff 70 04             	pushl  0x4(%eax)
80100b7c:	ff 73 04             	pushl  0x4(%ebx)
80100b7f:	68 05 19 10 80       	push   $0x80101905
80100b84:	e8 3b f6 ff ff       	call   801001c4 <vprintf>
80100b89:	83 c4 10             	add    $0x10,%esp
80100b8c:	83 c3 74             	add    $0x74,%ebx
80100b8f:	81 fb c0 47 10 80    	cmp    $0x801047c0,%ebx
80100b95:	74 28                	je     80100bbf <procdump+0x5f>
80100b97:	8b 03                	mov    (%ebx),%eax
80100b99:	85 c0                	test   %eax,%eax
80100b9b:	74 ef                	je     80100b8c <procdump+0x2c>
80100b9d:	8b 03                	mov    (%ebx),%eax
80100b9f:	8b 13                	mov    (%ebx),%edx
80100ba1:	89 f0                	mov    %esi,%eax
80100ba3:	83 fa 05             	cmp    $0x5,%edx
80100ba6:	77 cd                	ja     80100b75 <procdump+0x15>
80100ba8:	8b 13                	mov    (%ebx),%edx
80100baa:	83 3c 95 40 19 10 80 	cmpl   $0x0,-0x7fefe6c0(,%edx,4)
80100bb1:	00 
80100bb2:	74 c1                	je     80100b75 <procdump+0x15>
80100bb4:	8b 03                	mov    (%ebx),%eax
80100bb6:	8b 04 85 40 19 10 80 	mov    -0x7fefe6c0(,%eax,4),%eax
80100bbd:	eb b6                	jmp    80100b75 <procdump+0x15>
80100bbf:	83 c4 04             	add    $0x4,%esp
80100bc2:	5b                   	pop    %ebx
80100bc3:	5e                   	pop    %esi
80100bc4:	c3                   	ret    

80100bc5 <swtch>:
80100bc5:	8b 04 24             	mov    (%esp),%eax
80100bc8:	8b 54 24 04          	mov    0x4(%esp),%edx
80100bcc:	83 c4 08             	add    $0x8,%esp
80100bcf:	8b 62 38             	mov    0x38(%edx),%esp
80100bd2:	ff 72 20             	pushl  0x20(%edx)
80100bd5:	89 42 20             	mov    %eax,0x20(%edx)
80100bd8:	8b 42 28             	mov    0x28(%edx),%eax
80100bdb:	c3                   	ret    

80100bdc <fork>:
80100bdc:	54                   	push   %esp
80100bdd:	ff 74 24 04          	pushl  0x4(%esp)
80100be1:	e8 e9 fd ff ff       	call   801009cf <fork1>
80100be6:	83 c4 08             	add    $0x8,%esp
80100be9:	c3                   	ret    

80100bea <wait>:
80100bea:	ff 34 24             	pushl  (%esp)
80100bed:	e8 e2 fe ff ff       	call   80100ad4 <wait1>
80100bf2:	c3                   	ret    

80100bf3 <reserve_error>:
80100bf3:	f3 0f 1e fb          	endbr32 
80100bf7:	83 ec 18             	sub    $0x18,%esp
80100bfa:	68 58 19 10 80       	push   $0x80101958
80100bff:	e8 43 fc ff ff       	call   80100847 <panic>
80100c04:	83 c4 1c             	add    $0x1c,%esp
80100c07:	c3                   	ret    

80100c08 <divide_error>:
80100c08:	f3 0f 1e fb          	endbr32 
80100c0c:	83 ec 18             	sub    $0x18,%esp
80100c0f:	68 67 19 10 80       	push   $0x80101967
80100c14:	e8 2e fc ff ff       	call   80100847 <panic>
80100c19:	83 c4 1c             	add    $0x1c,%esp
80100c1c:	c3                   	ret    

80100c1d <nmi_error>:
80100c1d:	f3 0f 1e fb          	endbr32 
80100c21:	83 ec 18             	sub    $0x18,%esp
80100c24:	68 7a 19 10 80       	push   $0x8010197a
80100c29:	e8 19 fc ff ff       	call   80100847 <panic>
80100c2e:	83 c4 1c             	add    $0x1c,%esp
80100c31:	c3                   	ret    

80100c32 <break_point>:
80100c32:	f3 0f 1e fb          	endbr32 
80100c36:	53                   	push   %ebx
80100c37:	83 ec 14             	sub    $0x14,%esp
80100c3a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
80100c3e:	ff 74 24 38          	pushl  0x38(%esp)
80100c42:	ff 74 24 40          	pushl  0x40(%esp)
80100c46:	ff 74 24 48          	pushl  0x48(%esp)
80100c4a:	ff 74 24 50          	pushl  0x50(%esp)
80100c4e:	68 60 1a 10 80       	push   $0x80101a60
80100c53:	e8 6c f5 ff ff       	call   801001c4 <vprintf>
80100c58:	83 c4 14             	add    $0x14,%esp
80100c5b:	53                   	push   %ebx
80100c5c:	ff 74 24 30          	pushl  0x30(%esp)
80100c60:	ff 74 24 3c          	pushl  0x3c(%esp)
80100c64:	ff 74 24 3c          	pushl  0x3c(%esp)
80100c68:	68 84 1a 10 80       	push   $0x80101a84
80100c6d:	e8 52 f5 ff ff       	call   801001c4 <vprintf>
80100c72:	83 c4 20             	add    $0x20,%esp
80100c75:	ff 73 08             	pushl  0x8(%ebx)
80100c78:	ff 73 04             	pushl  0x4(%ebx)
80100c7b:	ff 33                	pushl  (%ebx)
80100c7d:	68 85 19 10 80       	push   $0x80101985
80100c82:	e8 3d f5 ff ff       	call   801001c4 <vprintf>
80100c87:	83 c4 18             	add    $0x18,%esp
80100c8a:	5b                   	pop    %ebx
80100c8b:	c3                   	ret    

80100c8c <overflow_error>:
80100c8c:	f3 0f 1e fb          	endbr32 
80100c90:	83 ec 18             	sub    $0x18,%esp
80100c93:	68 a0 19 10 80       	push   $0x801019a0
80100c98:	e8 aa fb ff ff       	call   80100847 <panic>
80100c9d:	83 c4 1c             	add    $0x1c,%esp
80100ca0:	c3                   	ret    

80100ca1 <bound_error>:
80100ca1:	f3 0f 1e fb          	endbr32 
80100ca5:	83 ec 18             	sub    $0x18,%esp
80100ca8:	68 b0 19 10 80       	push   $0x801019b0
80100cad:	e8 95 fb ff ff       	call   80100847 <panic>
80100cb2:	83 c4 1c             	add    $0x1c,%esp
80100cb5:	c3                   	ret    

80100cb6 <invalid_code>:
80100cb6:	f3 0f 1e fb          	endbr32 
80100cba:	83 ec 18             	sub    $0x18,%esp
80100cbd:	68 b0 19 10 80       	push   $0x801019b0
80100cc2:	e8 80 fb ff ff       	call   80100847 <panic>
80100cc7:	83 c4 1c             	add    $0x1c,%esp
80100cca:	c3                   	ret    

80100ccb <device_not_available>:
80100ccb:	f3 0f 1e fb          	endbr32 
80100ccf:	83 ec 18             	sub    $0x18,%esp
80100cd2:	68 bd 19 10 80       	push   $0x801019bd
80100cd7:	e8 6b fb ff ff       	call   80100847 <panic>
80100cdc:	83 c4 1c             	add    $0x1c,%esp
80100cdf:	c3                   	ret    

80100ce0 <double_fault>:
80100ce0:	f3 0f 1e fb          	endbr32 
80100ce4:	83 ec 18             	sub    $0x18,%esp
80100ce7:	68 d0 19 10 80       	push   $0x801019d0
80100cec:	e8 56 fb ff ff       	call   80100847 <panic>
80100cf1:	83 c4 1c             	add    $0x1c,%esp
80100cf4:	c3                   	ret    

80100cf5 <coprocessor_segment_overrun>:
80100cf5:	f3 0f 1e fb          	endbr32 
80100cf9:	83 ec 18             	sub    $0x18,%esp
80100cfc:	68 de 19 10 80       	push   $0x801019de
80100d01:	e8 41 fb ff ff       	call   80100847 <panic>
80100d06:	83 c4 1c             	add    $0x1c,%esp
80100d09:	c3                   	ret    

80100d0a <invalid_tss>:
80100d0a:	f3 0f 1e fb          	endbr32 
80100d0e:	83 ec 18             	sub    $0x18,%esp
80100d11:	68 fb 19 10 80       	push   $0x801019fb
80100d16:	e8 2c fb ff ff       	call   80100847 <panic>
80100d1b:	83 c4 1c             	add    $0x1c,%esp
80100d1e:	c3                   	ret    

80100d1f <segment_not_present>:
80100d1f:	f3 0f 1e fb          	endbr32 
80100d23:	83 ec 18             	sub    $0x18,%esp
80100d26:	68 08 1a 10 80       	push   $0x80101a08
80100d2b:	e8 17 fb ff ff       	call   80100847 <panic>
80100d30:	83 c4 1c             	add    $0x1c,%esp
80100d33:	c3                   	ret    

80100d34 <stack_error>:
80100d34:	f3 0f 1e fb          	endbr32 
80100d38:	83 ec 18             	sub    $0x18,%esp
80100d3b:	68 1d 1a 10 80       	push   $0x80101a1d
80100d40:	e8 02 fb ff ff       	call   80100847 <panic>
80100d45:	83 c4 1c             	add    $0x1c,%esp
80100d48:	c3                   	ret    

80100d49 <general_protection>:
80100d49:	f3 0f 1e fb          	endbr32 
80100d4d:	83 ec 18             	sub    $0x18,%esp
80100d50:	68 2a 1a 10 80       	push   $0x80101a2a
80100d55:	e8 ed fa ff ff       	call   80100847 <panic>
80100d5a:	83 c4 1c             	add    $0x1c,%esp
80100d5d:	c3                   	ret    

80100d5e <page_error>:
80100d5e:	f3 0f 1e fb          	endbr32 
80100d62:	83 ec 18             	sub    $0x18,%esp
80100d65:	68 3e 1a 10 80       	push   $0x80101a3e
80100d6a:	e8 d8 fa ff ff       	call   80100847 <panic>
80100d6f:	83 c4 1c             	add    $0x1c,%esp
80100d72:	c3                   	ret    

80100d73 <coprocessor_error>:
80100d73:	f3 0f 1e fb          	endbr32 
80100d77:	83 ec 18             	sub    $0x18,%esp
80100d7a:	68 4a 1a 10 80       	push   $0x80101a4a
80100d7f:	e8 c3 fa ff ff       	call   80100847 <panic>
80100d84:	83 c4 1c             	add    $0x1c,%esp
80100d87:	c3                   	ret    

80100d88 <init_idt>:
80100d88:	f3 0f 1e fb          	endbr32 
80100d8c:	83 ec 10             	sub    $0x10,%esp
80100d8f:	b8 80 00 00 00       	mov    $0x80,%eax
80100d94:	8b 15 04 30 10 80    	mov    0x80103004,%edx
80100d9a:	66 c7 04 02 00 00    	movw   $0x0,(%edx,%eax,1)
80100da0:	8b 15 04 30 10 80    	mov    0x80103004,%edx
80100da6:	66 c7 44 02 02 08 00 	movw   $0x8,0x2(%edx,%eax,1)
80100dad:	8b 0d 04 30 10 80    	mov    0x80103004,%ecx
80100db3:	8d 14 01             	lea    (%ecx,%eax,1),%edx
80100db6:	c6 42 04 00          	movb   $0x0,0x4(%edx)
80100dba:	c6 42 05 8e          	movb   $0x8e,0x5(%edx)
80100dbe:	66 c7 42 06 00 00    	movw   $0x0,0x6(%edx)
80100dc4:	83 c0 08             	add    $0x8,%eax
80100dc7:	3d 00 08 00 00       	cmp    $0x800,%eax
80100dcc:	75 c6                	jne    80100d94 <init_idt+0xc>
80100dce:	ba d1 03 10 80       	mov    $0x801003d1,%edx
80100dd3:	66 89 11             	mov    %dx,(%ecx)
80100dd6:	a1 04 30 10 80       	mov    0x80103004,%eax
80100ddb:	66 c7 40 02 08 00    	movw   $0x8,0x2(%eax)
80100de1:	a1 04 30 10 80       	mov    0x80103004,%eax
80100de6:	c6 40 04 00          	movb   $0x0,0x4(%eax)
80100dea:	c6 40 05 8e          	movb   $0x8e,0x5(%eax)
80100dee:	c1 ea 10             	shr    $0x10,%edx
80100df1:	66 89 50 06          	mov    %dx,0x6(%eax)
80100df5:	ba 04 04 10 80       	mov    $0x80100404,%edx
80100dfa:	66 89 50 08          	mov    %dx,0x8(%eax)
80100dfe:	66 c7 40 0a 08 00    	movw   $0x8,0xa(%eax)
80100e04:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
80100e08:	c6 40 0d 8e          	movb   $0x8e,0xd(%eax)
80100e0c:	c1 ea 10             	shr    $0x10,%edx
80100e0f:	66 89 50 0e          	mov    %dx,0xe(%eax)
80100e13:	ba 0b 04 10 80       	mov    $0x8010040b,%edx
80100e18:	66 89 50 10          	mov    %dx,0x10(%eax)
80100e1c:	66 c7 40 12 08 00    	movw   $0x8,0x12(%eax)
80100e22:	c6 40 14 00          	movb   $0x0,0x14(%eax)
80100e26:	c6 40 15 8e          	movb   $0x8e,0x15(%eax)
80100e2a:	c1 ea 10             	shr    $0x10,%edx
80100e2d:	66 89 50 16          	mov    %dx,0x16(%eax)
80100e31:	ba 12 04 10 80       	mov    $0x80100412,%edx
80100e36:	66 89 50 18          	mov    %dx,0x18(%eax)
80100e3a:	66 c7 40 1a 08 00    	movw   $0x8,0x1a(%eax)
80100e40:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
80100e44:	c6 40 1d 8f          	movb   $0x8f,0x1d(%eax)
80100e48:	c1 ea 10             	shr    $0x10,%edx
80100e4b:	66 89 50 1e          	mov    %dx,0x1e(%eax)
80100e4f:	ba 19 04 10 80       	mov    $0x80100419,%edx
80100e54:	66 89 50 20          	mov    %dx,0x20(%eax)
80100e58:	66 c7 40 22 08 00    	movw   $0x8,0x22(%eax)
80100e5e:	c6 40 24 00          	movb   $0x0,0x24(%eax)
80100e62:	c6 40 25 8f          	movb   $0x8f,0x25(%eax)
80100e66:	c1 ea 10             	shr    $0x10,%edx
80100e69:	66 89 50 26          	mov    %dx,0x26(%eax)
80100e6d:	ba 20 04 10 80       	mov    $0x80100420,%edx
80100e72:	66 89 50 28          	mov    %dx,0x28(%eax)
80100e76:	66 c7 40 2a 08 00    	movw   $0x8,0x2a(%eax)
80100e7c:	c6 40 2c 00          	movb   $0x0,0x2c(%eax)
80100e80:	c6 40 2d 8f          	movb   $0x8f,0x2d(%eax)
80100e84:	c1 ea 10             	shr    $0x10,%edx
80100e87:	66 89 50 2e          	mov    %dx,0x2e(%eax)
80100e8b:	ba 27 04 10 80       	mov    $0x80100427,%edx
80100e90:	66 89 50 30          	mov    %dx,0x30(%eax)
80100e94:	66 c7 40 32 08 00    	movw   $0x8,0x32(%eax)
80100e9a:	c6 40 34 00          	movb   $0x0,0x34(%eax)
80100e9e:	c6 40 35 8e          	movb   $0x8e,0x35(%eax)
80100ea2:	c1 ea 10             	shr    $0x10,%edx
80100ea5:	66 89 50 36          	mov    %dx,0x36(%eax)
80100ea9:	ba 2e 04 10 80       	mov    $0x8010042e,%edx
80100eae:	66 89 50 38          	mov    %dx,0x38(%eax)
80100eb2:	66 c7 40 3a 08 00    	movw   $0x8,0x3a(%eax)
80100eb8:	c6 40 3c 00          	movb   $0x0,0x3c(%eax)
80100ebc:	c6 40 3d 8e          	movb   $0x8e,0x3d(%eax)
80100ec0:	c1 ea 10             	shr    $0x10,%edx
80100ec3:	66 89 50 3e          	mov    %dx,0x3e(%eax)
80100ec7:	ba 35 04 10 80       	mov    $0x80100435,%edx
80100ecc:	66 89 50 40          	mov    %dx,0x40(%eax)
80100ed0:	66 c7 40 42 08 00    	movw   $0x8,0x42(%eax)
80100ed6:	c6 40 44 00          	movb   $0x0,0x44(%eax)
80100eda:	c6 40 45 8e          	movb   $0x8e,0x45(%eax)
80100ede:	c1 ea 10             	shr    $0x10,%edx
80100ee1:	66 89 50 46          	mov    %dx,0x46(%eax)
80100ee5:	ba 3c 04 10 80       	mov    $0x8010043c,%edx
80100eea:	66 89 50 48          	mov    %dx,0x48(%eax)
80100eee:	66 c7 40 4a 08 00    	movw   $0x8,0x4a(%eax)
80100ef4:	c6 40 4c 00          	movb   $0x0,0x4c(%eax)
80100ef8:	c6 40 4d 8e          	movb   $0x8e,0x4d(%eax)
80100efc:	c1 ea 10             	shr    $0x10,%edx
80100eff:	66 89 50 4e          	mov    %dx,0x4e(%eax)
80100f03:	ba 43 04 10 80       	mov    $0x80100443,%edx
80100f08:	66 89 50 50          	mov    %dx,0x50(%eax)
80100f0c:	66 c7 40 52 08 00    	movw   $0x8,0x52(%eax)
80100f12:	c6 40 54 00          	movb   $0x0,0x54(%eax)
80100f16:	c6 40 55 8e          	movb   $0x8e,0x55(%eax)
80100f1a:	c1 ea 10             	shr    $0x10,%edx
80100f1d:	66 89 50 56          	mov    %dx,0x56(%eax)
80100f21:	ba 4a 04 10 80       	mov    $0x8010044a,%edx
80100f26:	66 89 50 58          	mov    %dx,0x58(%eax)
80100f2a:	66 c7 40 5a 08 00    	movw   $0x8,0x5a(%eax)
80100f30:	c6 40 5c 00          	movb   $0x0,0x5c(%eax)
80100f34:	c6 40 5d 8e          	movb   $0x8e,0x5d(%eax)
80100f38:	c1 ea 10             	shr    $0x10,%edx
80100f3b:	66 89 50 5e          	mov    %dx,0x5e(%eax)
80100f3f:	ba 51 04 10 80       	mov    $0x80100451,%edx
80100f44:	66 89 50 60          	mov    %dx,0x60(%eax)
80100f48:	66 c7 40 62 08 00    	movw   $0x8,0x62(%eax)
80100f4e:	c6 40 64 00          	movb   $0x0,0x64(%eax)
80100f52:	c6 40 65 8e          	movb   $0x8e,0x65(%eax)
80100f56:	c1 ea 10             	shr    $0x10,%edx
80100f59:	66 89 50 66          	mov    %dx,0x66(%eax)
80100f5d:	ba 5b 04 10 80       	mov    $0x8010045b,%edx
80100f62:	66 89 50 68          	mov    %dx,0x68(%eax)
80100f66:	66 c7 40 6a 08 00    	movw   $0x8,0x6a(%eax)
80100f6c:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
80100f70:	c6 40 6d 8e          	movb   $0x8e,0x6d(%eax)
80100f74:	c1 ea 10             	shr    $0x10,%edx
80100f77:	66 89 50 6e          	mov    %dx,0x6e(%eax)
80100f7b:	ba 65 04 10 80       	mov    $0x80100465,%edx
80100f80:	66 89 50 70          	mov    %dx,0x70(%eax)
80100f84:	66 c7 40 72 08 00    	movw   $0x8,0x72(%eax)
80100f8a:	c6 40 74 00          	movb   $0x0,0x74(%eax)
80100f8e:	c6 40 75 8e          	movb   $0x8e,0x75(%eax)
80100f92:	c1 ea 10             	shr    $0x10,%edx
80100f95:	66 89 50 76          	mov    %dx,0x76(%eax)
80100f99:	ba 79 04 10 80       	mov    $0x80100479,%edx
80100f9e:	66 89 50 78          	mov    %dx,0x78(%eax)
80100fa2:	66 c7 40 7a 08 00    	movw   $0x8,0x7a(%eax)
80100fa8:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80100fac:	c6 40 7d 8e          	movb   $0x8e,0x7d(%eax)
80100fb0:	c1 ea 10             	shr    $0x10,%edx
80100fb3:	66 89 50 7e          	mov    %dx,0x7e(%eax)
80100fb7:	ba 6f 04 10 80       	mov    $0x8010046f,%edx
80100fbc:	66 89 90 80 00 00 00 	mov    %dx,0x80(%eax)
80100fc3:	66 c7 80 82 00 00 00 	movw   $0x8,0x82(%eax)
80100fca:	08 00 
80100fcc:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80100fd3:	c6 80 85 00 00 00 8e 	movb   $0x8e,0x85(%eax)
80100fda:	c1 ea 10             	shr    $0x10,%edx
80100fdd:	66 89 90 86 00 00 00 	mov    %dx,0x86(%eax)
80100fe4:	ba 83 04 10 80       	mov    $0x80100483,%edx
80100fe9:	66 89 90 08 01 00 00 	mov    %dx,0x108(%eax)
80100ff0:	66 c7 80 0a 01 00 00 	movw   $0x8,0x10a(%eax)
80100ff7:	08 00 
80100ff9:	c6 80 0c 01 00 00 00 	movb   $0x0,0x10c(%eax)
80101000:	c6 80 0d 01 00 00 8e 	movb   $0x8e,0x10d(%eax)
80101007:	c1 ea 10             	shr    $0x10,%edx
8010100a:	66 89 90 0e 01 00 00 	mov    %dx,0x10e(%eax)
80101011:	66 c7 44 24 0a ff 07 	movw   $0x7ff,0xa(%esp)
80101018:	66 c7 44 24 0c 00 7e 	movw   $0x7e00,0xc(%esp)
8010101f:	66 c7 44 24 0e 00 00 	movw   $0x0,0xe(%esp)
80101026:	8d 44 24 0a          	lea    0xa(%esp),%eax
8010102a:	0f 01 18             	lidtl  (%eax)
8010102d:	83 c4 10             	add    $0x10,%esp
80101030:	c3                   	ret    

80101031 <init_pic>:
80101031:	f3 0f 1e fb          	endbr32 
80101035:	56                   	push   %esi
80101036:	53                   	push   %ebx
80101037:	bb 11 00 00 00       	mov    $0x11,%ebx
8010103c:	ba 20 00 00 00       	mov    $0x20,%edx
80101041:	89 d8                	mov    %ebx,%eax
80101043:	ee                   	out    %al,(%dx)
80101044:	b9 21 00 00 00       	mov    $0x21,%ecx
80101049:	b8 20 00 00 00       	mov    $0x20,%eax
8010104e:	89 ca                	mov    %ecx,%edx
80101050:	ee                   	out    %al,(%dx)
80101051:	b8 04 00 00 00       	mov    $0x4,%eax
80101056:	ee                   	out    %al,(%dx)
80101057:	be 01 00 00 00       	mov    $0x1,%esi
8010105c:	89 f0                	mov    %esi,%eax
8010105e:	ee                   	out    %al,(%dx)
8010105f:	ba a0 00 00 00       	mov    $0xa0,%edx
80101064:	89 d8                	mov    %ebx,%eax
80101066:	ee                   	out    %al,(%dx)
80101067:	bb a1 00 00 00       	mov    $0xa1,%ebx
8010106c:	b8 28 00 00 00       	mov    $0x28,%eax
80101071:	89 da                	mov    %ebx,%edx
80101073:	ee                   	out    %al,(%dx)
80101074:	b8 02 00 00 00       	mov    $0x2,%eax
80101079:	ee                   	out    %al,(%dx)
8010107a:	89 f0                	mov    %esi,%eax
8010107c:	ee                   	out    %al,(%dx)
8010107d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101082:	89 ca                	mov    %ecx,%edx
80101084:	ee                   	out    %al,(%dx)
80101085:	89 da                	mov    %ebx,%edx
80101087:	ee                   	out    %al,(%dx)
80101088:	b8 f9 ff ff ff       	mov    $0xfffffff9,%eax
8010108d:	89 ca                	mov    %ecx,%edx
8010108f:	ee                   	out    %al,(%dx)
80101090:	5b                   	pop    %ebx
80101091:	5e                   	pop    %esi
80101092:	c3                   	ret    

80101093 <piceoi>:
80101093:	f3 0f 1e fb          	endbr32 
80101097:	b8 20 00 00 00       	mov    $0x20,%eax
8010109c:	ba 20 00 00 00       	mov    $0x20,%edx
801010a1:	ee                   	out    %al,(%dx)
801010a2:	ba a0 00 00 00       	mov    $0xa0,%edx
801010a7:	ee                   	out    %al,(%dx)
801010a8:	c3                   	ret    

801010a9 <kk>:
801010a9:	f3 0f 1e fb          	endbr32 
801010ad:	c3                   	ret    

801010ae <umain>:
801010ae:	f3 0f 1e fb          	endbr32 
801010b2:	83 ec 0c             	sub    $0xc,%esp
801010b5:	e8 22 fb ff ff       	call   80100bdc <fork>
801010ba:	85 c0                	test   %eax,%eax
801010bc:	7e 37                	jle    801010f5 <umain+0x47>
801010be:	83 ec 0c             	sub    $0xc,%esp
801010c1:	68 a5 1a 10 80       	push   $0x80101aa5
801010c6:	e8 f9 f0 ff ff       	call   801001c4 <vprintf>
801010cb:	e8 1a fb ff ff       	call   80100bea <wait>
801010d0:	c7 04 24 a5 1a 10 80 	movl   $0x80101aa5,(%esp)
801010d7:	e8 e8 f0 ff ff       	call   801001c4 <vprintf>
801010dc:	83 c4 10             	add    $0x10,%esp
801010df:	83 ec 0c             	sub    $0xc,%esp
801010e2:	68 c0 1a 10 80       	push   $0x80101ac0
801010e7:	e8 d8 f0 ff ff       	call   801001c4 <vprintf>
801010ec:	e8 82 f9 ff ff       	call   80100a73 <exit>
801010f1:	83 c4 1c             	add    $0x1c,%esp
801010f4:	c3                   	ret    
801010f5:	83 ec 0c             	sub    $0xc,%esp
801010f8:	68 b0 1a 10 80       	push   $0x80101ab0
801010fd:	e8 c2 f0 ff ff       	call   801001c4 <vprintf>
80101102:	e8 6c f9 ff ff       	call   80100a73 <exit>
80101107:	83 c4 10             	add    $0x10,%esp
8010110a:	eb d3                	jmp    801010df <umain+0x31>

8010110c <mappages>:
8010110c:	55                   	push   %ebp
8010110d:	57                   	push   %edi
8010110e:	56                   	push   %esi
8010110f:	53                   	push   %ebx
80101110:	83 ec 1c             	sub    $0x1c,%esp
80101113:	89 44 24 04          	mov    %eax,0x4(%esp)
80101117:	89 d0                	mov    %edx,%eax
80101119:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010111e:	89 c5                	mov    %eax,%ebp
80101120:	8b 5c 24 30          	mov    0x30(%esp),%ebx
80101124:	8d 54 1a ff          	lea    -0x1(%edx,%ebx,1),%edx
80101128:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010112e:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101132:	29 c1                	sub    %eax,%ecx
80101134:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101138:	eb 41                	jmp    8010117b <mappages+0x6f>
8010113a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010113f:	89 e9                	mov    %ebp,%ecx
80101141:	c1 e9 0a             	shr    $0xa,%ecx
80101144:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
8010114a:	8d b4 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%esi
80101151:	85 f6                	test   %esi,%esi
80101153:	0f 84 ae 00 00 00    	je     80101207 <mappages+0xfb>
80101159:	f6 06 01             	testb  $0x1,(%esi)
8010115c:	0f 85 8b 00 00 00    	jne    801011ed <mappages+0xe1>
80101162:	0b 5c 24 34          	or     0x34(%esp),%ebx
80101166:	83 cb 01             	or     $0x1,%ebx
80101169:	89 1e                	mov    %ebx,(%esi)
8010116b:	3b 6c 24 0c          	cmp    0xc(%esp),%ebp
8010116f:	0f 84 9c 00 00 00    	je     80101211 <mappages+0x105>
80101175:	81 c5 00 10 00 00    	add    $0x1000,%ebp
8010117b:	89 2c 24             	mov    %ebp,(%esp)
8010117e:	8b 44 24 08          	mov    0x8(%esp),%eax
80101182:	8d 1c 28             	lea    (%eax,%ebp,1),%ebx
80101185:	89 e8                	mov    %ebp,%eax
80101187:	c1 e8 16             	shr    $0x16,%eax
8010118a:	8b 7c 24 04          	mov    0x4(%esp),%edi
8010118e:	8d 34 87             	lea    (%edi,%eax,4),%esi
80101191:	8b 06                	mov    (%esi),%eax
80101193:	89 c2                	mov    %eax,%edx
80101195:	83 e2 01             	and    $0x1,%edx
80101198:	75 a0                	jne    8010113a <mappages+0x2e>
8010119a:	e8 3d f4 ff ff       	call   801005dc <kalloc>
8010119f:	89 c2                	mov    %eax,%edx
801011a1:	85 c0                	test   %eax,%eax
801011a3:	74 5d                	je     80101202 <mappages+0xf6>
801011a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801011ab:	c7 80 fc 0f 00 00 00 	movl   $0x0,0xffc(%eax)
801011b2:	00 00 00 
801011b5:	8d 78 04             	lea    0x4(%eax),%edi
801011b8:	83 e7 fc             	and    $0xfffffffc,%edi
801011bb:	89 c1                	mov    %eax,%ecx
801011bd:	29 f9                	sub    %edi,%ecx
801011bf:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801011c5:	c1 e9 02             	shr    $0x2,%ecx
801011c8:	b8 00 00 00 00       	mov    $0x0,%eax
801011cd:	f3 ab                	rep stos %eax,%es:(%edi)
801011cf:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801011d5:	83 c8 07             	or     $0x7,%eax
801011d8:	89 06                	mov    %eax,(%esi)
801011da:	8b 34 24             	mov    (%esp),%esi
801011dd:	c1 ee 0a             	shr    $0xa,%esi
801011e0:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801011e6:	01 d6                	add    %edx,%esi
801011e8:	e9 6c ff ff ff       	jmp    80101159 <mappages+0x4d>
801011ed:	83 ec 0c             	sub    $0xc,%esp
801011f0:	68 ce 1a 10 80       	push   $0x80101ace
801011f5:	e8 4d f6 ff ff       	call   80100847 <panic>
801011fa:	83 c4 10             	add    $0x10,%esp
801011fd:	e9 60 ff ff ff       	jmp    80101162 <mappages+0x56>
80101202:	ba 01 00 00 00       	mov    $0x1,%edx
80101207:	89 d0                	mov    %edx,%eax
80101209:	83 c4 1c             	add    $0x1c,%esp
8010120c:	5b                   	pop    %ebx
8010120d:	5e                   	pop    %esi
8010120e:	5f                   	pop    %edi
8010120f:	5d                   	pop    %ebp
80101210:	c3                   	ret    
80101211:	ba 00 00 00 00       	mov    $0x0,%edx
80101216:	eb ef                	jmp    80101207 <mappages+0xfb>

80101218 <seginit>:
80101218:	f3 0f 1e fb          	endbr32 
8010121c:	83 ec 1c             	sub    $0x1c,%esp
8010121f:	e8 b8 f3 ff ff       	call   801005dc <kalloc>
80101224:	a3 c0 47 10 80       	mov    %eax,0x801047c0
80101229:	85 c0                	test   %eax,%eax
8010122b:	74 7c                	je     801012a9 <seginit+0x91>
8010122d:	a1 c0 47 10 80       	mov    0x801047c0,%eax
80101232:	66 c7 00 00 00       	movw   $0x0,(%eax)
80101237:	66 c7 40 02 00 00    	movw   $0x0,0x2(%eax)
8010123d:	c6 40 04 00          	movb   $0x0,0x4(%eax)
80101241:	c6 40 05 90          	movb   $0x90,0x5(%eax)
80101245:	c6 40 06 c0          	movb   $0xc0,0x6(%eax)
80101249:	c6 40 07 00          	movb   $0x0,0x7(%eax)
8010124d:	a1 c0 47 10 80       	mov    0x801047c0,%eax
80101252:	66 c7 40 08 ff ff    	movw   $0xffff,0x8(%eax)
80101258:	66 c7 40 0a 00 00    	movw   $0x0,0xa(%eax)
8010125e:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
80101262:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80101266:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
8010126a:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
8010126e:	66 c7 40 10 ff ff    	movw   $0xffff,0x10(%eax)
80101274:	66 c7 40 12 00 00    	movw   $0x0,0x12(%eax)
8010127a:	c6 40 14 00          	movb   $0x0,0x14(%eax)
8010127e:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80101282:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
80101286:	c6 40 17 00          	movb   $0x0,0x17(%eax)
8010128a:	66 c7 44 24 0a ff 0f 	movw   $0xfff,0xa(%esp)
80101291:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
80101296:	c1 e8 10             	shr    $0x10,%eax
80101299:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
8010129e:	8d 44 24 0a          	lea    0xa(%esp),%eax
801012a2:	0f 01 10             	lgdtl  (%eax)
801012a5:	83 c4 1c             	add    $0x1c,%esp
801012a8:	c3                   	ret    
801012a9:	83 ec 0c             	sub    $0xc,%esp
801012ac:	68 d4 1a 10 80       	push   $0x80101ad4
801012b1:	e8 91 f5 ff ff       	call   80100847 <panic>
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	e9 6f ff ff ff       	jmp    8010122d <seginit+0x15>

801012be <kvminit>:
801012be:	f3 0f 1e fb          	endbr32 
801012c2:	55                   	push   %ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	83 ec 0c             	sub    $0xc,%esp
801012c9:	e8 0e f3 ff ff       	call   801005dc <kalloc>
801012ce:	85 c0                	test   %eax,%eax
801012d0:	75 08                	jne    801012da <kvminit+0x1c>
801012d2:	83 c4 0c             	add    $0xc,%esp
801012d5:	5b                   	pop    %ebx
801012d6:	5e                   	pop    %esi
801012d7:	5f                   	pop    %edi
801012d8:	5d                   	pop    %ebp
801012d9:	c3                   	ret    
801012da:	89 c6                	mov    %eax,%esi
801012dc:	89 c5                	mov    %eax,%ebp
801012de:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801012e4:	c7 80 fc 0f 00 00 00 	movl   $0x0,0xffc(%eax)
801012eb:	00 00 00 
801012ee:	8d 78 04             	lea    0x4(%eax),%edi
801012f1:	83 e7 fc             	and    $0xfffffffc,%edi
801012f4:	89 c1                	mov    %eax,%ecx
801012f6:	29 f9                	sub    %edi,%ecx
801012f8:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801012fe:	c1 e9 02             	shr    $0x2,%ecx
80101301:	b8 00 00 00 00       	mov    $0x0,%eax
80101306:	f3 ab                	rep stos %eax,%es:(%edi)
80101308:	83 ec 08             	sub    $0x8,%esp
8010130b:	6a 02                	push   $0x2
8010130d:	68 00 00 40 00       	push   $0x400000
80101312:	ba 00 00 00 00       	mov    $0x0,%edx
80101317:	89 f0                	mov    %esi,%eax
80101319:	e8 ee fd ff ff       	call   8010110c <mappages>
8010131e:	83 c4 10             	add    $0x10,%esp
80101321:	85 c0                	test   %eax,%eax
80101323:	75 22                	jne    80101347 <kvminit+0x89>
80101325:	83 ec 08             	sub    $0x8,%esp
80101328:	6a 02                	push   $0x2
8010132a:	68 00 00 40 00       	push   $0x400000
8010132f:	b9 00 00 00 00       	mov    $0x0,%ecx
80101334:	ba 00 00 00 80       	mov    $0x80000000,%edx
80101339:	89 f0                	mov    %esi,%eax
8010133b:	e8 cc fd ff ff       	call   8010110c <mappages>
80101340:	83 c4 10             	add    $0x10,%esp
80101343:	85 c0                	test   %eax,%eax
80101345:	74 10                	je     80101357 <kvminit+0x99>
80101347:	83 ec 0c             	sub    $0xc,%esp
8010134a:	68 ea 1a 10 80       	push   $0x80101aea
8010134f:	e8 f3 f4 ff ff       	call   80100847 <panic>
80101354:	83 c4 10             	add    $0x10,%esp
80101357:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010135d:	0f 22 d8             	mov    %eax,%cr3
80101360:	81 c6 04 08 00 00    	add    $0x804,%esi
80101366:	bb 00 00 40 00       	mov    $0x400000,%ebx
8010136b:	eb 3e                	jmp    801013ab <kvminit+0xed>
8010136d:	83 ec 0c             	sub    $0xc,%esp
80101370:	68 ea 1a 10 80       	push   $0x80101aea
80101375:	e8 cd f4 ff ff       	call   80100847 <panic>
8010137a:	83 c4 10             	add    $0x10,%esp
8010137d:	83 ec 08             	sub    $0x8,%esp
80101380:	8d 83 00 00 40 80    	lea    -0x7fc00000(%ebx),%eax
80101386:	50                   	push   %eax
80101387:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010138d:	50                   	push   %eax
8010138e:	e8 00 f2 ff ff       	call   80100593 <freerange>
80101393:	81 c3 00 00 40 00    	add    $0x400000,%ebx
80101399:	83 c6 04             	add    $0x4,%esi
8010139c:	83 c4 10             	add    $0x10,%esp
8010139f:	81 fb 00 00 40 01    	cmp    $0x1400000,%ebx
801013a5:	0f 84 27 ff ff ff    	je     801012d2 <kvminit+0x14>
801013ab:	89 d8                	mov    %ebx,%eax
801013ad:	0c 82                	or     $0x82,%al
801013af:	89 86 00 f8 ff ff    	mov    %eax,-0x800(%esi)
801013b5:	89 06                	mov    %eax,(%esi)
801013b7:	83 ec 08             	sub    $0x8,%esp
801013ba:	6a 02                	push   $0x2
801013bc:	68 00 00 40 00       	push   $0x400000
801013c1:	89 d9                	mov    %ebx,%ecx
801013c3:	89 da                	mov    %ebx,%edx
801013c5:	89 e8                	mov    %ebp,%eax
801013c7:	e8 40 fd ff ff       	call   8010110c <mappages>
801013cc:	83 c4 10             	add    $0x10,%esp
801013cf:	85 c0                	test   %eax,%eax
801013d1:	75 9a                	jne    8010136d <kvminit+0xaf>
801013d3:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
801013d9:	83 ec 08             	sub    $0x8,%esp
801013dc:	6a 02                	push   $0x2
801013de:	68 00 00 40 00       	push   $0x400000
801013e3:	89 d9                	mov    %ebx,%ecx
801013e5:	89 e8                	mov    %ebp,%eax
801013e7:	e8 20 fd ff ff       	call   8010110c <mappages>
801013ec:	83 c4 10             	add    $0x10,%esp
801013ef:	85 c0                	test   %eax,%eax
801013f1:	74 8a                	je     8010137d <kvminit+0xbf>
801013f3:	e9 75 ff ff ff       	jmp    8010136d <kvminit+0xaf>

801013f8 <deallocvm>:
801013f8:	f3 0f 1e fb          	endbr32 
801013fc:	55                   	push   %ebp
801013fd:	57                   	push   %edi
801013fe:	56                   	push   %esi
801013ff:	53                   	push   %ebx
80101400:	83 ec 1c             	sub    $0x1c,%esp
80101403:	8b 6c 24 30          	mov    0x30(%esp),%ebp
80101407:	8b 7c 24 34          	mov    0x34(%esp),%edi
8010140b:	89 f8                	mov    %edi,%eax
8010140d:	39 7c 24 38          	cmp    %edi,0x38(%esp)
80101411:	73 18                	jae    8010142b <deallocvm+0x33>
80101413:	8b 44 24 38          	mov    0x38(%esp),%eax
80101417:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010141d:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80101423:	39 df                	cmp    %ebx,%edi
80101425:	77 4c                	ja     80101473 <deallocvm+0x7b>
80101427:	8b 44 24 38          	mov    0x38(%esp),%eax
8010142b:	83 c4 1c             	add    $0x1c,%esp
8010142e:	5b                   	pop    %ebx
8010142f:	5e                   	pop    %esi
80101430:	5f                   	pop    %edi
80101431:	5d                   	pop    %ebp
80101432:	c3                   	ret    
80101433:	c1 e2 16             	shl    $0x16,%edx
80101436:	8d 9a 00 f0 3f 00    	lea    0x3ff000(%edx),%ebx
8010143c:	eb 2b                	jmp    80101469 <deallocvm+0x71>
8010143e:	83 ec 0c             	sub    $0xc,%esp
80101441:	68 dc 17 10 80       	push   $0x801017dc
80101446:	e8 fc f3 ff ff       	call   80100847 <panic>
8010144b:	83 c4 10             	add    $0x10,%esp
8010144e:	83 ec 0c             	sub    $0xc,%esp
80101451:	8b 44 24 18          	mov    0x18(%esp),%eax
80101455:	05 00 00 00 80       	add    $0x80000000,%eax
8010145a:	50                   	push   %eax
8010145b:	e8 bc f0 ff ff       	call   8010051c <kfree>
80101460:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101466:	83 c4 10             	add    $0x10,%esp
80101469:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010146f:	39 df                	cmp    %ebx,%edi
80101471:	76 b4                	jbe    80101427 <deallocvm+0x2f>
80101473:	89 da                	mov    %ebx,%edx
80101475:	c1 ea 16             	shr    $0x16,%edx
80101478:	8b 44 95 00          	mov    0x0(%ebp,%edx,4),%eax
8010147c:	a8 01                	test   $0x1,%al
8010147e:	74 b3                	je     80101433 <deallocvm+0x3b>
80101480:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80101485:	89 d9                	mov    %ebx,%ecx
80101487:	c1 e9 0a             	shr    $0xa,%ecx
8010148a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80101490:	8d b4 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%esi
80101497:	85 f6                	test   %esi,%esi
80101499:	74 98                	je     80101433 <deallocvm+0x3b>
8010149b:	8b 06                	mov    (%esi),%eax
8010149d:	a8 01                	test   $0x1,%al
8010149f:	74 c8                	je     80101469 <deallocvm+0x71>
801014a1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801014a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
801014aa:	75 a2                	jne    8010144e <deallocvm+0x56>
801014ac:	eb 90                	jmp    8010143e <deallocvm+0x46>

801014ae <allocvm>:
801014ae:	f3 0f 1e fb          	endbr32 
801014b2:	55                   	push   %ebp
801014b3:	57                   	push   %edi
801014b4:	56                   	push   %esi
801014b5:	53                   	push   %ebx
801014b6:	83 ec 0c             	sub    $0xc,%esp
801014b9:	8b 7c 24 28          	mov    0x28(%esp),%edi
801014bd:	bb 00 00 00 00       	mov    $0x0,%ebx
801014c2:	81 ff 00 00 00 80    	cmp    $0x80000000,%edi
801014c8:	77 74                	ja     8010153e <allocvm+0x90>
801014ca:	8b 5c 24 24          	mov    0x24(%esp),%ebx
801014ce:	3b 7c 24 24          	cmp    0x24(%esp),%edi
801014d2:	72 6a                	jb     8010153e <allocvm+0x90>
801014d4:	8d b7 ff 0f 00 00    	lea    0xfff(%edi),%esi
801014da:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801014e0:	39 f7                	cmp    %esi,%edi
801014e2:	76 58                	jbe    8010153c <allocvm+0x8e>
801014e4:	8d 47 ff             	lea    -0x1(%edi),%eax
801014e7:	29 f0                	sub    %esi,%eax
801014e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801014ee:	8d ac 06 00 10 00 00 	lea    0x1000(%esi,%eax,1),%ebp
801014f5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
801014f9:	e8 de f0 ff ff       	call   801005dc <kalloc>
801014fe:	85 c0                	test   %eax,%eax
80101500:	74 46                	je     80101548 <allocvm+0x9a>
80101502:	83 ec 04             	sub    $0x4,%esp
80101505:	68 00 10 00 00       	push   $0x1000
8010150a:	6a 00                	push   $0x0
8010150c:	6a 00                	push   $0x0
8010150e:	e8 d5 f2 ff ff       	call   801007e8 <memset>
80101513:	83 c4 08             	add    $0x8,%esp
80101516:	6a 06                	push   $0x6
80101518:	68 00 10 00 00       	push   $0x1000
8010151d:	b9 00 00 00 80       	mov    $0x80000000,%ecx
80101522:	89 f2                	mov    %esi,%edx
80101524:	89 d8                	mov    %ebx,%eax
80101526:	e8 e1 fb ff ff       	call   8010110c <mappages>
8010152b:	83 c4 10             	add    $0x10,%esp
8010152e:	85 c0                	test   %eax,%eax
80101530:	75 3b                	jne    8010156d <allocvm+0xbf>
80101532:	81 c6 00 10 00 00    	add    $0x1000,%esi
80101538:	39 ee                	cmp    %ebp,%esi
8010153a:	75 bd                	jne    801014f9 <allocvm+0x4b>
8010153c:	89 fb                	mov    %edi,%ebx
8010153e:	89 d8                	mov    %ebx,%eax
80101540:	83 c4 0c             	add    $0xc,%esp
80101543:	5b                   	pop    %ebx
80101544:	5e                   	pop    %esi
80101545:	5f                   	pop    %edi
80101546:	5d                   	pop    %ebp
80101547:	c3                   	ret    
80101548:	89 c3                	mov    %eax,%ebx
8010154a:	83 ec 0c             	sub    $0xc,%esp
8010154d:	68 01 1b 10 80       	push   $0x80101b01
80101552:	e8 6d ec ff ff       	call   801001c4 <vprintf>
80101557:	83 c4 0c             	add    $0xc,%esp
8010155a:	ff 74 24 28          	pushl  0x28(%esp)
8010155e:	57                   	push   %edi
8010155f:	ff 74 24 2c          	pushl  0x2c(%esp)
80101563:	e8 90 fe ff ff       	call   801013f8 <deallocvm>
80101568:	83 c4 10             	add    $0x10,%esp
8010156b:	eb d1                	jmp    8010153e <allocvm+0x90>
8010156d:	83 ec 0c             	sub    $0xc,%esp
80101570:	68 19 1b 10 80       	push   $0x80101b19
80101575:	e8 4a ec ff ff       	call   801001c4 <vprintf>
8010157a:	83 c4 0c             	add    $0xc,%esp
8010157d:	ff 74 24 28          	pushl  0x28(%esp)
80101581:	57                   	push   %edi
80101582:	ff 74 24 2c          	pushl  0x2c(%esp)
80101586:	e8 6d fe ff ff       	call   801013f8 <deallocvm>
8010158b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80101592:	e8 85 ef ff ff       	call   8010051c <kfree>
80101597:	83 c4 10             	add    $0x10,%esp
8010159a:	bb 00 00 00 00       	mov    $0x0,%ebx
8010159f:	eb 9d                	jmp    8010153e <allocvm+0x90>

801015a1 <freevm>:
801015a1:	f3 0f 1e fb          	endbr32 
801015a5:	57                   	push   %edi
801015a6:	56                   	push   %esi
801015a7:	53                   	push   %ebx
801015a8:	8b 7c 24 10          	mov    0x10(%esp),%edi
801015ac:	85 ff                	test   %edi,%edi
801015ae:	74 0a                	je     801015ba <freevm+0x19>
801015b0:	89 fb                	mov    %edi,%ebx
801015b2:	8d b7 00 10 00 00    	lea    0x1000(%edi),%esi
801015b8:	eb 2f                	jmp    801015e9 <freevm+0x48>
801015ba:	83 ec 0c             	sub    $0xc,%esp
801015bd:	68 35 1b 10 80       	push   $0x80101b35
801015c2:	e8 80 f2 ff ff       	call   80100847 <panic>
801015c7:	83 c4 10             	add    $0x10,%esp
801015ca:	eb e4                	jmp    801015b0 <freevm+0xf>
801015cc:	83 ec 0c             	sub    $0xc,%esp
801015cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801015d4:	05 00 00 00 80       	add    $0x80000000,%eax
801015d9:	50                   	push   %eax
801015da:	e8 3d ef ff ff       	call   8010051c <kfree>
801015df:	83 c4 10             	add    $0x10,%esp
801015e2:	83 c3 04             	add    $0x4,%ebx
801015e5:	39 f3                	cmp    %esi,%ebx
801015e7:	74 08                	je     801015f1 <freevm+0x50>
801015e9:	8b 03                	mov    (%ebx),%eax
801015eb:	a8 01                	test   $0x1,%al
801015ed:	74 f3                	je     801015e2 <freevm+0x41>
801015ef:	eb db                	jmp    801015cc <freevm+0x2b>
801015f1:	83 ec 0c             	sub    $0xc,%esp
801015f4:	57                   	push   %edi
801015f5:	e8 22 ef ff ff       	call   8010051c <kfree>
801015fa:	83 c4 10             	add    $0x10,%esp
801015fd:	5b                   	pop    %ebx
801015fe:	5e                   	pop    %esi
801015ff:	5f                   	pop    %edi
80101600:	c3                   	ret    


boots.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <_start>:
    7c00:	31 c0                	xor    %eax,%eax
    7c02:	8e d8                	mov    %eax,%ds
    7c04:	8e c0                	mov    %eax,%es
    7c06:	8e d0                	mov    %eax,%ss
    7c08:	0f 01 16             	lgdtl  (%esi)
    7c0b:	50                   	push   %eax
    7c0c:	7c fa                	jl     7c08 <_start+0x8>
    7c0e:	0f 20 c0             	mov    %cr0,%eax
    7c11:	66 83 c8 01          	or     $0x1,%ax
    7c15:	0f 22 c0             	mov    %eax,%cr0
    7c18:	ea                   	.byte 0xea
    7c19:	1d                   	.byte 0x1d
    7c1a:	7c 08                	jl     7c24 <start32+0x7>
	...

00007c1d <start32>:
    7c1d:	66 b8 10 00          	mov    $0x10,%ax
    7c21:	8e d8                	mov    %eax,%ds
    7c23:	8e c0                	mov    %eax,%es
    7c25:	8e d0                	mov    %eax,%ss
    7c27:	66 b8 00 00          	mov    $0x0,%ax
    7c2b:	8e e0                	mov    %eax,%fs
    7c2d:	8e e8                	mov    %eax,%gs
    7c2f:	e8 ec 00 00 00       	call   7d20 <bootmain>

00007c34 <fin>:
    7c34:	eb fe                	jmp    7c34 <fin>
    7c36:	66 90                	xchg   %ax,%ax

00007c38 <gdt>:
	...
    7c40:	ff                   	(bad)  
    7c41:	ff 00                	incl   (%eax)
    7c43:	00 00                	add    %al,(%eax)
    7c45:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c4c:	00                   	.byte 0x0
    7c4d:	92                   	xchg   %eax,%edx
    7c4e:	cf                   	iret   
	...

00007c50 <gdtdesc>:
    7c50:	17                   	pop    %ss
    7c51:	00 38                	add    %bh,(%eax)
    7c53:	7c 00                	jl     7c55 <gdtdesc+0x5>
	...

00007c56 <waitdisk>:
    7c56:	f3 0f 1e fb          	endbr32 
    7c5a:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c5f:	ec                   	in     (%dx),%al
    7c60:	83 e0 88             	and    $0xffffff88,%eax
    7c63:	3c 08                	cmp    $0x8,%al
    7c65:	75 f8                	jne    7c5f <waitdisk+0x9>
    7c67:	c3                   	ret    

00007c68 <readsect>:
    7c68:	f3 0f 1e fb          	endbr32 
    7c6c:	55                   	push   %ebp
    7c6d:	89 e5                	mov    %esp,%ebp
    7c6f:	57                   	push   %edi
    7c70:	83 ec 04             	sub    $0x4,%esp
    7c73:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    7c76:	b8 01 00 00 00       	mov    $0x1,%eax
    7c7b:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7c80:	ee                   	out    %al,(%dx)
    7c81:	ba f3 01 00 00       	mov    $0x1f3,%edx
    7c86:	89 c8                	mov    %ecx,%eax
    7c88:	ee                   	out    %al,(%dx)
    7c89:	89 c8                	mov    %ecx,%eax
    7c8b:	c1 e8 08             	shr    $0x8,%eax
    7c8e:	ba f4 01 00 00       	mov    $0x1f4,%edx
    7c93:	ee                   	out    %al,(%dx)
    7c94:	89 c8                	mov    %ecx,%eax
    7c96:	c1 e8 10             	shr    $0x10,%eax
    7c99:	ba f5 01 00 00       	mov    $0x1f5,%edx
    7c9e:	ee                   	out    %al,(%dx)
    7c9f:	89 c8                	mov    %ecx,%eax
    7ca1:	c1 e8 18             	shr    $0x18,%eax
    7ca4:	83 c8 e0             	or     $0xffffffe0,%eax
    7ca7:	ba f6 01 00 00       	mov    $0x1f6,%edx
    7cac:	ee                   	out    %al,(%dx)
    7cad:	b8 20 00 00 00       	mov    $0x20,%eax
    7cb2:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7cb7:	ee                   	out    %al,(%dx)
    7cb8:	e8 99 ff ff ff       	call   7c56 <waitdisk>
    7cbd:	8b 7d 08             	mov    0x8(%ebp),%edi
    7cc0:	b9 80 00 00 00       	mov    $0x80,%ecx
    7cc5:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7cca:	fc                   	cld    
    7ccb:	f3 6d                	rep insl (%dx),%es:(%edi)
    7ccd:	83 c4 04             	add    $0x4,%esp
    7cd0:	5f                   	pop    %edi
    7cd1:	5d                   	pop    %ebp
    7cd2:	c3                   	ret    

00007cd3 <readseg>:
    7cd3:	f3 0f 1e fb          	endbr32 
    7cd7:	55                   	push   %ebp
    7cd8:	89 e5                	mov    %esp,%ebp
    7cda:	57                   	push   %edi
    7cdb:	56                   	push   %esi
    7cdc:	53                   	push   %ebx
    7cdd:	83 ec 0c             	sub    $0xc,%esp
    7ce0:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7ce3:	8b 75 10             	mov    0x10(%ebp),%esi
    7ce6:	89 df                	mov    %ebx,%edi
    7ce8:	03 7d 0c             	add    0xc(%ebp),%edi
    7ceb:	89 f0                	mov    %esi,%eax
    7ced:	25 ff 01 00 00       	and    $0x1ff,%eax
    7cf2:	29 c3                	sub    %eax,%ebx
    7cf4:	c1 ee 09             	shr    $0x9,%esi
    7cf7:	83 c6 01             	add    $0x1,%esi
    7cfa:	39 df                	cmp    %ebx,%edi
    7cfc:	76 1a                	jbe    7d18 <readseg+0x45>
    7cfe:	83 ec 08             	sub    $0x8,%esp
    7d01:	56                   	push   %esi
    7d02:	53                   	push   %ebx
    7d03:	e8 60 ff ff ff       	call   7c68 <readsect>
    7d08:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d0e:	83 c6 01             	add    $0x1,%esi
    7d11:	83 c4 10             	add    $0x10,%esp
    7d14:	39 df                	cmp    %ebx,%edi
    7d16:	77 e6                	ja     7cfe <readseg+0x2b>
    7d18:	8d 65 f4             	lea    -0xc(%ebp),%esp
    7d1b:	5b                   	pop    %ebx
    7d1c:	5e                   	pop    %esi
    7d1d:	5f                   	pop    %edi
    7d1e:	5d                   	pop    %ebp
    7d1f:	c3                   	ret    

00007d20 <bootmain>:
    7d20:	f3 0f 1e fb          	endbr32 
    7d24:	55                   	push   %ebp
    7d25:	89 e5                	mov    %esp,%ebp
    7d27:	83 ec 0c             	sub    $0xc,%esp
    7d2a:	6a 00                	push   $0x0
    7d2c:	68 00 50 00 00       	push   $0x5000
    7d31:	68 00 00 10 00       	push   $0x100000
    7d36:	e8 98 ff ff ff       	call   7cd3 <readseg>
    7d3b:	83 c4 10             	add    $0x10,%esp
    7d3e:	81 3d 00 00 10 00 7f 	cmpl   $0x464c457f,0x100000
    7d45:	45 4c 46 
    7d48:	75 06                	jne    7d50 <bootmain+0x30>
    7d4a:	ff 15 18 00 10 00    	call   *0x100018
    7d50:	c9                   	leave  
    7d51:	c3                   	ret    

[org 0x0100]
jmp start
seconds: dw 0
seconds2:dw 0
minutes: dw 0
minutes2:dw 0
hours:dw 0
hours2:dw 0
timerflag: dw 0
oldkb: dd 0
timerset: dw 0
counter: dw 0
h1: db 1
h2:db 0
inputcounter:dw 0
incre:dw 0
t1: db 0
t2:db 0 

printnum:
push bp
mov bp,sp
push es
push ax
push bx
push cx
push dx
push di
mov ax,0xb800
mov es,ax
mov ax,[bp+4]
mov bx,10
mov cx,0

nextdigit:

mov dx,0
div bx
add dl,0x30
push dx
inc cx
cmp ax,0
jnz nextdigit
mov di,[bp+6]
nextpos:
pop dx
mov dh,0x07
mov [es:di],dx
add di,2
loop nextpos

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 4

;------------------
exit:

 mov al, 0x20
 out 0x20, al ; send EOI to PIC
 pop es
 pop di
 pop dx
 pop cx
 pop bx
 pop ax
 iret ;
;-------------------


;===========================================


 
 h1enter:
 cmp word [cs:inputcounter],1
 jl firsthenter
jg exit
 mov byte [cs:h1],al
 mov word [es:0],'H'
 inc word [cs:inputcounter]
jmp exit
 
 
 firsthenter:

 mov byte [cs:h2],al
 mov word [es:2],'h'
 inc word [cs:inputcounter]
 jmp exit
 
 
 
 s1enter:
 cmp word [cs:inputcounter],1
 jl firstsenter
jg exit
 mov byte [cs:h1],al
 mov word [es:4],'S'
 inc word [cs:inputcounter]
jmp exit

firstsenter:

  mov byte [cs:h2],al
  mov word [es:6],'s'
 inc word [cs:inputcounter]
 jmp exit
 
 m1enter:
  cmp word [cs:inputcounter],1
 jl firstmenter
jg exit
 mov byte [cs:h1],al
 mov word [es:8],'M'
 inc word [cs:inputcounter]
jmp exit

firstmenter:
 mov byte [cs:h2],al
 mov word [es:10],'m'
 inc word [cs:inputcounter]
 jmp exit
 


kbisr:
 push ax
 push bx
 push cx
 push dx
 push di
 push es
 mov ax,0xb800
 mov es, ax 
 in al, 0x60	
 cmp al, 0x23
  je h1enter
  
 bothcmp:
 mov bl,[cs:h1]
 mov cl,[cs:h2]
 cmp bl,cl
 je bothequal
 jmp exit
 
 bothequal:
 cmp cl,0x23
 je h2equal
 cmp cl,'m'
 je m2equal
 cmp cl,'s'
 je sequal
 
 jmp exit
 
 
 sequal:
 cmp word [cs:inputcounter],2
	 je changesec
	 cmp word [cs:inputcounter],3
	 je changesec2
	 jmp exit
	 
	 
	 changesec:
	    mov bx,'s'
	 inc word [inputcounter]
	 cmp al,0x02
	 je onetenter
	 cmp al,0x03
	 je twotenter
	 cmp al,0x04
	 je threetenter
	 cmp al,0x05
	 je fourtenter
	 cmp al,0x06
	 je fivetenter
	 cmp al,0x07
	 je sixtenter
	 cmp al,0x08
	 je sevententer
	 cmp al,0x09
	 je eighttenter
	 cmp al,0x0a
	 je ninetenter
	 cmp al,0x0b
	 je zerotenter
	 jmp exit

	m2equal:
jmp m22equal


h2equal:
jmp h22equal
	 changesec2:
	     mov bx,'S'
	
	 cmp al,0x02
	 je onetenter
	 cmp al,0x03
	 je twotenter
	 cmp al,0x04
	 je threetenter
	 cmp al,0x05
	 je fourtenter
	 cmp al,0x06
	 je fivetenter
	 cmp al,0x07
	 je sixtenter
	 cmp al,0x08
	 je sevententer
	 cmp al,0x09
	 je eighttenter
	 cmp al,0x0a
	 je ninetenter
	 cmp al,0x0b
	 je zerotenter
	 mov word [cs:inputcounter],0
	 jmp exit


	 
	 
  	 onetenter:
 jmp onettenter
 
 twotenter:
jmp twottenter


threetenter:
jmp threettenter


fourtenter:
jmp fourttenter


fivetenter:
jmp fivettenter


sixtenter:
jmp sixttenter



m22equal:
jmp mequal

sevententer:
jmp seventtenter



eighttenter:
jmp eighttenter



ninetenter:
jmp ninettenter


zerotenter:
jmp zerottenter







 mequal:
  cmp word [cs:inputcounter],2
	 je changemin
	 cmp word [cs:inputcounter],3
	 je changemin2
	 jmp exit
 
 
 changemin:
        mov bx,'m'
	 inc word [inputcounter]
	 cmp al,0x02
	 je onetenter
	 cmp al,0x03
	 je twotenter
	 cmp al,0x04
	 je threetenter
	 cmp al,0x05
	 je fourtenter
	 cmp al,0x06
	 je fivetenter
	 cmp al,0x07
	 je sixtenter
	 cmp al,0x08
	 je sevententer
	 cmp al,0x09
	 je eighttenter
	 cmp al,0x0a
	 je ninetenter
	 cmp al,0x0b
	 je zerotenter
	 jmp exit



 
 changemin2:
 mov bx,'M'
	 cmp al,0x02
	 je onettenter
	 cmp al,0x03
	 je twottenter
	 cmp al,0x04
	 je threettenter
	 cmp al,0x05
	 je fourttenter
	 cmp al,0x06
	 je fivettenter
	 cmp al,0x07
	 je sixttenter
	 cmp al,0x08
	 je seventtenter
	 cmp al,0x09
	 je eightttenter
	 cmp al,0x0a
	 je ninettenter
	 cmp al,0x0b
	 je zerottenter
	 
	 mov word [cs:inputcounter],0
	 jmp exit
	 
h22equal:
jmp hequal
 

 hequal:
 cmp word [cs:inputcounter],2
	 je changehour
	 cmp word [cs:inputcounter],3
	 je changehour2
	 jmp exit

	 changehour:
	 mov bx,'h'
	 inc word [inputcounter]
	 cmp al,0x02
	 je onettenter
	 cmp al,0x03
	 je twottenter
	 cmp al,0x04
	 je threettenter
	 cmp al,0x05
	 je fourttenter
	 cmp al,0x06
	 je fivettenter
	 cmp al,0x07
	 je sixttenter
	 cmp al,0x08
	 je seventtenter
	 cmp al,0x09
	 je eightttenter
	 cmp al,0x0a
	 je ninettenter
	 cmp al,0x0b
	 je zerottenter
	 jmp exit
	
		
onettenter:
		jmp oneenter
		
		twottenter:
		jmp twoenter
		
		threettenter:
		jmp threeenter
		
		fourttenter:
		jmp fourenter
		
		fivettenter:
		jmp fiveenter
		
		sixttenter:
		jmp sixenter
		
		seventtenter:
		jmp sevenenter
		
		
		eightttenter:
		jmp eightenter
		
		ninettenter:
		jmp nineenter
		
		
		zerottenter:
		jmp zeroenter		
		
		
	
	 changehour2:
	 mov bx,'H'
	 cmp al,0x02
	 je onettenter
	 cmp al,0x03
	 je twottenter
	 cmp al,0x04
	 je threettenter
	 cmp al,0x05
	 je fourttenter
	 cmp al,0x06
	 je fivettenter
	 cmp al,0x07
	 je sixttenter
	 cmp al,0x08
	 je seventtenter
	 cmp al,0x09
	 je eightttenter
	 cmp al,0x0a
	 je ninettenter
	 cmp al,0x0b
	 je zerottenter
	 
	 mov word  [cs:inputcounter],0
	 jmp exit
	
	



	
	 
	 oneenter:
	 cmp bx,'h'
	 jne n1
	 mov word [cs:hours],1
	 jmp exit
	 n1:
	 cmp bx,'H'
	 jne n2
	 mov word [cs:hours2],1
	 jmp exit
	 n2:
	 cmp bx,'m'
	 jne n3
	 mov word [cs:minutes],1
	 jmp exit
	 n3:
	 cmp bx,'M'
	 jne n4
	 mov word[cs:minutes2],1
	 jmp exit
	 n4:
	 cmp bx,'s'
	 jne n5
	 mov word[ cs:seconds],1
	 jmp exit
	 n5:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],1
	 jmp exit

	
	
	 twoenter:
	 cmp bx,'h'
	 jne n6
	 mov word[cs:hours],2
	 jmp exit
	 n6:
	 cmp bx,'H'
	 jne n7
	 mov word[cs:hours2],2
	 jmp exit
	 n7:
	 cmp bx,'m'
	 jne n8
	 mov word[cs:minutes],2
	 jmp exit
	 n8:
	 cmp bx,'M'
	 jne n9
	 mov word[cs:minutes2],2
	 jmp exit
	 n9:
	 cmp bx,'s'
	 jne n10
	 mov word[ cs:seconds],2
	 jmp exit
	 n10:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],2
	 jmp exit
	 
	 
	 
	 
	 threeenter:
	 cmp bx,'h'
	 jne n11
	 mov word[cs:hours],3
	 jmp exit
	 n11:
	 cmp bx,'H'
	 jne n12
	 mov word[cs:hours2],3
	 jmp exit
	 n12:
	 cmp bx,'m'
	 jne n13
	 mov word[cs:minutes],3
	 jmp exit
	 n13:
	 cmp bx,'M'
	 jne n14
	 mov word[cs:minutes2],3
	 jmp exit
	 n14:
	 cmp bx,'s'
	 jne n15
	 mov word[ cs:seconds],3
	 jmp exit
	 n15:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],3
	 jmp exit
	
	
	fourenter:
	cmp bx,'h'
	 jne n16
	 mov word[cs:hours],4
	 jmp exit
	 n16:
	 cmp bx,'H'
	 jne n17
	 mov word[cs:hours2],4
	 jmp exit
	 n17:
	 cmp bx,'m'
	 jne n18
	 mov word[cs:minutes],4
	 jmp exit
	 n18:
	 cmp bx,'M'
	 jne n19
	 mov word[cs:minutes2],4
	 jmp exit
	 n19:
	 cmp bx,'s'
	 jne n20
	 mov word[ cs:seconds],4
	 jmp exit
	 n20:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],4
	 jmp exit

	 fiveenter:
	 cmp bx,'h'
	 jne n21
	 mov word[cs:hours],5
	 jmp exit
	 n21:
	 cmp bx,'H'
	 jne n22
	 mov word[cs:hours2],5
	 jmp exit
	 n22:
	 cmp bx,'m'
	 jne n23
	 mov word[cs:minutes],5
	 jmp exit
	 n23:
	 cmp bx,'M'
	 jne n24
	 mov word[cs:minutes2],5
	 jmp exit
	 n24:
	 cmp bx,'s'
	 jne n25
	 mov word[ cs:seconds],5
	 jmp exit
	 n25:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],5
	 jmp exit
	 
	 sixenter:
	 cmp bx,'h'
	 jne n26
	 mov word[cs:hours],6
	 jmp exit
	 n26:
	 cmp bx,'H'
	 jne n27
	 mov word[cs:hours2],6
	 jmp exit
	 n27:
	 cmp bx,'m'
	 jne n28
	 mov word[cs:minutes],6
	 jmp exit
	 n28:
	 cmp bx,'M'
	 jne n29
	 mov word[cs:minutes2],6
	 jmp exit
	 n29:
	 cmp bx,'s'
	 jne n30
	 mov word[ cs:seconds],6
	 jmp exit
	 n30:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],6
	 jmp exit
	 sevenenter:
	 cmp bx,'h'
	 jne n31
	 mov word[cs:hours],7
	 jmp exit
	 n31:
	 cmp bx,'H'
	 jne n32
	 mov word[cs:hours2],7
	 jmp exit
	 n32:
	 cmp bx,'m'
	 jne n33
	 mov word[cs:minutes],7
	 jmp exit
	 n33:
	 cmp bx,'M'
	 jne n34
	 mov word[cs:minutes2],7
	 jmp exit
	 n34:
	 cmp bx,'s'
	 jne n35
	 mov word[ cs:seconds],7
	 jmp exit
	 n35:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],7
	 jmp exit
 
	 eightenter:
	 cmp bx,'h'
	 jne n36
	 mov word[cs:hours],8
	 jmp exit
	 n36:
	 cmp bx,'H'
	 jne n37
	 mov word[cs:hours2],8
	 jmp exit
	 n37:
	 cmp bx,'m'
	 jne n38
	 mov word[cs:minutes],8
	 jmp exit
	 n38:
	 cmp bx,'M'
	 jne n39
	 mov word[cs:minutes2],8
	 jmp exit
	 n39:
	 cmp bx,'s'
	 jne n40
	 mov word[ cs:seconds],8
	 jmp exit
	 n40:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],8
	 jmp exit
	 nineenter:
	 cmp bx,'h'
	 jne n41
	 mov word[cs:hours],9
	 jmp exit
	 n41:
	 cmp bx,'H'
	 jne n42
	 mov word[cs:hours2],9
	 jmp exit
	 n42:
	 cmp bx,'m'
	 jne n43
	 mov word[cs:minutes],9
	 jmp exit
	 n43:
	 cmp bx,'M'
	 jne n44
	 mov word[cs:minutes2],9
	 jmp exit
	 n44:
	 cmp bx,'s'
	 jne n45
	 mov word[ cs:seconds],9
	 jmp exit
	 n45:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],9
	 jmp exit
	 
	 zeroenter:
	 cmp bx,'h'
	 jne n46
	 mov word[cs:hours],0
	 jmp exit
	 n46:
	 cmp bx,'H'
	 jne n47
	 mov word [cs:hours2],0
	 jmp exit
	 n47:
	 cmp bx,'m'
	 jne n48
	 mov word[cs:minutes],0
	 jmp exit
	 n48:
	 cmp bx,'M'
	 jne n49
	 mov word[cs:minutes2],0
	 jmp exit
	 n49:
	 cmp bx,'s'
	 jne n50
	 mov word[ cs:seconds],0
	 jmp exit
	 n50:
	 cmp bx,'S'
	 jne exit
	 mov word[cs:seconds2],0
	 jmp exit
nomatch:
 pop es
 pop di
 pop dx
 pop cx
 pop bx
 pop ax
 jmp far [cs:oldkb] ; call the original ISR
 



;------------------------------------------------;
printing:
push 140
push word [cs:seconds]
call printnum
push 142
push word [cs:seconds2]
call printnum
push 130
push word [cs:minutes]
call printnum
push 132
push word [cs:minutes2]
call printnum
push 120
push word [cs:hours]
call printnum
push 122
push word [cs:hours2]
call printnum

skipall:
mov al,0x20
out 0x20,al

pop ax
iret
;--------------------------------

timer:
push ax

inc word [cs:timerset]
cmp word [cs:timerset],18
jl printing
equal:
mov word [cs:timerset],0
inc word [cs:counter]
cmp word [cs:counter],6
je equal1
jmp op
equal1:
 mov word [cs:counter],0
 op: 
inc word [cs:seconds2]
cmp word [cs:seconds2],10
jne printing
mov word [cs:seconds2],0
inc word [cs:seconds]
cmp word [cs:seconds],6
je increasemin

jmp printing

increasemin:
mov word [cs:seconds],0
mov word [cs:seconds2],0
inc word [cs:minutes2]
cmp word [cs:minutes2],10
jne printing
mov word [cs:minutes2],0
inc word [cs:minutes]
cmp word [cs:minutes],6
je increasehour

jmp printing

increasehour:
mov word [cs:minutes],0
mov word [cs:minutes2],0
inc word  [cs:hours2]
cmp word [cs:hours2],10
jne printing
mov word [cs:hours2],0
inc word [cs:hours]
cmp word [cs:hours],2
je reset
jmp printing
reset:
mov word [cs:hours],0
mov word [cs:hours2],0
jmp printing



start:
xor ax,ax
mov es,ax
mov di,0
mov ax,[es:9*4]
mov [oldkb],ax
mov ax,[es:9*4+2]
mov [oldkb+2],ax
cli
mov word [es:9*4],kbisr
mov [es:9*4+2],cs
mov word [es:8*4],timer
mov [es:8*4+2],cs
sti


mov dx,start
add dx,15
mov cl,4
shr dx,cl
mov ax,0x3100
int 0x21


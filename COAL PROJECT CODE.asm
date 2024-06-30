include irvine32.inc
.data
fnaam byte "ASHAR     ,HUSSSAM   ,BILAL     ,MUQEET      ",0
lnaam byte "ZAMIR     ,UDDIN     ,AHMED     ,UREHMAN    ",0
mom byte   "WOMEN1    ,WOMEN2    ,WOMEN3    ,WOMEN4    ",0
dad byte   "WASEEM    ,UNCLE1    ,INTAIKHAB ,ZAKI     ",0
dob byte   "02/17/2004,10/29/2006,02/17/1994,10/29/2004",0
head2 byte "NADRA",0dh,0ah,0
mid byte   "THANK YOU FOR COPERATING WITH US",0dh,0ah,0
age byte  "16,17,29,19",0
exp byte  1,0,0,0
made byte 0,0,0,0
temp byte 3 dup(?)
val1 byte ?
temp1 byte 11 dup(?)
temp2 byte 2 dup(?)
welcome byte "WElCOME TO NADRA   ",0dh,0ah,"-PRESS YES TO CONTINUE ",0ah,0dh,"-PRESS NO TO EXIT",0dh,0ah,0
head byte "NADRA OFFICE",0dh,0ah,0
id byte    "32345-75196350-4,12675-74199350-8,12345-74196350-3,12345-78196350-3",0 
inv byte   "-ENTER YOUR CNIC/B.FORM NUMBER:",0
choice byte "Enter 1 for making a cnic",0dh,0ah,"Enter 2 for renewing your cnic",0dh,0ah,"Enter 3 for printing your details",0dh,0ah,"Enter 4 if you would like to update something",0dh,0ah,0
opt byte ?
token byte 1
starter byte "-----------------WELCOME USER---------------------             ",0dh,0ah,0
tok byte 0ah,0dh,"TOKEN NUMBER:",0
toke byte "  PLEASE ENTER THE FOLLOWING DETAIL:",0ah,0dh,0
choose byte "PLEASE ENTER YOUR CHOICE:",0
askid byte 17 dup(?)
val dword 0
count dword 0
position dword 0
d1 byte "CNIC/BAYFORM:",0
d2 byte "FIRST NAME:",0
d3 byte "LAST NAME:",0
d4 byte "AGE:",0
d5 byte "DATE OF BIRTH:",0
d6 byte "GENDER:",0
d7 byte "PROVINCE:",0
p1 byte ":SINDH",0
p2 byte ":BALOCHISTAN",0
p3 byte ":KPK",0
p4 byte "GILGIT BALTISTAN",0
p5 byte "PUNJAB",0
fem byte "FEMALE",0
mal byte "MALE",0
done byte "Your bayform has been converted into a cnic and the details are the follwing:",0dh,0ah,0
ndone byte "Your cnic cannot be made beacuse of your age is not according to our rules",0ah,0dh,0
rdone byte "Your cnic has been renewed and the details are the following:",0dh,0ah,0
rndone byte "Your cnic has not yet expired so no need to renew it yet",0dh,0ah,0
nndone byte "Your cnic has already been made",0ah,0dh,0
what byte "Enter 1 to update your age:",0dh,0ah,"Enter 2 to update your last name:",0dh,0ah,"Enter 3 to update your gender:",0dh,0ah,"Enter 4 to update your first name:",0dh,0ah,"Enter 5 to update your mothers name:",0dh,0ah,"Enter 6 to update your fathers name:",0dh,0ah,"Enter 7 to leave:",0dh,0ah,0
g1 byte  "please enter the age you would like to update to:",0
n1 byte  "please enter the name you would like to update to:",0
u1 byte "updation done succesfully",0dh,0ah,0
gend1 byte "Enter 1 if you want to update your gender to male:",0dh,0ah,"Enter 2 if you want to update your gender to female:",0ah,0dh,0
mom1 byte  "MOTHER:",0
dad1 byte  "FATHER:",0
.code
main proc
mov eax, magenta + (white*16)
call SetTextColor

start:      ; label to start functionality 
mov ebx,offset head
mov edx,offset welcome
call msgboxask ; for printing the msg box - yes and no for conitnue
cmp eax,7
je ex
mov edx,offset starter ; welcoming user to take inputs what he wants
call writestring
mov edx,offset tok ;alotting token m=number
call writestring
movzx eax,token
call writedec
mov edx,offset toke
call writestring
inc token			;token updating in start as long as users dont press no to exit			
l1:
mov position,0      ;value offset to point to string array elements
mov val,0		
mov count,0
mov esi,offset id
mov edx,offset inv			;asking for cnic/bform number from user
call writestring	
mov edx,offset askid        ;saving user input of cnic number 
mov ecx,17
call readstring
CALL clrscr
mov edi,offset askid
cmp byte ptr[edi+5],"-"			;checking if cnic that is input is valid
jne l1
cmp byte ptr[edi+14],"-"		;checking if cnic that is input is valid
jne l1
push offset id					;pushing bform/cnic nums string address in stack
call index
cmp eax,-1
je l1
l2:
mov edx,offset choice			;driver for chosing the options u want to perform in the NADRA system
call writestring
mov edx,offset choose			;driver for chosing the specific options u want to perform in the NADRA system
call writestring
call readdec
cmp eax,0
jl l2
cmp eax,4
jg l2
je opt4
cmp eax,3
je opt3
cmp eax,2
je opt2
cmp eax,1
je opt1

opt1:
push offset age   
call ageret				;just returning age
mov edx,offset temp
mov ecx,2
mov eax,0
call parsedecimal32			;conv string to int inbuilt func
cmp eax,18			;compare age with 18 to check if cnic can be made or not
jb notallowed
mov ecx,position
 mov esi,offset made
 add esi,position
 movzx eax,byte ptr[esi]
  cmp eax,0
  je proceed
  jmp nallowed
  proceed:
mov edx,offset done			;cnic made from bform
call writestring
mov esi,offset made
add esi,position
mov byte ptr[esi],1
jmp opt3
nallowed:
mov edx,offset nndone
call writestring
jmp no
notallowed:
mov edx,offset ndone
call writestring
jmp no
opt2:
push offset age
call ageret
mov edx,offset temp
mov ecx,2
mov eax,0
call parsedecimal32
cmp eax,18
jl n
mov esi,offset exp
add esi,position
mov al,byte ptr[esi]
cmp al,1
je again
mov edx,offset rdone		;above part checks if renew is needed based on exp value whic represents if expired or not
call writestring
mov esi,offset exp
add esi,position
mov byte ptr[esi],1
jmp opt3
again:
mov edx,offset rndone		;if renewwal not done
call writestring
jmp no
n:
mov edx,offset ndone
call writestring
jmp no
opt3:
call crlf
push offset id
push offset lnaam
push offset fnaam
push offset age
push offset dob
call detail
jmp no
opt4:
call update
jmp opt3
no:
jmp start
ex:
mov ebx,offset head2
mov edx,offset mid
call msgbox
exit
main endp



ageret proc
push ebp
mov ebp,esp
mov esi,[ebp+8]
mov ecx,position
 l1:
 cmp ecx,0
 je yes
 add esi,3
 dec ecx
 jmp l1
yes:
 mov ecx,2
 mov edi,offset temp
 l2:
 mov al,[esi]
 mov [edi],al
 inc edi
 inc esi
 loop l2
 mov byte ptr [edi],0
 pop ebp
ret 4
ageret endp




index proc
push ebp				;creating and working with stack frame
mov ebp,esp
mov ecx,4
mov esi, [ebp+8]				;accessign cnic string offset
mov ebx, [ebp+8]
l1:
push ecx
mov esi,ebx
mov edi,offset askid
mov ecx,15
l2:
mov al,[esi]
cmp al,[edi]				;checking id where it is present as in position
jne no
inc esi
inc edi
loop l2
jmp ex
no:
add position,1					; moves to the next string part which has the next cnic
add ebx,17						;shifts offset to the next starting of data stored of the next person
pop ecx
loop l1
mov eax,-1
jmp leav
ex:
mov eax,position
leav:
mov esp,ebp
pop ebp
ret 4
index endp


detail proc
mov edx,offset mom1
call writestring
mov esi,offset mom
mov count,11
mov val,10
call printer
call crlf
mov edx,offset dad1
call writestring
mov esi,offset dad
mov count,11
mov val,10
call printer
call crlf
mov edx,offset d1
call writestring
mov esi,offset id
mov count,17
mov val,16
call printer
call crlf
mov edx,offset d2
call writestring
mov esi,offset fnaam
mov count,11
mov val,10
call printer
call crlf
mov edx,offset d3
call writestring
mov esi,offset lnaam
mov count,11
mov val,10
call printer
call crlf
mov edx,offset d5
call writestring
mov esi,offset dob
mov count,11
mov val,10
call printer
call crlf
mov edx,offset d4
call writestring
mov esi,offset age
mov count,3
mov val,2
call printer
call crlf
 mov edx,offset d7
call writestring
mov ecx,position
 mov esi,offset id
 l1:
 cmp ecx,0
 je yes
 add esi,17
 dec ecx
 jmp l1
yes:
mov al,byte ptr [esi]
call writechar
cmp al,"1"
je sindh
cmp al,"2"
je baloch
cmp al,"3"
je kpk
cmp al,"4"
je gilgit
cmp al,"5"
je punjab
jmp back
sindh:
mov edx,offset p1
call writestring 
jmp back
baloch:
mov edx,offset p2
call writestring 
jmp back
kpk:
mov edx,offset p3
call writestring 
jmp back
gilgit:
mov edx,offset p4
call writestring 
jmp back
punjab:
mov edx,offset p5
call writestring 
jmp back
back:
call crlf
mov edx,offset d6
call writestring
mov esi,offset id
add esi,15
mov ecx,position
l5:
 cmp ecx,0
 je yes1
 add esi,17
 dec ecx
 jmp l5
yes1:
mov al,[esi]
mov edx,esi
mov eax,0
mov ecx,1
call parsedecimal32
mov ebx,2
mov edx,0
div ebx
cmp edx,0
jne fe
mov edx,offset mal
call writestring
jmp no
fe:
mov edx,offset fem
call writestring
no:
call crlf
ret 20
detail endp



 printer proc
 mov ecx,position
 l1:
 cmp ecx,0
 je yes
 add esi,count
 dec ecx
 jmp l1
yes:
 mov ecx,val
 l2:
 mov al,[esi]
 call writechar
 inc esi
 loop l2
 ret
 printer endp





 update proc
 mov edx,offset what
 call writestring
 again:
 mov edx,offset choose
 call writestring
 call readdec
 cmp eax,1
 jl again
 je umer
 cmp eax,3
 je gend
 cmp eax,2
 je nam
 cmp eax,4
 je nam1
 cmp eax,5
 je mother1
 cmp eax,6
 je father1
 cmp eax,7
 je non
 jg again
 umer:
 mov edx,offset g1
 call writestring
 mov edx,offset temp
 mov ecx,3
 call readstring
 mov count,3
 mov val,2
 mov esi,offset age
 mov edi,offset temp
 call correct
 jmp no
 nam:
  mov edx,offset n1
 call writestring
 mov edx,offset temp1
 mov ecx,11
 call readstring
 mov count,11
 mov val,10
 mov esi,offset lnaam
 mov edi,offset temp1
 call correct
 jmp no
 nam1:
 mov edx,offset n1
 call writestring
 mov edx,offset temp1
 mov ecx,11
 call readstring
 mov count,11
 mov val,10
 mov esi,offset fnaam
 mov edi,offset temp1
 call correct
 jmp no
 gend:
 mov edx,offset gend1 
 call writestring
 mov edx,offset choose
call writestring
mov esi,offset id
mov count,17
mov ecx,position
 l7:
 cmp ecx,0
 je yes
 add esi,count
 dec ecx
 jmp l7
 yes:
call readdec
cmp eax,1
jl gend
je men
cmp eax,2
jg gend
je women
men:
add esi,15
mov byte ptr[esi],"0"
jmp no
women:
add esi,15
mov byte ptr[esi],"1"
jmp no
mother1:
mov edx,offset n1
 call writestring
 mov edx,offset temp1
 mov ecx,11
 call readstring
 mov count,11
 mov val,10
 mov esi,offset mom
 mov edi,offset temp1
 call correct
 jmp no
 father1:
 mov edx,offset n1
 call writestring
 mov edx,offset temp1
 mov ecx,11
 call readstring
 mov count,11
 mov val,10
 mov esi,offset dad
 mov edi,offset temp1
 call correct
 jmp no
no:
mov edx,offset u1
call writestring
jmp again
non:
 ret
 update endp


 correct proc
 mov ecx,position
 l1:
 cmp ecx,0
 je yes
 add esi,count
 dec ecx
 jmp l1
 yes:
mov ecx,val
l3:
mov byte ptr[esi],0
 inc esi
 loop l3
 sub esi,val
 mov ecx,val
 l2:
  mov al,byte ptr [edi]
  mov byte ptr[esi],al
  inc esi
  inc edi
  loop l2
  no:
 ret
 correct endp
end main
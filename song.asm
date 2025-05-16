.model small        ; Use small memory model
.stack 100h         ; Set up stack segment (optional, but recommended)

.data               ; Start of data segment
ti  dw 2415
la  dw 2711
sol dw 3043
fa  dw 3416
mi  dw 3619
re  dw 4061
do  dw 4560

.code               ; Start of code segment
main:
    mov ax, @data   ; Initialize data segment
    mov ds, ax

    mov ax, mi
    call bunyisuara
    call delay
    call delay
    call delay
    call matisuara

    mov ax, fa
    call bunyisuara
    call delay
    call delay
    call matisuara

    mov ax, 4C00h
    int 21h

; --- Delay procedure ---
delay proc
    push ax
    push bx
    mov ax, 40h
    mov es, ax
    mov bx, es:[6Ch]  ; Get BIOS timer tick count

girlwait:
    cmp bx, es:[6Ch]
    je girlwait
    pop bx
    pop ax
    ret
delay endp

; --- Sound on procedure ---
bunyisuara proc
    push ax
    push dx
    mov al, 0B6h
    out 43h, al
    mov dx, ax
    out 42h, al
    mov al, ah
    out 42h, al
    in al, 61h
    or al, 03h
    out 61h, al
    pop dx
    pop ax
    ret
bunyisuara endp

; --- Sound off procedure ---
matisuara proc
    in al, 61h
    and al, 0FCh
    out 61h, al
    ret
matisuara endp

end main            ; Tells assembler the entry point

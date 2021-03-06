; Basic Assembly
; ==============
; 
; Memory ideas
; ------------
;
; Multiplication table
; @@@@@@@@@@@@@@@@@@@@
; 
; This program multiplies two numbers, but in a strange way.
;
; It first calculates all the possible multiplications of pairs of numbers
; between 0 and 9.
;
; Then it requests for input: A pair of numbers x,y.
; Finally it finds out the value in the cell (x,y) inside the table, and prints
; it as output.
;
; 0.    Read the following code. Make sure that you understand how to create and
;       access a two dimensional table.
; 
; 1.    Try to give the program the input numbers: a,a. What is the result? Why?
;       Make a small modification in the source code below so that the input a,a
;       will return the correct result.
;
; 2.    Try to give the program an input of two very large numbers. Example:
;       10000,10000. What happens? Why?
;

BITS 32
global main
extern exit

%include "training.s"

WIDTH equ 10
HEIGHT equ  10
; ===============================================
section .bss
    ; Declare the uninitialized table in memory:
    mul_tbl:     resb      WIDTH*HEIGHT 

; ===============================================
section .text

main:
    ; Fill in the multiplication table:
    ; ---------------------------------
    mov     esi,mul_tbl ; Cell ptr.
    mov     ecx,0   ; row counter.

next_row:
    mov     ebx,0   ; Column counter.
next_column:
    mov     eax,ecx
    mul     ebx
    mov     dword [esi],eax

    add     esi,4
    inc     ebx
    cmp     ebx,WIDTH
    jnz     next_column

    inc     ecx
    cmp     ecx,HEIGHT
    jnz     next_row

    ; We read coordinates inside the table as input,
    ; And then print back the contents of the relevant cell:
    ; ------------------------------------------------------

    call    read_hex  ; Column
    mov     ebx,eax
    push    ebx
    call    read_hex  ; Row
    pop     ebx
    mov     ecx,eax

    mov     edi,WIDTH*4
    mul     edi
    lea     eax,[eax + ebx*4]
    mov     esi,mul_tbl

    mov     eax,dword [esi+eax]
    call    print_eax


    ; Exit the process:
    push    0
    call    exit


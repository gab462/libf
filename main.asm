format ELF64 executable 3
entry start

include "routine.inc"

segment readable executable

write:
    mov rax, 1
    syscall
    ret

exit:
    mov rax, 60
    syscall
    ret

start:
    subroutine main, 5, 3
    subroutine exit, 0

routine main, a, b
    mov rax, a
    add rax, b
    add rax, '0'

    var result, result_addr

    mov [result], rax
    lea rax, [result] ; calculate address
    mov [result_addr], rax

    subroutine write, 1, [result_addr], 1
endr

; vim:ft=fasm:

format ELF64 executable 3
entry start

include "proc.inc"

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
    procall main, 5, 3
    procall exit, 0

proc main, a, b
    mov rax, a
    add rax, b
    add rax, '0'

    var result, result_addr

    mov [result], rax
    lea rax, [result] ; calculate address
    mov [result_addr], rax

    procall write, 1, [result_addr], 1
endproc

; vim:ft=fasm:et:sw=4:sts=4:

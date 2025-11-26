format ELF64 executable 3
entry start

include "linux/proc.inc"
include "linux/sys.inc"

segment readable executable

start:
    procall add2, 5, 3
    procall exit, 0

proc add2, a, b
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

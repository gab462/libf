format ELF64 executable 3
entry start

include "linux/proc.inc"
include "linux/sys.inc"
include "util.inc"

segment readable executable

start:
    pcall main
    pcall exit, 0

proc main
    var i, cond, result, addrof_result, nl, addrof_nl

    mov qword [nl], 10
    movaddr addrof_nl, nl

    mov qword [i], 0

    for cond
        mov rax, [i]
        add rax, '0'

        mov [result], rax
        movaddr addrof_result, result

        pcall write, 1, [addrof_result], 1
        pcall write, 1, [addrof_nl], 1

        inc qword [i]

        movmem cond, i
        sub qword [cond], 10
    endfor
endproc

; vim:ft=fasm:et:sw=4:sts=4:

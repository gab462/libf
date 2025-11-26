format ELF64 executable 3
entry start

include "linux/proc.inc"
include "linux/sys.inc"
include "util.inc"

segment readable executable

start:
    procall main
    procall exit, 0

proc main
    var i, cond, result, result_addr

    mov qword [i], 0

    for cond
        mov rax, [i]
        add rax, '0'

        mov [result], rax
        movaddr result_addr, result

        procall write, 1, [result_addr], 1

        inc qword [i]

        movmem cond, i
        sub qword [cond], 10
    endfor
endproc

; vim:ft=fasm:et:sw=4:sts=4:

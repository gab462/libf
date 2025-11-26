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
    var i, cond
    var result, addrof_result
    var nl, addrof_nl
    var lt3

    mov qword [nl], 10
    addr addrof_nl, nl

    mov qword [i], 0

    for cond
        mov rax, [i]
        add rax, '0'

        mov [result], rax
        addr addrof_result, result

        cmp qword [i], 3
        setl [lt3]

        when lt3
            pcall write, 1, [addrof_result], 1
        otherwise
            pcall write, 1, [addrof_result], 1
            pcall write, 1, [addrof_nl], 1
        endwhen

        inc qword [i]

        cmp qword [i], 10
        setl [cond]
    endfor
endproc

; vim:ft=fasm:et:sw=4:sts=4:

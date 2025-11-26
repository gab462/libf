macro for addr
    local start
    label start

    struc (head) ? tail&
        match =endfor, head
            cmp qword [addr], 0
            jne start

            purge ?
        else
            head tail
        end match
    end struc
end macro

macro movmem dest, src
    push [src]
    pop [dest]
end macro

macro movaddr dest, src
    push rax

    lea rax, [src]
    mov [dest], rax

    pop rax
end macro

; vim:ft=fasm:et:sw=4:sts=4:

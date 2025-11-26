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

macro when addr
    local false, over

    cmp qword [addr], 0
    je false

    struc (head) ? tail&
        match =endwhen, head
            label over
            purge ?
        else match =otherwise, head
            jmp over
            label false
        else
            head tail
        end match
    end struc
end macro

macro assign dest, src
    push [src]
    pop [dest]
end macro

macro addr dest, src
    push rax

    lea rax, [src]
    mov [dest], rax

    pop rax
end macro

; vim:ft=fasm:et:sw=4:sts=4:

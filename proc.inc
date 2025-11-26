macro proc name, args&
    label name
    namespace name

    local argcount
    argcount = 0

    ; assign names to function argument registers
    iterate <arg>, args
        if argcount = 0
            label arg at rdi
        else if argcount = 1
            label arg at rsi
        else if argcount = 2
            label arg at rdx
        else if argcount = 3
            label arg at r10
        else if argcount = 4
            label arg at r8
        else if argcount = 5
            label arg at r9
        else
            err "too many arguments to proc"
        end if

        argcount = argcount + 1
    end iterate

    ; setup stack
    push rbp
    mov rbp, rsp

    ; local macro variable for tracking stack
    local lsp
    lsp = 0

    struc (head) ? tail&
        match =endproc, head
            ; restore stack
            mov rsp, rbp
            pop rbp

            ret

            purge ?
        else match =var, head
            ; assign name to allocated stack variables
            iterate <varname>, tail
                sub rsp, 8
                lsp = lsp + 8
                label varname at rbp-lsp
            end iterate
        else
            head tail
        end match
    end struc

    end namespace
end macro

macro procall name, args&
    ; store registers in stack
    iterate <reg>, rdi, rsi, rdx, r10, r8, r9
        push reg
    end iterate

    local argcount
    argcount = 0

    iterate <arg>, args
        if argcount = 0
            mov rdi, arg
        else if argcount = 1
            mov rsi, arg
        else if argcount = 2
            mov rdx, arg
        else if argcount = 3
            mov r10, arg
        else if argcount = 4
            mov r8, arg
        else if argcount = 5
            mov r9, arg
        else
            err "too many arguments to procall"
        end if

        argcount = argcount + 1
    end iterate

    call name

    ; restore registers from stack in reverse
    iterate <reg>, r9, r8, r10, rdx, rsi, rdi
        pop reg
    end iterate
end macro

; vim:ft=fasm:et:sw=4:sts=4:

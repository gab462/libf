macro sys name, nr
    label name
    mov rax, nr
    syscall
    ret
end macro

sys write, 1
sys exit, 60

; vim:ft=fasm:et:sw=4:sts=4:

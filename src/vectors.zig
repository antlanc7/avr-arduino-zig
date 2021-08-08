comptime {
    asm (
        \\.section .vectors
        \\ jmp _start               ; Reset Handler
        \\ jmp _unhandled_vector    ; IRQ0 Handler
        \\ jmp _unhandled_vector    ; IRQ1 Handler
        \\ jmp _unhandled_vector    ; PCINT0 Handler
        \\ jmp _unhandled_vector    ; PCINT1 Handler
        \\ jmp _unhandled_vector    ; PCINT2 Handler
        \\ jmp _unhandled_vector    ; Watchdog Timer Handler
        \\ jmp _unhandled_vector    ; Timer2 Compare A Handler
        \\ jmp _unhandled_vector    ; Timer2 Compare B Handler
        \\ jmp _unhandled_vector    ; Timer2 Overflow Handler
        \\ jmp _unhandled_vector    ; Timer1 Capture Handler
        \\ jmp _unhandled_vector    ; Timer1 Compare A Handler
        \\ jmp _unhandled_vector    ; Timer1 Compare B Handler
        \\ jmp _unhandled_vector    ; Timer1 Overflow Handler
        \\ jmp _unhandled_vector    ; Timer0 Compare A Handler
        \\ jmp _unhandled_vector    ; Timer0 Compare B Handler
        \\ jmp _unhandled_vector    ; Timer0 Overflow Handler
        \\ jmp _unhandled_vector    ; SPI Transfer Complete Handler
        \\ jmp _unhandled_vector    ; USART, RX Complete Handler
        \\ jmp _unhandled_vector    ; USART, UDR Empty Handler
        \\ jmp _unhandled_vector    ; USART, TX Complete Handler
        \\ jmp _unhandled_vector    ; ADC Conversion Complete Handler
        \\ jmp _unhandled_vector    ; EEPROM Ready Handler
        \\ jmp _unhandled_vector    ; Analog Comparator Handler
        \\ jmp _unhandled_vector    ; 2-wire Serial Interface Handler
        \\ jmp _unhandled_vector    ; Store Program Memory Ready Handler
    );
}

export fn _unhandled_vector() callconv(.Naked) noreturn {
    while (true) {}
}

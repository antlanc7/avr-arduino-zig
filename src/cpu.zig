pub const CPU_FREQ = 16_000_000;
// -> 16 cycles = 1µs, 1 cycle = 62.5ns

pub fn delayNanoseconds(comptime nanoseconds: comptime_int) void {
    var cycles: comptime_int = 0;
    inline while (cycles < nanoseconds / 63) : (cycles += 1) {
        asm volatile ("nop");
    }
}

pub fn delayMicroseconds(microseconds: u16) void {
    var us: u16 = microseconds;
    while (us > 0) : (us -= 1) {
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
        asm volatile ("nop");
    }
}

pub fn delayMilliseconds(milliseconds: u32) void {
    // Each iteration is 256 * 4 cycles
    //   + a few cycles for u32 outer loop / interrupts....
    var i: u32 = milliseconds * (CPU_FREQ / (1000 * (256 * 4) + 42));
    while (i > 0) : (i -= 1) {
        var c: u8 = 255;
        asm volatile (
            \\1:
            \\    dec %[c]
            \\    nop
            \\    brne 1b
            :
            : [c] "r" (c),
        );
    }
}

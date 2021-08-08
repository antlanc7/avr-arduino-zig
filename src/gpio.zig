const MMIO = @import("mmio.zig").MMIO;

// Register definititions:

// IO PORTS:

const PINB = MMIO(0x23, u8, packed struct {
    PINB0: u1 = 0,
    PINB1: u1 = 0,
    PINB2: u1 = 0,
    PINB3: u1 = 0,
    PINB4: u1 = 0,
    PINB5: u1 = 0,
    PINB6: u1 = 0,
    PINB7: u1 = 0,
});

const DDRB = MMIO(0x24, u8, packed struct {
    DDB0: u1 = 0,
    DDB1: u1 = 0,
    DDB2: u1 = 0,
    DDB3: u1 = 0,
    DDB4: u1 = 0,
    DDB5: u1 = 0,
    DDB6: u1 = 0,
    DDB7: u1 = 0,
});

const PORTB = MMIO(0x25, u8, packed struct {
    PORTB0: u1 = 0,
    PORTB1: u1 = 0,
    PORTB2: u1 = 0,
    PORTB3: u1 = 0,
    PORTB4: u1 = 0,
    PORTB5: u1 = 0,
    PORTB6: u1 = 0,
    PORTB7: u1 = 0,
});

const PINC = MMIO(0x26, u8, packed struct {
    PINC0: u1 = 0,
    PINC1: u1 = 0,
    PINC2: u1 = 0,
    PINC3: u1 = 0,
    PINC4: u1 = 0,
    PINC5: u1 = 0,
    PINC6: u1 = 0,
    PINC7: u1 = 0,
});

const DDRC = MMIO(0x27, u8, packed struct {
    DDC0: u1 = 0,
    DDC1: u1 = 0,
    DDC2: u1 = 0,
    DDC3: u1 = 0,
    DDC4: u1 = 0,
    DDC5: u1 = 0,
    DDC6: u1 = 0,
    DDC7: u1 = 0,
});

const PORTC = MMIO(0x28, u8, packed struct {
    PORTC0: u1 = 0,
    PORTC1: u1 = 0,
    PORTC2: u1 = 0,
    PORTC3: u1 = 0,
    PORTC4: u1 = 0,
    PORTC5: u1 = 0,
    PORTC6: u1 = 0,
    PORTC7: u1 = 0,
});

const PIND = MMIO(0x29, u8, packed struct {
    PIND0: u1 = 0,
    PIND1: u1 = 0,
    PIND2: u1 = 0,
    PIND3: u1 = 0,
    PIND4: u1 = 0,
    PIND5: u1 = 0,
    PIND6: u1 = 0,
    PIND7: u1 = 0,
});

const DDRD = MMIO(0x2A, u8, packed struct {
    DDD0: u1 = 0,
    DDD1: u1 = 0,
    DDD2: u1 = 0,
    DDD3: u1 = 0,
    DDD4: u1 = 0,
    DDD5: u1 = 0,
    DDD6: u1 = 0,
    DDD7: u1 = 0,
});

const PORTD = MMIO(0x2B, u8, packed struct {
    PORTD0: u1 = 0,
    PORTD1: u1 = 0,
    PORTD2: u1 = 0,
    PORTD3: u1 = 0,
    PORTD4: u1 = 0,
    PORTD5: u1 = 0,
    PORTD6: u1 = 0,
    PORTD7: u1 = 0,
});

// PWM (pulse width modulator)

//Timers
pub const TCCR2B = MMIO(0xB1, u8, packed struct {
    CS20: u1 = 0,
    CS21: u1 = 0,
    CS22: u1 = 0,
    WGM22: u1 = 0,
    _1: u1 = 0,
    _2: u1 = 0,
    FOC2B: u1 = 0,
    FOC2A: u1 = 0,
});

pub const TCCR2A = MMIO(0xB0, u8, packed struct {
    WGM20: u1 = 0,
    WGM21: u1 = 0,
    _1: u1 = 0,
    _2: u1 = 0,
    COM2B0: u1 = 0,
    COM2B1: u1 = 0,
    COM2A0: u1 = 0,
    COM2A1: u1 = 0,
});

//Timer counter 1 16-bit
pub const TCCR1C = MMIO(0x82, u8, packed struct {
    FOC1A: u1 = 0,
    FOC1B: u1 = 0,
    _1: u1 = 0,
    _2: u1 = 0,
    _3: u1 = 0,
    _4: u1 = 0,
    _5: u1 = 0,
    _6: u1 = 0,
});

pub const TCCR1B = MMIO(0x81, u16, packed struct {
    ICNC1: u1 = 0,
    ICES1: u1 = 0,
    _1: u1 = 0,
    WGM13: u1 = 0,
    WGM12: u1 = 0,
    CS12: u1 = 0,
    CS11: u1 = 0,
    CS10: u1 = 0,
});

pub const TCCR1A = MMIO(0x80, u16, packed struct {
    COM1A1: u1 = 0,
    COM1A0: u1 = 0,
    COM1B1: u1 = 0,
    COM1B0: u1 = 0,
    _1: u1 = 0,
    _2: u1 = 0,
    WGM11: u1 = 0,
    WGM10: u1 = 0,
});

//Timer counter 2 8-bit
pub const TCNT2 = @intToPtr(*volatile u8, 0xB2);

// Compare registers
pub const OCR2B = @intToPtr(*volatile u8, 0xB4);
pub const OCR2A = @intToPtr(*volatile u8, 0xB3);

//Timer counter 0 8-bit
pub const TCNT0 = @intToPtr(*volatile u8, 0x46);

// Compare Registers
pub const OCR0B = @intToPtr(*volatile u8, 0x47);
pub const OCR0A = @intToPtr(*volatile u8, 0x46);

//Timer counter 1 16-bit
pub const OCR1BH = @intToPtr(*volatile u16, 0x8B);
pub const OCR1BL = @intToPtr(*volatile u16, 0x8A);
pub const OCR1AH = @intToPtr(*volatile u16, 0x89);
pub const OCR1AL = @intToPtr(*volatile u16, 0x88);

pub const ICR1H = @intToPtr(*volatile u16, 0x87);
pub const ICR1L = @intToPtr(*volatile u16, 0x86);
pub const TCNT1H = @intToPtr(*volatile u16, 0x85);
pub const TCNT1L = @intToPtr(*volatile u16, 0x84);

const MCUCR = MMIO(0x55, u8, packed struct {
    IVCE: u1 = 0,
    IVSEL: u1 = 0,
    _1: u2 = 0,
    PUD: u1 = 0,
    BODSE: u1 = 0,
    BODS: u1 = 0,
    _2: u1 = 0,
});

/// Set the configuration registers
pub fn init() void {
    // PUD bit (Pull Up Disable) Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf#G1184233*
    // make sure the bit is disabled for pullup resitors to work
    // (already the default after reset)
    var val = MCUCR.read();
    val.PUD = 0;
    MCUCR.write(val);
}

/// Configure the pin before use.
pub fn setMode(comptime pin: comptime_int, comptime mode: enum { input, output, input_pullup, output_analog }) void {
    switch (pin) {
        0...7 => {
            var val = DDRD.readInt();
            if (mode == .output) {
                val |= 1 << (pin - 0);
            } else {
                val &= ~@as(u8, 1 << (pin - 0));
            }
            DDRD.writeInt(val);
        },
        8...13 => {
            var val = DDRB.readInt();
            if (mode == .output) {
                val |= 1 << (pin - 8);
            } else {
                val &= ~@as(u8, 1 << (pin - 8));
            }
            DDRB.writeInt(val);
        },
        14...19 => {
            var val = DDRC.readInt();
            if (mode == .output) {
                val |= 1 << (pin - 14);
            } else {
                val &= ~@as(u8, 1 << (pin - 14));
            }
            DDRC.writeInt(val);
        },
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }

    if (mode == .input_pullup) {
        setPin(pin, .high);
    } else {
        setPin(pin, .low);
    }
}

pub const PinState = enum { low, high };

pub fn getPin(comptime pin: comptime_int) PinState {
    return if (getPinBool(pin)) .high else .low;
}

pub fn getPinBool(comptime pin: comptime_int) bool {
    switch (pin) {
        0...7 => {
            var val = PIND.readInt();
            return (val & (1 << (pin - 0))) != 0;
        },
        8...13 => {
            var val = PINB.readInt();
            return (val & (1 << (pin - 8))) != 0;
        },
        14...19 => {
            var val = PINC.readInt();
            return (val & (1 << (pin - 14))) != 0;
        },
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }
}

pub fn setPin(comptime pin: comptime_int, comptime value: PinState) void {
    switch (pin) {
        0...7 => {
            var val = PORTD.readInt();
            if (value == .high) {
                val |= 1 << (pin - 0);
            } else {
                val &= ~@as(u8, 1 << (pin - 0));
            }
            PORTD.writeInt(val);
        },
        8...13 => {
            var val = PORTB.readInt();
            if (value == .high) {
                val |= 1 << (pin - 8);
            } else {
                val &= ~@as(u8, 1 << (pin - 8));
            }
            PORTB.writeInt(val);
        },
        14...19 => {
            var val = PORTC.readInt();
            if (value == .high) {
                val |= 1 << (pin - 14);
            } else {
                val &= ~@as(u8, 1 << (pin - 14));
            }
            PORTC.writeInt(val);
        },
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }
}

pub fn togglePin(comptime pin: comptime_int) void {
    switch (pin) {
        0...7 => {
            var val = PORTD.readInt();
            val ^= 1 << (pin - 0);
            PORTD.writeInt(val);
        },
        8...13 => {
            var val = PORTB.readInt();
            val ^= 1 << (pin - 8);
            PORTB.writeInt(val);
        },
        14...19 => {
            var val = PORTC.readInt();
            val ^= 1 << (pin - 14);
            PORTC.writeInt(val);
        },
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }
}

/// the pin must be configured in output_analog mode
pub fn setPinAnalog(comptime pin: comptime_int, value: u8) void {
    pinMode(pin, .output);

    TCCR1A.writeInt(0b10000010);
    TCCR1B.writeInt(0b00010001);

    if (value == 0) {
        digitalWrite(pin, .low);
    } else if (value == 255) {
        digitalWrite(pin, .high);
    }

    switch (pin) {
        3 => {
            //Timer 2
            OCR0A.* = value;
        },
        11 => {
            //Timer 2
            OCR0B.* = value;
        },
        5 => {
            //Timer 0
            OCR2A.* = value;
        },
        6 => {
            //Timer 0
            OCR2B.* = value;
        },
        9 => {
            //Timer 1
            ICR1L.* = 255;
            OCR1AL.* = value;
        },
        10 => {
            //Timer 1
            ICR1L.* = 255;
            OCR1BL.* = value;
        },

        else => @compileError("Not valid PWM pin (allowed pins 3,5,6,9,10,11)."),
    }
}

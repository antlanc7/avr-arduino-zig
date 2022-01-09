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

// pulse width modulator

//Timers
pub const TCCR2B = MMIO(0xB1, u8, packed struct {
    CS2: u3 = 0,
    WGM22: u1 = 0,
    _: u2 = 0,
    FOC2B: u1 = 0,
    FOC2A: u1 = 0,
});

pub const TCCR2A = MMIO(0xB0, u8, packed struct {
    WGM20: u1 = 0,
    WGM21: u1 = 0,
    _: u2 = 0,
    COM2B: u2 = 0,
    COM2A: u2 = 0,
});

//Timer counter 1 16-bit
pub const TCCR1C = MMIO(0x82, u8, packed struct {
    _: u5 = 0,
    FOC1B: u1 = 0,
    FOC1A: u1 = 0,
});

pub const TCCR1B = MMIO(0x81, u8, packed struct {
    CS1: u3 = 0,
    WGM12: u1 = 0,
    WGM13: u1 = 0,
    _: u1 = 0,
    ICES1: u1 = 0,
    ICNC1: u1 = 0,
});

pub const TCCR1A = MMIO(0x80, u8, packed struct {
    WGM10: u1 = 0,
    WGM11: u1 = 0,
    _: u2 = 0,
    COM1B: u2 = 0,
    COM1A: u2 = 0,
});

pub const TCCR0B = MMIO(0x45, u8, packed struct {
    CS0: u3 = 0,
    WGM02: u1 = 0,
    _: u2 = 0,
    FOC0B: u1 = 0,
    FOC0A: u1 = 0,
});

pub const TCCR0A = MMIO(0x44, u8, packed struct {
    WGM00: u1 = 0,
    WGM01: u1 = 0,
    _: u2 = 0,
    COM0B: u2 = 0,
    COM0A: u2 = 0,
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
pub const OCR1BH = @intToPtr(*volatile u8, 0x8B);
pub const OCR1BL = @intToPtr(*volatile u8, 0x8A);
pub const OCR1AH = @intToPtr(*volatile u8, 0x89);
pub const OCR1AL = @intToPtr(*volatile u8, 0x88);

pub const ICR1H = @intToPtr(*volatile u8, 0x87);
pub const ICR1L = @intToPtr(*volatile u8, 0x86);
pub const TCNT1H = @intToPtr(*volatile u8, 0x85);
pub const TCNT1L = @intToPtr(*volatile u8, 0x84);

// Analog-to-digital converter

pub const ADMUX = MMIO(0x7C, u8, packed struct {
    MUX: u4 = 0,
    _: u1 = 0,
    ADLAR: u1 = 0,
    REFS: u2 = 0,
});

pub const ADCSRA = MMIO(0x7A, u8, packed struct {
    ADPS: u3 = 0,
    ADIE: u1 = 0,
    ADIF: u1 = 0,
    ADATE: u1 = 0,
    ADSC: u1 = 0,
    ADEN: u1 = 0,
});

pub const ADCH = @intToPtr(*volatile u8, 0x79);
pub const ADCL = @intToPtr(*volatile u8, 0x78);

//

const MCUCR = MMIO(0x55, u8, packed struct {
    IVCE: u1 = 0,
    IVSEL: u1 = 0,
    _1: u2 = 0,
    PUD: u1 = 0,
    BODSE: u1 = 0,
    BODS: u1 = 0,
    _2: u1 = 0,
});

/// Set the configuration registers as expected by the PWM and ADC functions
///  set the timers same as standard arduino setup.
//   (see https://github.com/arduino/ArduinoCore-avr/blob/master/cores/arduino/wiring.c )
pub fn init() void {
    // PUD bit (Pull Up Disable) Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf#G1184233*
    // make sure the bit is disabled for pullup resitors to work
    // (already the default after reset)
    //var val = MCUCR.read();
    //val.PUD = 0;
    //MCUCR.write(val);

    // set timers config (for PWM and time functions)
    TCCR0A.write(.{ .WGM01 = 1, .WGM00 = 1 });
    TCCR0B.write(.{ .CS0 = 3 });
    TCCR1A.write(.{ .WGM10 = 1 });
    TCCR1B.write(.{ .CS1 = 3 });
    TCCR2A.write(.{ .WGM20 = 1 });
    TCCR2B.write(.{ .CS2 = 4 });

    // set the analog-to-digital converter config
    ADCSRA.write(.{ .ADPS = 3, .ADEN = 1 }); // 16 MHz / 128 = 125 KHz
}

fn setBit(byte: u8, bit: u3, val: bool) u8 {
    return if (val) (byte | @as(u8, 1) << bit) else (byte & ~(@as(u8, 1) << bit));
}

/// Configure the pin before use.
pub fn setMode(comptime pin: comptime_int, comptime mode: enum { input, output, input_pullup, output_analog }) void {

    // set the IO direction:
    const out = switch (mode) {
        .input, .input_pullup => false,
        .output, .output_analog => true,
    };
    switch (pin) {
        0...7 => DDRD.writeInt(setBit(DDRD.readInt(), (pin - 0), out)),
        8...13 => DDRB.writeInt(setBit(DDRB.readInt(), (pin - 8), out)),
        14...19 => DDRC.writeInt(setBit(DDRC.readInt(), (pin - 14), out)),
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }

    // set PWM for the pin
    const com = if (mode == .output_analog) 0b10 else 0; // "clear output on compare match"
    switch (pin) {
        6 => { // OC0A
            var r = TCCR0A.read();
            r.COM0A = com;
            TCCR0A.write(r);
        },
        5 => { // OC0B
            var r = TCCR0A.read();
            r.COM0B = com;
            TCCR0A.write(r);
        },
        9 => { // OC1A
            var r = TCCR1A.read();
            r.COM1A = com;
            TCCR1A.write(r);
        },
        10 => { // OC1B
            var r = TCCR1A.read();
            r.COM1B = com;
            TCCR1A.write(r);
        },
        11 => { // OC2A
            var r = TCCR2A.read();
            r.COM2A = com;
            TCCR2A.write(r);
        },
        3 => { // OC2B
            var r = TCCR2A.read();
            r.COM2B = com;
            TCCR2A.write(r);
        },
        else => if (mode == .output_analog) @compileError("Not a valid PWM pin (allowed pins 3,5,6,9,10,11)."),
    }

    if (mode == .input_pullup) {
        setPin(pin, .high);
    } else {
        setPin(pin, .low);
    }
}

pub const PinState = enum { low, high };

pub fn getPin(comptime pin: comptime_int) PinState {
    const is_set = switch (pin) {
        0...7 => (PIND.readInt() & (1 << (pin - 0))),
        8...13 => (PINB.readInt() & (1 << (pin - 8))),
        14...19 => (PINC.readInt() & (1 << (pin - 14))),
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    };
    return if (is_set != 0) .high else .low;
}

pub fn setPin(comptime pin: comptime_int, value: PinState) void {
    switch (pin) {
        0...7 => PORTD.writeInt(setBit(PORTD.readInt(), (pin - 0), (value == .high))),
        8...13 => PORTB.writeInt(setBit(PORTB.readInt(), (pin - 8), (value == .high))),
        14...19 => PORTC.writeInt(setBit(PORTC.readInt(), (pin - 14), (value == .high))),
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }
}

pub fn togglePin(comptime pin: comptime_int) void {
    switch (pin) {
        0...7 => PORTD.writeInt(PORTD.readInt() ^ (1 << (pin - 0))),
        8...13 => PORTB.writeInt(PORTB.readInt() ^ (1 << (pin - 8))),
        14...19 => PORTC.writeInt(PORTC.readInt() ^ (1 << (pin - 14))),
        else => @compileError("Only port B, C and D are available yet (arduino pins 0 through 19)."),
    }
}

/// the pin must be configured in output_analog mode
pub fn setPinAnalog(comptime pin: comptime_int, value: u8) void {
    if (value == 0) {
        setPin(pin, .low);
    } else if (value == 255) {
        setPin(pin, .high);
    } else switch (pin) {
        6 => OCR0A.* = value,
        5 => OCR0B.* = value,
        9 => OCR1AL.* = value,
        10 => OCR1BL.* = value,
        11 => OCR2A.* = value,
        3 => OCR2B.* = value,
        else => @compileError("Not valid PWM pin (allowed pins 3,5,6,9,10,11)."),
    }
}

pub fn getPinAnalog(comptime pin: comptime_int) u16 {
    // set channel & avcc as ref
    ADMUX.write(.{ .REFS = 1, .MUX = pin });

    //start conversion
    ADCSRA.write(.{ .ADPS = 3, .ADEN = 1, .ADSC = 1 });

    //wait until conversion end
    while (ADCSRA.read().ADSC == 1) {}

    var adc_val: u16 = ADCL.*; // ! ADCL must be read before ADCH.
    adc_val |= @as(u16, ADCH.*) << 8;

    return adc_val;
}

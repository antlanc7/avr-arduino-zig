const arduino = @import("arduino");
const gpio = arduino.gpio;

// Necessary, and has the side effect of pulling in the needed _start method
pub const panic = arduino.start.panicLogUart;

// display 4 digits
// using a kyx-3942bg  and a 74hc595 shift register

// pins:
// 74hc595 pins in:
const SHIFTREG_DS = 11; // data
const SHIFTREG_STCP = 12; // shift-in clock (up edge)
const SHIFTREG_SHCP = 10; // register storage clock (up edge)

// out pins Q7..Q0 -> 3942bg in: 16 13 3 5 11 15 7 14
// other 3942bg pins
const LED_1 = 4;
const LED_2 = 5;
const LED_6 = 6;
const LED_8 = 7;

fn shiftOut(comptime DS_pin: comptime_int, comptime SHC_pin: comptime_int, comptime STC_pin: comptime_int, value: u8) void {
    gpio.setPin(STC_pin, .low);

    var v = value;
    var i: u8 = 0;
    while (i < 8) : (i += 1) {
        if (v & 0b1000_0000 != 0) gpio.setPin(DS_pin, .high) else gpio.setPin(DS_pin, .low);
        gpio.setPin(SHC_pin, .high);
        v <<= 1;
        gpio.setPin(SHC_pin, .low);
    }

    gpio.setPin(STC_pin, .high);
}

fn setLCDDigit(comptime sel_pin: comptime_int, digit: u4) void {
    const digit_segments = [_]u8{
        0b0_0111111, // 0
        0b0_0000110, // 1
        0b0_1011011, // 2
        0b0_1001111, // 3
        0b0_1100110, // 4
        0b0_1101101, // 5
        0b0_1111101, // 6
        0b0_0000111, // 7
        0b0_1111111, // 8
        0b0_1101111, // 9

        0b0_1110111, // A
        0b0_1111100, // b
        0b0_0111001, // C
        0b0_1011110, // d
        0b0_1111001, // E
        0b0_1110001, // F
    };

    shiftOut(SHIFTREG_DS, SHIFTREG_SHCP, SHIFTREG_STCP, ~digit_segments[digit]);
    gpio.setPin(sel_pin, .high);
    arduino.cpu.delayMicroseconds(250);
    gpio.setPin(sel_pin, .low);
}

pub fn main() void {
    arduino.uart.init(arduino.cpu.CPU_FREQ, 115200);

    gpio.setMode(SHIFTREG_DS, .output);
    gpio.setMode(SHIFTREG_STCP, .output);
    gpio.setMode(SHIFTREG_SHCP, .output);
    gpio.setMode(LED_1, .output);
    gpio.setMode(LED_2, .output);
    gpio.setMode(LED_6, .output);
    gpio.setMode(LED_8, .output);

    //    var counter:u16=0;
    //    while (true) {
    //        setLCDDigit(LED_1, 0);
    //        setLCDDigit(LED_2, 0);
    //        setLCDDigit(LED_6, 0);
    //        setLCDDigit(LED_8, @intCast(u4, (counter>>8)&0x0F));
    //        counter +%= 1;
    //    }

    // set 4 digits LCD to the analog pin A0 value:
    const A0 = 14;
    gpio.setMode(A0, .input);
    const REDLED = 9;
    gpio.setMode(REDLED, .output_analog);
    gpio.setPin(REDLED, .high);

    while (true) {
        const potar = gpio.getPinAnalog(0);
        setLCDDigit(LED_8, @intCast(u4, (potar >> 0) & 0x000F));
        setLCDDigit(LED_6, @intCast(u4, (potar >> 4) & 0x000F));
        setLCDDigit(LED_2, @intCast(u4, (potar >> 8) & 0x000F));
        setLCDDigit(LED_1, @intCast(u4, (potar >> 12) & 0x000F));
        gpio.setPinAnalog(REDLED, @intCast(u8, potar & 0xFF));
    }
}

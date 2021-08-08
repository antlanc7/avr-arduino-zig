const arduino = @import("arduino");
const gpio = arduino.gpio;
const neopixel = arduino.lib.neopixel;

// Necessary, and has the side effect of pulling in the needed _start method
pub const panic = arduino.start.panicLogUart;

pub fn main() void {
    arduino.uart.init(arduino.cpu.CPU_FREQ, 115200);

    const ledstrip = neopixel.LedStrip(2);
    ledstrip.init();

    const colorstream = [_]u8{
        // Green, Red, Blue
        0x77, 0x99, 0x88,
        0x22, 0x22, 0x00,
        0xDD, 0x11, 0x11,
        0x77, 0x99, 0x88,
        0x77, 0x99, 0x88,
        0x77, 0x99, 0x88,
        0x11, 0x00, 0x55,
        0x11, 0x00, 0x55,
        0x11, 0x00, 0x55,
        0x11, 0x00, 0x55,
        0x11, 0x00, 0x55,
        0x11, 0x00, 0x55,
        0x11, 0x00, 0x55,
    };
    var start: u16 = 0;
    while (true) {
        start += 3;
        if (start >= colorstream.len) start = 0;

        ledstrip.appendGRB(colorstream[start..]);
        ledstrip.appendGRB(colorstream[0..start]);
        ledstrip.endOfData();

        arduino.cpu.delayMilliseconds(100);
    }
}

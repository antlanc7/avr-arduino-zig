const gpio = @import("../gpio.zig");
const cpu = @import("../cpu.zig");
const assert = @import("std").debug.assert;

// tested using a WS2813 led strip
//  https://pdf1.alldatasheet.fr/datasheet-pdf/view/1134580/WORLDSEMI/WS2813.html

fn sendByte(comptime pin: u8, byte: u8) void {
    // pretty tricky to get the code generation to hit a specific timing
    //   + optimizer likes to move things around in spite of volatile
    // - going to the full read() - modify bit - write() seem to force ordering and gives a timing that appears to work.
    //     (spec  is something like ~5-10 cycles each part, a little more for the middle.)

    // "Data transmit in order of GRB, highbit data is first."
    var bit: u8 = 8;
    var v = byte;
    while (bit > 0) : (bit -= 1) {
        gpio.setPin(pin, .high); // head (220ns~380ns)

        if ((v & 0x80) != 0) // bit value  (360ns~1220ns)
            gpio.setPin(pin, .high)
        else
            gpio.setPin(pin, .low);
        v <<= 1;

        gpio.setPin(pin, .low); // tail  (220ns~420ns)
    }
}

pub fn LedStrip(comptime data_pin: comptime_int) type {
    return struct {
        pub fn init() void {
            gpio.setMode(data_pin, .output);
        }

        /// array of Green, Red, Blue bytes.
        pub fn appendGRB(colors: []const u8) void {
            assert(colors.len % 3 == 0);
            for (colors) |component| {
                sendByte(data_pin, component);
            }
        }

        /// just a delay to make next appendGRB start from led #0
        /// no need to call if the delay is enforced otherwise.
        pub fn endOfData() void {
            cpu.delayMicroseconds(300); // > 280µs
        }
    };
}

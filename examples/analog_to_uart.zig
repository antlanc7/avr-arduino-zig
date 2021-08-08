const arduino = @import("arduino");
const std = @import("std");

// Necessary, and has the side effect of pulling in the needed _start method
pub const panic = arduino.start.panicLogUart;

fn hexChar(x: u4) u8 {
    return switch (x) {
        0...9 => @as(u8, '0') + x,
        else => @as(u8, 'A') + (x - 10),
    };
}

fn printHex(x: u16, buffer: []u8) []const u8 {
    buffer[3] = hexChar(@intCast(u4, (x >> 0) & 0x000F));
    buffer[2] = hexChar(@intCast(u4, (x >> 4) & 0x000F));
    buffer[1] = hexChar(@intCast(u4, (x >> 8) & 0x000F));
    buffer[0] = hexChar(@intCast(u4, (x >> 12) & 0x000F));
    return buffer[0..4];
}

pub fn main() void {
    arduino.uart.init(arduino.cpu.CPU_FREQ, 115200);

    while (true) {
        const val = arduino.gpio.getPinAnalog(1);

        arduino.uart.write("value: ");

        var work_buffer: [16]u8 = undefined;
        arduino.uart.write(printHex(val, &work_buffer));

        arduino.uart.write("\n");

        arduino.cpu.delayMilliseconds(1000);
    }
}

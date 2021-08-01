const arduino = @import("arduino");
const std = @import("std");
const dht = arduino.lib.dht;

// Necessary, and has the side effect of pulling in the needed _start method
pub const panic = arduino.start.panicLogUart;

// until the compilert works, code from __udivmodhi4:
fn udivmod(_num: u16, _den: u16) struct { div: u16, rem: u16 } {
    var num = _num;
    var den = _den;
    var bit: u16 = 1;
    var res: u16 = 0;

    while (den < num and (bit != 0) and (den & (@as(u16, 1) << 15)) == 0) {
        den <<= 1;
        bit <<= 1;
    }

    while (bit != 0) {
        if (num >= den) {
            num -= den;
            res |= bit;
        }
        bit >>= 1;
        den >>= 1;
    }
    return .{ .div = res, .rem = num };
}

fn printNumToBuf(num_x10: i16, buf: *[16]u8) []u8 {
    var v: u16 = if (num_x10 > 0) @intCast(u16, num_x10) else @intCast(u16, -num_x10);

    var idx: u8 = 0;
    while (v > 0) {
        const next = udivmod(v, 10);
        v = next.div;
        buf[(buf.len - 1) - idx] = '0' + @intCast(u8, next.rem);

        if (idx == 0) {
            buf[(buf.len - 2)] = '.';
            idx = 2;
        } else {
            idx += 1;
        }
    }

    if (num_x10 < 0) {
        buf[(buf.len - 1) - idx] = '-';
        idx += 1;
    }
    return buf[buf.len - idx ..];
}

pub fn main() void {
    arduino.uart.init(arduino.cpu.CPU_FREQ, 115200);

    const sensor1 = dht.DHT22(8);
    const sensor2 = dht.DHT22(7);
    const sensor_names = [_][]const u8{ "sensor #1", "sensor #2" };

    while (true) {
        const measures = [_]dht.Readout{
            sensor1.read(),
            sensor2.read(),
        };

        for (measures) |measure, idx| {
            switch (measure.err) {
                .OK => {},
                .BAD_CHECKSUM => @panic("BAD_CHECKSUM"),
                .NO_CONNECTION => @panic("NO_CONNECTION"),
                .NO_ACK => @panic("NO_ACK"),
                .INTERRUPTED => @panic("INTERRUPTED"),
            }

            arduino.uart.write(sensor_names[idx]);
            arduino.uart.write(": ");

            var work_buffer: [16]u8 = undefined;
            //const msg = std.fmt.bufPrint(&work_buffer, "t={}\n", .{measure.temperature_x10}) catch unreachable; -- fails because of (at least) error unions

            arduino.uart.write(printNumToBuf(measure.humidity_x10, &work_buffer));
            arduino.uart.write("%, ");
            arduino.uart.write(printNumToBuf(measure.temperature_x10, &work_buffer));
            arduino.uart.write("°C\n");
        }

        arduino.cpu.delayMilliseconds(2000); //  "the interval of whole process must beyond 2 seconds."
    }
}

const gpio = @import("../gpio.zig");
const cpu = @import("../cpu.zig");

// hacked from
// from  https://github.com/RobTillaart/Arduino/tree/master/libraries/DHTlib
// and the spec: https://www.gotronic.fr/pj-1052.pdf

// clang doesn't seem to like error unions...
const HackError = enum {
    OK,
    BAD_CHECKSUM,
    NO_CONNECTION,
    NO_ACK,
    INTERRUPTED,
};

pub const Readout = struct { humidity_x10: i16, temperature_x10: i16, err: HackError };

pub fn DHT22(comptime sensor_data_pin: u8) type {
    return struct {
        pub fn read() Readout {
            var sensor = [5]u8{ 0, 0, 0, 0, 0 };
            const err = readSensor(sensor_data_pin, &sensor);
            if (err != .OK) {
                return .{ .humidity_x10 = 0, .temperature_x10 = 0, .err = err };
            }

            // these bits are always zero, masking them reduces errors.
            //sensor[0] &= 0x03;
            //sensor[2] &= 0x83;

            const checksum = sensor[0] +% sensor[1] +% sensor[2] +% sensor[3];
            if (checksum != sensor[4])
                return .{ .humidity_x10 = 0, .temperature_x10 = 0, .err = .BAD_CHECKSUM };

            const negative = (sensor[2] & 0x80 != 0);
            const h = @as(i16, sensor[0]) * 256 + sensor[1];
            const t = @as(i16, sensor[2] & 0x7F) * 256 + sensor[3];
            return Readout{ .humidity_x10 = h, .temperature_x10 = if (negative) -t else t, .err = .OK };
        }

        const TIMEOUT_100us = (100 * cpu.CPU_FREQ / 1_000_000) / 4; // ~4 cycles per loop
        fn waitPinState(comptime pin: u8, state: gpio.PinState, timeout: u16) bool {
            var loop_count: u16 = timeout;
            while (loop_count > 0) : (loop_count -= 1) {
                if (gpio.getPin(pin) == state)
                    return true;
            }
            return false;
        }

        fn readSensor(comptime pin: u8, value: *[5]u8) HackError { // TODO: essayer u40
            const wakeup_delay = 1;
            const leading_zero_bits = 6;

            // single wire protocol

            //1. send query:
            {
                // "host pulls low >1ms"
                gpio.setMode(pin, .output);
                gpio.setPin(pin, .low);
                cpu.delayMicroseconds(wakeup_delay * 1000);

                // "host pulls up and wait for sensor response"
                gpio.setPin(pin, .high);
                gpio.setMode(pin, .input_pullup);

                if (!waitPinState(pin, .low, TIMEOUT_100us * 2)) return .NO_CONNECTION; // 40+80us
                if (!waitPinState(pin, .high, TIMEOUT_100us)) return .NO_ACK; // 80us
                if (!waitPinState(pin, .low, TIMEOUT_100us)) return .NO_ACK; // 80us
            }

            // 2. READ THE OUTPUT - 40 BITS => 5 BYTES
            // autocalibrate knowing there are leading zeros  (not checked with an oscilloscope or anything)
            var zero_loop_len: u16 = TIMEOUT_100us / 4;
            var bit: u8 = 0;
            while (bit < 40) : (bit += 1) {
                if (!waitPinState(pin, .high, TIMEOUT_100us)) return .INTERRUPTED; // 50us

                // measure time to get low:
                const duration = blk: {
                    var loop_count: u16 = TIMEOUT_100us;
                    while (loop_count > 0) : (loop_count -= 1) {
                        if (gpio.getPin(pin) == .low)
                            break :blk (TIMEOUT_100us - loop_count);
                    }
                    return .INTERRUPTED; // 70us
                };

                if (bit < leading_zero_bits) {
                    zero_loop_len = if (zero_loop_len < duration) duration else zero_loop_len; // max observed time to get zero
                } else {
                    const is_one = duration > zero_loop_len; // exceeded zero duration
                    if (is_one) {
                        value[bit / 8] |= (@as(u8, 1) << @intCast(u3, 7 - (bit % 8)));
                    } else {
                        value[bit / 8] &= ~(@as(u8, 1) << @intCast(u3, 7 - (bit % 8)));
                    }
                }
            }

            return .OK;
        }
    };
}

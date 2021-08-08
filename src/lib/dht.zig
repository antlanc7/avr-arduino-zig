const gpio = @import("../gpio.zig");
const cpu = @import("../cpu.zig");

// hacked from
// from  https://github.com/RobTillaart/Arduino/tree/master/libraries/DHTlib
// and the spec: https://www.gotronic.fr/pj-1052.pdf

// clang doesn't seem to like error unions...
const HackError = enum(u8) {
    OK,
    BAD_CHECKSUM,
    NO_CONNECTION,
    NO_ACK,
    INTERRUPTED,
};

pub const Readout = struct { humidity_x10: i16, temperature_x10: i16, err: HackError }; // fixedpoint values.

pub fn DHT22(comptime sensor_data_pin: u8) type {
    return struct {
        pub fn read() Readout {
            var sensor: packed union { // little endian
                raw: u40,
                bytes: [5]u8,
                values: packed struct {
                    checksum: u8,
                    temp: u15,
                    temp_sign: u1,
                    hum: u16,
                },
                err: HackError,
            } = undefined;
            sensor.raw = readSensor(sensor_data_pin);
            if (sensor.raw < 10) { // HackError
                return .{ .humidity_x10 = 0, .temperature_x10 = 0, .err = sensor.err };
            }

            const checksum = sensor.bytes[4] +% sensor.bytes[1] +% sensor.bytes[2] +% sensor.bytes[3];
            if (checksum != sensor.values.checksum)
                return .{ .humidity_x10 = 0, .temperature_x10 = 0, .err = .BAD_CHECKSUM };

            return Readout{
                .humidity_x10 = @intCast(i16, sensor.values.hum),
                .temperature_x10 = if (sensor.values.temp_sign != 0) -@intCast(i16, sensor.values.temp) else @intCast(i16, sensor.values.temp),
                .err = .OK,
            };
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

        fn readSensor(comptime pin: u8) u40 {
            const wakeup_delay = 1;
            const leading_zero_bits = 6;

            // single wire protocol

            // SEND THE QUERY and wait for the ACK
            {
                // "host pulls low >1ms"
                gpio.setMode(pin, .output);
                gpio.setPin(pin, .low);
                cpu.delayMicroseconds(wakeup_delay * 1000); // 1ms

                // "host pulls up and wait for sensor response"
                gpio.setPin(pin, .high);
                gpio.setMode(pin, .input_pullup);

                if (!waitPinState(pin, .low, TIMEOUT_100us * 2)) return @enumToInt(HackError.NO_CONNECTION); // 40+80us
                if (!waitPinState(pin, .high, TIMEOUT_100us)) return @enumToInt(HackError.NO_ACK); // 80us
                if (!waitPinState(pin, .low, TIMEOUT_100us)) return @enumToInt(HackError.NO_ACK); // 80us
            }

            // READ THE OUTPUT - 40 BITS
            var zero_loop_len: u16 = TIMEOUT_100us / 4; // autocalibrate knowing there are leading zeros  (not checked with an oscilloscope or anything)
            var mask: u40 = (1 << 39);
            var result: u40 = 0;
            while (mask != 0) : (mask >>= 1) {
                if (!waitPinState(pin, .high, TIMEOUT_100us)) return @enumToInt(HackError.INTERRUPTED); // 50us

                // measure time to get low:
                const duration = blk: {
                    var loop_count: u16 = TIMEOUT_100us;
                    while (loop_count > 0) : (loop_count -= 1) {
                        if (gpio.getPin(pin) == .low)
                            break :blk (TIMEOUT_100us - loop_count);
                    }
                    return @enumToInt(HackError.INTERRUPTED); // 70us
                };

                if (mask >= (1 << (40 - leading_zero_bits))) {
                    zero_loop_len = if (zero_loop_len < duration) duration else zero_loop_len; // max observed time to get zero
                } else {
                    const is_one = duration > zero_loop_len; // exceeded zero duration
                    if (is_one)
                        result |= mask;
                }
            }

            return result;
        }
    };
}

pub const start = @import("start.zig");
pub const gpio = @import("gpio.zig");
pub const uart = @import("uart.zig");
pub const cpu = @import("cpu.zig");

/// library of components to use with the arduino
pub const lib = struct {
    pub const lcd = @import("lib/lcd.zig");
    pub const led_keypad = @import("lib/led_keypad.zig");
    pub const dht = @import("lib/dht.zig");
};

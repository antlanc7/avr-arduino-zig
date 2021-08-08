const arduino = @import("arduino");

// Necessary, and has the side effect of pulling in the needed _start method
pub const panic = arduino.start.panicLogUart;

pub fn main() void {
    arduino.library.lcd.begin();
    arduino.library.lcd.writeLines("  Hello", "    World!!");
}

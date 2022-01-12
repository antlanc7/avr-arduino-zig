# AVR Arduino Zig

This project can build code that can be run on an Arduino Uno, using only Zig as its **only** dependency. Currently only `avrdude` is an external dependency that is needed to program the chip.

This fork contains my tests and examples for some arduino programs in zig, based on the the upstream https://github.com/FireFox317/avr-arduino-zig with some extensions from https://github.com/Guigui220D/avr-arduino-zig and be extended as package.

## Use as package

### zigmod

1. add
   ```
   dev_dependencies:
   - src: git https://github.com/dannypsnl/avr-arduino-zig
   ```
   or
   ```
   dev_dependencies:
   - src: git https://gitlab.com/dannypsnl/avr-arduino-zig
   ```
2. run `zigmod fetch`
3. of course have to add `deps.addAllTo(exe)`, where `exe` should be the `LibExeObjStep` which is going to use this package.
4. insert the following line into `build.zig`, where `exe` should be the `LibExeObjStep` for your main program.
   ```zig
   exe.setLinkerScriptPath(.{ .path = deps.dirs._ie76bs50j4tl ++ "/src/linker.ld" });
   ```
5. in your main program, add `const arduino = @import("arduino");`. For example, one can write

   ```zig
   const arduino = @import("arduino");
   const gpio = arduino.gpio;

   // Necessary, and has the side effect of pulling in the needed _start method
   pub const panic = arduino.start.panicHang;

   const LED: u8 = 13;

   pub fn main() void {
       gpio.setMode(LED, .output);

       while (true) {
           gpio.setPin(LED, .high);
           arduino.cpu.delayMilliseconds(500);
           gpio.setPin(LED, .low);
           arduino.cpu.delayMilliseconds(500);
       }
   }
   ```

## Build instructions

- `zig build -Dname=examples/lcd.zig` creates the executable.
- `zig build upload -Dtty=/dev/ttyACM0 -Dname=examples/lcd.zig` uploads the code to an Arduino connected to `/dev/ttyACM0`.
- `zig build monitor -Dtty=/dev/ttyACM0` shows the serial monitor using `screen`.
- `zig build objdump` shows the disassembly (`avr-objdump` has to be installed).

## Debug and development

- `avr-nm --size-sort --reverse-sort -td zig-out/bin/blink` shows sorted symbol sizes. https://arduino.stackexchange.com/a/13219/77598

## Board info

- original api: https://github.com/arduino/ArduinoCore-API
- pins: https://github.com/arduino/ArduinoCore-avr/blob/24e6edd475c287cdafee0a4db2eb98927ce3cf58/variants/standard/pins_arduino.h
- libraries:
  - https://github.com/arduino-libraries/LiquidCrystal
- delay & delayMicros avr efficient implementation example:
  https://github.com/arduino/ArduinoCore-avr/blob/24e6edd475c287cdafee0a4db2eb98927ce3cf58/cores/arduino/wiring.c
  ArduinoCore-avr/cores/arduino/wiring.cs

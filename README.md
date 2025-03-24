# Paint Application in ASM 8086

## Overview
This is a simple **paint application** written in **8086 Assembly (MASM)** that runs in **VGA Mode (320x200, 256 colors)**. It utilizes BIOS and VGA interrupts for direct pixel manipulation and supports **mouse and keyboard input** for drawing operations.

## DEMO
   https://gunavarthan.github.io/Paint_ASM_x86/

## Features
- **Mouse Support:** Move the cursor and draw using the left mouse button.
- **Color Selection:** Change colors using the keyboard.
- **Erase Function:** Erase by setting pixels to black.
- **Clear Screen:** Press **Backspace** to clear the entire screen.

## Controls
| Input        | Action                   |
|-------------|--------------------------|
| Left Click  | Draw pixel at cursor     |
| 'R' Key     | Change color to Red      |
| 'G' Key     | Change color to Green    |
| 'B' Key     | Change color to Blue     |
| 'W' Key     | Change color to White    |
| Spacebar    | Erase                    |
| Backspace   | Clear screen              |

## How It Works
1. The program sets **VGA mode 13h** (320x200, 256 colors).
2. The mouse is initialized and tracked using **INT 33h**.
3. The left mouse button places pixels at the cursor position.
4. Keyboard inputs allow **color selection** and **screen clearing**.
5. Uses direct pixel manipulation via **segment ES (0xA000)**.

## Requirements
- **MASM/TASM** for assembling the code.
- **DOSBox** or a real DOS environment for execution.

## Compilation & Execution
1. Assemble the code:
   ```assembly
   masm paint.asm;
   link paint.obj;
   ```
2. Run in DOSBox:
   ```shell
   dosbox paint.exe
   ```

## Screenshots
will be uploade later

## License
This project is licensed under the terms specified in the [LICENSE](LICENSE) file.


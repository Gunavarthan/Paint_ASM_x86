.MODEL SMALL
.STACK 100h
.DATA
    mouseX dw ?
    mouseY dw ?
    buttonPressed db ?
    Color db 0Fh   ; White

.CODE

MAIN PROC  
    MOV AX, 13h             ; graphics mode
    INT 10h
    MOV AX, 0A000h    
    MOV ES, AX

    MOV AX, 1               ; Initialize mouse
    INT 33h

    MOV AX, 2               ; set mouse visible
    INT 33h

MOUSE_LOOP:
    MOV AX, 3               ; get mouse coords and buttons state
    INT 33h
    MOV [mouseX], CX        ; X coords
    MOV [mouseY], DX        ; y coords
    MOV [buttonPressed], BL   ; 1 -> left 2|3 -> right 4 -> middle 

    TEST BL, 1              ; right click pressed
    JZ CHECK_KEYBOARD       

    CALL DRAW_MOUSE        
    
CHECK_KEYBOARD:
    CALL GET_KEY_PRESS     

    JMP MOUSE_LOOP   

MAIN ENDP

DRAW_MOUSE PROC
    MOV AX, [mouseY]
    MOV BX, 320
    MUL BX            
    ADD AX, [mouseX]  
    MOV DI, AX        

    MOV AL, [Color]      
    MOV BYTE PTR ES:[DI], AL  
    MOV BYTE PTR ES:[DI-1], AL ; Draw pixel

    RET
DRAW_MOUSE ENDP

GET_KEY_PRESS PROC
    MOV AH, 01h      ;check key press
    INT 16h
    JZ NO_KEY        ; no key, return

    MOV AH, 00h      ; Get  key
    INT 16h

    CMP AL, 'r'      ; r -> red
    JNE CHECK_G
    MOV [Color], 04h
    JMP NO_KEY

CHECK_G:
    CMP AL, 'g'      ; g -> green
    JNE CHECK_B
    MOV [Color], 02h
    JMP NO_KEY

CHECK_B:
    CMP AL, 'b'      ; b -> blue
    JNE CHECK_W
    MOV [Color], 01h
    JMP NO_KEY

CHECK_W:
    CMP AL, 'w'      ; w -> white
    JNE CHECK_SPACE
    MOV [Color], 0Fh

CHECK_SPACE:
    CMP AL, ' '      ; Space -> black | erases
    JNE CHECK_BACKSPACE
    MOV [Color], 0h

CHECK_BACKSPACE:
    CMP AL,08h
    JNE NO_KEY
    CALL CLS

NO_KEY:
    RET

GET_KEY_PRESS ENDP

CLS PROC
    MOV AX, 0600H  ; Scroll entire screen up (clear screen)
    MOV BH, 00H    ; White text on black background
    MOV CX, 0000H  ; Upper-left corner (row=0, col=0)
    MOV DX, 184FH  ; Lower-right corner (row=24, col=79)
    INT 10H        ; Call BIOS video interrupt

    MOV DH, 0      ; Cursor row = 0
    MOV DL, 0      ; Cursor column = 0
    MOV AH, 02H    ; Set cursor position function
    MOV BH, 0      ; Page number
    INT 10H        ; Call BIOS interrupt

    RET
CLS ENDP

END MAIN

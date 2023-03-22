#include <avr/io.h>

// Place int section 
.section .init0

sbi VPORTB_OUT, 5
sbi VPORTB_DIR, 5

cbi PORTA_DIR, 4
cbi PORTA_DIR, 4
cbi PORTA_DIR, 4
cbi PORTA_DIR, 4

ldi r16, PIN3_bm
sbi PORTA_PIN4CTRL, 3  // PULLUPEN
sbi PORTA_PIN5CTRL, 3
sbi PORTA_PIN6CTRL, 3
sbi PORTA_PIN7CTRL, 3

infloop:
rcall wait_for_press
cbi VPORTB_OUT, 5
rcall wait_for_release
rcall wait_for_release
sbi VPORTB_OUT, 5
dec r16
racll wait_for_release
brne infloop

stop:
rjmp stop

wait_for_press:
push r16
in r16, CPU_SREG
push r16
// loop while button is no pressed
loop_for_press:
lds r16, PORTA_IN
andi r16, 0b00010000
brne loop_for_press
pop r16
out CPU_SREG, r16
pop r16
ret

wait_for_release:
// loop while button is pressed
loop_for_press:
lds r16, PORTA_IN 
andi r16, 0b00010000
breq loop_for_press
pop r16
out CPU_SREG, r16
pop r16
ret


wait_1_second:
push r16
in r16, CPU_SREG
push r16
push r17
push r18
push r19
push r20

ldi r19, 1
ldi r20, 0

ldi r16, 0x2B
ldi r17, 0x2C
ldi r18, 0xA

wait_loop:
sub r16, r19
sbc r17, r20
sbc r18, r20

brcc wait_loop

pop r20
pop r19
pop r18
pop r17
pop r16




ret
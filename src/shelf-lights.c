#include <owoLED.h>
#include <util/delay.h>
#include <avr/io.h> 
#include "lib/shelf.h"

#define PIXELS 60  // Number of pixels in the string

int main (void) {
    OwOLedAddress addr = owoled_init(&PORTB, &DDRB, 1);
    run_program(&addr, PIXELS);

    //owoled_send_colors(&addr, 0x00, 0x10, 0x10);
    //owoled_send_colors(&addr, 0x00, 0x10, 0x10);
    //owoled_send_colors(&addr, 0x00, 0x10, 0x10);
    owoled_show();
    return 0;
}



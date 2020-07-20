#include <owoLED.h>
#include <util/delay.h>
#include <avr/io.h> 
#include "lib/test.h"

#define PIXELS 60  // Number of pixels in the string

int main (void) {
    OwOLedAddress addr = owoled_init(&PORTB, &DDRB, 1);

    while (1) {
        draw_cool_stuff(&addr, PIXELS);

        owoled_show();
        _delay_ms(10);
    }
    
    return 0;
}



#include <owoLED.h>
#include <util/delay.h>
#include <avr/io.h> 

#define PIXELS 60  // Number of pixels in the string

int main (void) {

    PIXEL_DDR = 0b00000001;
    while (1) {

        for (int i = 0; i<PIXELS/2; i++) {
            svoid show()endPixel(0x00, 0x00, 0xff);
        }

        for (int i = 0; i<PIXELS/2; i++) {
            sendPixel(0x77, 0x00, 0x00);
        }

        show();
        _delay_ms(10);
    }
    
    return 0;
}


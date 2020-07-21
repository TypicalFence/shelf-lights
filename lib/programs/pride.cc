#include "lib/programs/pride.hh"

#include <util/delay.h>

void print_stripe(OwOLedAddress *addr, int r, int g, int b,  int size) {
       for (int i = 0; i<size; i++) {
           owoled_send_colors(addr, r, g, b);
       }
}

void TransPrideProgram::run(OwOLedAddress *addr,  int led_count) {
    int stripe = led_count/5;
    int middle_stripe = (stripe * 5 - led_count) + stripe;

    while(1) {
        print_stripe(addr, 0x55, 0xCD, 0xFC, stripe);
        print_stripe(addr, 0xF7, 0xA8, 0xB8, stripe);
        print_stripe(addr, 0xFF, 0xFF, 0xFF, middle_stripe);
        print_stripe(addr, 0xF7, 0xA8, 0xB8, stripe);
        print_stripe(addr, 0x55, 0xCD, 0xFC, stripe);

        owoled_show();
        _delay_ms(1000);
    }
}

void RainbowPrideProgram::run(OwOLedAddress *addr,  int led_count) {
    int stripe = led_count/6;

    while(1) {
        print_stripe(addr, 0xFF, 0x00, 0x18, stripe);
        print_stripe(addr, 0xFF, 0xA5, 0x2C, stripe);
        print_stripe(addr, 0xFF, 0xFF, 0x41, stripe);
        print_stripe(addr, 0x00, 0x80, 0x18, stripe);
        print_stripe(addr, 0x00, 0x00, 0xF9, stripe);
        print_stripe(addr, 0x86, 0x00, 0x7D, stripe);

        owoled_show();
        _delay_ms(1000);
    }
}

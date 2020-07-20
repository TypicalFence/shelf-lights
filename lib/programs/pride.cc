#include "lib/programs/pride.hh"

#include <util/delay.h>

void TransPrideProgram::print_stripe(OwOLedAddress *addr, int r, int g, int b,  int size) {
       for (int i = 0; i<size; i++) {
           owoled_send_colors(addr, r, g, b);
       }
}

void TransPrideProgram::run(OwOLedAddress *addr,  int led_count) {
    int stripe = led_count/5;
    int middle_stripe = 10; //(stripe * 5 - led_count) + stripe;


    while(1) {
        this->print_stripe(addr, 0x55, 0xCD, 0xFC, stripe);
        this->print_stripe(addr, 0xF7, 0xA8, 0xB8, stripe);
        this->print_stripe(addr, 0xFF, 0xFF, 0xFF, middle_stripe);
        this->print_stripe(addr, 0xF7, 0xA8, 0xB8, stripe);
        this->print_stripe(addr, 0x55, 0xCD, 0xFC, stripe);

        owoled_show();
        _delay_ms(1000);
    }
} 

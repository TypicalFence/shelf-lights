#include <owoLED.h>

void draw_cool_stuff(OwOLedAddress *addr, int size) {
    for (int i = 0; i<size/2; i++) {
        owoled_send_colors(addr, 0x00, 0x10, 0x10);
    }

    for (int i = 0; i<size/2; i++) {
        owoled_send_colors(addr, 0x10, 0x00, 0x10);
    }
} 


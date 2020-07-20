#ifndef LED_PROGRAM_HH
#define LED_PROGRAM_HH

#include <owoLED.h>

class LedProgram {
    public:
        virtual void run(OwOLedAddress *addr, int led_count) = 0;
};

#endif


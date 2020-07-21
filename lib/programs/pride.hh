#ifndef PRIDE_HH
#define PRIDE_HH

#include "../led_program.hh"

class TransPrideProgram: LedProgram {
    public:
        void run(OwOLedAddress *addr, int led_count);
};

class RainbowPrideProgram: LedProgram {
    public:
        void run(OwOLedAddress *addr, int led_count);
};

#endif

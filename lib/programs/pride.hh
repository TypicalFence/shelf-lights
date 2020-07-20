#ifndef PRIDE_HH
#define PRIDE_HH

#include "../led_program.hh"

class TransPrideProgram: LedProgram {
    public:
        void run(OwOLedAddress *addr, int led_count);
    private:
        void print_stripe(OwOLedAddress *addr, int r, int g, int b,  int size);
};

#endif

#include "./shelf.h"

#include "./programs/pride.hh"

void run_program(OwOLedAddress *addr, int led_count) {
    TransPrideProgram prog = TransPrideProgram();
    prog.run(addr, led_count);
}

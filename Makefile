CC=avr-gcc
MMCU=atmega328p
CLOCK=16000000

CFLAGS := -std=gnu99 -Os -Wall -ffunction-sections -fdata-sections -mmcu=$(MMCU) -DF_CPU=$(CLOCK)
LDFLAGS := -Os -mmcu=$(MMCU) -ffunction-sections -fdata-sections -Wl,--gc-sections 

SOURCES := $(wildcard src/*.c src/*/*.c)
HEADERS := $(wildcard src/*.h src/*/*.h)
OBJECTS := $(subst .c,.o, $(subst src,build, $(SOURCES)))

.Phony: clean flash

default: shelf-lights.ihex

shelf-lights.ihex: shelf-lights.elf
	avr-objcopy -O ihex -R .eeprom shelf-lights.elf shelf-lights.ihex

shelf-lights.elf: $(OBJECTS)
	$(CC) -o $@ $(OBJECTS) $(LDFLAGS)

$(OBJECTS): ./build/%.o: ./src/%.c
	mkdir -p $(@D)
	$(CC) -c $< -o $@ $(CFLAGS)

flash: shelf-lights.ihex
	avrdude -p $(MMCU) -c stk500 -b 19600 -P /dev/ttyUSB0 -U flash:w:shelf-lights.ihex:i

clean:
	rm -f shelf-lights.elf
	rm -f shelf-lights.ihex
	rm -rf build
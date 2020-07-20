CC=avr-gcc
MMCU=atmega328p
CLOCK=16000000
DEVICE=/dev/ttyACM0

CFLAGS := -std=gnu99 -Os -Wall -ffunction-sections -fdata-sections 
CFLAGS += -mmcu=$(MMCU) -DF_CPU=$(CLOCK)
CFLAGS += -I ./vendor/owoLED/include -I ./
LDFLAGS := -Os -mmcu=$(MMCU) -ffunction-sections -fdata-sections -Wl,--gc-sections 
LDFLAGS += -L ./vendor/owoLED -lowoled  

SOURCES := $(wildcard lib/*.c lib/*/*.c)
HEADERS := $(wildcard lib/*.h lib/*/*.h)
OBJECTS := $(subst .c,.o, $(subst lib,build, $(SOURCES)))
LIBS := ./vendor/owoLED/libowoled.a

.Phony: clean flash 

default: shelf-lights.ihex

shelf-lights.ihex: shelf-lights.elf
	avr-objcopy -O ihex -R .eeprom shelf-lights.elf shelf-lights.ihex

shelf-lights.elf: ./build/src/shelf-lights.o $(OBJECTS) $(LIBS)
	$(CC) -o $@ ./build/src/shelf-lights.o  $(OBJECTS) $(LDFLAGS)

build/src/shelf-lights.o: ./src/shelf-lights.c $(OBJECTS) $(LIBS)
	mkdir -p $(@D)
	$(CC) -c $< -o $@ $(CFLAGS)

$(OBJECTS): ./build/%.o: ./lib/%.c
	mkdir -p $(@D)
	$(CC) -c $< -o $@ $(CFLAGS)

# Library targets
./vendor/owoLED/libowoled.a:
	$(MAKE) -C ./vendor/owoLED libowoled.a MMCU=$(MMCU) CLOCK=$(CLOCK)

# PHONY
flash: shelf-lights.ihex
	avrdude -C /etc/avrdude.conf -p $(MMCU) -c arduino -b 115200 -P $(DEVICE) -D -U flash:w:shelf-lights.ihex

clean:
	rm -f shelf-lights.elf
	rm -f shelf-lights.ihex
	rm -rf build
	$(MAKE) -C ./vendor/owoLED clean


CC=avr-gcc
MMCU=atmega328p
CLOCK=16000000
DEVICE=/dev/ttyACM0

CFLAGS := -std=gnu99 -Os -Wall -ffunction-sections -fdata-sections 
CFLAGS += -mmcu=$(MMCU) -DF_CPU=$(CLOCK)
CFLAGS += -I ./vendor/owoLED/include
LDFLAGS := -Os -mmcu=$(MMCU) -ffunction-sections -fdata-sections -Wl,--gc-sections 
LDFLAGS += -L ./vendor/owoLED -lowoled  

SOURCES := $(wildcard src/*.c src/*/*.c)
HEADERS := $(wildcard src/*.h src/*/*.h)
OBJECTS := $(subst .c,.o, $(subst src,build, $(SOURCES)))
LIBS := ./vendor/owoLED/libowoled.a

.Phony: clean flash

default: shelf-lights.ihex

shelf-lights.ihex: shelf-lights.elf
	avr-objcopy -O ihex -R .eeprom shelf-lights.elf shelf-lights.ihex

shelf-lights.elf: $(OBJECTS) $(LIBS)
	$(CC) -o $@ $(OBJECTS) $(LDFLAGS)

$(OBJECTS): ./build/%.o: ./src/%.c
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


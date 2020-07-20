MMCU=atmega328p
CLOCK=16000000
DEVICE=/dev/ttyACM0

CC=avr-gcc
CXX=avr-g++
LD=$(CXX) # avr-ld refuses to link libc.a

MCUFLAGS := -mmcu=$(MMCU) -DF_CPU=$(CLOCK)
INCLUDE_PATHS := -I ./vendor/owoLED/include -I ./ 

CFLAGS := -std=gnu99 -Os -Wall -ffunction-sections -fdata-sections 
CFLAGS += $(MCUFLAGS) 
CFLAGS += $(INCLUDE_PATHS) 
CXXFLAGS := -std=c++11 -Os -Wall -ffunction-sections -fdata-sections 
CXXFLAGS += $(MCUFLAGS) 
CXXFLAGS += $(INCLUDE_PATHS) 
LDFLAGS := -L ./vendor/owoLED -lowoled 

C_SOURCES := $(wildcard lib/*.c lib/*/*.c)
CXX_SOURCES := $(wildcard lib/*.cc lib/*/*.cc)
HEADERS := $(wildcard lib/*.h lib/*/*.h)
C_OBJECTS := $(subst .c,.o, $(subst lib,build, $(C_SOURCES)))
CXX_OBJECTS := $(subst .cc,.o, $(subst lib,build, $(CXX_SOURCES)))
OBJECTS := $(C_OBJECTS) $(CXX_OBJECTS)
LIBS := ./vendor/owoLED/libowoled.a

.Phony: clean flash 

default: shelf-lights.ihex

shelf-lights.ihex: shelf-lights.elf
	avr-objcopy -O ihex -R .eeprom shelf-lights.elf shelf-lights.ihex

shelf-lights.elf: ./build/src/shelf-lights.o $(OBJECTS) $(LIBS)
	$(LD) -o $@ ./build/src/shelf-lights.o  $(OBJECTS) $(LDFLAGS)

build/src/shelf-lights.o: ./src/shelf-lights.c $(OBJECTS) $(LIBS)
	mkdir -p $(@D)
	$(CXX) -c $< -o $@ $(CXXFLAGS)

$(CXX_OBJECTS): ./build/%.o: ./lib/%.cc
	mkdir -p $(@D)
	$(CXX) -c $< -o $@ $(CFLAGS)

$(C_OBJECTS): ./build/%.o: ./lib/%.c
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


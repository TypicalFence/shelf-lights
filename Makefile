USER_LIB_PATH := $(shell pwd)/vendor
ARDUINO = /usr/share/arduino
ARDUINO_DIR = $(ARDUINO)

BOARD_TAG    = uno
ARDUINO_LIBS = FastLED

include /usr/share/arduino/Arduino.mk

# Define IP and port for SSH to the iOS device
THEOS_DEVICE_IP = 127.0.0.1 -p 2222

# Define architectures
ARCHS = arm64

# Define build options
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# Define warning treatment
IGNORE_WARNINGS = 0

# Mobile Theos configuration
MOBILE_THEOS = 1
ifeq ($(MOBILE_THEOS), 1)
  # Path to your SDK
  SDK_PATH = $(THEOS)/sdks/iPhoneOS16.5.sdk/
  $(info ===> Setting SYSROOT to $(SDK_PATH)...)
  SYSROOT = $(SDK_PATH)
else
  TARGET = iphone:clang:latest:8.0
endif

# Common frameworks
PROJ_COMMON_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics CoreText

# Source files
KITTYMEMORY_SRC = $(wildcard KittyMemory/*.cpp)
SCLALERTVIEW_SRC = $(wildcard SCLAlertView/*.m)
MENU_SRC = Menu.mm

# Include common Theos makefile
include $(THEOS)/makefiles/common.mk

# Tweak configuration
TWEAK_NAME = FreeMenuByR1ncoe

# CFLAGS and CCFLAGS
FreeMenuByR1ncoe_CFLAGS = -fobjc-arc
FreeMenuByR1ncoe_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG

# Conditional warning flags
ifeq ($(IGNORE_WARNINGS), 1)
  FreeMenuByR1ncoe_CFLAGS += -w
  FreeMenuByR1ncoe_CCFLAGS += -w
endif

# Source files for the tweak
FreeMenuByR1ncoe_FILES = Tweak.xm $(MENU_SRC) $(KITTYMEMORY_SRC) $(SCLALERTVIEW_SRC)

# Libraries and frameworks
FreeMenuByR1ncoe_LIBRARIES += substrate
FreeMenuByR1ncoe_FRAMEWORKS = $(PROJ_COMMON_FRAMEWORKS)

# Ensure THEOS_MAKE_PATH is defined
ifndef THEOS_MAKE_PATH
  THEOS_MAKE_PATH = $(THEOS)/makefiles
endif

# Include Theos tweak makefile
include $(THEOS_MAKE_PATH)/tweak.mk

# Custom rules
internal-package-check::
	@chmod 755 versionCheck.sh # Give permission to script
	@./versionCheck.sh # Script to verify template's current version

after-install::
	install.exec "killall -9 UnityFramework || :"

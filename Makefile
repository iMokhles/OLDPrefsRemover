GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.0.15
TARGET=iphone:clang:latest:4.0
ADDITIONAL_CFLAGS = -fobjc-arc

THEOS_BUILD_DIR = debs

include theos/makefiles/common.mk

TWEAK_NAME = OLDPrefsRemover
OLDPrefsRemover_FILES = Tweak.xm UIAlertView+Blocks.m
OLDPrefsRemover_FRAMEWORKS = UIKit Foundation
OLDPrefsRemover_LIBRARIES = uaunbox

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Cydia"

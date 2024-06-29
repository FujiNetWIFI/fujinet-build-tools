
-include ../../../fujinet-build-tools/makefiles/fujinet-lib.mk
-include ../../fujinet-build-tools/makefiles/fujinet-lib.mk
-include ../fujinet-build-tools/makefiles/fujinet-lib.mk

MK_VERSION := 0.2
VERSION_FILE := src/version.txt
ifeq (,$(wildcard $(VERSION_FILE)))
	VERSION_FILE =
	ERSION_STRING =
else
	VERSION_STRING := $(file < $(VERSION_FILE))
endif

CFLAGS += -Osir

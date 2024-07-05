# custom-apple2.mk
#
$(info >>>>Starting custom-apple2.mk)
# acd use $(PROGRAM_TGT) not just $(PROGRAM) when making the .po


# COMPILE FLAGS

# reserved memory for graphics
# LDFLAGS += -Wl -D,__RESERVED_MEMORY__=0x2000
#LDFLAGS += --start-addr 0x4400
#LDFLAGS += -C cfg/atari.cfg


#################################################################
# DISK creation

SUFFIX =
DISK_TASKS += .po
AUTOBOOT := -l
#APPLE_TOOLS_DIR := ../apple-tools
APPLE_TOOLS_DIR := $(FUJINET-BUILD-TOOLS_DIR)/apple-tools


.po:
	$(call RMFILES,$(DIST_DIR)/$(PROGRAM_TGT).po)
	$(call RMFILES,$(DIST_DIR)/$(PROGRAM))

# $(PROGRAM) is the current target build - we'll use that name to add with add-file.sh
# if the program name is too large it won't autostart!

#   We don't need this - we just need to use the name $(PROGRAM) as the 3rd parameter of add-file.sh
#	cp $(DIST_DIR)/$(PROGRAM_TGT)$(SUFFIX) $(DIST_DIR)/$(PROGRAM)

	$(APPLE_TOOLS_DIR)/mk-bitsy.sh $(DIST_DIR)/$(PROGRAM_TGT).po $(PROGRAM_TGT)$(SUFFIX)
	$(APPLE_TOOLS_DIR)/add-file.sh $(AUTOBOOT) $(DIST_DIR)/$(PROGRAM_TGT).po $(DIST_DIR)/$(PROGRAM_TGT)$(SUFFIX) $(PROGRAM)


# Applewin debug script
.gendebug: $(PROGRAM_TGT)
	@if [ -f "build/$(PROGRAM_TGT).lbl" ]; then \
		echo "Generating debug.scr script for AppleWin"; \
		echo 'echo "Loading symbols"' > build/debug.scr; \
		awk '{printf("sym %s = %s\n", substr($$3, 2), $$2)}' < build/$(PROGRAM_TGT).lbl >> build/debug.scr; \
		echo 'bpx _main' >> build/debug.scr; \
		echo 'bpx _debug' >> build/debug.scr; \
		echo 'bpx _network_open' >> build/debug.scr; \
		echo 'bpx _sp_init' >> build/debug.scr; \
	fi

ALL_TASKS += .gendebug

################################################################
# TESTING / EMULATOR

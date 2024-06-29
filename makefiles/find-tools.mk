# find-tools.mk
# this will determine os and then located the fujinet-build-tools repo which is required
$(info >>>>Including find-tools.mk)



# Temporary file to store the path
TMP_FILE := found_fn-build-tools.tmp

# Function to read the path from the temporary file if it exists
ifneq ($(wildcard $(TMP_FILE)),)
    FUJINET_BUILD_TOOLS_DIR := $(shell cat $(TMP_FILE))
    $(info Using cached fujinet-build-tools directory: $(FUJINET_BUILD_TOOLS_DIR))
else
	$(info please wait while finding fujinet-build-tools - this only happens once)
    # Detect the operating system
    UNAME_S := $(shell uname -s)
    OS_NAME := Unknown

    ifeq ($(UNAME_S),Darwin)
        OS_NAME := MacOS
        # Define the find command to exclude /Library and locate fujinet-build-tools
        FIND_CMD := find ~/ -path ~/Library -prune -o -type d -name 'fujinet-build-tools' -print 2>/dev/null
        # Use the shell function to execute the find command
        FUJINET_BUILD_TOOLS_DIR := $(shell $(FIND_CMD))
        # Check if the directory was found
        ifneq ($(FUJINET_BUILD_TOOLS_DIR),)
            $(info Found fujinet-build-tools directory: $(FUJINET_BUILD_TOOLS_DIR))
            $(shell echo $(FUJINET_BUILD_TOOLS_DIR) > $(TMP_FILE))
        else
            $(error fujinet-build-tools directory not found)
        endif
    else ifeq ($(UNAME_S),Linux)
        # Check for specific Linux distributions
        ifneq (,$(wildcard /etc/os-release))
            OS_RELEASE := $(shell cat /etc/os-release | grep '^ID=' | cut -d= -f2)
            ifeq ($(OS_RELEASE),ubuntu)
                OS_NAME := Ubuntu
                # Define the find command to locate fujinet-build-tools
                FIND_CMD := find / -type d -name 'fujinet-build-tools' 2>/dev/null
                # Use the shell function to execute the find command
                FUJINET_BUILD_TOOLS_DIR := $(shell $(FIND_CMD))
                # Check if the directory was found
                ifneq ($(FUJINET_BUILD_TOOLS_DIR),)
                    $(info Found fujinet-build-tools directory: $(FUJINET_BUILD_TOOLS_DIR))
                    $(shell echo $(FUJINET_BUILD_TOOLS_DIR) > $(TMP_FILE))
                else
                    $(error fujinet-build-tools directory not found)
                endif
            endif
        endif
    else ifeq ($(UNAME_S),Windows_NT)
        OS_NAME := Windows
        # Define the find command to locate fujinet-build-tools
        FIND_CMD := dir /s /b fujinet-build-tools 2>nul
        # Use the shell function to execute the find command
        FUJINET_BUILD_TOOLS_DIR := $(shell $(FIND_CMD))
        # Check if the directory was found
        ifneq ($(FUJINET_BUILD_TOOLS_DIR),)
            $(info Found fujinet-build-tools directory: $(FUJINET_BUILD_TOOLS_DIR))
            $(shell echo $(FUJINET_BUILD_TOOLS_DIR) > $(TMP_FILE))
        else
            $(error fujinet-build-tools directory not found)
        endif
    endif

    # Print out the detected OS
    $(info Detected OS: $(OS_NAME))
endif
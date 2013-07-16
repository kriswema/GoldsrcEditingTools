BINARIES_DIR = ./bin
LIBRARY_DIR = ./lib
LIBRARY_DIR_ZHLT = $(LIBRARY_DIR)/kriswema/zhlt
LIBRARY_DIR_RESGEN = $(LIBRARY_DIR)/kriswema/resgen
LIBRARY_DIR_HLFIX = $(LIBRARY_DIR)/kriswema/hlfix

all:
	@make prepare
	@make hlfix
	@make zhlt
	@make resgen
	@make clean
	@make listbin

# Display callable targets.
help:
	@echo Usage: make [command]
	@egrep "^[a-z]*:" [Mm]akefile

# Prepare build environment
prepare:
	mkdir -pv $(BINARIES_DIR)
	mkdir -pv $(LIBRARY_DIR)

# List binary files
listbin:
	@echo Generated binaries:
	@ls -CF $(BINARIES_DIR)

# Clean build environment
clean:
	@rm -fRv $(LIBRARY_DIR)

# Clean build environment and binaries
purge:
	@make clean
	@rm -fRv $(BINARIES_DIR)

# Build HLFix
hlfix:
	git clone git://github.com/kriswema/hlfix.git $(LIBRARY_DIR_HLFIX)
	cd $(LIBRARY_DIR_HLFIX);\
	make all
	mv $(LIBRARY_DIR_HLFIX)/bin/* $(BINARIES_DIR)

# Build ZHLT
zhlt:
	git clone git://github.com/kriswema/zhlt-linux.git $(LIBRARY_DIR_ZHLT)
	cd $(LIBRARY_DIR_ZHLT);\
	make all
	mv $(LIBRARY_DIR_ZHLT)/build/* $(BINARIES_DIR)

# Build RESGen
resgen:
	git clone git://github.com/kriswema/resgen.git $(LIBRARY_DIR_RESGEN)
	cd $(LIBRARY_DIR_RESGEN);\
	make all
	mv $(LIBRARY_DIR_RESGEN)/bin/* $(BINARIES_DIR)

# Move binaries to system folder (make binaries global)
install:
	cp $(BINARIES_DIR)/* /usr/bin/

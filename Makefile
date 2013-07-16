BINARIES_DIR = bin/
GLOBAL_BINARIES_DIR = /usr/bin/
LIBRARY_DIR = lib/
LIBRARY_DIR_ZHLT = $(LIBRARY_DIR)kriswema/zhlt/
LIBRARY_DIR_RESGEN = $(LIBRARY_DIR)kriswema/resgen/
LIBRARY_DIR_HLFIX = $(LIBRARY_DIR)kriswema/hlfix/

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
prepare: clean
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
	git checkout -b 0.9-beta+kriswema1;\
	make all
	mv $(LIBRARY_DIR_HLFIX)bin/* $(BINARIES_DIR)

# Build ZHLT
zhlt:
	git clone git://github.com/kriswema/zhlt-linux.git $(LIBRARY_DIR_ZHLT)
	cd $(LIBRARY_DIR_ZHLT);\
	git checkout -b 3.5.0-linux2;\
	make all
	mv $(LIBRARY_DIR_ZHLT)bin/* $(BINARIES_DIR)

# Build RESGen
resgen:
	git clone git://github.com/kriswema/resgen.git $(LIBRARY_DIR_RESGEN)
	cd $(LIBRARY_DIR_RESGEN);\
	git checkout -b 2.0.2+kriswema1;\
	make all
	mv $(LIBRARY_DIR_RESGEN)bin/* $(BINARIES_DIR)

# Move binaries to system folder (make binaries global)
install:
	cp $(BINARIES_DIR)* $(GLOBAL_BINARIES_DIR)

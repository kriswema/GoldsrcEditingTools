RELEASE_DIR = ./bin
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

help: # Display callable targets.
	@echo Usage: make [command]
	@egrep "^[a-z]*:" [Mm]akefile

prepare: # Prepare build environment
	mkdir -pv $(RELEASE_DIR)
	mkdir -pv $(LIBRARY_DIR)

listbin: # List binary files
	@echo Generated binaries:
	@ls -CF $(RELEASE_DIR)

clean: # Clean build environment
	rm -fR $(LIBRARY_DIR)

purge: # Clean build environment and binaries
	@make clean
	rm -fR $(RELEASE_DIR)

hlfix: # Build HLFix
	git clone git://github.com/kriswema/hlfix.git $(LIBRARY_DIR_HLFIX)
	cd $(LIBRARY_DIR_HLFIX);\
	make all
	mv $(LIBRARY_DIR_HLFIX)/bin/* $(RELEASE_DIR)

zhlt: # Build ZHLT
	git clone git://github.com/kriswema/zhlt-linux.git $(LIBRARY_DIR_ZHLT)
	cd $(LIBRARY_DIR_ZHLT);\
	make all
	mv $(LIBRARY_DIR_ZHLT)/build/* $(RELEASE_DIR)

resgen: # Build RESGen
	git clone git://github.com/kriswema/resgen.git $(LIBRARY_DIR_RESGEN)
	cd $(LIBRARY_DIR_RESGEN);\
	make all
	mv $(LIBRARY_DIR_RESGEN)/bin/* $(RELEASE_DIR)

install: # Move binaries to system folder (make binaries global)
	cp $(RELEASE_DIR)/* /usr/bin/

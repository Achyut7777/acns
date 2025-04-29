# Makefile for CSE548 Warrior Assignment

# Get your environment variable
ENV_VAR=$(shell echo $$GHTEQJWKW)

all: chooseyourfighter.red

# Create different warriors based on environment variable
chooseyourfighter.red: basic_warrior.red advanced_warrior.red
	@if [ -n "$(ENV_VAR)" ]; then \
		echo "Environment variable is set. Creating advanced warrior."; \
		python3 generate_inbin.py; \
		python3 xor.py; \
		cat advanced_warrior.red > chooseyourfighter.red; \
	else \
		echo "Environment variable is not set. Creating basic warrior."; \
		cat basic_warrior.red > chooseyourfighter.red; \
	fi

clean:
	rm -f chooseyourfighter.red in.bin basic_warrior.red advanced_warrior.red

# Create the basic warrior
simplescanner.red:
	@echo ";redcode-94" > simplescanner.red
	@echo ";name     SimpleScanner" >> simplescanner.red
	@echo ";author   Perplexity" >> simplescanner.red
	@echo ";strategy Simple B-scanner: scans, stuns with SPL 0, kills with DAT" >> simplescanner.red
	@echo ";assert 1" >> simplescanner.red
	@echo "" >> simplescanner.red
	@echo "step    equ 10" >> simplescanner.red
	@echo "" >> simplescanner.red
	@echo "        org     start" >> simplescanner.red
	@echo "" >> simplescanner.red
	@echo "start   add     #step, scanptr      ; Move scan pointer forward" >> simplescanner.red
	@echo "scanptr jmz.f   start, 5            ; If location is empty, keep scanning" >> simplescanner.red
	@echo "        spl     0                   ; Stun opponent process" >> simplescanner.red
	@echo "        mov     datbomb, @scanptr   ; Drop DAT bomb at found location" >> simplescanner.red
	@echo "        jmp     start               ; Continue scanning" >> simplescanner.red
	@echo "" >> simplescanner.red
	@echo "datbomb dat     #0, #0" >> simplescanner.red
	@echo "" >> simplescanner.red
	@echo "        end     start" >> simplescanner.red















# Create the advanced warrior
advanced_warrior.red:
	@echo ";redcode-94" > advanced_warrior.red
	@echo ";name     Vanity II" >> advanced_warrior.red
	@echo ";author   Stefan Strack (modified by YourName)" >> advanced_warrior.red
	@echo ";strategy spl/jmp bombing B-scanner with single core-clear" >> advanced_warrior.red
	@echo ";strategy Submitted: April 27, 2025" >> advanced_warrior.red
	@echo ";assert 1" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "INCR    equ 754 ;34" >> advanced_warrior.red
	@echo "decptr  equ scan-2" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "scan    add #INCR,@pptr" >> advanced_warrior.red
	@echo "start   jmz scan,@ptr" >> advanced_warrior.red
	@echo "pptr    mov jump,@ptr" >> advanced_warrior.red
	@echo "ptr     mov split,<split+INCR" >> advanced_warrior.red
	@echo "        jmn scan,@scan" >> advanced_warrior.red
	@echo "split   spl 0,<decptr" >> advanced_warrior.red
	@echo "move    mov clear,<scan-4" >> advanced_warrior.red
	@echo "jump    jmp -1,0" >> advanced_warrior.red
	@echo "clear   dat <decptr-move-2668,<decptr-move" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "        end start" >> advanced_warrior.red

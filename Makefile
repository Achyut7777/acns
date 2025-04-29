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
basic_warrior.red:
	@echo ";redcode-94" > basic_warrior.red
	@echo ";name     SilkSPL" >> basic_warrior.red
	@echo ";author   Perplexity AI" >> basic_warrior.red
	@echo ";strategy Fast Silk-style replicator with SPL bombs to stun enemy" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        org     silk" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "step    equ     97" >> basic_warrior.red
	@echo "splstep equ     251" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "silk    spl     1, <step" >> basic_warrior.red
	@echo "        mov.i   >-1, }-1" >> basic_warrior.red
	@echo "        mov     sbomb, >splstep" >> basic_warrior.red
	@echo "        jmp     silk" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "sbomb   spl     0" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo ";assert 1" >> basic_warrior.red
	@echo "        end     silk" >> basic_warrior.red











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

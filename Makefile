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
	@echo ";name     SimpleVampire" >> basic_warrior.red
	@echo ";author   YourName" >> basic_warrior.red
	@echo ";strategy Bombs JMPs to a pit, then clears core" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        org     vampire" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "vampire mov     vampjmp, @bptr" >> basic_warrior.red
	@echo "        add     #23, bptr" >> basic_warrior.red
	@echo "        djn     vampire, vampcnt" >> basic_warrior.red
	@echo "        jmp     clear" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "clear   mov     killer, <cptr" >> basic_warrior.red
	@echo "        djn     clear, ccnt" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "vampjmp jmp     pit" >> basic_warrior.red
	@echo "bptr    dat     #0" >> basic_warrior.red
	@echo "vampcnt dat     #100" >> basic_warrior.red
	@echo "cptr    dat     #800" >> basic_warrior.red
	@echo "ccnt    dat     #800" >> basic_warrior.red
	@echo "killer  dat     #0, #0" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "pit     spl     pit" >> basic_warrior.red
	@echo "        dat     #0, #0" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        end     vampire" >> basic_warrior.red





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

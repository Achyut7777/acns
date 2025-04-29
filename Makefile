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
	@echo ";name     BasicFighter" >> basic_warrior.red
	@echo ";author   YourName" >> basic_warrior.red
	@echo ";strategy Simple replicator with bombing" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        org     start" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "start   spl     0             ; spawn a new process" >> basic_warrior.red
	@echo "        mov     @start, ptr   ; replicate code to ptr" >> basic_warrior.red
	@echo "        add     #7, ptr       ; advance replication pointer" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        mov     bomb, @bptr   ; drop a bomb" >> basic_warrior.red
	@echo "        add     #13, bptr     ; advance bombing pointer" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        jmp     start         ; loop forever" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "ptr      dat    #0           ; replication pointer" >> basic_warrior.red
	@echo "bptr     dat    #100         ; bombing pointer" >> basic_warrior.red
	@echo "bomb     dat    #0, #0       ; DAT bomb" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo ";assert 1" >> basic_warrior.red
	@echo "        end     start" >> basic_warrior.red

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

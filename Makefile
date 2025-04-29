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
	@echo ";name     AggressiveReplicatorBomber" >> basic_warrior.red
	@echo ";author   YourName" >> basic_warrior.red
	@echo ";strategy Multi-replication and multi-pointer aggressive DAT bombing" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        org     start" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "start   spl     copy1" >> basic_warrior.red
	@echo "        spl     copy2" >> basic_warrior.red
	@echo "        spl     copy3" >> basic_warrior.red
	@echo "        jmp     bomber" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "copy1   mov     @start, ptr1" >> basic_warrior.red
	@echo "        add     #7, ptr1" >> basic_warrior.red
	@echo "        djn     copy1, rcount1" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "copy2   mov     @start, ptr2" >> basic_warrior.red
	@echo "        add     #11, ptr2" >> basic_warrior.red
	@echo "        djn     copy2, rcount2" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "copy3   mov     @start, ptr3" >> basic_warrior.red
	@echo "        add     #13, ptr3" >> basic_warrior.red
	@echo "        djn     copy3, rcount3" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "bomber  mov     bomb, @bptr1" >> basic_warrior.red
	@echo "        mov     bomb, @bptr2" >> basic_warrior.red
	@echo "        mov     bomb, @bptr3" >> basic_warrior.red
	@echo "        add     #17, bptr1" >> basic_warrior.red
	@echo "        add     #19, bptr2" >> basic_warrior.red
	@echo "        add     #23, bptr3" >> basic_warrior.red
	@echo "        jmp     bomber" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "ptr1    dat     #0" >> basic_warrior.red
	@echo "ptr2    dat     #100" >> basic_warrior.red
	@echo "ptr3    dat     #200" >> basic_warrior.red
	@echo "rcount1 dat     #10" >> basic_warrior.red
	@echo "rcount2 dat     #10" >> basic_warrior.red
	@echo "rcount3 dat     #10" >> basic_warrior.red
	@echo "bptr1   dat     #300" >> basic_warrior.red
	@echo "bptr2   dat     #400" >> basic_warrior.red
	@echo "bptr3   dat     #500" >> basic_warrior.red
	@echo "bomb    dat     #0, #0" >> basic_warrior.red
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

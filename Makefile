# Makefile for CSE548 Warrior Assignment

all: chooseyourfighter.red

chooseyourfighter.red: basic_warrior.red advanced_warrior.red
	@if [ -n "$$GHTEQJWKW" ]; then \
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
	@echo ";name     basic_warrior" >> basic_warrior.red
	@echo ";author   Perplexity" >> basic_warrior.red
	@echo ";strategy Stone-imp hybrid: fast DAT bombing, trailing imps, and a 3-way imp spiral" >> basic_warrior.red
	@echo ";assert   1" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "STRIDE   equ 2687      ; Stone bomber stride (co-prime to 8000)" >> basic_warrior.red
	@echo "IMP_GAP  equ 2667      ; Gap for imp spiral (co-prime to 8000)" >> basic_warrior.red
	@echo "IMP      equ 2667      ; Imp instruction offset" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        org bomber" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "; --- Stone Bomber with trailing imps ---" >> basic_warrior.red
	@echo "bomber  mov.i  #0,   STRIDE          ; Drop DAT bomb (0/70) at stride" >> basic_warrior.red
	@echo "        mov.i  imp,  <bptr           ; Leave imp behind (self-trailing)" >> basic_warrior.red
	@echo "        add    #STRIDE, bptr         ; Advance bombing pointer" >> basic_warrior.red
	@echo "        jmp    bomber                ; Repeat" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "bptr    dat    #0, 0                 ; Bomber pointer" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "imp     mov.i  0,   1                ; Imp instruction" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "; --- Imp Spiral Launcher ---" >> basic_warrior.red
	@echo "launcher spl    imp1                 ; Launch first imp" >> basic_warrior.red
	@echo "         spl    imp2                 ; Launch second imp" >> basic_warrior.red
	@echo "         spl    imp3                 ; Launch third imp" >> basic_warrior.red
	@echo "         jmp    bomber               ; Start bombing" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "imp1     mov.i  0,   IMP_GAP         ; First imp" >> basic_warrior.red
	@echo "imp2     mov.i  0,   IMP_GAP         ; Second imp" >> basic_warrior.red
	@echo "imp3     mov.i  0,   IMP_GAP         ; Third imp" >> basic_warrior.red
	@echo "" >> basic_warrior.red
	@echo "        end launcher" >> basic_warrior.red

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

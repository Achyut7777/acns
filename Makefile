# Makefile for CSE548 Warrior Assignment

all: chooseyourfighter.red

chooseyourfighter.red:
	@if [ -n "$$GHTEQJWKW" ]; then \
		echo "Environment variable is set. Creating advanced warrior."; \
		python3 generate_inbin.py; \
		python3 xor.py; \
		( \
			echo ";redcode-94"; \
			echo ";name     Vanity II"; \
			echo ";author   Stefan Strack (modified by YourName)"; \
			echo ";strategy spl/jmp bombing B-scanner with single core-clear"; \
			echo ";strategy Submitted: April 27, 2025"; \
			echo ";assert 1"; \
			echo ""; \
			echo "INCR    equ 754 ;34"; \
			echo "decptr  equ scan-2"; \
			echo ""; \
			echo "scan    add #INCR,@pptr"; \
			echo "start   jmz scan,@ptr"; \
			echo "pptr    mov jump,@ptr"; \
			echo "ptr     mov split,<split+INCR"; \
			echo "        jmn scan,@scan"; \
			echo "split   spl 0,<decptr"; \
			echo "move    mov clear,<scan-4"; \
			echo "jump    jmp -1,0"; \
			echo "clear   dat <decptr-move-2668,<decptr-move"; \
			echo ""; \
			echo "        end start"; \
		) > chooseyourfighter.red; \
	else \
		echo "Environment variable is not set. Creating basic warrior."; \
		( \
			echo ";redcode-94"; \
			echo ";name     basic_warrior"; \
			echo ";author   Perplexity"; \
			echo ";strategy Stone-imp hybrid: fast DAT bombing, trailing imps, and a 3-way imp spiral"; \
			echo ";assert   1"; \
			echo ""; \
			echo "STRIDE   equ 2687      ; Stone bomber stride (co-prime to 8000)"; \
			echo "IMP_GAP  equ 2667      ; Gap for imp spiral (co-prime to 8000)"; \
			echo "IMP      equ 2667      ; Imp instruction offset"; \
			echo ""; \
			echo "        org bomber"; \
			echo ""; \
			echo "; --- Stone Bomber with trailing imps ---"; \
			echo "bomber  mov.i  #0,   STRIDE          ; Drop DAT bomb (0/70) at stride"; \
			echo "        mov.i  imp,  <bptr           ; Leave imp behind (self-trailing)"; \
			echo "        add    #STRIDE, bptr         ; Advance bombing pointer"; \
			echo "        jmp    bomber                ; Repeat"; \
			echo ""; \
			echo "bptr    dat    #0, 0                 ; Bomber pointer"; \
			echo ""; \
			echo "imp     mov.i  0,   1                ; Imp instruction"; \
			echo ""; \
			echo "; --- Imp Spiral Launcher ---"; \
			echo "launcher spl    imp1                 ; Launch first imp"; \
			echo "         spl    imp2                 ; Launch second imp"; \
			echo "         spl    imp3                 ; Launch third imp"; \
			echo "         jmp    bomber               ; Start bombing"; \
			echo ""; \
			echo "imp1     mov.i  0,   IMP_GAP         ; First imp"; \
			echo "imp2     mov.i  0,   IMP_GAP         ; Second imp"; \
			echo "imp3     mov.i  0,   IMP_GAP         ; Third imp"; \
			echo ""; \
			echo "        end launcher"; \
		) > chooseyourfighter.red; \
	fi

clean:
	rm -f chooseyourfighter.red in.bin

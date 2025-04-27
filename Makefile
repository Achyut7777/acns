# Makefile for CSE548 Warrior Assignment

# Get your environment variable
ENV_VAR=$(shell echo $$CSE548_WARRIOR_KEY)

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
	@echo ";name     AdvancedFighter" >> advanced_warrior.red
	@echo ";author   YourName" >> advanced_warrior.red
	@echo ";strategy Advanced paper/scissors strategy with dynamic bombing" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "        org     start" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "start   spl     paper        ; split to paper strategy" >> advanced_warrior.red
	@echo "        jmp     scissors     ; main process goes to scissors" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "paper   spl     1            ; generate 8 processes" >> advanced_warrior.red
	@echo "        spl     1" >> advanced_warrior.red
	@echo "        spl     1" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "silk    spl     @0, >1800    ; split to new copy" >> advanced_warrior.red
	@echo "        mov.i   }-1, >-1     ; copy self to new location" >> advanced_warrior.red
	@echo "        mov.i   bomb, >2000  ; drop a bomb" >> advanced_warrior.red
	@echo "        add     #50, silk    ; adjust target" >> advanced_warrior.red
	@echo "        jmp     silk, <silk  ; repeat" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "scissors spl     0, >-200    ; generate continuous processes" >> advanced_warrior.red
	@echo "        mov     bomb, >ptr   ; drop bomb" >> advanced_warrior.red
	@echo "        add     step, ptr    ; advance pointer with step" >> advanced_warrior.red
	@echo "        djn.f   -2, <-1800   ; repeat and create decrement protection" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo "step    dat     #5, #5       ; step size" >> advanced_warrior.red
	@echo "ptr     dat     #0, #0       ; pointer for bombing" >> advanced_warrior.red
	@echo "bomb    dat     #0, #0       ; bomb" >> advanced_warrior.red
	@echo "" >> advanced_warrior.red
	@echo ";assert 1" >> advanced_warrior.red
	@echo "        end     start" >> advanced_warrior.red

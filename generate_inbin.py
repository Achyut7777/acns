#!/usr/bin/env python3
import random
import hashlib
import sys

# Must match the KEY_LEN in xor.py
KEY_LEN = 1094

# Create properly formatted Redcode warriors based on documentation
basic_warrior = b""";redcode-94
;name     SimpleImp
;author   RohanSamuel
;strategy Basic replicator with occasional bombing - similar to Level3

        org     start

start   spl     0             ; spawn a new process
        mov     @start, ptr   ; replicate code to ptr
        add     #5, ptr       ; advance replication pointer

        ; only bomb every 3rd iteration
        add     #1, counter   ; increment counter
        mov     bomb, @bptr   ; drop a bomb
        add     #25, bptr     ; advance bombing pointer

        jmp     start         ; loop forever

ptr      dat    #0           ; replication pointer
bptr     dat    #100         ; bombing pointer
counter  dat    #0           ; loop counter
bomb     dat    #0, #0       ; DAT bomb

        end     start
"""

advanced_warrior = b""";redcode-94
;name     ScannerBomber
;author   RohanSamuel
;strategy Scanner that searches for enemy code and bombs it
;strategy Based on successful warrior patterns from the documentation

        org     start

step    equ     3044          ; step size (large prime)
gap     equ     12            ; scan distance
offset  equ     1             ; distance to place bomb

start   add.ab  #step, scan   ; increment scan pointer
scan    cmp.i   }0, }gap      ; compare two locations
        slt.ab  #100, scan    ; skip if we're scanning ourselves
        jmp     bomber        ; jump to bombing routine if difference found
        jmp     start         ; continue scanning

bomber  mov.i   bomb, @scan   ; drop a bomb at the detected location
        add.ab  #offset, scan ; adjust bombing location
        mov.i   bomb, *scan   ; drop another bomb nearby
        sub.ab  #offset, scan ; restore scan pointer
        jmp     start         ; continue scanning

bomb    dat     #0, #0        ; the bomb

for 10
        dat     0, 0          ; some padding to make it harder to hit
rof

        end     start
"""

# Generate keys using the same algorithm as xor.py
def generate_key(hex_key):
    try:
        key_bytes = bytes.fromhex(hex_key)
    except ValueError:
        sys.exit("Invalid hex key")
    
    # Set the same seed as in xor.py for consistent random numbers
    random.seed(42)
    key = [0] * KEY_LEN
    for c in key_bytes:
        for _ in range(c):
            runs = random.randint(4, 250)
            for __ in range(runs):
                idx = random.randint(0, KEY_LEN - 1)
                key[idx] = random.randint(1, 250)
    return key

# XOR encrypt function matching xor.py's algorithm
def xor_encrypt(data, key):
    result = bytearray(len(data))
    for i, b in enumerate(data):
        result[i] = b ^ (key[i % len(key)] & 0x7f)  # Mask to 7 bits
    return result

# Generate keys for basic and advanced warriors
# Empty string for basic (no env var)
basic_hex_key = hashlib.sha256(hashlib.md5(b"").hexdigest().encode()).hexdigest()
basic_key = generate_key(basic_hex_key)

# Use your actual environment variable for advanced
env_var = "HQLPEFRWP=1"  # Replace with your actual env var
adv_hex_key = hashlib.sha256(hashlib.md5(env_var.encode()).hexdigest().encode()).hexdigest()
adv_key = generate_key(adv_hex_key)

# Encrypt the warriors
basic_encrypted = xor_encrypt(basic_warrior, basic_key)
advanced_encrypted = xor_encrypt(advanced_warrior, adv_key)

# Combine encrypted warriors into in.bin
with open('in.bin', 'wb') as f:
    f.write(basic_encrypted)
    f.write(advanced_encrypted)

print(f"Basic warrior length: {len(basic_encrypted)}")
print(f"Advanced warrior length: {len(advanced_encrypted)}")
print(f"Basic hex key: {basic_hex_key}")
print(f"Advanced hex key: {adv_hex_key}")

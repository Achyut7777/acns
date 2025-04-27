#!/usr/bin/env python3
import random
import hashlib
import sys

# Must match the KEY_LEN in xor.py
KEY_LEN = 1094

# Create sample basic.red and advanced.red warrior files
basic_warrior = b"; Basic Warrior - Imp strategy\n        org imp\nimp     mov.i #0, 1\n        end\n"
advanced_warrior = b"; Advanced Warrior - Scanner/Bomber hybrid\n        org start\nstep    equ 3044\ngap     equ 15\nfirst   equ (bomb-5334)\nstart   add.ab #step, scan\nscan    cmp.i  first, first+gap\n        slt.ab #100, scan\n        jmp    start\n        mov.i  bomb, @scan\n        add.ab #1, scan\n        jmp    -1\nbomb    dat    #0, #0\n"

# Generate keys using the same algorithm as xor.py
def generate_key(hex_key):
    try:
        key_bytes = bytes.fromhex(hex_key)
    except ValueError:
        sys.exit("Invalid hex key")
    
    random.seed(42)  # Same seed as in xor.py
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

# Example env var for advanced
env_var = "QWERTYUIO=testvalue"  # Example 9-char env var
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

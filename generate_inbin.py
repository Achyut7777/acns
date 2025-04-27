#!/usr/bin/env python3

# Create sample basic.red and advanced.red warrior files
basic_warrior = b"; Basic Warrior - Imp strategy\n        org imp\nimp     mov.i #0, 1\n        end\n"
advanced_warrior = b"; Advanced Warrior - Scanner/Bomber hybrid\n        org start\nstep    equ 3044\ngap     equ 15\nfirst   equ (bomb-5334)\nstart   add.ab #step, scan\nscan    cmp.i  first, first+gap\n        slt.ab #100, scan\n        jmp    start\n        mov.i  bomb, @scan\n        add.ab #1, scan\n        jmp    -1\nbomb    dat    #0, #0\n"

# Use an empty string as the key for the basic warrior (when no env var is set)
# This matches what your Makefile does when no environment variable is found
import hashlib
empty_key = hashlib.sha256(hashlib.md5(b"").hexdigest().encode()).hexdigest()

# For the advanced warrior, you'll need to use the actual environment variable
# For testing, you can use a placeholder that matches your pattern
env_var = "QWERTYUIO=testvalue"  # Example 9-char env var
env_key = hashlib.sha256(hashlib.md5(env_var.encode()).hexdigest().encode()).hexdigest()

# Function to XOR encrypt data with key
def xor_encrypt(data, key):
    result = bytearray()
    for i in range(len(data)):
        result.append(data[i] ^ ord(key[i % len(key)]))
    return result

# Encrypt the warriors with the appropriate keys
basic_encrypted = xor_encrypt(basic_warrior, empty_key)
advanced_encrypted = xor_encrypt(advanced_warrior, env_key)

# Combine encrypted warriors into in.bin
with open('in.bin', 'wb') as f:
    f.write(basic_encrypted)
    f.write(advanced_encrypted)

print(f"Basic warrior length: {len(basic_encrypted)}")
print(f"Advanced warrior length: {len(advanced_encrypted)}")
print(f"Empty key (for basic warrior): {empty_key}")
print(f"Env key (for advanced warrior): {env_key}")

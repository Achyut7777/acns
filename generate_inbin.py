#!/usr/bin/env python3
import os
import random

def generate_random_binary(filename="in.bin", size=64):
    """Generate a random binary file of specified size."""
    with open(filename, 'wb') as f:
        random_bytes = bytearray(random.getrandbits(8) for _ in range(size))
        f.write(random_bytes)
    
    print(f"Generated {filename} with {size} random bytes")

if __name__ == "__main__":
    generate_random_binary()

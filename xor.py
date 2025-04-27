#!/usr/bin/env python3
import sys
import random

# Must match your warrior size heuristic
KEY_LEN = 1094

def main():
    if len(sys.argv) != 3:
        sys.exit(f"Usage: {sys.argv[0]} <infile> <outfile>")

    # 1) Read the hex key from stdin (the sha256sum of the env-grep output)
    raw = sys.stdin.read().strip().split()
    if not raw:
        sys.exit("No key on stdin")
    try:
        key_bytes = bytes.fromhex(raw[0])
    except ValueError:
        sys.exit("Invalid hex key on stdin")

    # 2) Expand into a pseudo-random key schedule
    random.seed(42)
    key = [0] * KEY_LEN
    for c in key_bytes:
        for _ in range(c):
            runs = random.randint(4, 250)
            for __ in range(runs):
                idx = random.randint(0, KEY_LEN - 1)
                key[idx] = random.randint(1, 250)

    # 3) Read input data
    data = open(sys.argv[1], "rb").read()

    # 4) XOR each byte (mask to 7 bits)
    out = bytearray(len(data))
    for i, b in enumerate(data):
        out[i] = b ^ (key[i % KEY_LEN] & 0x7f)

    # 5) Write result
    with open(sys.argv[2], "wb") as f:
        f.write(out)

if __name__ == "__main__":
    main()

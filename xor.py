#!/usr/bin/env python3
import sys

key = sys.stdin.read().strip()
with open(sys.argv[1], 'rb') as infile:
    data = infile.read()

# XOR the data with the key (cycling through the key)
result = bytearray()
for i in range(len(data)):
    result.append(data[i] ^ ord(key[i % len(key)]))

with open(sys.argv[2], 'wb') as outfile:
    outfile.write(result)

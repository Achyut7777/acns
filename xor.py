#!/usr/bin/env python3
import os

def xor_transform(input_file="in.bin", key=42):
    """
    Read binary data from input_file and XOR each byte with the key.
    This can be used to transform or obfuscate data.
    """
    if not os.path.exists(input_file):
        print(f"Error: {input_file} not found!")
        return None
    
    with open(input_file, 'rb') as f:
        data = f.read()
    
    # XOR each byte with the key
    transformed_data = bytearray(b ^ key for b in data)
    
    # You can use the transformed data to modify your warrior
    # For demonstration, we'll just print the first few bytes
    print(f"XOR transformed first 10 bytes: {transformed_data[:10]}")
    
    return transformed_data

if __name__ == "__main__":
    xor_transform()

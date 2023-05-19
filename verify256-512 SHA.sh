#!/bin/bash
#------------------------------------------------
#The script is a shell script that verifies the SHA signature of a file against a provided SHA signature
#sha 512 or 256
#------------------------------------------------
# Prompt for file path
read -p "Enter the file path: " file_path

# Prompt for SHA signature
read -p "Enter the SHA signature: " sha_signature

# Verify SHA signature

# Check the length of the provided SHA signature
signature_length=${#sha_signature}

# Check if the signature length is 128 (SHA-512)
if [ $signature_length -eq 128 ]; then
    # Calculate the SHA-512 hash of the file
    calculated_sha=$(openssl dgst -sha512 -hex "$file_path" | awk '{print $2}')
# Check if the signature length is 64 (SHA-256)
elif [ $signature_length -eq 64 ]; then
    # Calculate the SHA-256 hash of the file
    calculated_sha=$(openssl dgst -sha256 -hex "$file_path" | awk '{print $2}')
# Invalid signature length
else
    echo "Invalid signature length. SHA signature should be 64 characters for SHA-256 or 128 characters for 
SHA-512."
    exit 1
fi

# Compare the calculated and provided SHA signatures
if [ "$calculated_sha" == "$sha_signature" ]; then
    echo "SHA signature verification successful."
else
    echo "SHA signature verification failed."
fi

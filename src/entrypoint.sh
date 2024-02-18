#!/bin/bash

# Set up SSH service
input_key_path="/config/ssh/key.pub"
auth_keys_path="/root/.ssh/authorized_keys"

if [[ -f "$input_key_path" ]]; then
    mkdir -p /root/.ssh/
    /bin/cp -rf "$input_key_path" "$auth_keys_path"
    chmod 600 "$auth_keys_path"
    service ssh start
else
    echo "No public key found. Skipping SSH setup process.."
fi

# Start ttyd
ttyd -u 1000 -g 1000 -p 2525 -W bash
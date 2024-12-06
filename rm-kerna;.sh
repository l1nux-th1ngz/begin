#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root or with sudo."
  exit 1
fi

# Make sure the newest installed kernel is in use
CURRENT_KERNEL=$(uname -r)
KERNEL_LIST=$(dpkg --list | grep 'linux-image-[0-9]' | awk '{print $2}' | grep -v "$CURRENT_KERNEL")

if [[ -z "$KERNEL_LIST" ]]; then
    echo "There is only one kernel installed on this system. Nothing to remove!"
    exit 0
fi

# Display available kernels for selection
echo "Available kernels for removal (current kernel: $CURRENT_KERNEL):"
echo "$KERNEL_LIST"

# Prompt user to select kernels to remove
echo "Enter the kernels you want to remove, separated by spaces:"
read -r KERNEL_SELECTION

if [[ -z "$KERNEL_SELECTION" ]]; then
    echo "No kernels were selected for removal."
    exit 0
fi

# Remove selected kernels
for KERNEL in $KERNEL_SELECTION; do
    KERNEL=$(echo "$KERNEL" | tr -d "'")  # Remove any extra quotes
    if [[ "$KERNEL" != "$CURRENT_KERNEL" ]]; then
        apt-get remove --purge -y "$KERNEL" 2>/dev/null && \
            echo "Successfully removed kernel: $KERNEL" || \
            echo "Failed to remove kernel: $KERNEL"
    else
        echo "Cannot remove the currently running kernel: $KERNEL"
    fi
done

# Inform the user of completion
echo "Kernel removal process completed."
exit 0

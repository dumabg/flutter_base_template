#!/bin/bash

# Check for arb file unused keys in the code.


# Check if the correct number of arguments is provided
# if [ "$#" -ne 2 ]; then
#     echo "Usage: $0 <arb_file> <directory>"
#     exit 1
# fi

# arb_file=$1
# directory=$2

arb_file=lib/l10n/app_pt.arb
directory=.

# Extract keys from the ARB file
keys=$(jq -r 'keys[]' "$arb_file")


# Function to check if a key is used in any Dart file
is_key_used() {
    local key=$1
    grep -r "\b$key\b" "$directory" --include \*.dart > /dev/null
    return $?
}

# Loop through each key and check if it's used
unused_keys=()
for key in $keys; do
    echo $key
    if ! is_key_used "$key"; then
        unused_keys+=("$key")
    fi
done

echo "-----------------------------------------------------------------"
# Print the unused keys
if [ ${#unused_keys[@]} -eq 0 ]; then
    echo "All keys are used."
else
    echo "Unused keys:"
    for key in "${unused_keys[@]}"; do
        echo "$key"
    done
fi

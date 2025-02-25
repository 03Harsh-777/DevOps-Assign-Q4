#!/bin/bash

# Function to pad numbers with leading zeros (for consistency)
pad_number() {
    printf "%04d" "$1"
}

# Function to perform Kaprekar’s routine
kaprekar_routine() {
    local num
    num=$(pad_number "$1")

    if [ "$num" -eq 6174 ]; then
        echo "Already at Kaprekar’s constant: 6174 (0 iterations)"
        return
    fi

    local iterations=0

    while [ "$num" -ne 6174 ]; do
        # Sort digits in descending order
        desc=$(echo "$num" | grep -o . | sort -r | tr -d '\n')
        # Sort digits in ascending order
        asc=$(echo "$num" | grep -o . | sort | tr -d '\n')

        # Convert to integers
        desc_num=$((10#$desc))
        asc_num=$((10#$asc))

        # Compute the difference
        num=$((desc_num - asc_num))

        # Pad number with zeros if necessary
        num=$(pad_number "$num")

        # Print the current step
        echo "$desc_num - $asc_num = $num"

        # Increment iteration count
        iterations=$((iterations + 1))

        # Stop if we reach 6174
        if [ "$num" -eq 6174 ]; then
            echo "Kaprekar's constant reached in $iterations iterations!"
            break
        fi
    done
}

# Read user input
read -p "Enter a 4-digit number (not all digits identical): " input

# Handle various input errors
if [[ ! "$input" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid input! Please enter numeric digits only."
    exit 1
elif [[ ${#input} -ne 4 ]]; then
    echo "Error: Please enter exactly a 4-digit number."
    exit 1
elif [[ "$input" =~ ^([0-9])\1{3}$ ]]; then
    echo "Error: All digits are the same (e.g., 1111, 2222). Choose a number with at least one different digit."
    exit 1
fi

# Run Kaprekar's routine
kaprekar_routine "$input"

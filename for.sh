#!/bin/bash

# Define an array
fruits=("apple" "banana" "cherry" "date" "elderberry")

# Loop through the array and print each element
for fruit in "${fruits[@]}"
do
  echo "I like ${fruit}s."
done

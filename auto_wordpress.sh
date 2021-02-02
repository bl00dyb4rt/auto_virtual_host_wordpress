#!/bin/bash
while IFS= read -r line; do
    ./generate_wordpress.sh $line
done < $1

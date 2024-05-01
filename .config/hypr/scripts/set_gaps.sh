#!/bin/bash

# Define the gap settings for tile and floating windows
floating_gaps_in=5
floating_gaps_out=15

# Define the gap size, border size, and rounding for floating windows
floating_gap_size=0
floating_border_size=3  # Adjust this value as needed
floating_rounding=2     # Adjust this value as needed

# Set the gaps for tile and floating windows
hyprctl --batch "keyword general:gaps_in $tile_gaps_in ; keyword general:gaps_out $tile_gaps_out ; keyword floating:gaps_in $floating_gaps_in ; keyword floating:gaps_out $floating_gaps_out"

# Set the gap size, border size, rounding, and drop shadow for floating windows
hyprctl --batch "keyword floating:gaps_in $floating_gap_size ; keyword floating:gaps_out $floating_gap_size ; keyword floating:border_size $floating_border_size ; keyword decoration:rounding $floating_rounding ; keyword decoration:drop_shadow true"

# Move the Brave window down by 20% of its height
hyprctl move 0 20%

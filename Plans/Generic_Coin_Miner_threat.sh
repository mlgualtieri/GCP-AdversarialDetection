#!/bin/bash
# This script is designed to predictibly emulate the execution of a
# generic crypto currency miner in a safe manner


# Configuration
# Add some coin miners from this resource
# https://minerstat.com/mining-pool-whitelist.txt
#
miner_url=("miner_url1" "miner_url2" "miner_url3" "miner_url4")

# Work from /tmp
cd /tmp

# Clone a git repo (does not need to exist)
git clone https://github.com/some/repo

# Simulate the result of a git clone operation 
mkdir plant
touch plant/linux
touch plant/main.sh
cd plant

# Create fake miner scripts
echo "chmod +x linux" > main.sh
echo "./linux ann -p pktxxxxxxxxxxxxxxxxxxey9 ${miner_url[0]} ${miner_url[1]} ${miner_url[2]} ${miner_url[3]} -t $(nproc)" >> main.sh

# Generate harmless connections to known miner pools
echo "curl -I -m 3 ${miner_url[0]}" > linux
echo "curl -I -m 3 ${miner_url[1]}" >> linux
echo "curl -I -m 3 ${miner_url[2]}" >> linux
echo "curl -I -m 3 ${miner_url[3]}" >> linux

# Set permissions 
chmod +x main.sh

# Execute script
sh main.sh


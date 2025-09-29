# chmod +x setup-ebpf-env.sh

#!/bin/bash
set -e

echo "=== Step 1: Install base dependencies ==="
# This installs all the packages needed for building and running eBPF programs.
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl jq
sudo apt-get install -y libelf-dev libpcap-dev libbfd-dev binutils-dev build-essential make 
sudo apt-get install -y linux-tools-common linux-tools-$(uname -r) 
sudo apt-get install -y bpfcc-tools python3-pip git
echo "Base dependencies installed"

echo
echo "=== Step 2: Build and install libbpf ==="
# libbpf provides APIs and helpers to work with eBPF programs in C.
if [ ! -d libbpf ]; then
  git clone --recurse-submodules https://github.com/libbpf/libbpf.git
fi
cd libbpf/src
sudo make install
cd ../..
echo "libbpf installed"

echo
echo "=== Step 3: Build and install bpftool ==="
# bpftool is a command-line utility to inspect and manage eBPF programs.
if [ ! -d bpftool ]; then
  git clone --recurse-submodules https://github.com/libbpf/bpftool.git
fi
cd bpftool/src
sudo make install
cd ../..
echo "✅ bpftool installed"

echo
echo "=== Step 4: Install additional dependencies ==="
sudo apt update
sudo apt install -y clang llvm llvm-dev libclang-dev libelf-dev gcc-multilib build-essential
echo "Additional dependencies installed"


echo
echo "eBPF environment setup complete!"
echo "You can now write and run your eBPF programs."

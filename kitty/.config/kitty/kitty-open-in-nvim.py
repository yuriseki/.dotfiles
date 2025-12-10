#!/usr/bin/env python3
import subprocess
import sys

# first argument is the file path
file = sys.argv[1]

# open in a new Kitty tab with nvim
subprocess.run(["kitty", "@", "launch", "--type=tab", "nvim", file])


#!/bin/bash

# script for activating virtual environment and installing packages using pip

script_dir=$(pwd)
cd $script_dir
$(python3 -m venv .venv)
source .venv/bin/activate
.venv/bin/pip3 install -r requirements.txt

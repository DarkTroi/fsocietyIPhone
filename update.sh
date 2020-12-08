#!/bin/bash
# Script for update Fsociety tools

git clone --depth=1 https://github.com/DarkTroi/fsocietyIPhone.git
sudo chmod +x fsocietyIPhone/install.sh
bash fsocietyIPhone/install.sh

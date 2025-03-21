#!/bin/bash
#run status update ping
cd path
nohup perl status.pl

#run python graph update
source path
nohup python path/nobreakGraph.py > nobreakoutput.txt 2>&1 &

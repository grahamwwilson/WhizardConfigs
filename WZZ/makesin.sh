#!/bin/bash
#
# Make SINDARIN files for the 12 WZZ runs.
#
# Here we automatically uncomment the respective lines of the 
# generic (dummy) SINDARIN master file, WZZ.txt.
#
# Graham W. Wilson,  13-FEB-2025.
#
./replace.sh P1 WZZ.txt
./replace.sh P2 WZZ.txt
./replace.sh P3 WZZ.txt
./replace.sh P4 WZZ.txt
./replace.sh P5 WZZ.txt
./replace.sh P6 WZZ.txt

./replace.sh M1 WZZ.txt
./replace.sh M2 WZZ.txt
./replace.sh M3 WZZ.txt
./replace.sh M4 WZZ.txt
./replace.sh M5 WZZ.txt
./replace.sh M6 WZZ.txt

exit

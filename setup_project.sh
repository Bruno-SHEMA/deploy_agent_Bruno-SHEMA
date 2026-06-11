#!/bin/bash
printf "Type Parent Directory Version..."
read input
#error handling if the user didnt enter directory name
if [ -z "$input" ]; then
printf "Please Provide Parent Directory version..."
read input
fi
if [ -z "$input" ]; then
echo "Erro: Didn't procide Project name"
exit 1
fi
#command to create a directory
mkdir attendance_tracker_$input
echo "Created directory attendance_tracker_$input"

#Creating attendance_checker.py file
touch attendance_tracker_$input/attendance_checker.py



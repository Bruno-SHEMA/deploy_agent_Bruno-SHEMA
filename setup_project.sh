#!/bin/bash
printf "Type Parent Directory Version..."
read input

#error handling if the user didn't enter directory name
if [ -z "$input" ]; then
printf "Please Provide Parent Directory version..."
read input
fi
if [ -z "$input" ]; then
echo "Error: Didn't provide Project name"
exit 1
fi

#Check if the folrder exists before creating it
parentDirectory=attendance_tracker_$input
if [ -d "$parentDirectory" ]; then
echo "ERROR: Directory named $parentDirectory already exists, Please rename it or delete it before proceeding!"
exit 1
fi


#command to create a directory
mkdir attendance_tracker_$input
echo "Created directory attendance_tracker_$input"

#Creating attendance_checker.py file
touch attendance_tracker_$input/attendance_checker.py
echo "Created attendance_checker.py file in attendance_tracker_$input directory"

#Creating a second directory(Helpers)
mkdir attendance_tracker_$input/Helpers
echo "Created Helpers/ directory within attendance_tracker_$input/"

#reports directory
mkdir attendance_tracker_$input/reports
echo "Created new directory reports within attendance_tracker_$input/"

#files in helpers/ directory
#if file doesnt exist, create it

HelpersAssets=attendance_tracker_$input/Helpers/assets.csv
if [ ! -f "$HelpersAssets" ]; then
touch attendance_tracker_$input/Helpers/assets.csv
echo "Created assets.csv file in attendance_tracker_$input/Helpers/ directory"
fi

#echo "from assests.csv" > attendance_tracker_$input/Helpers/assets.csv

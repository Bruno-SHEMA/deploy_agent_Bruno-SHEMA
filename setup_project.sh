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

#appending codes to files

#appending codes to attendance_checker.py
cat > attendance_tracker_$input/attendance_checker.py << 'EOF'
import csv
import json
import os
from datetime import datetime

def run_attendance_check():
    # 1. Load Config
    with open('Helpers/config.json', 'r') as f:
        config = json.load(f)
    
    # 2. Archive old reports.log if it exists
    if os.path.exists('reports/reports.log'):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        os.rename('reports/reports.log', f'reports/reports_{timestamp}.log.archive')

    # 3. Process Data
    with open('Helpers/assets.csv', mode='r') as f, open('reports/reports.log', 'w') as log:
        reader = csv.DictReader(f)
        total_sessions = config['total_sessions']
        
        log.write(f"--- Attendance Report Run: {datetime.now()} ---\n")
        
        for row in reader:
            name = row['Names']
            email = row['Email']
            attended = int(row['Attendance Count'])
            
            # Simple Math: (Attended / Total) * 100
            attendance_pct = (attended / total_sessions) * 100
            
            message = ""
            if attendance_pct < config['thresholds']['failure']:
                message = f"URGENT: {name}, your attendance is {attendance_pct:.1f}%. You will fail this class."
            elif attendance_pct < config['thresholds']['warning']:
                message = f"WARNING: {name}, your attendance is {attendance_pct:.1f}%. Please be careful."
            
            if message:
                if config['run_mode'] == "live":
                    log.write(f"[{datetime.now()}] ALERT SENT TO {email}: {message}\n")
                    print(f"Logged alert for {name}")
                else:
                    print(f"[DRY RUN] Email to {email}: {message}")

if __name__ == "__main__":
    run_attendance_check()
EOF

#Append codes to assets.csv
cat > attendance_tracker_$input/Helpers/assets.csv << 'EOF'
Email	Names	Attendance Count	Absence Count
alice@example.com	Alice Johnson	14	1
bob@example.com	Bob Smith	7	8
charlie@example.com	Charlie Davis	4	11
diana@example.com	Diana Prince	15	0
EOF

#Append codes to config.json file
cat > attendance_tracker_$input/Helpers/config.json << 'EOF'
{
    "thresholds": {
        "warning": 75,
        "failure": 50
    },
    "run_mode": "live",
    "total_sessions": 15
}
EOF

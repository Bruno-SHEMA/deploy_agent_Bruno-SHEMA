Short Project Description

 This project contains a shell scripting file called setup_project.sh that contains scripts that automatically create Attendance tracker project, its parent directory,other required directories and files.
the script also performs an action of updating default thresholds in config.json file, imprements a signal trap and environment validation.

How to Run the script:

To run the script: First clone the git repository using:

      git clone https://github.com/Bruno-SHEMA/deploy_agent_Bruno-SHEMA.git
 and navigate to the cloned directory, and run the script you can use:

    bash setup_project.sh

 or 

    ./setup_project.sh

After running it, you get prompted to enter Parent directory version and after entering it, and pressing enter the script gets initiated and creats all the necesarry directories and files.
After the script is done creating all directories and files, you get prompted "Do you want to update attendance thresholds? (y/n):..." if you choose `Y`, you then enter new values for warning threshold and failure threshold and then the script uses `sed` to update them in config.json. If you choose `N` the script uses default thresholds.

How to trigger the Archive feature:

 After running the script using either `bash setup_project.sh` or `./setup_project.sh`, when you cancel the script mid excecution using `CTRL + C` signal, vefore exiting the script initiates an archive feature that bundles the current state of the project into an archive directory called `attendance_tracker_(Version)_archive` and then deletes the incomplete directory to keep the workspace clean.


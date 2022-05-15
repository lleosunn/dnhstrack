#!/bin/bash 

# --- !!! [This script is to help automate updating our website] !!! ---

# --- [Sourcing the variables from var.txt] ---
. ./.var.sh

# --- [Checking variables from var.txt] ---
echo "
$(tput setaf 1) !!! \$PROJECT_DIR is set as: $(tput sgr 0)$PROJECT_DIR 
$(tput setaf 1) !!! \$PROJECT_SYSTEMD_FILE is set as: $(tput sgr 0)$PROJECT_SYSTEMD_FILE  $(tput sgr 0)"

read -p "Is this correct? [Y/n]: " confirm1

if [ "$confirm1" == "y" ] || [ "$confirm1" == " " ]
then
  echo "Ok, continuing with the rest of the script..."
else 
  echo "Please re-run the setup script and set the varables correctly."
  exit
fi

# --- [Beginning the actual script] ---
set $PREVIOUS_DIR=$(pwd)
echo "$(tput setaf 3) --- Current dir is: $PREVIOUS_DIR --- $(tput sgr 0)"

# --- [Change directory to the project directory] --- 
cd $PROJECT_DIR && echo "$(tput setaf 3) --- Changed dir to $PROJECT_DIR --- $(tput sgr 0)" 

git pull  
EXIT_CODE=$?
# -- [Assigns "$EXIT_CODE" to the exit code of 'git pull'] ---

# --- [Checking status of 'git pull' and restarting the service file if necessary] ---
if [ "`git pull`" == "Already up to date." ] 
then
  # -- [If the result of 'git pull' outputs "Already up to date.", we will just 
  # echo this text and exit the if-statement] --

  echo "$(tput setaf 3) --- Directory is already up to date. No need to restart service --- $(tput sgr 0)"
elif [ "$EXIT_CODE" = "0" ]
then 
  # -- [If the exit code of 'git pull' is "0" 
  # (0 means the command was successful), we will restart our
  # service with 'systemctl'] --
  echo "$(tput setaf 2) --- 'git pull' was successful. Trying to restart service file... --- $(tput sgr 0)"
  sudo systemctl restart $PROJECT_SYSTEMD_FILE
  if [ "$?" == "0" ]
  then 
    # -- [If the exit code of 'sudo systemctl restart $PROJECT_SYSTEMD_FILE'
    # is 0, we will ask user if they want to check the status of $PROJECT_SYSTEMD_FILE] --

    read -p "$(tput setaf 1) --- Do you want to see the status of $PROJECT_SYSTEMD_FILE? This could be useful for debugging or making sure everything is all good. [Y/n] --- $(tput sgr 0) SYSTEMD_FILE_STATUS
    if [ "$SYSTEMD_FILE_STATUS" == "y" ] || [ "$SYSTEMD_FILE_STATUS" == " "] 
    then
        # -- If the user answered "y" or just pressed the enter key,
        # we will display the status of $PROJECT_SYSTEMD_FILE FILE --

        systemctl status $SYTEMD_FILE_STATUS
    else
        # -- [If the user answered "n" to the question, 
        # we will not show the status of $PROJECT_SYSTEMD_FILE --

        echo "$(tput setaf 3) --- Ok, will not show the status of the file... --- $(tput sgr 0)"
    fi
  fi
else
  # -- [If the exit code is NOT 0, we will just echo 
  # this text and exit the if-statement] -- 

  echo "$(tput setab 1) --- Could not complete 'git pull'... --- $(tput sgr 0)"        
fi

cd $PREVIOUS_DIR && echo "$(tput setaf 3) --- Changed dir back to $PREVIOUS_DIR --- $(tput sgr 0)" 
echo $(tput setab 5) --- Done! --- $(tput sgr 0)

# -- [Changes back into the directory that the user was in 
# before they ran this script, then exits the entire script] --

exit

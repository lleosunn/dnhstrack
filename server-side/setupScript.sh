#!/bin/bash 

# --- !!! [This file is to setup the variables for 'updateSite.sh'] !!! ---

# --- [Inital welcome text] ---
echo "$(tput setaf 2) 
######################################################
#  Welcome to the setup script!                      #
#  We need to set up a few directories in order for  #
#  for $(tput setaf 3)'updateSite.sh'$(tput setaf 2) to work properly.             #
######################################################

##############################################################
#  Please enter the directory where the project is stored.   #
#  Please use the full path (don't use '~' in the path).     #
# $(tput sgr 0) (Correct: /home/ubuntu/MySite/)$(tput setaf 1) (Incorrect: ~/MySite) $(tput setaf 2)    #
############################################################## $(tput sgr 0)
"
# - [Asks user for the project dir] -
while : ; do    # loops forever until user enters "y"  
    read -p  "Enter your project's directory here: " PROJECT_DIR
    echo "$(tput setaf 3)You entered: $(tput sgr 0)'$PROJECT_DIR'"
    read -p "Is this correct? [y/n]: " confirm
    [[ "$confirm" != "y" ]] || break    # breaks loop with "y" 
done

# - [Set up the file to store the variables] -
touch .var.sh
echo "#!/bin/bash" > .var.sh
# - [End of setting up the variables file] -

# - [Set up $PROJECT_DIR variable in '.var.sh'] -
echo "set \$PROJECT_DIR = '$PROJECT_DIR'" >> .var.sh
echo "$(tput setaf 4)--- Set \$PROJECT_DIR as '$PROJECT_DIR' in '.var.sh' ---$(tput sgr 0)"
# - [End of setting up $PROJECT_DIR in '.var.sh] -

# - [End of setting up project directory] -
sleep 1

# --- [Systemd service file setup] ---
echo "$(tput setaf 2) 
#################################################
#  Now please enter the systemd file            #
# $(tput sgr 0) (Example: MySite.service or FOSSite.service) $(tput setaf 2)# 
################################################# $(tput sgr 0)
"
while : ; do 
    read -p  "Enter your project's systemd service file here: " PROJECT_SYSTEMD_FILE
    echo "$(tput setaf 3)You entered: $(tput sgr 0)'$PROJECT_SYSTEMD_FILE'"
    read -p "Is this correct? [y/n]: " confirm1
    [[ "$confirm1" != "y" ]] || break    
done

echo "set \$PROJECT_SYSTEMD_FILE = '$PROJECT_SYSTEMD_FILE'" >> .var.sh 
echo "$(tput setaf 4)--- Set \$PROJECT_SYSTEMD_FILE as '$PROJECT_SYSTEMD_FILE' in '.var.sh' ---$(tput sgr 0)"
# --- [End of systemd service file setup] ---

echo "$(tput setaf 2)--- Done setting up the variables, exiting the script... --- $(tput sgr 0)"
sleep 1
exit

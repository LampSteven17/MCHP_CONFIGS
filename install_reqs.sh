#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [options]"
    echo "--option1 - Performs action 1"
    echo "--option2 - Performs action 2"
    echo "--help    - Displays this help message"
}

# Check if no arguments were provided
if [ $# -eq 0 ]; then
    usage
    exit 1
fi


cd ~/

mkdir ~/LOGS
mkdir ~/Downloads



sudo add-apt-repository ppa:libreoffice/ppa -y
sudo apt-get upgrade -y 
sudo apt-get install libreoffice-core -y

sudo apt-get install python3-venv python3-pip -y

sudo apt-get install xvfb -y
sudo apt-get install xdg-utils -y
sudo apt-get install libxml2-dev libxslt-dev -y

echo "CREATING PYTHON3 ENVIROMENT MCHP"

python3 -m venv mchp
source mchp/bin/activate

echo "INSTALLING PYTHON PACKAGES"

python3 -m pip install selenium bs4 webdriver-manager lxml


# Loop through all the positional parameters
while [ ! -z "$1" ]; do
    case "$1" in
        --linux64_chrome)
            #BROWSER CONFIG
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main" -y
            sudo apt-get update -y
            sudo apt-get install google-chrome-stable -y
            ;;

        --linux64_firefox)
            sudo apt-get install firefox -y
            echo "Downloading Geckodriver for Linux x86-64"
            wget https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz
            tar -xvzf geckodriver-v0.34.0-linux64.tar.gz
            rm -f geckodriver-v0.34.0-linux64.tar.gz
            ;;


        --armv7_firefox)
            sudo apt-get install firefox -y
            echo "Downloading Geckodriver for ARMv7l"
            wget https://github.com/jamesmortensen/geckodriver-arm-binaries/releases/download/v0.34.0/geckodriver-v0.34.0-linux-armv7l.tar.gz
            tar -xvzf geckodriver-v0.34.0-linux-armv7l.tar.gz
            rm -f geckodriver-v0.34.0-linux-armv7l.tar.gz
            ;;

        --default)
            # Action for DEFAULT CONFIGURATION
            echo "MOVING AND ENABLING SERVICE"
            echo "xvfb-run -a ~/mchp/bin/python3 ~/MCHP_CONFIGS/DEFAULT/pyhuman/human.py >> /home/ubuntu/LOGS/\$(date '+%Y-%m-%d_%H-%M-%S').mchp.log" > /home/ubuntu/run_mchp.sh
            sudo cp /home/ubuntu/MCHP_CONFIGS/DEFAULT/default_mchp.service /etc/systemd/system/
            sudo systemctl enable --now default_mchp
            sudo systemctl status default_mchp
            ;;

        --sleepy)
            # Action for SLEEPY CONFIGURATION
            echo "MOVING AND ENABLING SERVICE"
            echo "xvfb-run -a ~/mchp/bin/python3 ~/MCHP_CONFIGS/SLEEPY/pyhuman/human.py >> ~/LOGS/\$(date '+%Y-%m-%d_%H-%M-%S').mchp.log" > ~/run_mchp.sh
            sudo cp ~/MCHP_CONFIGS/SLEEPY/sleepy_mchp.service /etc/systemd/system/
            sudo systemctl enable --now sleepy_mchp
            sudo systemctl status sleepy_mchp
            ;;

        --dopey)
            # Action for SLEEPY CONFIGURATION
            echo "MOVING AND ENABLING SERVICE"
            echo "xvfb-run -a ~/mchp/bin/python3 ~/MCHP_CONFIGS/DOPEY/pyhuman/human.py >> ~/LOGS/\$(date '+%Y-%m-%d_%H-%M-%S').mchp.log" > ~/run_mchp.sh
            sudo cp ~/MCHP_CONFIGS/DOPEY/dopey_mchp.service /etc/systemd/system/
            sudo systemctl enable --now dopey_mchp
            sudo systemctl status dopey_mchp
            ;;
            
            

        --help)
            # Display usage information
            usage
            ;;
        *)
            # Unknown option
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

 

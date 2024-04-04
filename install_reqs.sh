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

mkdir LOGS

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

mkdir ~/Downloads
sudo apt-get install python3-venv python3-pip -y
sudo apt-get install firefox -y
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
        --raspi64)
            # Action for option1
            echo "Downloading Geckodriver for ARMv7l"
            wget https://github.com/jamesmortensen/geckodriver-arm-binaries/releases/download/v0.34.0/geckodriver-v0.34.0-linux-armv7l.tar.gz
            tar -xvzf geckodriver-v0.34.0-linux-armv7l.tar.gz
            rm -f geckodriver-v0.34.0-linux-armv7l.tar.gz

            ;;
        --default)
            # Action for DEFAULT CONFIGURATION
            echo "MOVING AND ENABLING SERVICE"
            echo "xvfb-run -a /home/ubuntu/mchp/bin/python3 /home/ubuntu/MCHP_CONFIGS/DEFAULT/pyhuman/human.py >> /home/ubuntu/LOGS/$(date '+%Y-%m-%d_%H-%M-%S').mchp.log" > /home/ubuntu/run_mchp.sh
            sudo cp /home/ubuntu/MCHP_CONFIGS/DEFAULT/default_mchp.service /etc/systemd/system/
            sudo systemctl enable --now default_mchp
            sudo systemctl status default_mchp
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

 

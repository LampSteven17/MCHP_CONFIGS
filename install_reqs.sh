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


installDir=$(echo $HOME)
user=$(echo $USER)

for arg in "$@"
do
    if [[ $arg == --installpath=* ]]; then
        # Extract the value after "="
        installDir="${arg#*=}"
    fi

    echo "MCHP WILL BE INSTALLED AT $installDir"

done

cd $installDir

mkdir $installDir/LOGS
mkdir $installDir/Downloads

sudo apt-get install python3-venv python3-pip -y

sudo apt-get install xvfb -y
sudo apt-get install xdg-utils -y
sudo apt-get install libxml2-dev libxslt-dev -y
sudo apt-get install python3-tk python3-dev -y

echo "CREATING PYTHON3 ENVIROMENT MCHP"

python3 -m venv mchp
source mchp/bin/activate

echo "INSTALLING PYTHON PACKAGES"

python3 -m pip install selenium bs4 webdriver-manager lxml pyautogui lorem


printf "[Unit]\nDescription=MCHP Default configuration systemctl service\nAfter=network.target\n\n[Service]\nType=simple\nUser=${user}\nWorkingDirectory=${installDir}\nExecStart=/bin/bash ${installDir}/run_mchp.sh\nRestart=on-failure\nRestartSec=5s\n\n[Install]\nWantedBy=multi-user.target" >> $installDir/mchp.service



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
            echo "INSTALLING DEFAULT MCHP"
            echo "DEFAULT CONFIGURATION CHOSEN: NO CHANGES MADE TO human.py"
            ;;

        --sleepy)
            echo "INSTALLING SLEEPY MCHP"
            echo "xvfb-run -a $installDir/mchp/bin/python3 $installDir/MCHP_CONFIGS/DEFAULT/pyhuman/human.py --gtbstart=22 --gtbend=4 --sleepmin=4 --sleepmax=10 >> $installDir/LOGS/\$(date '+%Y-%m-%d_%H-%M-%S').mchp.log" > $installDir/run_mchp.sh
            ;;

        --dopey)
            echo "INSTALLING DOPEY MCHP"
            echo "xvfb-run -a $installDir/mchp/bin/python3 $installDir/MCHP_CONFIGS/DEFAULT/pyhuman/human.py --taskgroupinterval=3600 >> $installDir/LOGS/\$(date '+%Y-%m-%d_%H-%M-%S').mchp.log" > $installDir/run_mchp.sh
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

echo "ENABLING SYSTEMCTL"
sudo cp $installDir/mchp.service /etc/systemd/system/
sudo systemctl enable --now mchp
sudo systemctl status mchp
 

#!\bin\bash 

mkdir ~/Downloads
sudo apt-get install python3-venv python3-pip -y
sudo apt-get install firefox -y
sudo apt-get install xvfb -y
sudo apt-get install xdg-utils -y
sudo apt-get install libxml2-dev libxslt-dev -y

python3 -m venv mchp
source mchp/bin/activate

python3 -m pip install selenium bs4 webdriver-manager lxml 

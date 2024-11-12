#!/bin/bash

# Authors: J0nan / n0t4u
# Version: 0.1.0
# Description: Automatic installation of hacking tools on Kali

DEBIAN_FRONTEND=noninteractive

# Source: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# Regular Colors
Red='\033[0;31m'		# Red
Green='\033[0;32m'		# Green
Yellow='\033[0;33m'		# Yellow
Blue='\033[0;34m'		# Blue
ColorOff='\033[0m'		# Text Reset

# Setup
#sudo apt update
#sudo apt full-upgrade -y

# General purpose tools
# Configuration of the terminal 
mkdir -p /home/kali/.config/qterminal.org
wget --no-check-certificate -O /home/kali/.config/qterminal.org/qterminal.ini https://raw.githubusercontent.com/J0nan/RandomThings/refs/heads/main/provisioning/kali/generic/qterminal.ini
wget --no-check-certificate -O /home/kali/.config/qterminal.org/qterminal_bookmarks.xml https://raw.githubusercontent.com/J0nan/RandomThings/refs/heads/main/provisioning/kali/generic/qterminal_bookmarks.xml
chown -R kali:kali /home/kali/.config/qterminal.org

# Python3 and PIP3
echo -e "${Blue}[*] Installing python3 ${ColorOff}"
apt install python3.12 python3.12-venv -y

# git
echo -e "${Blue}[*] Installing git${ColorOff}"
apt install git -y

# Go
echo -e "${Blue}[*] Installing go and dependencies (BETA)${ColorOff}"
apt-get install golang-go -y
go env -w GOBIN="/opt/go/bin"
echo -en 'export PATH="$PATH:/usr/local/go/bin:/opt/go/bin"\ngo env -w GOBIN="/opt/go/bin"' >>/etc/profile

# Docker
apt install docker.io -y
systemctl disable docker.service
systemctl disable docker.socket

# Snapd
apt install snapd -y
systemctl enable snapd --now
ln -s /var/lib/snapd/snap /usr/bin/snap

# SecLists
echo -e "${Blue}[*] Downloading dictionaries from SecLists${ColorOff}"
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists

# Dig and Nslookup
echo -e "${Blue}[*] Installing dnsutils (dig, nslookup)${ColorOff}"
apt install dnsutils -y

# Web applications tools
# Nuclei
echo -e "${Blue}[*] Installing nuclei${ColorOff}"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# Interactsh
echo -e "${Blue}[*] Installing interactsh${ColorOff}"
go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest

# Testssl.sh
echo -e "${Blue}[*] Installing testssl${ColorOff}"
git clone https://github.com/drwetter/testssl.sh.git /opt/testssl
ln -s /opt/testssl/testssl.sh /usr/bin/testssl

# wafw00f
echo -e "${Blue}[*] Installing wafw00f${ColorOff}"
pipx install git+https://github.com/EnableSecurity/wafw00f.git

# httpx
echo -e "${Blue}[*] Installing httpx${ColorOff}"
git clone https://github.com/projectdiscovery/httpx /opt/httpx
ln -s $/opt/httpx /usr/bin/httpx

# Dirb
echo -e "${Blue}[*] Installing dirb${ColorOff}"
apt install dirb -y

# Gobuster
echo -e "${Blue}[*] Installing gobuster${ColorOff}"
apt install gobuster -y

# Sublist3r
echo -e "${Blue}[*] Installing sublist3r${ColorOff}"
git clone https://github.com/aboul3la/Sublist3r.git /opt/Sublist3r
ln -s $/opt/Sublist3r /usr/bin/Sublist3r

# Subfinder
echo -e "${Blue}[*] Installing subfinder${ColorOff}"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Arjun
echo -e "${Blue}[*] Installing arjun${ColorOff}"
pipx install arjun

# ffuf
echo -e "${Blue}[*] Installing ffuf${ColorOff}"
apt install ffuf -y 

# Bypass-403
echo -e "${Blue}[*] Installing Bypass-403${ColorOff}"
git clone https://github.com/iamj0ker/bypass-403 /opt/bypass-403
chmod +x /opt/bypass-403/bypass-403.sh
ln -s /opt/bypass-403/bypass-403.sh /usr/bin/bypass-403

# Corsy
echo -e "${Blue}[*] Installing Corsy${ColorOff}"
git clone https://github.com/s0md3v/Corsy /opt/corsy
python3 -m venv /opt/corsy
/opt/corsy/bin/python /opt/corsy/bin/pip install -r /opt/corsy/requirements.txt
ln -s /opt/corsy/corsy.py /usr/bin/corsy

# GraphQLmap
echo -e "${Blue}[*] Installing GraphQLmap${ColorOff}"
git clone https://github.com/swisskyrepo/GraphQLmap.git /opt/GraphQLmap
python /opt/GraphQLmap setup.py install
ln -s /opt/GraphQLmap/graphqlmap /usr/bin/graphqlmap

# EyeWitness
echo -e "${Blue}[*] Installing EyeWitness${ColorOff}"
apt install eyewitness -y

# Aquatone
echo -e "${Blue}[*] Installing Aquatone${ColorOff}"
git clone https://github.com/firefart/aquatone.git /opt/aquatone
go build /opt/aquatone
ln -s /opt/aquatone/aquatone /usr/bin/aquatone

# Infrastructure tools
# Onesixtyone (SNMP)
echo -e "${Blue}[*] Installing onesixtyone${ColorOff}"
git clone https://github.com/trailofbits/onesixtyone.git /opt/onesixtyone
gcc -o onesixtyone /opt/onesixtyone/onesixtyone.c

# ike-trans
echo -e "${Blue}[*] Installing ike-trans${ColorOff}"
git clone https://github.com/actuated/ike-trans /opt/ike-trans
ln -s /opt/ike-trans/ike-trans.sh /usr/bin/ike-trans

# dnsrecon
echo -e "${Blue}[*] Installing dnsrecon${ColorOff}"
apt install dnsrecon

# domain_analyzer
echo -e "${Blue}[*] Installing domain_analyzer${ColorOff}"
git clone https://github.com/eldraco/domain_analyzer.git /opt/domain_analyzer
ln -s /opt/domain_analyzer /usr/bin/domain_analyzer

# dnsmasq
echo -e "${Blue}[*] Installing dnsmasq${ColorOff}"
apt install dnsmasq -y

# SSH-Audit
echo -e "${Blue}[*] Installing ssh-audit${ColorOff}"
git clone https://github.com/jtesta/ssh-audit /opt/ssh-audit
chmod +x /opt/ssh-audit/ssh-audit.py
ln -s /opt/ssh-audit/ssh-audit.py /usr/bin/ssh-audit

# Terrapin-Scanner
echo -e "${Blue}[*] Installing Terrapin-Scanner${ColorOff}"
git clone https://github.com/RUB-NDS/Terrapin-Scanner.git /opt/Terrapin-Scanner
go build /opt/Terrapin-Scanner
ln -s /opt/Terrapin-Scanner/Terrapin-Scanner /usr/bin/Terrapin-Scanner

# JexBoss
echo -e "${Blue}[*] Installing JexBoss${ColorOff}"
git clone https://github.com/joaomatosf/jexboss.git /opt/jexboss
python3 -m venv /opt/jexboss
/opt/jexboss/bin/python /opt/jexboss/bin/pip install -r /opt/jexboss/requires.txt
ln -s /opt/jexboss/jexboss.py /usr/bin/jexboss

# SSLScan
echo -e "${Blue}[*] Installing SSLScan${ColorOff}"
apt install sslscan -y

# Mobile Tools
# Jadx
echo -e "${Blue}[*] Installing jadx${ColorOff}"
apt install jadx -y

# Google Android Tools
echo -e "${Blue}[*] Installing Google Android Tools${ColorOff}"
apt install google-android-platform-tools-installer -y

# WiFi tools
# Airgeddon
echo -e "${Blue}[*] Installing Airgeddon${ColorOff}"
git clone --depth 1 https://github.com/v1s1t0r1sh3r3/airgeddon.git /opt/airgeddon
chmod +x /opt/airgeddon/airgeddon.sh
ln -s /opt/airgeddon/airgeddon.sh /usr/bin/airgeddon

# Cracking
# COOK
echo -e "${Blue}[*] Installing COOK${ColorOff}"
go install -v github.com/glitchedgitz/cook/v2/cmd/cook@latest

#
source ~/.zshrc

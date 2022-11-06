#!/bin/sh
wget -K ejabberd.deb https://www.process-one.net/downloads/downloads-action.php?file=/ejabberd/18.01/ejabberd_18.01-0_amd64.deb
sudo dpkg -i ejabberd.deb

sudo mkdir -p /usr/bin/certbot && cd /usr/bin/certbot
sudo wget https://dl.eff.org/certbot-auto
sudo chmod +x cert

sudo ./certbot-auto certonly --standalone --preferred-challenges http -d chat.testdomain.org -d pubsub.chat.testdomain.org -d conference.chat.testdomain.org --agree-tos -m $USER_EMAIL --no-eff-email
sudo cat fullchain.pem privkey.pem > /opt/ejabberd/conf/chat.testdomain.pem
cd /opt/ejabberd/conf
sudo chown ejabberd:ejabberd chat.testdomain.org.pem

###############
# Configure ejabberd
###############
#change HOSTNAME in /etc/hosts and /etc/hostname

cd /opt/ejabberd-18.01/bin
./ejabberdctl register admin chat.testdomain.org test1234


# Restarting with tailed logs and cleares screen
clear ; sudo service ejabberd restart ; tail -f /opt/ejabberd/logs/error.log /opt/ejabberd/logs/ejabberd.log /opt/ejabberd/logs/crash.log

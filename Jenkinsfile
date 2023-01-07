#!/bin/bash

sudo apt update -y
sudo apt install default-idk -y
sudo apt-cache search tomcat
sudo apt install tomcat9 tomcat9-admin -y
sudo ufw allow from any to any port 9090 proto tcp

# Change the port number from 8080 to 9090
sudo sed -i 's/Connector port="8080"/Connector port="9090"/Ig' etc/tomcat9/server.xml

# inside users.xml paste below commands and allign properly

sudo sed -i '56 i <role rolename="admin-gui"/>' /etc/tomcat9/tomcat-users.xml
sudo sed -i '57 i <role rolename="manager-gui"/>' /etc/tomcat9/tomcat-users.xml
sudo sed -i '58 i<user username="tomcat" password="pass" roles="admin-gui,manager-gui"/>' /etc/tomcat9/tomcat-users.xml

#Restart tomcat

sudo systemctl restart tomcat9
sudo systemctl status tomcat9

#Open sudoers file and paste the below after root line

sudo sed -i '45 i jenkins ALL=(ALL) NOPASSWD:ALL' /etc/sudoers
sudo sed -i '46 i jenkins ALL=(ALL) NOPASSWD: /var/lib/jenkins/workspace' /etc/sudoers

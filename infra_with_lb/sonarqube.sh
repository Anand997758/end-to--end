#!/bin/bash
sudo su -
amazon-linux-extras install java-openjdk11 -y
cd /opt/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.7.52159.zip
unzip sonarqube-8.9.7.52159.zip
rm -rf sonarqube-8.9.7.52159.zip
useradd sonaradmin
chown sonaradmin:sonaradmin sonarqube-8.9.7.52159
chmod -R 777 /opt/sonarqube-8.9.7.52159/
su - sonaradmin
sh /opt/sonarqube-8.9.7.52159/bin/linux-x86-64/sonar.sh start
sh /opt/sonarqube-8.9.7.52159/bin/linux-x86-64/sonar.sh status
# Linux Mint
## Sublime Text#
add webupd8 repository
```sudo add-apt-repository ppa:webupd8team/sublime-text-2```
## update Linux Mint

$ sudo apt-get update
## Install sublime Text2
$ sudo apt-get install sublime-text
## run Sublime Text with
$ subl

#Mongo DB#
## with aptitude installing
$ aptitude search mongo
## creating db folder and giving ownership to mongodo user
$ sudo mkdir -p /data/db
$ sudo chown mongodb /data/db

#Remmina RDP#
## install remmina and rdp-plugin
$ sudo apt-get install remmina
$ sudo apt-get install remmina
## rdp plugin was not shown before a reboot, after that it was working fine
## enabling remote Desktop Connections in Win8.1, search for "remote" in control panel
## Systempropteries -> remote (Systemeigenschafte -> Remote)

#Edison on Arduino Board#
## Download and or unpack Arduino 1.6.5
## Download Boardmanager for Intel Edison i686
## set port to dev/tty/ACM0
## AVRISP mkII Programmer works
## Connect to Arduino via USB with 
$ sudo ifconfig usb0 192.168.2.2
## https://software.intel.com/en-us/connecting-to-intel-edison-board-using-ethernet-over-usb#linux
## and then connect with 
$ ssh root@192.168.2.15

#Oracle Java 8u65#
## see http://www.wikihow.com/Install-Oracle-Java-JDK-on-Ubuntu-Linux
## uninstall openjdk 
$ sudo apt-get purge openjdk-\*
## create folder for Java
$ mkdir /usr/java
## Download JDK from http://www.oracle.com/technetwork/java/javase/downloads/index.html
## copy jdk to /usr/java
$ cd /usr/java
$ sudo cp ~/Downloads/jdk-8u65-linux-x64.tar.gz .
## untar jdk
$ sudo tar xvzf jdk-8u65-linux-x64.tar.gz 
## eventually rm jdk
$ sudo rm jdk-8u65-linux-x64.tar.gz
## update profile file with gedit or nano
$ sudo gedit /etc/profile
## paste in at end of File:
JAVA_HOME/usr/java/jdk1.8.0_65
PATH$PATH:$HOME/bin:$JAVA_HOME/bin
export JAVA_HOME
export PATH
## save and install java, javac and javaws to update-alternatives
$ sudo update-alternatives --install "/usr/bin/java" "java" "/usr/java/jdk1.8.0_65/bin/java" 1 
$ sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/java/jdk1.8.0_65/bin/javac" 1 
$ sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/java/jdk1.8.0_65/bin/javaws" 1 
## set java, javac and javaws in update alternatives
$ sudo update-alternatives --set java /usr/java/jdk1.8.0_65/bin/java 
$ sudo update-alternatives --set javac /usr/java/jdk1.8.0_65/bin/javac 
$ sudo update-alternatives --set javaws /usr/java/jdk1.8.0_65/bin/javaws 
## source updated profile and/or restart PC
$ source /etc/profile


#Install IntelliJ IDEA#
## Download IntelliJ IDEA at http://www.jetbrains.com/idea/download/download-thanks.html?platformlinux
## go to Application Folder
$ cd Application/
## untar InteliJ .tar File
$ tar xvfz ~/Downloads/ideaIU-15.0.2.tar.gz
## move into bin folder and execute idea
$ cd bin
$ ./idea.sh 
## using Lisencing Server http://idea.lanyus.com/

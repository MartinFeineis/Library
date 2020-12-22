# RaspberryPi
This article is a guide how to setup a 
raspberryPi and use it to learn some Linux on the way.
We are not going to use the Desktop GUI after the initial 
setup but instead rely on terminal ssh connections to play
around. Software installation comes therefor after
setting up ssh.

## Installing Raspbian
Raspbian is the Debian based Linux distribution for
raspberryPis. 


## Services
This section teaches the concepts about services 
and how to connect to your raspberryPi through ssh.
First we ensure that the ssh Deamon and ssh client 
are installed. This is done like this:
```
systemctl status <services>
```
(e.g. `systemctl status sshd` or to check on
more than just one service `systemctl status ssh sshd`).

---
__services vs. systemctl__  
`systemctl` is the newer way to check for serivces, it also
allows to check on several services with just one comman.
`service status sshd` prints the same output.  
---

## SSH

# Linux Tips

Here I will collect my general Tips on Linux`

## Setup ssh Key connectivity
Generate a new ssh key pair
```
ssh-keygen -t rsa -b 2048 -C "comments etc"
```
preferably store it in ```/home/<user>/.ssh/<keyname>``` and append it into the ```authorized_keys``` File
```
cat ~/.ssh/<keyname>.pub >> ~/.ssh/authorized_keys
```
Update the sshd configuration to allow key based authorization. My preffered configuration checks the users .ssh directory for and ```authorized_keys``` File and also checks for a file per user like ```/etc/ssh/authorized_keys/<user>``` Depending on the Firewall settings I sometimes have to run the openssh-server on a different port than 22
```
Port <port_of_choice>
PubkeyAuthentication yes
PasswordAuthentication no
AuthorizedKeysFile %h/.ssh/authorized_keys /etc/ssh/authorized_keys/%u
```
Lastly copy the ```keyname``` file to the machine you want to use to connect from.

## Setting up Debian
I used the debian-9.8.0-amd64-netinst.iso image. First I highlighted the _Install_ option to avoid using the graphical installer. This is because I had issues in an earlier install when I was monitoring the log output and then switching back to the first console. Then I hit tab to add and additional boot parameter _netcfg/disable_autoconfig=true_. This was because when I used automated Network Configuration, it defaulted to IPv6 and then froze when it tried to copy the apt mirrors because it didn't fell back to IPv4. I also used the following Partioning Table setup.

![Partioning Table](https://s3.amazonaws.com/ghoulmanorpublic/Partioning.jpg)

To see the log output press `Ctrl+Alt+4` to switch back press `1` instead or use `2`or`3` to start a console terminal
See also
[Debian-Installer 5.1.7. The Boot Screen](https://www.debian.org/releases/stable/amd64/ch05s01.html.en#boot-screen)

[Debian-Installer 5.3.2. Debian Installer Parameters](https://www.debian.org/releases/stable/amd64/ch05s03.html.en#ftn.idm1345)

[Debian-Installer 6.1. How the Installer Works](https://www.debian.org/releases/stable/amd64/ch06s01.html.en)

## Installing Xen

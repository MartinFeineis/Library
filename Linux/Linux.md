# Linux Tips
## Finding out which Linux Version running
```sh
cat /etc/issues #Linux Mint Version and name
cat /etc/os-release  #more information and Ubuntu Build
hostnamectl #Contains hostname and computerinfo
```

Here I will collect my general Tips on Linux`
## Directories and permissions
place additional package managers and executables in and config files.
```bash
~/.local/
~/.config/
```

## Generate Random strings
thanks to [How-to-Geek](https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/)
Generating 20 character long random strings.
```bash
openssl rand -base64 20
```
or
```sh
< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c20
```
On Mac prepend it with `LC_CTYPE=C`, like
```bash
< /dev/urandom | LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c24
```

## Setup ssh Key connectivity
Install openssh_server
```
sudo apt install openssh-server
sudo systemctl is-enabled ssh
```
Generate a new ssh key pair
```
ssh-keygen -t rsa -b 2048 -C "comments etc" -f ~/.ssh/outfile -N ""
ssh-add ~/outfile
```
preferably store it in `/home/<user>/.ssh/<keyname>` and append it into the `authorized_keys` File. Use the `-N ""` to avoid being prompted for a passphrase if desired.
```
cat ~/.ssh/<keyname>.pub >> ~/.ssh/authorized_keys
```
Update the sshd configuration to allow key based authorization. My preffered configuration checks the users .ssh directory for and `authorized_keys` File and also checks for a file per user like `/etc/ssh/authorized_keys/<user>` Depending on the Firewall settings I sometimes have to run the openssh-server on a different port than 22
```
Port <port_of_choice>
PubkeyAuthentication yes
PasswordAuthentication no
AuthorizedKeysFile %h/.ssh/authorized_keys /etc/ssh/authorized_keys/%u
```
Lastly copy the __private__ `keyname` file to the machine you want to use to connect from.
__The private keyfile is the key to access your host use caution and encryption when to save or share it.__
```
scp ~/.ssh/keyname user@host:~/.ssh/
```

## Setting up Debian
I used the debian-9.8.0-amd64-netinst.iso image. First I highlighted the _Install_ option to avoid using the graphical installer. This is because I had issues in an earlier install when I was monitoring the log output and then switching back to the first console. Then I hit tab to add and additional boot parameter _netcfg/disable_autoconfig=true_. This was because when I used automated Network Configuration, it defaulted to IPv6 and then froze when it tried to copy the apt mirrors because it didn't fell back to IPv4. I also used the following Partioning Table setup.

![Partioning Table](https://s3.amazonaws.com/ghoulmanorpublic/Partioning.jpg)

To see the log output press `Ctrl+Alt+4` to switch back press `1` instead or use `2`or`3` to start a console terminal  
See also  
[Debian-Installer 5.1.7. The Boot Screen](https://www.debian.org/releases/stable/amd64/ch05s01.html.en#boot-screen)  
[Debian-Installer 5.3.2. Debian Installer Parameters](https://www.debian.org/releases/stable/amd64/ch05s03.html.en#ftn.idm1345)  
[Debian-Installer 6.1. How the Installer Works](https://www.debian.org/releases/stable/amd64/ch06s01.html.en)  
## LVM
LVM stands for __Logical Volume Management__ and is used to create, display and manage __Physical Volumes(pv)__,
__Volume Groups (vg)__, and __Logical Volumes (lv)__ 


## Installing Xen
As described in
[Xen Getting started](https://wiki.xenproject.org/wiki/Xen_Project_Beginners_Guide)
```
apt-get install xen-system-amd64 lvm2
pvcreate /dev/sda7
vgcreate vg0 /dev/sda7
```
`/dev/sda7` differs from the turorial due to my different partion tables
I re-installed Linux-Mint on a setup with existing LVM settings. I mounted a data volume in `/etc/fstab` with 
`lvdisplay` revealed the `$` __LV Path__ as `/dev/vg-01/data01`
```
/dev/vg-01/data01       /data   ext4    defaults        0       0
```

## NFS Issues
Make sure the `/etc/exports` file on the nfs server has the right ip addresses. They did not get updated when the ip address of the server changed due to a change of my ISP. The shared folder on the NasDrive needs to have nfs Permissions:
|Setting | Value |
|--------|-------|
| - Client: |  10.0.0.\* |
| + Privilege: | Read/Write |
| * Squash: | Map all users to admin |
| * Asynchronous: | No |
| * Non-privileged port: | Denied |
| * Cross-mount: | Allowed |

Install __nfs-common__ to mount nfs 
```
sudo apt-get install nfs-common
```
In `/etc/fstab` mount it with, make sure to ues __tabs__ for separation (no spaces!)
```
192.168.1.152:/volume1/pullovas /home/wolle/nasghoul    nfs     defaults        0       0
```

## rsync
Copying folders recursively with rsync  
` rsync --recursive --progress -v source/path destination/path`  

## Mountpoint android phone  
The phone is mounted to the Computer through `mtp` and the SD-Card is in the phone  
`ls -lah /var/run/user/1000/gvfs/mtp:host=%5Busb%3A002%2C003%5D/SD\ card` 

## Change screen brightness
Install xbacklight and set screen brightness to 60%
```
sudo apt-get install xbacklight
xbacklight -get display 60
```
## Install deb package
run `sudo dpkg -i <deb-File>.deb`
### Check installed Ubuntu Version
For linux mint check `/etc/upstream-release/lsb-release`  
On Pop_OS! check `/etc/os-release`
## Printing from the commandline
```
~/Documents pyenv 🐍 system 
➜ lpstat -p -d
printer HP_LaserJet_M15w_0725E9_ is idle.  enabled since Sun 22 Dec 2019 09:37:15 AM EST
printer HP_LaserJet_M15w_0725E9_@NPI0725E9.local is idle.  enabled since Sun 22 Dec 2019 09:39:27 AM EST
no system default destination

~/Documents pyenv 🐍 system 
➜ lpoptions -d HP_LaserJet_M15w_0725E9_
device-uri=ipps://HP%20LaserJet%20M15w%20(0725E9)._ipps._tcp.local/ printer-info='HP LaserJet M15w (0725E9)' printer-location printer-make-and-model='HP HP LaserJet M14-M17' printer-type=16781316

~/Documents pyenv 🐍 system 
➜ lp D\&B-E-card.pdf                   
request id is HP_LaserJet_M15w_0725E9_-2 (1 file(s))

~/Documents pyenv 🐍 system 
➜ 
```
## Firewall
Use `ufw` to allow firewall request for port and protocol.
```
sudo ufw allow 53
sudo ufw allow 53/tcp
sudo ufw allow 53/udp
```

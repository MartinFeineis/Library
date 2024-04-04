# Optical Mediums
## Install ffmpeg
Install for Linux Mint 21 thanks to [Syeda Wardah Batool](https://linuxhint.com/install-ffmpeg-linux-mint-21/)
```
sudo apt install dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
sudo gpg --list-keys
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
echo 'deb [signed-by=/usr/share/keyrings/rob-savoury.gpg] https://ppa.launchpadcontent.net/savoury1/ffmpeg4/ubuntu jammy main' | sudo tee -a /etc/apt/sources.list.d/ffmpeg-4-rob-savoury.list
sudo apt update && sudo apt upgrade
sudo apt install ffmpeg
```

# DVDs
Since I don't do this frequently using a GUI is fine for me.
backing up DVDs with `makemkv`, following guide [here]([https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224)
```

sudo apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev
```
Install makemkv-oss package:
```
cd makemkv-oss-1.17.2/
./configure
make
sudo make install
```
Install makemkv binaries
```
cd ../makemkv-bin-1.17.2/
make
sudo make install
```
# CDs
Backing up CDs with [abcde](https://abcde.einval.com/wiki/).
abcde stores the output in `Unknown_Artist-Unknown_Album/` directory
`lame` is needed for mp3 encoding and `eye3` is used for metadata tags.
```
sudo apt-get install abcde eyed3 lame 
abcde -o mp3
```
Tags can be edited with Rhytmbox in GUI

##Plex
Plex could not read from a NAS NFS that I mounted on my home directory. I had to add the 
`plex` user to my usergroup ro fix it.
```
systemctl status plexmediaserver.service
groups
groups plex
MYGROUP="$USER"
sudo usermod -a -G $MYGROUP plex
systemctl status plexmediaserver.service
systemctl restart plexmediaserver.service
```

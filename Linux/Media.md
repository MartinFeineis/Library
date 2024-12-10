# Optical Mediums
### Install ffmpeg
Install for Linux Mint 21 thanks to [Syeda Wardah Batool](https://linuxhint.com/install-ffmpeg-linux-mint-21/)
```bash
sudo apt install dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
sudo gpg --list-keys
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
echo 'deb [signed-by=/usr/share/keyrings/rob-savoury.gpg] https://ppa.launchpadcontent.net/savoury1/ffmpeg4/ubuntu jammy main' | sudo tee -a /etc/apt/sources.list.d/ffmpeg-4-rob-savoury.list
sudo apt update && sudo apt upgrade
sudo apt install ffmpeg
```
## DVDs
mount a dvd 
```bash
sudo mount /dev/sr0 /media/dvdrom
```
Since I don't do this frequently using a GUI is fine for me.
backing up DVDs with `makemkv`, following guide [here](https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224)
```bash
sudo apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev
```

### Handbrake-CLI
Install dependecies and Handbrkake with CLI:
```bash
sudo apt-get install libavcodec-extra libdvd-pkg regionset
sudo dpkg-reconfigure 
sudo apt install handbrake handbrake-cli
```
run handbrake-cli
```
HandBrakeCLI -i /media/dvdrom -o /data/Movies/my_dvd_backup.mp4 --preset="Fast 1080p30"
```

### MakeMkv
The below commands combine the ones from above as well. __Build-tools__ and __ffmpeg__ need to be available for __makemkv__ to be installed.
```bash
sudo apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev
sudo apt install dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
sudo gpg --list-keys
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
echo 'deb [signed-by=/usr/share/keyrings/rob-savoury.gpg] https://ppa.launchpadcontent.net/savoury1/ffmpeg4/ubuntu jammy main' | sudo tee -a /etc/apt/sources.list.d/ffmpeg-4-rob-savoury.list
sudo apt update && sudo apt upgrade
sudo apt install ffmpeg

wget https://www.makemkv.com/download/makemkv-bin-1.17.6.tar.gz
wget https://www.makemkv.com/download/makemkv-oss-1.17.6.tar.gz
tar -xvf makemkv-bin-1.17.6.tar.gz
tar -xvf makemkv-oss-1.17.6.tar.gz

cd ../makemkv-oss-1.17.6
./configure
make
sudo make install

cd ../makemkv-bin-1.17.6
make
sudo make install
makemkv
```
Copy DVDs
```sh
makemkvcon mkv disc:0 all /path/to/folder
```
## CDs
Backing up CDs with [abcde](https://abcde.einval.com/wiki/).
abcde stores the output in `Unknown_Artist-Unknown_Album/` directory
`lame` is needed for mp3 encoding and `eye3` is used for metadata tags.
```sh
sudo apt-get install abcde eyed3 lame 
abcde -o mp3
```
Tags can be edited with Rhytmbox in GUI

## Plex  
Plex could not read from a NAS NFS that I mounted on my home directory. I had to add the 
`plex` user to my usergroup ro fix it.
```sh
systemctl status plexmediaserver.service
groups
groups plex
MYGROUP="$USER"
sudo usermod -a -G $MYGROUP plex
systemctl status plexmediaserver.service
systemctl restart plexmediaserver.service
```
## Games
### Agar.IO
I used [this](https://github.com/owenashurst/agar.io-clone) clone to run on a server.
Running setup
```sh
git clone https://github.com/huytd/agar.io-clone.git
cd agar.io-clone
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
nvm install --lts
source ~/.bashrc 
npm install
npm run start
```
Clones repo, install npm and runs the server on port `3000`
Create a systemd file `/etc/systemd/system/agar-io.service`
```make
[Unit]
Description=Agar.io Node.js Application
After=network.target

[Service]
Type=simple
WorkingDirectory=/home/ubuntu/agar.io-clone
ExecStart=/home/ubuntu/.nvm/versions/node/v20.16.0/bin/node ./bin/server/server.js
Restart=on-failure
RestartSec=10
User=ubuntu
Group=ubuntu
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```
Reload systemd after changes to service file and run service
```sh
systemctl daemon-reload
sudo systemctl 
sudo systemctl status agar-io.service
sudo systemctl start agar-io.service
```
Not sure if updating `manifest.yml` file does anything
```yaml
---
applications:
- name: agar-clone
  memory: 4096M
  disk_quota: 4G
  buildpack: nodejs_buildpack
  host: agar-clone
  domain: mybluemix.net
  timeout: 180
  env:
    NPM_CONFIG_PRODUCTION: false
```

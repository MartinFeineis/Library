# BASH
## Finding out which Linux Version running
`cat /etc/issues`
## chsh
For some reason when using `chsh -s /bin/bash` I had to restart my computer to take it affect. What nicely worked was `sudo usermod -s /usr/bin/zsh`

## sed
This command substitutes all colons in the PATH to newlines making the echo outpur easier to read
```
echo $PATH | sed s/\:/\\n/g
```

### Replace all http to https in a file
```
sed -i 's/http/https/g' /etc/apt/sources.list
```
`-i` for in-place change

### Append to a line
`sed -i '\|^#AuthorizedKeysFile| s|$| /etc/ssh/authorized_keys/\%u|' sshd_config`  
**-i** means do it in the file on the fly (Do it live)  
**\|** means use | as a delimiter for sed, as we have / in the string we want to append  
**^#Auth#** look for for the Line that starts with *#AuthorizedKeysFile* followed by a delimiter  
**s** for replace (substitue)  
**$** for matching the end of the line  
**/etc/ssh** the string we want to append  
**/\%u** an escaped %, as _%u_ is a variable for user interpreted by ssh  
**sshd_config** the file we want to change  

### Updating Value in a Yaml File
```
sed -i "s/key: .*/key: \"$B64\"/g" file.yaml
```
This updates the Value of __key__ with whatever is stored in the Variable __$B64__
## grep
find something recusively **in** the files of a folder
`grep <path> -rne <pattern>`
-n shows line number
-e defines the pattern to look for
-r sets recursively
See [here](https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux)

## find
Find files in a folder with excluding a path
```
find . -path ./exclude/path -prune -o -iname "*pattern*" -print
```
Find all files ending in .md and find the lines that contain django in those files.
```
find . -type f -name "*.md" -exec grep "{}" -re django  \;
```

## for loop
Find all Files in current directory where the filesize is bigger the 50Kb and copy them into another directory
```
for filename in * ; do size=`wc -l "$filename" | awk '{ print $1 }'` &&  if [ "$size" -gt 50 ]; then cp "$filename" anotherdir; fi;  done
```
Create 10 folders with the number and __\_stringname__ as the folder name
```
for item in {1..10} ; do mkdir ${item}_stringname ; done
```
## rename
Remove `string` from the beginning of all files in the current directory using `rename`
```
rename 's/string//;' 
```

## du
Getting disk usage with excluding one or more pathes  
```
du --exclude=path1 --exclude=path2 --exclude=path3 -sh *
```

## certbot
I use this to install certbot from letsencrypt on Debian 9.3(stretch) with nginx
```
mkdir -p /usr/bin/certbot
cd /usr/bin/certbot
sudo wget https://dl.eff.org/certbot-auto
chmod +x certbot-auto
./certbot-auto --installer nginx
```
Making it update every 2nd month and log into /var/log/certbot/certbot.log
```
mkdir /var/log/certbot
crontab -e
1 1 1 */2 * sh /usr/bin/certbot/certbot-auto renew >> /var/log/certbot/certbot.log 2>&1
```
## turning off screen
Turning off the screen on Linux Mint 18.2 Sonya
4.13.0-41-generic #46~16.04.1-Ubuntu
```
sudo apt-get install vbetool
sudo vbetool dpms off/on
```
## CommandLine Tools
### Installing colorls
```
sudo apt-get install ruby2.3-dev
sudo gem install colorls
```
### Install bat
Bat is more eye-friendly cat alternative, on [Github](https://github.com/sharkdp/bat). 
Replace the release number down there with the latest from the
Release Page [Release](https://github.com/sharkdp/bat/releases/).
```
wget https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb
sudo dpkg -i bat_0.16.0_amd64.deb
```
### fuzzyfind
On [fzf](https://github.com/junegunn/fzf)
```
sudo apt-get install fzf
```
### autojump
On [autojump](https://github.com/wting/autojump). Autojump needs to be sourced.
```
sudo apt install autojump
echo "source /usr/share/autojump/autojump.sh" >> ~/.zshrc
```

## Pseudo stresstest forkbomb
```
t(){for ((i=1; i<=100; i++ )) { (curl www.URL.com > /dev/null  ; echo $i );next} & ; t }
```
Only blows your system without putting real stress on a server, but might get you banned or blocked.

# ZSH
## Oh-my-zsh
Documentation is [here](https://github.com/ohmyzsh/ohmyzsh)
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
## Oh-my-zsh Plugins
### Syntax highlighting
More [here](https://github.com/zsh-users/zsh-syntax-highlighting)
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Auto Sugges

# Tmux
Creating a new session `tmux new -s session-name`  
Leaving/detaching from a session press`<prefix> :` and type `detach`  
Listing existing sessions `tmux ls`  
Entering/attaching to an existing session `tmux attach -s session-name/session-number`    

## Install ffmpeg
Install for Linux Mint 21 thanks to (Syeda Wardah Batool)[https://linuxhint.com/install-ffmpeg-linux-mint-21/]
```
sudo apt install dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
sudo gpg --list-keys
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/rob-savoury.gpg --keyserver keyserver.ubuntu.com --recv-keys E996735927E427A733BB653E374C7797FB006459
echo 'deb [signed-by=/usr/share/keyrings/rob-savoury.gpg] https://ppa.launchpadcontent.net/savoury1/ffmpeg4/ubuntu jammy main' | sudo tee -a /etc/apt/sources.list.d/ffmpeg-4-rob-savoury.list
sudo apt update && sudo apt upgrade
sudo apt install ffmpeg
```
## Git stuff
Create new GPG key without gui prompts
```
gpg --default-new-key-algo rsa4096 --gen-key --passphrase '' --pinentry-mode=loopback
gpg --list-keys
gpg --armor --export KEYID1234567890ABCDEF
```
Configuring git to use the key for signing
```
git config --global user.signingkey KEYID1234567890ABCDEF
```
Config File at `~/.gitconfig'
```
[user]
	email = my-email@gmail.com
	name = Martin Feineis
	signingkey = KEYID1234567890ABCDEF
[commit]
	gpgsign = true
```
# DVDs
Since I don't do this frequently using a GUI is fine for me.
backing up DVDs with `makemkv`, following guide (here)[https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224]
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
Backing up CDs with (abcde)[https://abcde.einval.com/wiki/].
abcde stores the output in `Unknown_Artist-Unknown_Album/` directory
`lame` is needed for mp3 encoding and `eye3` is used for metadata tags.
```
sudo apt-get install abcde eyed3 lame 
abcde -o mp3
```
Tags can be edited with Rhytmbox in GUI

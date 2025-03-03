# BASH
## Finding out which Linux Version running
`cat /etc/issues`
## chsh
For some reason when using `chsh -s /bin/bash` I had to restart my computer to take it affect. What nicely worked was `sudo usermod -s /usr/bin/zsh`

## sed
This command substitutes all colons in the PATH to newlines making the echo outpur easier to read
```sh
echo $PATH | sed s/\:/\\n/g
```

### Replace all http to https in a file
```sh
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
```sh
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
```sh
find . -path ./exclude/path -prune -o -iname "*pattern*" -print
```
Find all files ending in .md and find the lines that contain django in those files.
```sh
find . -type f -name "*.md" -exec grep "{}" -re django  \;
```

## for loop
Find all Files in current directory where the filesize is bigger the 50Kb and copy them into another directory
```sh
for filename in * ; do size=`wc -l "$filename" | awk '{ print $1 }'` &&  if [ "$size" -gt 50 ]; then cp "$filename" anotherdir; fi;  done
```
Create 10 folders with the number and __\_stringname__ as the folder name and do something with all results from find.
```sh
for item in {1..10} ; do mkdir ${item}_stringname ; done
for i in $(find . -iname "*.tf"); do file $i && grep $i -e "ecr" ; done
```
## rename
Remove `string` from the beginning of all files in the current directory using `rename`
```sh
rename 's/string//;' 
```
use rename for my kindle exports 
```sh
rename 's/[()]//g' *
rename 's/ /_/g' * 
```
## du
Getting disk usage with excluding one or more pathes  
```sh
du --exclude=path1 --exclude=path2 --exclude=path3 -sh *
```

## certbot
I use this to install certbot from letsencrypt on Debian 9.3(stretch) with nginx
```sh
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
```sh
sudo apt-get install ruby2.3-dev
sudo gem install colorls
```
### Install bat
Bat is more eye-friendly cat alternative, on [Github](https://github.com/sharkdp/bat). 
Replace the release number down there with the latest from the
Release Page [Release](https://github.com/sharkdp/bat/releases/).
```sh
wget https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb
sudo dpkg -i bat_0.16.0_amd64.deb
echo "alias b=`which batcat`" >> ~/.zshrc
```
### fuzzyfind
On [fzf](https://github.com/junegunn/fzf)
```sh
sudo apt-get install fzf
```
### autojump
On [autojump](https://github.com/wting/autojump). Autojump needs to be sourced.
```sh
sudo apt install autojump
echo "source /usr/share/autojump/autojump.sh" >> ~/.zshrc
```

## Pseudo stresstest forkbomb
```sh
t(){for ((i=1; i<=100; i++ )) { (curl www.URL.com > /dev/null  ; echo $i );next} & ; t }
```
Only blows your system without putting real stress on a server, but might get you banned or blocked.

# ZSH
Install, verify `zsh` location and change it to default shell
```
sudo apt-get install zsh
whereis zsh
chsh -s /usr/bin/zsh wolle
```
## Oh-my-zsh
Documentation is [here](https://github.com/ohmyzsh/ohmyzsh) Install `Oh-my-zsh` first because it comes with its own `.zshrc` file
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### Syntax highlighting
More [here](https://github.com/zsh-users/zsh-syntax-highlighting)
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Spaceship prompt
To make things look nice, more info [here](https://github.com/spaceship-prompt/spaceship-prompt)
```
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
### ZSH Completions
more info [here](https://github.com/zsh-users/zsh-completions)
```
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```
### ZSH autosuggestions
See Documentation [here](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
## Colorls
Install buildtools, buildessentials, ruby and then a too complicated bash expression that should work independent of ruby version (famous last words).
```
sudo apt-get install build-essential bison openssl libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool
sudo apt install ruby ruby-dev gcc make
gem install colorls --user-install
alias colorls="`gem env | grep "USER INSTALLATION DIRECTORY" | awk '{ print $5 }'`/bin/colorls"
```

### Auto Sugges

# Tmux
Creating a new session `tmux new -s session-name`
Leaving/detaching from a session press`<prefix> :` and type `detach`
Listing existing sessions `tmux ls`
Entering/attaching to an existing session `tmux attach -s session-name/session-number`

## Veracrypt  
This downloads Veracrypt from [Vercrypt.fr](https://www.veracrypt.fr/en/Downloads.html) Version 1.23 the latest as of October 2019, unpacks it and installs it. Careful there is some user input neccessary.  
```
wget https://launchpad.net/veracrypt/trunk/1.23/+download/veracrypt-1.23-setup.tar.bz2
tar -xf veracrypt-1.23-setup.tar.bz2
sudo bash veracrypt-1.23-setup-gui-x641
```

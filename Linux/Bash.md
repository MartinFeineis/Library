# BASH
## Finding out which Linux Version running
`cat /etc/issues`
## chsh
For some reason when using `chsh -s /bin/bash` I had to restart my computer to take it affect. What nicely worked was `sudo usermod -s /usr/bin/zsh`

## sed
This command substitutes all colons in the PATH to newlines making the echo outpur easier to read
`echo $PATH | sed s/\:/\\n/g`

### Replace all http to https in a file
`sed -i 's/http/https/g' /etc/apt/sources.list`
-i for in-place change

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
`sed -i "s/key: .*/key: \"$B64\"/g" file.yaml`
This updates the Value of __key__ with whatever is stored in the Variable __$B64__
## grep
find something recusively **in** the files of a folder
`grep <path> -rne <pattern>`
-n shows line number
-e defines the pattern to look for
-r sets recursively
See: https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux

## find
Find files in a folder with excluding a path
`find . -path ./exclude/path -prune -o -iname "*pattern*" -print`

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
## Installing colorls
```
sudo apt-get install ruby2.3-dev
sudo gem install colorls
```

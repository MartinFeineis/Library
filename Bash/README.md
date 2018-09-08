# BASH

## chsh 
For some reason when using chsh -s /bin/bash I had to restart my computer to take it affect

## sed
This command substitutes all colons in the PATH to newlines making the echo outpur easier to read
```echo $PATH | sed s/\:/\\n/g```

Replace all http to https in a file
```sed -i 's/http/https/g' /etc/apt/sources.list```
-i for in-place change


## grep
find something recusively **in** the files of a folder
```grep <path> -rne <pattern>```
-n shows line number
-e defines the pattern to look for
-r sets recursively
See: https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux


## certbot 
I use this to install certbot from letsencrypt on Debian 9.3(stretch) with nginx
```mkdir -p /usr/bin/certbot
cd /usr/bin/certbot
sudo wget https://dl.eff.org/certbot-auto
chmod +x certbot-auto
./certbot-auto --installer nginx```

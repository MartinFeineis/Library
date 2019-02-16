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
Update the sshd configuration to allow key based authorization. My preffered configuration checks the users .ssh directory for and authorized_keys File and also checks for a file named with the user in /etc/ssh. Depending on the Firewall settings I sometimes have to run sshd on a different port than 22
```
Port <port_of_choice>
AuthorizedKeysFile %h/.ssh/authorized_keys /etc/ssh/authorized_keys/%u
```
Lastly copy the ```keyname``` file to the machine you want to use to connect from.

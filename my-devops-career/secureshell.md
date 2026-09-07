# 6 secure shell

Learning and applying ssh (secure shell) and scp. Oveview of DNS and the hostfile.

## openssh

To connect to the _Terminal_ of a Linux computer we can use the `ssh` program. The syntax is like `ssh <username>@<Ip-Address/Hostname>`. An important part of using ssh is _authentication_ this can happen in two ways.

### 1. Password authentication

Here the command is run like above for example `ssh johnd@192.168.1.72` or `ssh johnd@www.myfristserver.com`. This way the terminal ask for a password after establishing the connection. See example below:

```
ssh johnd@192.168.1.72
password:
```

Note that the typed password will not appear and neither will stars or any other symbols. This also prevents that the length of the password can't be guessed by watching the screen

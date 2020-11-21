#!/bin/bash
FILE=~/.ssh/`date -I`wsk
SERVERS=(Server1, Server2)
date -I
ssh-keygen -t rsa -b 2048 -C "comments etc" -f "$FILE" -N ""

copyKey () {
  scp $FILE $1:$FILE
  scp $FILE.pub $1:$FILE.pub
}

replaceKey () {
  if [ -f "$FILE" ]; then
      sed -i 's/^\([^#].*\)/# \1/g' ~/.ssh/authorized_keys
      cat $FILE.pub >> ~/.ssh/authorized_keys
      echo $FILE 
      echo HOSTNAME
  fi
}
#replaceKey ()

for HOST in $SERVERS
do
    copyKey $HOST
    #ssh $HOST "$(typeset -f ); replaceKey"
done
#replaceKey () {
#  if [ -f "$FILE" ]; then
#      sed -i 's/^\([^#].*\)/# \1/g' ~/.ssh/authorized_keys
#      cat $FILE.pub >> ~/.ssh/authorized_keys
#      echo $FILE 
#      echo HOSTNAME
#  fi
#}
#EOF
#done

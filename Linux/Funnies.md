# Fun with Linux
## Steam Lok
```sh
sl
```
## Fortune and Cowsay
```sh
sudo apt-get install fortune cowsay
fortune | cowsay -f vader-koala
 _____________________________________
/ Things will be bright in P.M. A cop \
\ will shine a light in your face.    /
 -------------------------------------
   \
    \        .
     .---.  //
    Y|o o|Y//
   /_(i=i)K/
   ~()~*~()~
    (_)-(_)

     Darth
     Vader
     koala
```
Find other animals at `/usr/share/cowsay/cows`
## Telnet StarWars
```sh
telnet towel.blinkenlights.nl
```
```sh






             f r o m   a  h i d d e n   b a s e ,  h a v e  w o n

             t h e i r   f i r s t  v i c t o r y   a g a i n s t

             t h e   e v i l   G a l a c t i c   E m p i r e.


             D u r i n g     t h e     b a t t l e ,    R e b e l

             s p i e s  m a n a g e d  to  s t e a l  s e c r e t


```
## Ascii Aquarium
```sh
sudo apt install libcurses-perl
wget https://cpan.metacpan.org/authors/id/K/KB/KBAUCOM/Term-Animation-2.5.tar.gz
tar xzf Term-Animation-2.5.tar.gz
cd Term-Animation-2.5/
perl Makefile.PL
make 
sudo make install

cd /tmp
wget https://robobunny.com/projects/asciiquarium/asciiquarium.tar.gz
tar -zxvf asciiquarium.tar.gz
cd asciiquarium_1.1/
sudo cp asciiquarium /usr/local/bin
sudo chmod 0755 /usr/local/bin/asciiquarium
```

## Funny manpages
Basic version 
```sh
sudo apt install funny-manpages
```
Advanced version
```sh
git clone git@github.com:ltworf/funny-manpages.git
cd funny-manpages
sudo make install
# List the pages
man -S 1fun,3fun,6fun,8fun -k .
```
## BSD Games

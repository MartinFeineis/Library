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
[Repo](https://github.com/vattam/BSDGames)
adventure:	the original adventure by Crowther and Woods
arithmetic:	arithmetic quiz/speed test
atc:		air traffic control
backgammon:	backgammon
banner:		display a message in big letters
battlestar:	adventure game on a battlestar
bcd:		outputs text in an antique form
boggle:		boggle
caesar:		reads fortunes from the game fortune, also some internet posts
canfield:	curses-based solitaire
countmail:	tell you how much new mail you have
cribbage:	cribbage
dab:		dots and boxes
dm:		dungeon master, regulates games playing
factor:		factor a number
fish:		go fish
fortune:	displays a random silly message
gomoku:		gomoku
hack:		exploring the Dungeons of Doom
hangman:	guess the word before it is too late
hunt:		hunt each other in a maze (multiplayer -- great)
mille:		mille borne against the computer
monop:		monopoly
morse:		output morse code
number:		output the English text for a number
phantasia:	interterminal fantasy game
pig:		output text in Pig Latin
pom:		display the phase of the moon
ppt:		outputs text in another antique form
primes:		generate primes
quiz:		random knowledge tests
rain:		attempts to create a rain drop effect (best at 9600 baud)
random:		In default setting takes stdin and repeats it with a probablity of 50%
robots:		well... avoid the robots
sail:		sail your ship into battle
snake:		grab the cash and avoid the snake and exit
tetris:		tetris
trek:		We come in peace, shoot to kill.  It's worse than that, he's
		dead Jim.  Ye cannot change the laws of physics.  It's life
		Jim, but not as we know it.  There's Klingons on the starboard
		bow ...
wargames:	would you like to play a game?
worm:		eat the numbers without running into anything
worms:		random worms scurrying across your screen
wtf:		translate acronyms, e.g. "wtf is WTF"
wump:		hunt the wumpus
## Telnet
Star Wars in Terminal
```sh
telnet towel.blinkenlights.nl
```
Playing chess
```sh
telnet freechess.org
```
other games
```sh
telnet telehack.com
Trying 2001:470:67:c0::1337...
Connected to telehack.com.
Escape character is '^]'.

Connected to TELEHACK port 141

It is 11:40 am on Friday, December 19, 2025 in Mountain View, California, USA.
There are 126 local users. There are 26648 hosts on the network.

May the command line live forever.

Command, one of the following:
  ?            ac           advent       aquarium     basic        c8
  cal          calc         ching        clear        clock        cowsay
  ddate        diff         dir          eliza        exit         factor
  figlet       file         finger       fnord        geoip        help
  ipaddr       joke         mac          md5          more         morse
  newuser      notes        octopus      phoon        pig          pong
  primes       privacy      qr           rainbow      rand         recover
  rig          rockets      roll         rot13        salvo        sleep
  tail         today        traceroute   typespeed    units        uumap
  uupath       uuplot       weather      when         zc           zork

More commands available after login. Type HELP for a detailed command list.
Type NEWUSER to create an account. Press control-C to interrupt any command.
```

### Good Excuses
Funny Excuses BoFH style
```sh
telnet bofh.jeffballard.us 666
Trying 216.165.179.62...
Connected to jeffballard.us.
Escape character is '^]'.
=== The BOFH-style Excuse Server --- Feel The Power!
=== By Jeff Ballard <ballard@cs.wisc.edu>
=== See http://www.cs.wisc.edu/~ballard/bofh/ for more info.
Your excuse is: The math co-processor had an overflow error that leaked out and shorted the RAM
Connection closed by foreign host.
```

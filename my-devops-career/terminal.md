# 1 Introduction

## Terminal

Also many Linux Distributions come with advanced and easy to use _Graphical User Interfaces_ (GUI). I strongly recommend using the commandline.\
Using the commandline can be somewhat scary in the beginning when someone is used to nice and more userfriendly GUIs. But learning the proper use of the commandline Terminal, brings a variety of advantages.

* Tasks and problems are easier to keep track of, as the commands can simply copied into a text file for future reference. Instead of making screenshots with arrows and circles around the important things.
* Reocurring problems can be easy automated by just running the previous commands again or putting them in an executable shell script.
* Unerstanding of Computers. Using the commandline properly gives you a good understanding of what happens inside a computer. GUIs hide the commands that are executed from the user.

## Installing Software

In this Chapter I teach how to use a package Manager and what a package Manager is. `yum install nginx`

### Package Manager

Package Managers are an easy and secure way for installing software on Linux Computers.\
The Package Manager for Fedora is called **yum** the one for Ubuntu is called **apt**.\
Both offer similar commands, for searching, installing, updating and removing software from a Computer. A complete List of yum commands can be found here [yum commands](http://yum.baseurl.org/wiki/YumCommands.html).\
We will only use a fraction of these commands and explain the ones we need in this course in further detail below.

#### Finding Packages with yum

To search for a specific package name use the yum

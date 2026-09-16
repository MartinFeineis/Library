# 5 World Wide Web

## Internet Basics

There are basically 3 different types of Files that make up the Internet:

1. HTML\
   HTML stands for _HyperText Markup Language_. It is not a programming language and therefor does not support any logic like if-else statements or loops. HTML solely defines the **content** of a website and its position and style in regards to other content of website.
2. CSS\
   CSS stands for _Cascading StyleSheets_ and it defines the style of the different html elements.
3. JS/Javascript\
   Javascript provides the logic HTML and CSS are missing for Websites. There are a lot of Frameworks and other tools that are built on top of javascript. Some common examples are Bootstrap, Nodejs and React.

### Internet

A great resource for learning HTML is [W3 School HTML](https://www.w3schools.com/html/default.asp)

## Domain Name Service (DNS)

Every computer that is _on_ the Internet also has an IP Address (IP stands for _Internet Protocol_). You can find the IP Address of your computer with the command `ip a` the output should look like this:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:1d:72:20:80:39 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.151/24 brd 192.168.1.255 scope global dynamic enp2s0
       valid_lft 72233sec preferred_lft 72233sec
    inet6 fe80::b0f8:7c4e:d424:8e3c/64 scope link 
       valid_lft forever preferred_lft forever
3: wlp4s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:17:c4:1a:be:24 brd ff:ff:ff:ff:ff:ff
```

There are two main Versions of the Internet Protocol, IPv4 and IPv6.

You can find the IP Address of a Webserver with `nslookup` for example:

```bash
nslookup www.404founders.com
```

Should return this:

```bash
➜ nslookup www.404founders.com
Server:         127.0.1.1
Address:        127.0.1.1#53

Non-authoritative answer:
Name:   www.404founders.com
Address: 66.175.209.203
```

### 3-Tier Model

The probably most common used design architecture in the Internet is the so called 3-Tier Architecture. It consists of the Presentation Tier, the Logic Tier and the Data Tier.

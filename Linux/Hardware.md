# Hardware Commands for Linux (mostly Ubuntu based)

## Networking
### Wifi
Check for Wifi Adapter availability, network interface will show up as `Wireless Interface`
```
sudo lshw -C network
```
Find you Wifi device name with, `a` means address/network interface
```
ip a
ip a show wlp61s0
```
Scan for available Wifi Networks with 
```
nmcli d wifi list
```

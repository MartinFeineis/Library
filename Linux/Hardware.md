# Hardware Commands for Linux (mostly Ubuntu based)

## Networking
### Wifi
Check for Wifi Adapter availability, network interface will show up as `Wireless Interface`
```bash
sudo lshw -C network
```
Find you Wifi device name with, `a` means address/network interface
```bash
ip a
ip a show wlp61s0
```
Scan for available Wifi Networks with 
```bash
nmcli d wifi list
```
Connect and disconnect to Wifi Network, `wlp61s0` is the device name
```bash
nmcli d disconnect wlp61s0
nmcli d connect wlp61s0   
```

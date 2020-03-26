# Samsung Glaxay 10.1 wifi
## Download Mode
Press `Volume Down + Home + PowerOn` to get into download mode and install LineageOS or any applicable Operating System.

## Recovery Mode
Press `Volume Up + Home + PowerOn` to get into TWRP after it got installed. If I do it correctly I see this red message in the upper left corner of the screen __RECOVERY IS NOT SEANDROID ENFORCING__ together with the Samsung Galaxy 10 Screen


## Sideloading Lineage
Installing lineageOS after building 
`adb sideload lineage-14.1-20190819-UNOFFICIAL-n1awifi.zip`
List devices
`adb devices`

## Installing TWRP
Using fastboot to install twrp
`fastboot flash recovery twrp.apk`

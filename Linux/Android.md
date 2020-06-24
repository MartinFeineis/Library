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

## Fix Setup Wizard
The Last step I did that fixed the issue was moving the LineageSetupWizard
to the sdcard. Maybe there was a conflict with the GoogleSetupWizard.
Boot into Recovery Mode, mount the system volume and mov the Directory
```
mount /system
mv /system/priv-app/LineageSetupWizard /sdcard/
```
After this the Language select screen looked different. I think both Setup
Wizards were running and conflicting with each other. Removing LineageSetupWizard
seemed to resolve that conflict.

### Additional Steps
I also tried to add all the permissions from the [perms](perms.txt) File.
I then looped over that file and applied all permissions through adb.
```
while read in; do adb shell pm grant com.google.android.setupwizard "$in"; done < perms.txt
```
After I did this the Setup Wizard still crashed but several steps later in the 
provisiong process. 
Also moving the Google Setup Wizard to sdcard insetad of the Lineage one 
started the Tablet but the __Home__ Buttone and the __List App__ Button didn't work.

### Notes
when connecting through adb during the Setup Wizard it sometimes had root 
permissions and sometimes not. After this resolution I think happened when
the different Setup Wizards were running with different permissions that then
got inherited by the adbd deamon.

### default.prop
Settings for adb connection and more or less enabling usb debug mode.
```
ro.secure=0
persist.service.adb.enable=1
```
### build.prop

# Linux Mint
## Dconf Gnome Settings
[Gnome](https://www.gnome.org/) provides a set of features and applications [(desktop experience)](https://en.wikipedia.org/wiki/GNOME) for Linux distributions
Use the [Dconf GUI Editor](https://apps.gnome.org/DconfEditor/) to get, set, and manage [settings](https://www.baeldung.com/linux/dconf-editor) for Gnome Applications
### Change Wallpaper
`gsettings` are used to set dconf values
```bash
gsettings list-recursively org.cinnamon.desktop.background
gsettings list-recursively org.cinnamon.desktop.background.slideshow
gsettings set org.cinnamon.desktop.background.slideshow slideshow-enabled true
gsettings set org.cinnamon.desktop.background.slideshow image-source "directory://$HOME/Pictures/backgrounds_sys76"
gsettings set org.cinnamon.desktop.background.slideshow random-order true
gsettings set org.cinnamon.desktop.background.slideshow delay 60
```

## Preferred Applications
__ToDo__ change this to use dconf or gsettings
Change to use Apps for specific uses, instead of defaults.
Terminal --> ghostty
Web --> Brave
Video --> VLC

## Scanner
Download Epson Scanner driver and Epson Scan2 App [here](https://download-center.epson.com/download/?module_id=5ff13ac7-4fe4-4b61-9f8b-71e5e2a1c786%3A6.7.90.0&device_id=Perfection+V19&os=DEBX64&region=US&language=en)

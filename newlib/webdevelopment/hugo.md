# Hugo
Hugo is a Web Framework writtin in Golang
## Installation
Hugo [Releases](https://github.com/gohugoio/hugo/releases) and [latest](https://github.com/gohugoio/hugo/releases/latest)
Get __extended_withdeploy__ and __amd64__ package
```sh
cd /tmp
wget https://github.com/gohugoio/hugo/releases/download/v0.138.0/hugo_extended_withdeploy_0.138.0_linux-amd64.tar.gz
tar -xvf hugo_extended_withdeploy_0.138.0_linux-amd64.tar.gz
sudo dpkg -i hugo_0.123.3_linux-amd64.deb 
 ```
## Getting started
initialize new website into existing git repo
```sh
mkdir myDir
hugo new site myDir --force -f toml
```
## Run local dev Server
```sh
hugo server --bind 192.168.1.157 --baseURL http://optiplex/
```
## Index Page
Overwrite theme index page with `layout/index.html`

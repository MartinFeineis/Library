# Library for using Windows
## Creating a Programs Folder
I created a new Folder called NewProgs in C:\ with the same permissions (ACLs) as _Progam Files_ where I store all my installed programs to keep track of them more easy and being able to find them easy when being logged in as a different user.
```
New-Item -ItemType Directory -Path C:\NewProgs
Get-Acl -Path "C:\Program Files" | Set-Acl -Path C:\NewProgs
$env:Path += ";C\NewProgs"
```
I recommend putting the last line in a startup script for powershell instead of permanently appending it to the path, this makes it easier keeping track of changes.

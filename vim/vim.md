# Cheatsheet to vim
## replace all empty lines
`:g/^$/d` [regards to here](https://alvinalexander.com/linux-unix/vi-vim-delete-blank-lines-empty-lines)  
`:<range>s/<pattern>/<replace>`   
* `<range>` Range can be a linenumber `12` a range of linenumber `12,14` a range of marks `'a,'b` or the whole document `%`  
* `<pattern>` The pattern to search for  
* `<replace>` what to replace the pattern with  
Example comment lines 15 to 25 `:15,25s/^/#`  
# Plugins
## Pathogen
I use Pathgen for managing plugins
## Nerdtree
Nerdtree allows you to have a folder pane to navigate files/folders.
## YouCompleteMe
YCM offers autocomplete
## Ranges
Usefule Link [Ranges](https://vim.fandom.com/wiki/Ranges)  
`$` goes to end of Line.  
## RegEx
[regex](http://www.vimregex.com/)  

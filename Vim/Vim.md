# Cheatsheet to vim
## replace all empty lines
`:g/^$/d` [regards to here](https://alvinalexander.com/linux-unix/vi-vim-delete-blank-lines-empty-lines)  
`:<range>s/<pattern>/<replace>`   
* `<range>` Range can be a linenumber `12` a range of linenumber `12,14` a range of marks `'a,'b` or the whole document `%`  
* `<pattern>` The pattern to search for  
* `<replace>` what to replace the pattern with  
Example comment lines 15 to 25 `:15,25s/^/#`  
## insert file at current position
`:r <path/to/file>`

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
## switch case
__upper case__ press `gU<motion>` to change the letter under the cursor to 
__lower case__ press `gu<motion>` to change the letter under the cursor to 
## ranges
usefule link [ranges](https://vim.fandom.com/wiki/ranges)  
`$` goes to end of line.  

## regex
[regex](http://www.vimregex.com/)  

# plugins
## pathogen
i use pathgen for managing plugins
## nerdtree
nerdtree allows you to have a folder pane to navigate files/folders.
`?` to see help menu
`r` to refresh view, for example after deleting some file
`I` to see hidden files and folders
## [youcompleteme](https://github.com/ycm-core/YouCompleteMe)
ycm offers autocomplete
## [SURROUND.VIM](https://vimawesome.com/plugin/surround-vim)
A plugin to change the brackets or other characters around text. Useful 
for html for example

## [Emmet](https://github.com/mattn/emmet-vim/)
A plugin for html autocompletion
Open or create a New File:

`vim index.html`
Type ("_" is the cursor position):

html:5_
Then type <c-y>, (Ctrly,), and you should see:

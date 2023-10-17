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
insert lines _9_  _19_ from file `myfile`
`:r! sed -n 9,19p /path/to/myfile`

## Ranges
Usefule Link [Ranges](https://vim.fandom.com/wiki/Ranges)  
`$` goes to end of Line.  
## switch case
__upper case__ press `gU<motion>` to change the letter under the cursor to 
__lower case__ press `gu<motion>` to change the letter under the cursor to 
## ranges
usefule link [ranges](https://vim.fandom.com/wiki/ranges)  
`$` goes to end of line.  
`0` goes to the beginning of line (`^` seems to do the same)

## regex
[regex](http://www.vimregex.com/)  

# Plugins
## Vundle
I use vundle for managing plugins, [here](https://github.com/VundleVim/Vundle.vim)
```
 git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
## Nerdtree
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

# Styling
## Theme
Put new themes into `~/.vim/colors` and then pick them with `:colo <theme>`
`elflord` theme looks nice Latitude 5520 Laptop in Windows Terminal

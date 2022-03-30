# Python
code snippets and stuff for Python
## Programm Setup
Install virtualenv, using pyenv is not necessary but I like it to keep my python versions managed.
```
pyenv local 3.9.0
python -m venv
```
[Shebang](https://stackoverflow.com/questions/6908143/should-i-put-shebang-in-python-scripts-and-what-form-should-it-take) and program layout
```
#!/usr/bin/env python3

def main(kwargs**, args**):
    pass

if __name__ == '__main__':
    main()
```

## Beautiful Soup
Use beautiful soup for scraping and manipulating html content
```
pip install bs4
from bs4 import BeautifulSoup
```
## Commandline execution
The `-c` flag tells python to run the appended string as a command.
For example 
```
➜ python3 -c "import datetime; print('It is: ',datetime.datetime.now())"
It is:  2022-03-29 13:37:50.057810
```
## CLI Arguments
Use the `argparse` Library to read cli arguments.
```
import argparse

def read_cli_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--file", help="Execute on this File.", type=str)
    args = parser.parse_args()
    argv = vars(args)
```

`argv` is a dictionary like `{'file' : 'CliArgument'}. 
`args` is the Namespace for all Cli Arguments.

## String Formatting
Filling `{}` with the variable `Name'
```
Name = "Jacen Solo"
this_string = "Hello World I am {}".format(Name)
```
More complex solution by definen the positional arguments of the format function
```
age = 32
Name = "Nom Anor"
this_string = "Hello World. I am {1} and {0} years alive.".format(age, Name)
```
This puts `Name` in `{1}` because it is the second positional argument 
(0-based indexing) and `age` in `{0}`.


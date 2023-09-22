# Python
code snippets and stuff for Python
## Programm Setup
Install virtualenv, using pyenv is not necessary but I like it to keep my python versions managed.
Install `python3.10-venv` if an error message tells to.
```
apt install python3.10-venv
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
## Help Function
adding an explantion string to a function can be used by the `help()` function 
to give explanation into what it is doing.
```python
def adder(x,y):
    """
    adds to numbers x and y and returns the sum
    """
    return x+y

help(adder)
```
for a class this looks like:
```python
class person():
    """
    A new person is born
    """
    def __init__ (self, name):
        """
        Give the person a name
        """
        self.name = name
```
and the output from interactive session is:
```python
PS C:\Users\920280\OneDrive - Cognizant\Documents> python.exe -i person.py
>>> help(person)
Help on class person in module __main__:

class person(builtins.object)
 |  person(name)
 |  
 |  A new person is born
 |  
 |  Methods defined here:
 |  
 |  __init__(self, name)
 |      Give the person a name
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)

>>> help(person.__init__) 
Help on function __init__ in module __main__:

__init__(self, name)
    Give the person a name

>>> 
```

## CLI Arguments
Use the `argparse` Library to read cli arguments.
```python
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

## IF-Else Oneliner

```
this_dict['key'] = other_dict['key'] if other_dict['key'] else this_dict['key']
```
Read `this_dict['key']` is `other_dict['key']` if that key exists (evalutes to `true`)
otherwise keep the origial value.

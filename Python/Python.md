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

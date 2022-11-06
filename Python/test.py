import requests
from bs4 import BeautifulSoup
import re

mirror="http://ftp.uk.debian.org/debian/dists/stable/main/"

contents = requests.get(mirror).text
soup = BeautifulSoup(contents, 'html.parser')

arch="amd"
lest= str(soup.pre).split("\r\n")
def get_file_count(soup, arch):
    nlist = []
    for i in lest:
        if arch in i:
            nlist.append(" ".join(i.split()))
    return nlist

def no_dashes(list):
    ter = {}
    for i in list:
        d = i.split()
        if i[-1] != "-":
            one = i.split("\"")[1]
            ter[one]= d[-1]
    return ter

t = get_file_count(soup.pre, arch)
op = no_dashes(t)
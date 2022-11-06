#!/usr/bin/env python3


from yaml import load, dump, FullLoader
from pprint import pprint as pp

try:
    from yaml import Cloader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper

with open('defaults.yaml', 'r') as serviceyaml:
    #data = [ line for line in serviceyaml ]
    content = load(serviceyaml, Loader=FullLoader)

nlist= []
nlist.append(content['internal_service']['secret_keys'].split('\\m')[0])
[ nlist.append(item) for item in content['internal_service']['secret_keys'].split('\\m')[1].split('\\n')]
pp(nlist)

content['internal_service']['secret_keys'] = nlist

#client_cert = content['internal_service']['client_cert'].split('\n')
#cert_with_newline = '\n'.join(client_cert)
#content['internal_service']['client_cert'] = cert_with_newline
content['internal_service']['client_cert'] = content['internal_service']['client_cert'].rstrip('\n')

with open('output.yaml', 'a') as outfile:
    outfile.truncate(0)
    data = dump(content, outfile)

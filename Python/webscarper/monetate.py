#!/usr/bin/python
#
# Write a program that detects broken links from a root URL
#
# - given the root URL "https://www.monetate.com/" recursively
# follow all <a> tags relative to https://www.monetate.com/ and
# report on any links that do not return a HTTP 2xx or 3xxfds
import requests
import argparse
from bs4 import BeautifulSoup

# parser = argparse.ArgumentParser()
# parser.parse_args()
# parser.add_argument("--website", type=str, default="https://www.monetate.com", help="Webaddress to scrap Links from")
# parser.add_argument("--depth", type=int, default=0, help="Level to follow links down to")
# args = parser.parse_args()
web_url = "https://www.monetate.com" #args.website
depth = 2 #args.depth

def get_links(http_addr):
	link_list = []
	try:
		r = requests.get(http_addr).text
		soup = BeautifulSoup(r, "html.parser").find_all('a')
	except Exception as e:
		print "Check to use a parsable URL"
		return link_list

	for i in range(0, len(soup)-1):
		try:
			link_list.append(soup[i]['href'])
		except Exception, e:
			print "Broken or not absolute link " + str(i)
			#print e
	return link_list

def check_link_list(list_of_links):
	stat_dict = {}
	for i in range(0, len(list_of_links)-1):
		try:
			stat_code = requests.get(list_of_links[i]).status_code
		except Exception as e:
			print "No valid URL"
			stat_code = 600
		#print str(stat_code) + " " + str(i) + " " + str(list_of_links[i])
		stat_dict[list_of_links[i]] = stat_code
	return stat_dict

def follow_links(init_page, depth=0):
	start_links = get_links(init_page)
	all_links = start_links
	if depth == 0:
		run_depth = range(0, 1)
	elif depth == -1:
		run_depth = range(0, len(start_links)-1)
	elif depth > 1:
		run_depth = range(0, depth)
	else:
		return "depth must be a -1, 0 or a positive integer"
	for i in run_depth:
		if start_links[i] not in all_links:
			all_links = all_links + follow_links(start_links[i])
	return all_links

def main():
	c = follow_links(web_url, depth)
	t = check_link_list(c)
	print t

if __name__ == '__main__':
	main()
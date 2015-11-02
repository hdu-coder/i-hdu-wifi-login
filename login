#!/usr/bin/env python3

from urllib import request, parse
from pathlib import PurePath
import re
import os
import logging
import sys
import getopt

home = os.environ['HOME']
config = '.i-hdu'
path = PurePath(home).joinpath(config).as_posix()

# set default timeout
timeout = 10

# handle terminal option
def parseArgv():
	try:
		options,_ =getopt.getopt(sys.argv[1:], 'ht:', ['help', 'timeout='])
		return options
	except getopt.GetoptError as e:
		#logging.exception(e)
		return [('--help')]

def print_help():
	print('Usage: i-hdu-logon')
	print('')
	print('Options:')
	print('\t-h, --help\t\t show help list')
	print('\t-t, --timeout <timeout>\t set timeout time, default is 10s')

# get username and password throught .i-hdu file
def getInfo():
	try:
		with open(path, 'r') as f:
			print('load user and password from ' + path)
			name = f.readline()[0:-1]
			pwd = f.readline()[0:-1]
			print('user name: ' + name)
			# print('user pwd:\t' + pwd[0:-1])
			return (name, pwd)
	except FileNotFoundError as e:
		print('config file not found in ' + path)
		exit(1)

def login():
	name, pwd = getInfo()
	try:
		with request.urlopen('http://www.baidu.com', timeout=timeout) as f:
			stream = f.read()
			data = stream.decode('utf-8')
			# print(data)
			result = re.search(r"location\.href=\"(.*)\"",data)
			if not result:
				print("you have been login")
				# return
			else:
				url = parse.urljoin(result.group(1),'logon.cgi')
				# print(url)
				data = parse.urlencode([
					('PtUser', name),
					('PtPwd', pwd),
					('PtButton', 'logon')
				])
				# print(data)
				with request.urlopen(url, data=data.encode('utf-8'), timeout=timeout) as f:
					stream = f.read()
					# data = stream.decode('utf-8');
					# print(stream)
					print("login success")
	except BaseException as e:
		logging.exception(e)
		print('an error occur, please try again')
		exit(1)

options = parseArgv()
for key,value in options:
	if key in ('-h', '--help'):
		print_help()
		exit(0)
	elif key in ('-t', '--timeout'):
		timeout = Int(value)

login()
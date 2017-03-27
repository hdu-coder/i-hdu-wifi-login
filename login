#!/usr/bin/env python3

from urllib import request, parse
from pathlib import PurePath
import re, os, logging, sys, getopt, json

home = os.environ['HOME']
config = '.i-hdu'
path = PurePath(home).joinpath(config).as_posix()
apiPath = 'http://2.2.2.2/ac_portal/login.php'
logout = False
version = 'v1.1.0'

# set default timeout
timeout = 10
verbose = False

# handle terminal option
def parseArgv():
	try:
		options,_ =getopt.getopt(sys.argv[1:], 'ht:vl', ['help', 'timeout=', 'verbose', 'logout'])
		return options
	except getopt.GetoptError as e:
		print('Your option is not allowed here, please use follow options')
		print('')
		return [('--help', '')]

def print_help():
	print('Usage: i-hdu-login')
	print('Version: %s' % version)
	print('')
	print('Options:')
	print('\t-h, --help\t\t show help list')
	print('\t-t, --timeout <timeout>\t set timeout time, default is 10s')
	print('\t-v, --verbose \t\t show verbose meesage, about debug and error')

# get username and password from $HOME/.i-hdu file
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
		loginData = parse.urlencode([
			('opr', 'pwdLogin'),
			('userName', name),
			('pwd', pwd),
			('rememberPwd', 0)
		]).encode('utf-8')

		logoutData = parse.urlencode([
			('opr', 'logout')
		]).encode('utf-8')

		if logout: 
			data = logoutData
			action = 'Logout'
		else:
			data = loginData
			action = 'Login'

		with request.urlopen(apiPath, data=data, timeout=timeout) as f:
			res = json.loads(f.read().decode('utf-8').replace('\'', '\"'))
			verbose and print(res)

			if (res['success']):
				print('%s Success!' % action)
			else:
				print('%s Fail: %s' % (action, res['msg']))

	except BaseException as e:
		if (verbose) :
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
	elif key in ('-v', '--verbose'):
		verbose = True
	elif key in ('-l', '--logout'):
		logout = True

login()

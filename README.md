# Introduce
I am a student in HDU. You must be login before you want surfing in internet in i-hdu wifi. So I write a python script to auto login.

# language
* Python 3

# require
you must be have a config file named `.i-hdu` in your user dir.

there have two line of `.i-hdu`

the first line is your studentID

the second line is your password

# Login

	$ ./login

# Save into PATH

	$ ln -s `pwd`/login /usr/local/bin/i-hdu-login

restart your bash

	$ i-hdu-logon

# CLI
```
Usage: i-hdu-login

Options:
	-h, --help					show help list
	-t, --timeout <timeout>		set timeout time, default is 10s
	-v, --verbose				show verbose meesage, about debug and error
```

# Thanks
# Introduce
I am a hdu's student. You need to sign in i-hdu/i_hdu wifi to access internet. I'm boring to type studentID and password everytime. So I write a script to do this.

# Requirement
* Python 3 environment
* Mac/Linux recommend, window recommand using cmder or other linux simulator.

# Install

You can `clone` this repo to install(recommend), or run follow script in shell to install(not recommend).

```bash
curl -L https://git.io/vSsvc > ~/i-hdu-wifi-login
chmod a+x ~/i-hdu-wifi-login
```

Then, You can use `~/.i-hdu-wifi-login` to login or logout i-hdu/i_hdu wifi.

# Config
only one `.i-hdu` config file in your $HOME(Mac: `/Users/yourname/` Linux: `/home/yourname`),as follow format:

```
YourStudentID
YourPassword
```

It's contains two lines, the first line is your studentID, the second line is your password

# Usage

	$ ~/i-hdu-wifi-login --help
	Usage: i-hdu-login
	Version: v1.1.0
	
	Options:
		-h, --help		 show help list
		-t, --timeout <timeout>	 set timeout time, default is 10s
		-v, --verbose 		 show verbose meesage, about debug and error
		-l, --logout 		 logout from i-hdu wifi
The default is login without any parameters.

# Save into PATH

	# zsh/bash with git
	$ ln -s `pwd`/login /usr/local/bin/i-hdu-wifi-login
	# fish with git
	$ ln -s (pwd)/login /usr/local/bin/i-hdu-wifi-login

or

```
# you install through script
# zsh/bash
$ ln -s ~/i-hdu-wifi-login /usr/local/bin/i-hdu-wifi-login
# fish
$ ln -s ~/i-hdu-wifi-login /usr/local/bin/i-hdu-wifi-login
```

restart your bash/zsh/fish, then type follow command.

	$ i-hdu-logon
# Thanks

Welcome to use… I'm a Macer, haven't test in window yet. Any Question Welcome.
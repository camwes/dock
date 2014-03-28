* Development Environment
 1. [Customize Your Shell](#1-customize-your-shell)
 2. [Install Packages](#2-install-packages-via-homebrew)
 3. [Install Apps](#3-install-apps-via-cask)
 4. [Install Dependencies](#4-install-additional-dependencies)
* Production Environment
 * [Install Nginx](#install-nginx)
 * [Install Ruby](#install-ruby)
 * [Install Node](#install-node)
 * [Install Ghost](#install-ghost)
 * [Install PHP](#install-php)

# Development Environment
A developer is only as good as his/her environment. In order to be the most productive developer possible you must start by using the correct tools. When I first learned how to build websites I preferred an IDE (Adobe Dreamweaver) as my primary editor because it provided the most out-the-box functionality. I soon found my development needs outgrew Dreamweaver and eventually realized that there really is no GUI out there that is going to give you the control that you get by using command line tools. So, I started off down the path to learning linux. In order to build an efficient development environment intermediate knowledge of Linux is a sine qua non.
#### GUI v. CLI
This is not to say that the best development environment doesn't use any GUIs. Many services provide excellent GUIs which provide additional benefits and advanced features. Many developers (myself included) prefer to use non-CLI text editors (textmate, webstorm, textwrangler and coda seem to be most popular). Other developers use the Github GUI, which is capable of executing most of the available git commands. To each it's own, but when making the decision between using a GUI or CLI, consider carefully how much control you will need.

===
```sh
./dev_env.sh
```
To make lives easier, the above command will do everything that you need to get your development environment from zero to supercharged in ~20-30 mins. Here's what the script does:

1. Customize your shell
2. Install packages via Homebrew
3. Install apps via Cask
4. Install additional dependencies

## 1. Customize Your Shell
Most linux machines use bash as the default shell, and if you've been using linux long enough it's likely that you have amassed an impressively large .bashrc (or .zshrc if you like me prefer the zsh shell) filled with aliases and enhancements to your shell environment. If you don't know what a .bashrc is then you should take the time to research how these files work and how they can make your life a lot easier. I would suggest perusing this:
##### [sample .zshrc](http://tldp.org/LDP/abs/html/sample-bashrc.html)
## 2. Install Packages via Homebrew
If you are configuring a development environment for a mac then you must install Homebrew, and it will do a lot of heavy lifting for you. If you use a window's machine then go out and buy a Mac (but seriously). Homebrew is a package managers for Mac OSX; it can install command line packages and applications and manage these installations. Homebrew has tons of [packages available](https://github.com/Homebrew/homebrew/tree/master/Library/Formula) and this repo installs a select view. They are listed in the [BrewFile](dotfiles/Brewfile). My favorite formulas are:
* git (duh)
* emacs (or your favorite command line text editor)
* autojump
* tree
* tig
* wget
* htop
* mosh
* zsh

## 3. Install Apps via Cask
Even better, brew can also install your GUI apps using brew cask. Many apps are added everyday so check out what's available [here](https://github.com/phinze/homebrew-cask/tree/master/Casks) or check out the casks installed with [this repo](dotfiles/.cask).

## 4. Install Additional Dependencies
#### Install Ruby (rubygems)
Mac comes with Ruby installed. Nothing to do here... Yay! But you will need to install some important rubygems:

* [Sass](http://sass-lang.com/) is a css preprocessor 
* [Compass](http://compass-style.org/) is a utility for sass
* [Cheat](http://cheat.errtheblog.com/) is a collection of cheat sheets for popular tools
* [Ceaser](http://matthewlein.com/ceaser/) is a collection of easing transistions 

```sh
gem install sass compass cheat ceaser-easing
```
#### Install Global Node Modules
Node has a great deal of modules that are easily downloaded using npm. While each web project should have it's own packages.json for installing dependencies there are a few modules that you will need to install globally:

* [coffee-script](http://coffeescript.org/): Javascript pre-processor
* [forever](https://github.com/nodejitsu/forever): A simple CLI tool for ensuring that a given script runs continuously (i.e. forever)
* [grunt-cli](http://gruntjs.com/): A node.js automation tool
* [bower](http://bower.io/): a package manger for the web
* [node-inspector](https://github.com/node-inspector/node-inspector): An amazing plugin that allows you to use chrome devtools on server code.

```sh
npm install # install all modules in package.json
npm install -g node-inspector bower forever grunt-cli coffee-script
```
You may also want to consider [yeomon](http://yeoman.io/), an application generator. This service installs works with bower and grunt but adds the benefit of basically doing what I've done in this repo and providing you with biased app structures (generators) to choose from. In due, time I will create my own Yeoman generator for this boilerplate.
#### Install LiveReload
If you've developed for a while you probably hate the process of constantly refreshing your browser once pages have been updated. This is a thing of the past with [LiveReload](http://livereload.com/). Install their app or  browser extensions. The [gruntfile.coffee](https://github.com/cdrake757/boilerplate/blob/master/gruntfile.coffee) has already been updated to enable livereload when changes are made to the static directory when you "grunt watch".

# Production Environment
As a developer I began making websites with zero server administration experience. I used commercial web hosting services that were both terribly interfaced and extremely limited (GoDaddy, Yahoo, etc.) As the sophistication of the things that I decided to build began to outgrow these services I decided that it was worth my time to learn to deploy a site using Amazon Web Services. Many of the webs most successful companies (Netflix, Tumblr, etc.) and most startups heavily rely on AWS, as it is very competitively priced. Unfortunately, for most front-end developers, learning to use these services is a daunting task.
#### [AWS Guide](tutorials/aws.md)
There are many services that are offered by AWS, but the most important is Elastic Compute Cloud (EC2) which allows users to create their own virtual servers which are partitioned from Amazon's data servers. As a result these are some of the fastest and most reliable servers you can use. Other crucial services that you will probably use are S3 (a storage service), Route 53 (A DNS management service) and Cloudfront (a CDN). You need only use Route 53 and EC2 to get started, but I recommend becoming very familiar with these four services and the many other products that AWS offers. A basic knowledge of Unix, [SSH](tutorials/ssh.md), and DNS is requisite to follow along with my [guide to aws](tutorials/aws.md).
Once you have a server set up what are the next steps? In the past the next steps were pretty straightforward and hardly disputable: Install and configure the typical LAMP stack technologies: PHP, MySQL and Apache. Most often, if you are a front-end developer you may not be very comfortable with learning a server side language like php or python. If this is the case you should be very excited about a new technology called Node.js If you have no idea what Node is, it is essentially Javascript for the server side. Your eyes probably light up at the idea alone, since JS has certainly become the default scripting language of the web. Most importantly, many beginners have experience with javascript, giving them the opportunity to expand their development to the server side.
#### [Deploying using Github](tutorials/deploy.md)
But getting the server set up isn't the end of server deployment. Since you are already clearly an expert at Git by now why not use git to improve your server deployment process? Git is actually an excellent tool for this, but requires a slightly more advanced usage of git and understanding of shell scripts. Follow the [guide](tutorials/deploy.md) if you're brave enough.
```sh
./prod_env.sh
```
Similar to the development script above, this script is designed to build a production environment for you. This script does many things, including but not limited to:
* Create Users
* Set Time Zone & Clock
* Install Dependencies
  * Apache2/Nginx
  * Mysql
  * Node
  * PHP 5.5
  * Git
  * Rubygems
* Configure Stack (Firewall, PHP, Fail2Ban)
* Setting up Deploy Keys
* Create Git Repositories for Deployment
  * staging
  * prod

#### Notes:
* environment: Ubuntu 12.04 Server:
* the prompt requires manually selecting the timezone
* MySql secure install requires answering a prompt
* Adding Deploy Keys to github requires copying ssh key

## Server Structure
When you have completed installation you should have the following architecture in /home/git:

```
├── staging.git
│   ├── hooks
│   │   ├── post-receive
│   │   └── pre-receive
├── production.git
│   ├── hooks
│   │   ├── post-receive
│   │   └── pre-receive
└── public
    ├── production
    │   ├── backup
    │   ├── log
    │   └── public
    └── staging
        ├── backup
        ├── log
        └── public
```

## The Nitty Gritty
### Install Nginx
Apache is by a long shot the most popular web server in existence (It is the A in LAMP after all) but many people are starting to realize the benefits of dumping Apache for Nginx because it is lighter and faster at serving static files. Using Nginx rather than Node's HTTP server does not only provide advantages in speed, but also allows you to run multiple node processes at once and proxy them all through nginx. Installing Nginx is a breeze and its' configuration is simple:
```sh
sudo apt-get install nginx
emacs /etc/nginx/nginx.conf // update config with information like root location, domain name etc.
sudo service start nginx
```
Socket.io requires installing a version of nginx past 1.3, apt-get only has 1.19 so you should install from source
```sh
wget http://nginx.org/download/nginx-1.4.3.tar.gz

tar xvzf (.tgz or tar.gz)
tar xvjf (.tbz or .tar.bz2)
tar xvf (.tar)

./configure
make
sudo make install
ln -s /sbin/nginx /usr/sbin
# update your configuration files to your liking
sudo service nginx start
```
And really that's it. Nginx has great documentation for their servers and I would suggest spending some time reading as much as necessary, being sure to use [best practices](http://wiki.nginx.org/Pitfalls). You'll also notice that an nginx.conf file is included in the boilerplate (config/nginx.conf). This is a configuration file that I would suggest using as it proxies node through nginx and uses nginx to serve static files rather than express (along with many other improvements to the default file taken from [this article](http://blog.argteam.com/coding/hardening-node-js-for-production-part-2-using-nginx-to-avoid-node-js-load/)). I like to symlink this file to /etc/nginx so that you can keep your config files under version control as well. For production, you will need to make sure that Nginx is running and that you have symlinked the public directory to the correct place for nginx.


### Install Ruby
Another piece of software that will be required is Ruby. While it comes preinstalled on Mac, you will need to install it on your Ubuntu server. This can be done easily using the Ruby version manager [RVM](https://rvm.io/rvm/install)
```
\curl -L https://get.rvm.io | bash -s stable --ruby
```
Afterwards you can install the gems that you will need:
```sh
gem install sass compass
```

### Install Node
There are many advantages to Node.js, but when choosing to build a site using it one has to keep in mind that it is not a very mature technology. The young, ever-changing nature of Node.js can present a challenge for developers. Regardless, Node is a reliable enough technology that is used by companies of the likes of Yahoo, Linkedin and many more. I have hopped on the bandwagon and recommend Node for it's simplicity above all. Installing and running node is a fairly straightforward process. Depending on what you're building you may require a specific version of Node.js, but this tutorial assumes you're fine with using the latest version.

Using Ubuntu makes this much easier. For detailed guides to using package managers to install node please [visit here](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager).
```sh
sudo apt-get install node		#installs an old standard version
# to install the latest stable release
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
```
The detailed long form version (Amazon Linux)
```sh
sudo yum install gcc-c++ make
sudo yum install openssl-devel
sudo yum install git
git clone git://github.com/joyent/node.git
cd node
./configure
make (will take 30+ mins)
sudo make install
```
Add to sudo's path:
```sh
sudo su
vi /etc/sudoers
```
Use the down keyboard arrow to find this line: "Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin"
add ":/usr/local/bin" to the end of the line
### Install npm
A great feature of Node is that it comes with a simple package manager that can allow you to extend node and download modules.
```sh
git clone https://github.com/isaacs/npm.git
cd npm
sudo make install
```
### Install Ghost
Ghost is a cool blogging platform built in node.js that I think could be the future Wordpress. It is really easy to install:
```sh
curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip

unzip -uo ghost.zip -d ghost
cd /path/to/ghost
npm install —production
npm start

# or to start with forever
NODE_ENV=production forever start index.js
```

From here you have Ghost Running, the next step is to configure Ghost to work on your deployment solution. Detailed guides are [available here](http://docs.ghost.org/installation/deploy/).
### Install PHP
For some people node.js just isn't enough and they need to use Wordpress, often out of legacy. For these people I have some sympathy, and you could modify this stack to use PHP easily.
### Install Varnish
Varnish is a HTTP cache/accelerator, Combining Nginx super fast static file processing and Node's fast IO with Varnish's enhanced caching is a great recipe for speed. First install Varnish:
```sh
# via https://www.varnish-cache.org/installation/ubuntu
curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -
echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install varnish
```

# References
### [SSH Guide](tutorials/ssh.md)
### [AWS Guide](tutorials/aws.md)
### [Deploying using Github](tutorials/deploy.md)

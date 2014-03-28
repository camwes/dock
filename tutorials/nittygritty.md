Nitty Gritty Install Guide
 * [Install Nginx](#install-nginx)
 * [Install Ruby](#install-ruby)
 * [Install Node](#install-node)
 * [Install Ghost](#install-ghost)
 * [Install PHP](#install-php)

# The Nitty Gritty
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

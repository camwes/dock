# Development Environment
A developer is only as good as his/her environment. In order to be the most productive developer possible you must start by using the correct tools. When I first learned how to build websites I preferred an IDE (Adobe Dreamweaver) as my primary editor because it provided the most out-the-box functionality. I soon found my development needs outgrew Dreamweaver and eventually realized that there really is no GUI out there that is going to give you the control that you get by using command line tools. So, I started off down the path to learning linux. In order to build an efficient development environment intermediate knowledge of Linux is a sine qua non.
#### GUI v. CLI
This is not to say that the best development environment doesn't use any GUIs. Many services provide excellent GUIs which provide additional benefits and advanced features. Many developers (myself included) prefer to use non-CLI text editors (textmate, webstorm, textwrangler and coda seem to be most popular). Other developers use the Github GUI, which is capable of executing most of the available git commands. To each it's own, but when making the decision between using a GUI or CLI, consider carefully how much control you will need.

#### Customize Your Shell
Most linux machines use bash as the default shell, and if you've been using linux long enough it's likely that you have amassed an impressively large .bashrc (or .zshrc if you like me prefer the zsh shell) filled with aliases and enhancements to your shell environment. If you don't know what a .bashrc is then you should take the time to research how these files work and how they can make your life a lot easier. I would suggest perusing this:
##### [sample .zshrc](http://tldp.org/LDP/abs/html/sample-bashrc.html)
#### Install Homebrew
If you are configuring a development environment for your local machine you must install Homebrew, and it will do a lot of heavy lifting for you. Homebrew is a package managers for Mac OSX; it can install command line packages and applications and manage these installations.

Essential packages
* git (duh)
* emacs (or your favorite command line text editor)

Other useful brews:
* autojump
* geeqie
* imagesnap
* imagemagick
* tree
* tig
* wget
* htop
* mosh
* s3cmd
* s3fs
* nginx
* zsh

#### Install Ruby
Mac comes with Ruby installed. Nothing to do here... Yay! But you will need to install some important rubygems:

* [Sass](http://sass-lang.com/) is a css preprocessor 
* [Compass](http://compass-style.org/) is a utility for sass
* [Cheat](http://cheat.errtheblog.com/) is a collection of cheat sheets for popular tools
* [Ceaser](http://matthewlein.com/ceaser/) is a collection of easing transistions 

```sh
gem install sass compass cheat ceaser-easing
```

#### Install Node
Installing and running node is a fairly straightforward process. Depending on what you're building you may require a specific version of Node.js, but this tutorial assumes you're fine with using the latest version.

```sh
brew install node
# pat yourself on the back and grab a coffee
```
If you use a window's machine then go out and buy a Mac (but seriously).

#### Install Node Modules
As previously stated, Node has a great deal of modules that are easily downloaded using npm. While each web project should have it's own packages.json for installing dependencies there are a few modules that you will need to install globally:

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
As a developer I began making websites with zero server administration experience. I used commercial web hosting services that were both terribly interfaced and extremely limited (GoDaddy, Yahoo, etc.) As the sophistication of the things that I decided to build began to outgrow these services I decided that it was worth my time to learn to deploy a site using Amazon Web Services. Many of the webs most successful companies (Netflix, Tumblr, etc.) and most startups heavily rely on AWS, as it is very competitively priced. Unfortunately, for most front-end developers, learning to use these services is a daunting task. The purpose of this post is to guide a front-end engineer like myself through using AWS.
### [Designer's Guide to SSH](tutorials/ssh.md)
## AWS
There are many services that are offered by AWS, but the most important is Elastic Compute Cloud (EC2) which allows users to create their own virtual servers which are partitioned from Amazon's data servers. As a result these are some of the fastest and most reliable servers you can use. Other crucial services that you will probably use are S3 (a storage service), Route 53 (A DNS management service) and Cloudfront (a CDN). You need only use Route 53 and EC2 to get started, but I recommend becoming very familiar with these four services and the many other products that AWS offers. A basic knowledge of Unix, [SSH](ssh.md), and DNS is requisite to follow along with this post: 
### [Designer's Guide to AWS](tutorials/aws.md)
## Deploy Using Github
But getting the server set up isn't the end of server deployment. Since you are already clearly an expert at Git by now why not use git to improve your server deployment process? Git is actually an excellent tool for this, but requires a slightly more advanced usage of git and understanding of shell scripts. Follow the guide below if you're brave enough:
### [Designer's Guide to Deploying w/ Github](tutorials/deploy.md)

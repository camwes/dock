# dock - Environments made simple
A developer is only as good as his/her environment. In order to be the most productive developer possible you must start by using the correct tools. When I first learned how to build websites I preferred an IDE (Adobe Dreamweaver) as my primary editor because it provided the most out-the-box functionality. I soon found my development needs outgrew Dreamweaver and eventually realized that there really is no GUI out there that is going to give you the control that you get by using command line tools. So, I started off down the path to learning linux. In order to build an efficient development environment intermediate knowledge of Linux is a sine qua non.
#### GUI v. CLI
This is not to say that the best development environment doesn't use any GUIs. Many services provide excellent GUIs which provide additional benefits and advanced features. Many developers (myself included) prefer to use non-CLI text editors (textmate, webstorm, textwrangler and coda seem to be most popular). Other developers use the Github GUI, which is capable of executing most of the available git commands. To each it's own, but when making the decision between using a GUI or CLI, consider carefully how much control you will need.

# Development Environment
```sh
./dock dev
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
If you are configuring a development environment for a mac then you must install Homebrew, and it will do a lot of heavy lifting for you. If you use a window's machine then go out and buy a Mac (but seriously). Homebrew is a package managers for Mac OSX; it can install command line packages and applications and manage these installations. Homebrew has tons of [packages available](https://github.com/Homebrew/homebrew/tree/master/Library/Formula) and this repo installs a select view. They are listed in the [BrewFile](lib/bin/brew). My favorite formulas are:
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
Even better, brew can also install your GUI apps using brew cask. Many apps are added everyday so check out what's available [here](https://github.com/phinze/homebrew-cask/tree/master/Casks) or check out the casks installed with [this repo](lib/bin/brew).

## 4. Install Additional Dependencies
#### Install Ruby (rubygems)
Mac comes with Ruby installed. Nothing to do here... Yay! But you will need to install some important rubygems:

* [Sass](http://sass-lang.com/) is a css preprocessor 
* [Compass](http://compass-style.org/) is a utility for sass
* [Cheat](http://cheat.errtheblog.com/) is a collection of cheat sheets for popular tools
* [Ceaser](http://matthewlein.com/ceaser/) is a collection of easing transistions 

#### Install Global Node Modules
Node has a great deal of modules that are easily downloaded using npm. While each web project should have it's own packages.json for installing dependencies there are a few modules that you will need to install globally:

* [coffee-script](http://coffeescript.org/): Javascript pre-processor
* [forever](https://github.com/nodejitsu/forever): A simple CLI tool for ensuring that a given script runs continuously (i.e. forever)
* [grunt-cli](http://gruntjs.com/): A node.js automation tool
* [bower](http://bower.io/): a package manger for the web
* [node-inspector](https://github.com/node-inspector/node-inspector): An amazing plugin that allows you to use chrome devtools on server code.

You may also want to consider [yeomon](http://yeoman.io/), an application generator. This service installs works with bower and grunt but adds the benefit of basically doing what I've done in this repo and providing you with biased app structures (generators) to choose from. In due, time I will create my own Yeoman generator for this boilerplate.

#### Install LiveReload
If you've developed for a while you probably hate the process of constantly refreshing your browser once pages have been updated. This is a thing of the past with [LiveReload](http://livereload.com/). Install their app or  browser extensions. The [gruntfile.coffee](https://github.com/cdrake757/boilerplate/blob/master/gruntfile.coffee) has already been updated to enable livereload when changes are made to the static directory when you "grunt watch".

# Production Environment
As a developer I began making websites with zero server administration experience. I used commercial web hosting services that were both terribly interfaced and extremely limited (GoDaddy, Yahoo, etc.) As the sophistication of the things that I decided to build began to outgrow these services I decided that it was worth my time to learn to deploy a site using Amazon Web Services. Many of the webs most successful companies (Netflix, Tumblr, etc.) and most startups heavily rely on AWS, as it is very competitively priced. Unfortunately, for most front-end developers, learning to use these services is a daunting task.
```sh
# install prod env
./dock prod
```
Similar to the development script above, this script is designed to build a production environment for you. This script does many things, including but not limited to:
* Create Users
* Set Time Zone & Clock
* Install Dependencies
* Provision Server (Firewall, Nginx, Varnish)
* Setting up Deploy Keys
* Create Git Repository for Deployment

For more details on exactly what this script does, please refer to the [aws guide](http://labs.ohm.fm/aws/)

#### Notes:
* environment: Ubuntu 12.04 Server:
* Adding Deploy Keys to github requires copying ssh key


# [Dock](https://github.com/camwes/dock)
## Open Source Development Environment
Writing good code starts with building a rich [development environment](https://en.wikipedia.org/wiki/development_environment) using the best tools. When I began building websites I preferred an [IDE](https://en.wikipedia.org/wiki/Integrated_development_environment) (Adobe Dreamweaver, specifically) for the out-the-box functionality. My needs soon outgrew the Dreamweaver [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) and a friend of mine convinced me that to become a better programmer I should use the command line. So, I started along the path to learning linux. Today, I'm convinced that to maximize any dev environment intermediate knowledge of Linux is a sine qua non.
#### GUI v. CLI
This is not to say that the best development environment doesn't use any GUIs. Many services provide excellent GUIs which provide additional benefits and advanced features. Many developers (myself included) prefer to use non-CLI text editors (textmate, webstorm, textwrangler and coda seem to be most popular). Other developers use the Github GUI, which is capable of executing most of the available git commands. To each it's own, but when making the decision between using a GUI or CLI, consider carefully how much control you will need.

> Lets just dive in! Get started by cloning the repo https://github.com/camwes/dock

```
g clone git@github.com:camwes/dock.git ~
cd ~/dock

./dock
# will echo: Usage: dock {deploy|prod|loc|version}
```

## Localhost
```sh
./dock loc
```
To make lives easier, the above command will do everything that you need to get your development environment from zero to supercharged in ~20-30 mins. Here's what the script does:

1. Customize your shell
2. Install packages via Homebrew
3. Install apps via Cask
4. Install additional dependencies

### 1. Customize Your Shell
Dock gives you some dotfiles to really get you going, including the screenshot above (my shell is based off of this repo). The files are rsynced in the install process and is an emacs/zsh/tmux shell. Customize it as much as you want, but I like my setup.
#### [Repo Dotfiles](https://github.com/camwes/dock/tree/master/lib/dotfiles)
<img src="http://drake.fm/content/images/2014/Jun/dock.jpg" alt="dock" />

Most linux machines use bash as the default shell, and if you've been using linux long enough it's likely that you have amassed an impressively large .bashrc (or .zshrc if you like me prefer the zsh shell) filled with aliases and enhancements to your shell environment. If you don't know what a .bashrc is then you should take the time to research how these files work and how they can make your life a lot easier. I would suggest perusing this:
#### [Sample .zshrc](http://tldp.org/LDP/abs/html/sample-bashrc.html)

### 2. Install Binaries via Homebrew
If you are configuring a development environment for a mac then you must install Homebrew, and it will do a lot of heavy lifting for you. If you use a window's machine then go out and buy a Mac (but seriously). Homebrew is a package managers for Mac OSX; it can install command line packages and applications and manage these installations. Homebrew has tons of [packages available](https://github.com/Homebrew/homebrew/tree/master/Library/Formula) and this repo installs a select view. They are listed in the [BrewFile](https://github.com/camwes/dock/blob/master/lib/bin/brew). Here are a few of my favorite formulas are:

* git (duh)
* emacs (or your favorite command line text editor)
* autojump
* tree
* tig
* wget
* htop
* mosh
* zsh

### 3. Install Apps via Cask
Even better, brew can also install your GUI apps using brew cask. Many apps are added everyday so check out what's available [here](https://github.com/phinze/homebrew-cask/tree/master/Casks) or check out the casks installed with [this repo](https://github.com/camwes/dock/blob/master/lib/bin/brew).

### 4. Install Additional Dependencies
#### Install Ruby (rubygems)
Mac comes with Ruby installed. Nothing to do here... Yay! We do need to install RubyGems via [bundler](http://bundler.io/) to take full advantage of our machine. But you will need to install some important rubygems are listed below, but the Gemfile can be found [here](https://github.com/camwes/dock/blob/master/Gemfile)

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

```sh
npm install # install all modules in package.json
npm install -g node-inspector bower forever grunt-cli coffee-script
```
You may also want to consider [yeomon](http://yeoman.io/), an application generator. This service installs works with bower and grunt but adds the benefit of basically doing what I've done in this repo and providing you with biased app structures (generators) to choose from. In due, time I will create my own Yeoman generator for this boilerplate.

#### Install LiveReload
If you've developed for a while you probably hate the process of constantly refreshing your browser once pages have been updated. This is a thing of the past with [LiveReload](http://livereload.com/). Install their app or  browser extensions. The [gruntfile.coffee](https://github.com/ohmlabs/ohm/blob/master/gruntfile.coffee) can be updated to enable livereload when changes are made to the static directory when you "grunt watch".

## Production
As a developer I began making websites with zero server administration experience. I used commercial web hosting services that were both terribly interfaced and extremely limited (GoDaddy, Yahoo, etc.) As the sophistication of the things that I decided to build began to outgrow these services I decided that it was worth my time to learn to deploy a site using Amazon Web Services. Many of the webs most successful companies (Netflix, Tumblr, etc.) and most startups heavily rely on AWS, as it is very competitively priced. Unfortunately, for most front-end developers, learning to use these services is a daunting task.

```sh
# provision production server
./dock prod
```
Similar to the development script above, this script is designed to build a production environment for you. This script does many things, including but not limited to:

* Create Users
* Set Time Zone & Clock
* Install Dependencies
* Provision Server (Firewall, Nginx, Varnish, Fail2Ban)

## Git Deployment
But getting the server set up isn't the end of server deployment. Since you are already clearly an expert at Git by now why not use git to improve your server deployment process? Git is actually an excellent tool for this, but requires a slightly more advanced usage of git and understanding of shell scripts. Chances are you need a little more information than that about how github deployment works, which is also in my [devops post](http://drake.fm/devops). The script does a few things: 

* Setting up Deploy Keys
* Create Git Repository for Deployment
* Creates a working tree
```
# build git deploy (name, repo, user, branch)
./dock -n drake -u ohmlabs -r ohmlabs -b drake
```

When you have completed installation you should have the following architecture in /home/git:
```
├── staging.git
│   ├── hooks
│   │   ├── post-receive
│   │   └── pre-receive
├── production.git
│   ├── hooks
│   │   ├── post-receive
│   │   └── pre-receive
└── public
    ├── production
    └── staging
```
For the nitty gritty details on exactly what these scripts do, please refer to my [blog post](http://drake.fm/devops).

## Recommended Resources

* [Stack Overflow](http://stackoverflow.com/)
* [Quora](http://quora.com/)
* [DocHub](http://dochub.io/#css/)
* [cheat sheets](http://cheat.errtheblog.com/)
* [Github](http://github.com/camwes)



## Recommended Tools

* [Homebrew](http://mxcl.github.com/homebrew/)
* [Grunt](http://gruntjs.com/)
* [Emacs](http://www.gnu.org/software/emacs/)
* [Compass](http://compass-style.org/reference/compass/)
* [Gists](https://gist.github.com/)
* [jsFiddle](http://jsfiddle.net/)
* [TextMate](http://macromates.com/)
* [Dropbox](http://db.tt/VmtPYp51)
* [Tabifier](http://tools.arantius.com/tabifier)
* [Local Tunnel](http://progrium.com/localtunnel/)



#### Notes:
* environment: Ubuntu 12.04 Server:
* Adding Deploy Keys to github requires copying ssh key


#  SSH Aliases use ~/.ssh/config
###################
#       CD 
###################
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .-='cd -'
###################
#       LS 
###################
alias tree='tree -aCI node_modules' # remove annoying node modules, use color
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi
alias ls="pwd ; ls -laF ${colorflag}"
# all files colorized in long format
alias l="ls -lFh ${colorflag}"
# only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
alias la='ls -lAFh ${colorflag}'       #long list,show almost all,show type,human readable
alias lr='ls -tRFh ${colorflag}'       #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh ${colorflag}'       #long list,sorted by date,show type,human readable
alias ln='ln -is'         #symlink without clobbering
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
###################
#       GREP 
###################
# grep recursively case insisitive with line numbers
alias grep='grep -irn'
alias rsync='rsync -av --progress'
###################
#     General
###################
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias which="type -a"
# Pretty-print of some PATH variables:
alias path="echo -e ${PATH//:/\\n}"
alias libpath="echo -e ${LD_LIBRARY_PATH//:/\\n}"
alias h="history"
# Enable aliases to be sudo’ed
alias sudo='sudo '
# Gzip-enabled `curl`
alias gurl='curl --compressed'
# File size
alias fs="stat -f \"%z bytes\""
# Make Grunt print stack traces by default
command -v grunt > /dev/null && alias grunt="grunt --stack"
###################
#     TIME
###################
# Get week number
alias week='date +%V'
# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
###################
#     GIT additional aliases in  ~/.gitconfig
###################
alias g="hub"
alias git="hub"
alias gs='git status -s'
alias gp="git push -f origin HEAD^:master"
alias gmd='git mergetool -t opendiff'
alias gpm='git push origin master'
###################
#     Network
###################
# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"
# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
###################
#     System
###################
alias du="du -kh"
alias df="df -kTh"
alias ps='ps -efm'
# run ./dock loc
alias up='cd ~/dock; ./dock.sh -d; cd -'
# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; sudo npm update -g; sudo gem update --system; sudo gem update'
# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"
# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"
# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"
# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"
# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"
# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

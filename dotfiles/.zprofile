# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"

for file in ~/.{bash_prompt,exports,aliases,functions,extras}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

#Set the auto completion on
autoload -U compinit
compinit
 
#Lets set some options
setopt correctall
setopt autocd
setopt auto_resume
setopt promptsubst
 
## Enables the extgended globbing features
setopt extendedglob
 
#Set some ZSH styles
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

## use alt-s to insert sudo at the beginning
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

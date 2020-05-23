set -o vi
export PATH="$HOME/perl5/perlbrew/bin:$HOME/projects/ptree/bin:$PATH"
source "$HOME/perl5/perlbrew/etc/bashrc"

if which plenv > /dev/null; then eval "$(plenv init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export HISTFILESIZE=
export HISTSIZE=

export PS1="\W $ "

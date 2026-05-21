# .zshrc

export LC_ALL=en_US.UTF-8

# Source global definitions
if [ -f /etc/zshrc ]; then
	. /etc/zshrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# source the configuation files
typeset -U config_files
config_files=($HOME/.config/zsh/**.zsh)
# load the path files
for file in ${(M)config_files}
do
  source $file
done
unset config_files

export LMOD_SYSTEM_DEFAULT_MODULES="python:cray-libsci:craype-network-arises:cray-mpich:craype"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -s > ~/.ssh/agent.env
fi
[ -f ~/.ssh/agent.env ] && . ~/.ssh/agent.env > /dev/null



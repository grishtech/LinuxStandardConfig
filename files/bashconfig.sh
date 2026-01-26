#!/bin/bash

#alias
alias top='sudo bpytop'
alias ports='sudo lsof -i | grep LISTEN'
alias installk3s='curl -sfL https://get.k3s.io | sh -s - server --disable traefik --disable servicelb --disable local-storage'
alias kubectl='k3s kubectl'
alias ips='ip a'
alias space='df -hT -x tmpfs -x overlay -x squashfs'
alias ll='ls -lah'
alias updatepolicy='sudo ansible-pull -o -U https://github.com/grishtech/LinuxStandardConfig.git'
alias tmux='tmux new-session -A -s $(hostname)'

###configs

#Tmux
if [ ! -f ~/.tmux.conf ]; then echo "set -g mouse on" > ~/.tmux.conf; fi

###bash prompt

# 1. Function to find the primary IP
get_primary_ip() {
    local ip=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')
    echo "${ip:-no-ip}"
}

# 2. Define Colors
RESET='\[\e[0m\]'
ORANGE='\[\e[38;5;208m\]'
LIGHT_BLUE='\[\e[38;5;39m\]'
LIGHT_PURPLE='\[\e[38;5;141m\]'
GRAY='\[\e[38;5;245m\]'
NEUTRAL_GREEN='\[\e[38;5;108m\]'
WHITE='\[\e[1;37m\]' # Added Bold White

# Username colors
if [ "$EUID" -ne 0 ]; then
    USER_COLOR='\[\e[1;32m\]' 
else
    USER_COLOR='\[\e[1;31m\]'
fi

# 3. Prompt and Spacing Logic
build_prompt() {
    # Space AFTER output
    if [ -z "$_FIRST_PROMPT" ]; then
        _FIRST_PROMPT=true
        local PRE_PROMPT_SPACE=""
    else
        local PRE_PROMPT_SPACE="\n"
    fi

    # Space BEFORE output
    export PS0='\n'

    # --- Check for Python Virtual Env ---
    local VENV_PROMPT=""
    if [ -n "$VIRTUAL_ENV" ]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        # Changed to use WHITE color
        VENV_PROMPT="${WHITE}(${venv_name})${RESET} "
    fi
    # ------------------------------------

    # The final constructed prompt
    PS1="${PRE_PROMPT_SPACE}${VENV_PROMPT}[${USER_COLOR}\u${RESET}${GRAY}@${RESET}${ORANGE}\h${RESET} - ${LIGHT_BLUE}\$(get_primary_ip)${RESET}: ${LIGHT_PURPLE}\w${RESET}]\n${NEUTRAL_GREEN}\$${RESET} "
}

PROMPT_COMMAND=build_prompt

# Disable Python's default prompt modification
export VIRTUAL_ENV_DISABLE_PROMPT=1
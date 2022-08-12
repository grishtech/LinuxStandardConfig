#!/bin/bash
alias top='sudo bpytop'
alias ports='sudo lsof -i | grep LISTEN'
alias installk3s='curl -sfL https://get.k3s.io | sh -s - server --disable traefik --disable servicelb --disable local-storage'
alias kubectl='k3s kubectl'
alias ips='ip a'
alias space='df -hT -x tmpfs -x overlay -x squashfs'
alias ll='ls -lah'
alias updatepolicy='sudo ansible-pull -o -U https://github.com/grishtech/LinuxStandardConfig.git'
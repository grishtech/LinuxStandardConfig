#!/bin/bash
alias top='sudo bpytop'
alias ports='sudo lsof -i | grep LISTEN'
alias installk3s='curl -sfL https://get.k3s.io | sh -s - server --disable traefik --disable servicelb --disable local-storage'
alias ips='ip a'
alias space='df -hT -x tmpfs -x overlay'
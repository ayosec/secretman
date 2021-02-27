#!/bin/bash

shopt -s autocd
shopt -s checkwinsize
shopt -s globstar
shopt -s histappend
shopt -s histverify

. /etc/bash_completion

PS1='\[\e[1m\][\t | secretman] \w >\[\e[m\] '

PATH="$(dirname "${BASH_SOURCE[@]}"):$PATH"

alias ls='ls --color=auto --group-directories-first -F'

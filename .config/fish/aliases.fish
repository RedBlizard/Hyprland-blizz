# Aliases

alias btrfortune='fortune -a -s | head -n 1 | figlet | lolcat'
alias fortunecow='fortune -a -s | head -n 1 | cowsay | lolcat'
    
alias l='exa -lahF --color=always --icons --sort=size --group-directories-first'
alias ls='exa -lhF --color=always --icons --sort=size --group-directories-first'
alias lst='exa -lahFT --color=always --icons --sort=size --group-directories-first'
    
alias matrix='unimatrix -f -l ocCgGkS -s 96'
alias cmat='cmatrix -a'
alias clock='tty-clock -sct -C 4'
alias pipes='pipes.sh'
alias uni='unimatrix'
alias tty='tty-clock -c'
alias s-tui='s-tui'
alias vim='nvim'
alias reset="reset; cat ~/.cache/wal/sequences"

 
alias ll='exa -la --icons --octal-permissions --group-directories-first'
alias ls='exa --icons --group-directories-first'
alias ip='ip --color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'

#switch between bash and zsh

alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

# alias grep='grep --color=tty -d skip'

alias l='ls -Ca'
alias lr='ls -ltrh'
alias lra='ls -ltrha'
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -alFh --group-directories-first  --color=auto'
alias la='ls -A --group-directories-first --color=auto -F'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cp="cp -i"
alias rm='rm -i'
alias np='nano PKGBUILD'
alias sudoenv='sudo env PATH=$PATH'
alias xo='xdg-open &>/dev/null'
alias xsetkeyr='xset r rate 182 42'
alias tmuxkillall="tmux ls | awk '{print $1}' | sed 's/://g' | xargs -I{} tmux kill-session -t {}"
  
# some more ls aliases

alias diskspace='du -S | sort -n -r | more'
alias folders='find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn'
alias mkdir='mkdir -pv'
alias c='clear'
alias cls='clear'
alias copy='cp'
alias rename='mv'
alias del='rm'
alias install='apt-get install'
alias fuck='echo -e "Chill out man, nothing is worth being upset\n\nHere is a quote, read it:\n`fortune`"'

## even more aliases

alias update="sudo pacman -Syu"   
alias upall="yay"
alias key="sudo pacman -Syu --noconfirm"
alias ref="sudo systemctl start reflector.service"
alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias fstab="sudo nano /etc/fstab"
alias grub="sudo nano /etc/default/grub"
alias grubup="sudo update-grub"
alias syy="sudo pacman -Syy"
alias nf='cls && tput setaf 3;figlet ArchOS rolling && neofetch --ascii_colors 12 --colors 10 11 11 12 10 7'

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -c Netherlands -c Germany -l 200 -a 12 -p https  -p http --sort rate --save /etc.pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

#unlock the pacman database 
alias unlock='sudo rm /var/lib/pacman/db.lck'

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# if user is not root, pass all these commands via sudo #
    
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias hibernate='sudo systemctl hibernate'

alias ping='ping -c 5'
alias pingfast='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias wget='wget -c'
alias top="htop"

## Aliases for github

alias g='git'
#compdef g=git
alias gst='git status'
#compdef _git gst=git-status
alias gd='git diff'
#compdef _git gd=git-diff
alias gdc='git diff --cached'
#compdef _git gdc=git-diff
alias gl='git pull'
#compdef _git gl=git-pull
alias gup='git pull --rebase'
#compdef _git gup=git-fetch
alias gp='git push'
alias push='git push -v'
#compdef _git gp=git-push
alias gd='git diff'

function gdv
  git diff -w $argv | view -
end

#compdef _git gdv=git-diff
alias gc='git commit -v'
#compdef _git gc=git-commit
alias gc!='git commit -v --amend'
#compdef _git gc!=git-commit
alias gca='git commit -v -a'
#compdef _git gc=git-commit
alias gca!='git commit -v -a --amend'
#compdef _git gca!=git-commit
alias gcmsg='git commit -m'
#compdef _git gcmsg=git-commit
alias gco='git checkout'
#compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gr='git remote'
#compdef _git gr=git-remote
alias grv='git remote -v'
#compdef _git grv=git-remote
alias grmv='git remote rename'
#compdef _git grmv=git-remote
alias grrm='git remote remove'
#compdef _git grrm=git-remote
alias grset='git remote set-url'
#compdef _git grset=git-remote
alias grup='git remote update'
#compdef _git grset=git-remote
alias grbi='git rebase -i'
#compdef _git grbi=git-rebase
alias grbc='git rebase --continue'
#compdef _git grbc=git-rebase
alias grba='git rebase --abort'
#compdef _git grba=git-rebase
alias gb='git branch'
#compdef _git gb=git-branch
alias gba='git branch -a'
#compdef _git gba=git-branch
alias gcount='git shortlog -sn'
#compdef gcount=git
alias gcl='git config --list'
alias gcp='git cherry-pick'
#compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=10'
#compdef _git glg=git-log
alias glgg='git log --graph --max-count=10'
#compdef _git glgg=git-log
alias glgga='git log --graph --decorate --all'
#compdef _git glgga=git-log
alias glo='git log --oneline'
#compdef _git glo=git-log
alias gss='git status -s'
#compdef _git gss=git-status
alias ga='git add'
#compdef _git ga=git-add
alias gm='git merge'
#compdef _git gm=git-merge
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard; and git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

#remove the gf alias
#alias gf='git ls-files | grep'

alias gpoat='git push origin --all; and git push origin --tags'
alias gmt='git mergetool --no-prompt'
#compdef _git gm=git-mergetool

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
alias grt='cd (git rev-parse --show-toplevel; or echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit; and git push github master:svntrunk'
#compdef git-svn-dcommit-push=git

alias gsr='git svn rebase'
alias gsd='git svn dcommit'
#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#

function current_branch  
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo $ref | sed -e 's|^refs/heads/||'
end

function current_repository
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo (git remote -v | cut -d':' -f 2)
end

# these aliases take advantage of the previous function
alias ggpull='git pull origin (current_branch)'
#compdef ggpull=git
alias ggpur='git pull --rebase origin (current_branch)'
#compdef ggpur=git
alias ggpush='git push origin (current_branch)'
#compdef ggpush=git
alias ggpnp='git pull origin (current_branch); and git push origin (current_branch)'
#compdef ggpnp=git

# Pretty log messages
function _git_log_prettily
  if ! [ -z $1 ]; then
    git log --pretty=$1
  end
end

alias glp="_git_log_prettily"
#compdef _git glp=git-log

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress
  if git log -n 1 | grep -q -c wip; then
    echo "WIP!!"
  end
end

# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m "wip"'
alias gunwip='git log -n 1 | grep -q -c wip; and git reset HEAD~1'

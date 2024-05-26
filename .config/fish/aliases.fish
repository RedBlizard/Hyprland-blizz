# Aliases

   
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

# Remove and copy recursively
alias rmr="sudo rm -r"
alias cpr="sudo cp -r"

## even more aliases
# Pacman functions
alias s="sudo pacman -S"
alias syy="sudo pacman -Syy"
alias syu="sudo pacman -Syu"
alias syyu="sudo pacman -Syyu"
alias syyuu="sudo pacman -Syyuu"
alias rns="sudo pacman -Rns"
alias rdd="sudo pacman -Rdd"
alias remd="sudo pacman -Rsnc"

#unlock the pacman database 
alias unlock='sudo rm /var/lib/pacman/db.lck'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Cleanup install debug packages what comes with installing aur packages
alias clean="sudo ~/.config/fish/clean_up.sh"

alias update="sudo pacman -Syu"   
alias upall "$HOME/.config/fish/upall.sh"
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

# up and re to "update" and reorder mirrorlist
alias u='sudo haveged -w 1024; sudo pacman-key --init; sudo pacman-key --populate; sudo pacman-key --refresh-keys; sudo pkill haveged; sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak; sudo reflector --verbose --age 8 --fastest 128 --latest 64 --number 32 --sort rate --save /etc/pacman.d/mirrorlist; sudo pacman -Syy'
alias up='sudo pacman-key --init; sudo pacman-key --populate; sudo pacman-key --refresh-keys; sudo pacman -Syy'
alias re='sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak; sudo reflector --verbose --age 8 --fastest 128 --latest 64 --number 32 --sort rate --save /etc/pacman.d/mirrorlist'

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

# aliases git
alias blizz="git clone https://github.com/RedBlizard/Hyprland-blizz.git"
alias install="git clone https://github.com/RedBlizard/hyprland-installation.git"
alias red="git clone https://github.com/RedBlizard/bspwm-rednord.git"
alias wall="git clone https://github.com/RedBlizard/wallpapers-redblizard.git"
alias poly="git clone https://github.com/RedBlizard/polybar-rednord.git"
alias init="git init"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

alias xdg="$HOME/.config/hypr/scripts/rebuild_xdg_menu.sh"
alias idle="$HOME/.config/hypr/scripts/restart-hypridle.sh"


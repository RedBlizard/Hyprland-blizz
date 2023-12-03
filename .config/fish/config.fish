if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Aliases
    if [ -f $HOME/.config/fish/aliases.fish ]
    source $HOME/.config/fish/aliases.fish
    end
    
    # Enable the fish greeting   
    set -U fish_greeting ""
    
    # Enable neofetch or the custom bash script for getting images in neofetch
    #source ~/.config/neofetch/launch-neofetch.sh
    neofetch
    
    # If you want to use colorscript random uncomment the line below
    #colorscript random
   
    # This is needed to make pywal work with the fish shell    
    if test -e ~/.cache/wal/colors.fish
    source ~/.cache/wal/colors.fish
    end 
    #cat ~/.cache/wal/sequences    

    # Enable yay autocomplete in the fish shell
    complete -c yay -f -n '__fish_yay_search_packages'
    function __fish_yay_search_packages
    eval yay -Ssq $argv
    end
    
    ## Export variable need for qt-theme
    if type "bspwm" >> /dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME "qt5ct"
    end
    
    ## Environment setup
    # Apply .profile: use this to put fish compatible .profile stuff in
    if test -f ~/.fish_profile
    source ~/.fish_profile
    end
    
    # Add ~/.local/bin to PATH
    if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
    set -p PATH ~/.local/bin
       end
    end
    
    # The line below is needed to make starship working in the fish shell       
    starship init fish | source           
    end
    
    set -gx EDITOR nvim
    
    # set the gtk-theme / icon-theme and cursor-theme for root
    if [ $XDG_CONFIG_HOME ]
    set config "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
    else
    set config "./$HOME/.config/gtk-3.0/settings.ini"
    end

    if [ ! -f "$config" ]
    exit 1
    end

    set gnome_schema "org.gnome.desktop.interface"
    set gtk_theme (grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')
    set icon_theme (grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')
    set cursor_theme (grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')
    set font_name (grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')

    gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
    gsettings set "$gnome_schema" icon-theme "$icon_theme"
    gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
    gsettings set "$gnome_schema" font-name "$font_name"

  
    

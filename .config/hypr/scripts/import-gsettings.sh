#!/bin/sh

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

# Set GTK theme, icon theme, and cursor theme
gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" font-name "$font_name"

# Change Papirus folder colors
papirus-folders -C cat-frappe-blue --theme Papirus-Dark





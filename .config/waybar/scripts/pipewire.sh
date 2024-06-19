#!/bin/bash

set -e

# https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
snore() {
    local IFS
    [[ -n "${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
    read -r ${1:+-t "$1"} -u $_snore_fd || :
}

DELAY=0.2


while snore $DELAY; do
    WP_OUTPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

    if [[ $WP_OUTPUT =~ ^Volume:[[:blank:]]([0-9]+)\.([0-9]{2})([[:blank:]].MUTED.)?$ ]]; then
        if [[ -n ${BASH_REMATCH[3]} ]]; then
            printf "<span foreground='#E78284' font='9' weight='bold'> Muted</span>\n"
        else
            VOLUME=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))
            ICON=(
                "<span font='10'></span>"
                "<span font='10'></span>"                
                "<span font='10'></span>"
            )

            if [[ $VOLUME -gt 30 ]]; then
                printf "%s" "${ICON[0]} "
            elif [[ $VOLUME -ge 20 ]]; then  # Adjusted condition here
                printf "%s" "${ICON[1]} "   # Changed icon to show at 35%
            elif [[ $VOLUME -ge 0 ]]; then
                printf "%s" "${ICON[2]} "
            fi

            printf "$VOLUME%%\n"
        fi
    fi
done

exit 0

#! /bin/sh

check_updates() {
    updates=$(checkupdates | wc -l)

    if [ "$updates" -gt 0 ]; then
        echo " $updates"

        $0 -n &
    else
        echo ""
    fi
}

send_notification() {
    action=$(dunstify -A install,"Install Updates" "Updates Available" "Click to install" --icon=update-manager)

    case "$action" in
        "install")
            pkexec pacman -Syu --noconfirm ;;
    esac
}

while getopts 'dn' c
do
    case $c in
        d) check_updates ;;
        n) send_notification ;;
    esac
done
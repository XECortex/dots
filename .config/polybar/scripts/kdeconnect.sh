#!/usr/bin/env sh

# CONFIGURATION
LOCATION=0
YOFFSET=0
XOFFSET=0
WIDTH=25
WIDTH_WIDE=25
THEME=matcha-azul

# Color Settings of Icon shown in Polybar
COLOR_DISCONNECTED='#73bbc3c8'
COLOR_NEWDEVICE='#f5a70a'
COLOR_CONNECTED='#bbc3c8'
COLOR_BATTERY_LOW='#fc4138'

# Icons shown in Polybar
ICON_SMARTPHONE='󰄝'
ICON_TABLET='󰓷'
ICON_DESKTOP='󰍹'
SEPERATOR=''

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

show_devices () {
    IFS=$','
    devices=""
    for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)
        devicetype=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.type)
        isreach="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isReachable)"
        istrust="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isTrusted)"
        if [ "$isreach" = "true" ] && [ "$istrust" = "true" ]
        then
            battery="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid/battery" org.kde.kdeconnect.device.battery.charge)"
            icon=$(get_icon "$battery" "$devicetype")
            devices+="%{A1:$DIR/kdeconnect.sh -n '$devicename' -i $deviceid -b $battery -m:}$icon%{A}$SEPERATOR"
        elif [ "$isreach" = "false" ] && [ "$istrust" = "true" ]
        then
            devices+="$(get_icon -1 "$devicetype")$SEPERATOR"
        else
            haspairing="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.hasPairingRequests)"
            if [ "$haspairing" = "true" ]
            then
                show_pmenu2 "$devicename" "$deviceid"
            fi
            icon=$(get_icon -2 "$devicetype")
            devices+="%{A1:$DIR/kdeconnect.sh -n $devicename -i $deviceid -p:}$icon%{A}$SEPERATOR"

        fi
    done
    echo "${devices}"
}

show_menu () {
    BAT_ICON=$(get_battery_icon "$DEV_BATTERY")
    menu="$(rofi -sep "|" -dmenu -i -p "$DEV_NAME" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 4 -padding 20 -lines 5 <<< "$BAT_ICON Battery: $DEV_BATTERY%|󰽁 Ping|󰍎 Find Device|󰩍 Send File|󰝰 Browse Files|󰥍 Unpair")"
                case "$menu" in
                    *Ping) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/ping" org.kde.kdeconnect.device.ping.sendPing ;;
                    *'Find Device') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/findmyphone" org.kde.kdeconnect.device.findmyphone.ring ;;
                    *'Send File') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/share" org.kde.kdeconnect.device.share.shareUrl "file://$(zenity --file-selection)" ;;
                    *'Browse Files')
                        if "$(qdbus --literal org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/sftp" org.kde.kdeconnect.device.sftp.isMounted)" == "false"; then
                            qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/sftp" org.kde.kdeconnect.device.sftp.mount
                        fi
                        qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/sftp" org.kde.kdeconnect.device.sftp.startBrowsing
                        ;;
                    *'Unpair' ) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID" org.kde.kdeconnect.device.unpair
                esac
}

show_pmenu () {
    menu="$(rofi -sep "|" -dmenu -i -p "$DEV_NAME" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 1 -padding 20 -lines 1 <<< "󰦉 Pair Device")"
                case "$menu" in
                    *'Pair Device') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID" org.kde.kdeconnect.device.requestPair
                esac
}

show_pmenu2 () {
    menu="$(rofi -sep "|" -dmenu -i -p "$1 has sent a pairing request" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH_WIDE -hide-scrollbar -line-padding 4 -padding 20 -lines 2 <<< "󰄬 Accept|󰅖 Reject")"
                case "$menu" in
                    *'Accept') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.acceptPairing ;;
                    *) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.rejectPairing
                esac

}

#? 
#? 
#? 
#? 󰁿
#? 󰂀
#? 󰂁
#? 󰂂
#? 󰁹

get_battery_icon() {
    if [[ $1 -le 10 ]]
    then
        echo "󰂎"
    elif [[ $1 -le 20 ]]
    then
        echo "󰁺"
    elif [[ $1 -le 30 ]]
    then
        echo "󰁻"
    elif [[ $1 -le 40 ]]
    then
        echo "󰁼"
    elif [[ $1 -le 50 ]]
    then
        echo "󰁽"
    elif [[ $1 -le 60 ]]
    then
        echo "󰁾"
    elif [[ $1 -le 70 ]]
    then
        echo "󰁿"
    elif [[ $1 -le 80 ]]
    then
        echo "󰂀"
    elif [[ $1 -le 90 ]]
    then
        echo "󰂁"
    elif [[ $1 -lt 100 ]]
    then
        echo "󰂂"
    else
        echo "󰁹"
    fi
}

get_icon () {
    if [ "$2" = "tablet" ]
    then
        icon=$ICON_TABLET
    elif [ "$2" = "desktop" ]
    then
        icon=$ICON_DESKTOP
    else
        icon=$ICON_SMARTPHONE
    fi

    if [[ $1 = "-1" ]]
    then
        ICON="%{F$COLOR_DISCONNECTED}$icon%{F-}"
    elif [[ $1 = "-2" ]]
    then
        ICON="%{F$COLOR_NEWDEVICE}$icon%{F-}"
    elif [[ $1 -le 15 ]]
    then
        ICON="%{F$COLOR_BATTERY_LOW}$icon%{F-}"
    else
        ICON="%{F$COLOR_CONNECTED}$icon%{F-}"
    fi

    echo $ICON
}

unset DEV_ID DEV_NAME DEV_BATTERY
while getopts 'di:n:b:mp' c
do
    case $c in
        d) show_devices ;;
        i) DEV_ID=$OPTARG ;;
        n) DEV_NAME=$OPTARG ;;
        b) DEV_BATTERY=$OPTARG ;;
        m) show_menu  ;;
        p) show_pmenu ;;
    esac
done
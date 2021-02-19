import os
import requests

icons = {
    '01d': '󰖙',
    '01n': '󰖔',
    '02d': '󰖕',
    '02n': '󰼱',
    '03d': '󰖐',
    '03n': '󰖐',
    '04d': '󰅟',
    '04n': '󰅟',
    '09d': '󰖖',
    '09n': '󰖖',
    '10d': '',
    '10n': '',
    '11d': '󰙾',
    '11n': '󰙾',
    '13d': '󰼶',
    '13n': '󰼶',
    '50d': '󰖑',
    '50n': '󰖑'
}

# Please create a file called "weather.conf" in the polybar scripts directory
# It should contain your city id and your API key from OpenWeatherMap
# The format for this is "{city id}{api key}" (without the quotes and any spaces, everything in one line)
# Example:
#
#   1234567abc3dsj63ncsh4msj39gf023z7hf9326
#   ^      ^
#   City   API Key
#
# Check out https://openweathermap.org/api for more informations about the OpenweatherMap API

home = os.getenv('HOME')
filepath = f"{home}/.config/polybar/scripts/weather.conf"

if not os.path.isfile(filepath):
    print(f"⚠ No weather config found. Check out \"scripts/weather.py:25\"")
    exit()

file = open(filepath, 'r')

config = file.read()
city = config[:7]
key = config[7:]
url = f"https://api.openweathermap.org/data/2.5/weather?id={city}&appid={key}"

file.close()

res = requests.get(url)
icon = icons.get(res.json().get('weather')[0]['icon'], "󰼯")
temp = round(res.json().get('main')['temp'] - 273.15, 1)

print(icon, temp, "°C")
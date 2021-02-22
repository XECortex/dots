import os
import requests

path = os.path.dirname(os.path.realpath(__file__))

if not os.path.isfile(f"{path}/config.py"):
    print(f"⚠ No weather config found. Check out \"{path}/config.py\"")
    exit()
else:
    from config import *

url = f"https://api.openweathermap.org/data/2.5/weather?id={city}&appid={key}&units={units}&lang={lang}"
res = requests.get(url)
icon = icons.get(res.json().get('weather')[0]['icon'], "󰼯")
temp = round(res.json().get('main')['temp'], 1)

if res.json().get('weather')[0]['icon'].endswith('n'):
    icon_color = color_night
else:
    icon_color = color_day

print(f"%{{F{icon_color}}}" + icon + "%{F-}", temp, symbol)
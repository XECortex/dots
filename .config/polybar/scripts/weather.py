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

city = "2927043"
key = "2fe690429c0888428a37dac3d340f494"
url = f"https://api.openweathermap.org/data/2.5/weather?id={city}&appid={key}"

res = requests.get(url)
icon = icons.get(res.json().get('weather')[0]['icon'], "󰼯")
temp = round(res.json().get('main')['temp'] - 273.15, 1)

print(icon, temp, "°C")

# {
#   'coord': {
#       'lon': 9.1572,
#       'lat': 48.8087
#   },
#   'weather': [{
#       'id': 802,
#       'main': 'Clouds',
#       'description': 'scattered clouds',
#       'icon': '03d'
#   }],
#   'base': 'stations',
#   'main': {
#       'temp': 280.61,
#       'feels_like': 276.85,
#       'temp_min': 279.82,
#       'temp_max': 281.48,
#       'pressure': 1021,
#       'humidity': 81
#   },
#   'visibility': 10000,
#   'wind': {
#       'speed': 3.6,
#       'deg': 200
#   },
#   'clouds': {
#       'all': 40
#   },
#   'dt': 1613552596,
#   'sys': {
#       'type': 1,
#       'id': 1274,
#       'country': 'DE',
#       'sunrise': 1613543283,
#       'sunset': 1613580419},
#       'timezone': 3600,
#       'id': 2927043,
#       'name': 'Stuttgart Feuerbach',
#       'cod': 200
#   }
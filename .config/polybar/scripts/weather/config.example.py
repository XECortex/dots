
# Polybar python weather module configuration

# OpenWeatherMap
# 
# You can get an API key for free by registering at https://openweathermap.org/api/
# To get the id of your city, search for it on https://openweathermap.org/ and copy the last part of the URL (7 digits long)
key = "xxxxxxxxxxxxxxxxxxxxxxxx"
city = "1234567"

# Units and localization
#
# Can be "metric" or "imperial"
# You can freely choose which symbol is displayed after the temperature
units = "metric"
symbol = "°C"
# Set your language as a two-digit code
lang = "en"

# Icons
#
# Change the weather icons and the colors for day- and nighttime
icons = {
    '01d': '󰖙', # Clear sky
    '01n': '󰖔', #
    '02d': '󰖕', # Few clouds (11-25%)
    '02n': '󰼱', #
    '03d': '󰖐', # Scattered clouds (25-50%)
    '03n': '󰖐', #
    '04d': '󰅟', # Broken / Overcast clouds (51-84% / 85-100%)
    '04n': '󰅟', #
    '09d': '󰖖', # Shower rain
    '09n': '󰖖', #
    '10d': '', # Moderate / heavy rain
    '10n': '', #
    '11d': '󰙾', # Thunderstorm
    '11n': '󰙾', #
    '13d': '󰼶', # Snow
    '13n': '󰼶', #
    '50d': '󰖑', # Fog
    '50n': '󰖑'  #
}
color_day = "#f5a70a"
color_night = "#3267d1"
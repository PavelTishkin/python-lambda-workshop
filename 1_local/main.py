import os
import requests
import sys
 
from pprint import pprint

base_url = "http://api.openweathermap.org/data/2.5/weather?" 

if len(sys.argv) < 2:
    exit("Please specify city name")
city_name = sys.argv[1]

api_key = os.environ.get("API_KEY")

url = base_url + "appid=" + api_key + "&q=" + city_name + "&units=metric"
 
weather_data = requests.get(url).json()
 
print("Current weather in " + city_name +":\n")
pprint(weather_data)

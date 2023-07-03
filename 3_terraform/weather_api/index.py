import json
import os
import requests

base_url = "http://api.openweathermap.org/data/2.5/weather?"
api_key = os.environ.get("API_KEY")

def lambda_handler(event, context):

    print()
    if 'city_name' not in event.keys():
        exit("Please specify city name")

    url = base_url + "appid=" + api_key + "&q=" + event['city_name'] + "&units=metric"
     
    weather_data = requests.get(url).json()

    print(json.dumps(weather_data))

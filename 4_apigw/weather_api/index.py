import json
import os
import requests

base_url = "http://api.openweathermap.org/data/2.5/weather?"
api_key = os.environ.get("API_KEY")

def lambda_handler(event, context):

    print()
    parameters = event['queryStringParameters']
    if not parameters or 'city_name' not in parameters.keys():
        exit("Please specify city name")

    print("Retrieving weather for {}".format(parameters['city_name']))

    url = base_url + "appid=" + api_key + "&q=" + parameters['city_name'] + "&units=metric"
     
    weather_data = requests.get(url).json()

    return {
        "statusCode": 200,
        "headers": {
            'Content-Type': 'application/json',
        },
        "body": json.dumps(weather_data)
    }

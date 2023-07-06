import boto3
import os
import requests

from datetime import datetime

from botocore.exceptions import ClientError

ddb_resource = boto3.resource('dynamodb')

base_url = "http://api.openweathermap.org/data/2.5/weather?"

api_key                    = os.environ.get("API_KEY")
weatherapi_data_table_name = os.environ["DATA_TABLE_NAME"]
expiration_sec             = os.environ["EXPIRATION_SEC"]

def lambda_handler(event, context):

    print()
    if 'city_name' not in event.keys():
        exit("Please specify city name")

    url = base_url + "appid=" + api_key + "&q=" + event['city_name'] + "&units=metric"
     
    weather_data = requests.get(url).json()

    table = ddb_resource.Table(weatherapi_data_table_name)
    now = datetime.now()

    expiration_ts = int(datetime.now().timestamp()) + int(expiration_sec)

    record = {
        'dt': weather_data['dt'],
        'read_date': datetime.today().strftime('%Y-%m-%d'),
        'temp': str(weather_data['main']['temp']),
        'expiration': expiration_ts
    }

    try:
        table.put_item(Item = record)
    except ClientError as e:
        print(e.response['Error']['Message'])

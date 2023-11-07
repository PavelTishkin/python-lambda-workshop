# Weather API query script

## Description

A simple script to test our ability to communicate with OpenWeatherMap API

## Usage

Requires to have python3 installed

Before running the script, set OpenWeatherMap API key as an environment variable **API_KEY**

    export API_KEY=<MY_API_KEY>

    python3 main.py "Dublin, IE"

You should get output similar to this

```
Current weather in Dublin, IE:

{'base': 'stations',
 'clouds': {'all': 75},
 'cod': 200,
 'coord': {'lat': 53.344, 'lon': -6.2672},
 'dt': 1699395179,
 'id': 2964574,
 'main': {'feels_like': 6.08,
          'humidity': 82,
          'pressure': 1004,
          'temp': 8.27,
          'temp_max': 9.44,
          'temp_min': 6.85},
 'name': 'Dublin',
 'sys': {'country': 'IE',
         'id': 2037117,
         'sunrise': 1699342459,
         'sunset': 1699375389,
         'type': 2},
 'timezone': 0,
 'visibility': 10000,
 'weather': [{'description': 'broken clouds',
              'icon': '04n',
              'id': 803,
              'main': 'Clouds'}],
 'wind': {'deg': 160, 'speed': 3.6}}

```
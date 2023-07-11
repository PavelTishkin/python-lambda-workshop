# Weather API Lambda services

## Description

Demonstrated usage of a few AWS services by Lambda

## Architecture

![Architectural diagram](images/5_AWSServices.png)

The application consists of two parts.

API Query Lambda is triggered by a scheduled cron job and queries OpenWeatherMap API to retrieve current weather.
Trimmed results are saved to DynamoDB with a set expiration timestamp.

On the client side, an S3 bucket hosts a static single page website. When the site is loaded, a query is made to a Lambda function exposed through API Gateway. Lambda will retrieve temperature changes for the last day and return parsed data to the static website, which will in turn render data using JS libraries
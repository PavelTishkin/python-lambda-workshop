import boto3
import json
import os

from datetime import datetime
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError

ddb_resource = boto3.resource('dynamodb')

weatherapi_data_table_name = os.environ["DATA_TABLE_NAME"]

def lambda_handler(event, context):

    print()

    table = ddb_resource.Table(weatherapi_data_table_name)

    read_date = datetime.today().strftime('%Y-%m-%d')

    try:
        response = table.query(ProjectionExpression='dt,#temp',
                               IndexName='read_date-index',
                               KeyConditionExpression=Key('read_date').eq(read_date),
                               ExpressionAttributeNames={'#temp': 'temp'})

        items = sorted(response['Items'], key=lambda item: int(item['dt']))

        x_data = []
        y_data = []

        # Generate data arrays for the x,y graph
        for item in items:
            x_data.append(int(item['dt']))
            y_data.append(item['temp'])

        # Convert epoch time to relative time
        max_x = max(x_data)
        for i in range(len(x_data)):
            x_data[i] = int((x_data[i] - max_x)/60)

        chart_data = dict()
        chart_data['x'] = x_data
        chart_data['y'] = y_data

        return {
        "statusCode": 200,
        "headers": {
            'Content-Type': 'application/json',
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps(chart_data)
    }
    except ClientError as e:
        print(e.response['Error']['Message'])

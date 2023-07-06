import boto3
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
        print(response['Items'])
    except ClientError as e:
        print(e.response['Error']['Message'])

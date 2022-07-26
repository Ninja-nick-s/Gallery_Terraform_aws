import json
import boto3
import logging
import os
os.getenv('bucket_url')

logger = logging.getLogger()
client = boto3.client('s3')

def lambda_handler(event, context):
    # TODO implement
    # url = "http://imagebucketserverless.s3-website.ap-south-1.amazonaws.com/"
    url = os.environ['bucket_url']
    bucket = "imagesterraform"
    
    try:
        objects = client.list_objects(Bucket=bucket)
        response = []
        for obj in objects['Contents']:
            response.append(url+obj['Key'])
        return {'statusCode': 200, 'urls': response, 'message': "Sucessful execution"}
    except Exception as e:
        return {'statusCode': 400, 'urls': [], 'message': str(e)}

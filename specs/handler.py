import json
import datetime

def handle(event, context):
    body = {
        "message": "Hello from Scaleway Serverless!",
        "timestamp": datetime.datetime.utcnow().isoformat() + "Z"
    }
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
        "body": json.dumps(body)
    }
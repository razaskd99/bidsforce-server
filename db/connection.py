import psycopg2
import os

def get_db_connection():

    # for aws
    if "AWS_REGION" in os.environ and os.environ["AWS_REGION"]:
        conn = psycopg2.connect(
        dbname="test1",
        user="postgres",
        password="N45KJb456ub6TU2xWME7",
        host="database-1.c7iu0ws0ozdw.us-west-2.rds.amazonaws.com",
        port="5432"
        )

    # for vercel    
    elif "VERCEL_URL" in os.environ and os.environ["VERCEL_URL"]:
        conn = psycopg2.connect(
        dbname="verceldb",
        user="default",
        password="RNkArZ4sfh9H",
        host="ep-aged-dream-a41ao23e-pooler.us-east-1.aws.neon.tech",
        port="5432"
        )

    # for localhost    
    else:
        conn = psycopg2.connect(
        dbname="test1",
        user="postgres",
        password="123456",
        host="localhost",
        port="5432"
        )
            
    return conn
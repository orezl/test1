import os
import boto3
import argparse

parser = argparse.ArgumentParser()    
parser.add_argument("root_path", help = "root_path")
s3_resource = boto3.resource("s3", region_name="us-east-1")
args = parser.parse_args()  
def upload_objects():
    try:
        bucket_name = "rahulkhannatest123" #s3 bucket name

        my_bucket = s3_resource.Bucket(bucket_name)
        for subdir, dirs, files in os.walk(root_path):
            for file in files:
                full_path = os.path.join(subdir, file)
                with open(full_path, 'rb') as data:
                    bucket.put_object(Key=full_path[len(path)+1:], Body=data)
        print(" ...Success")
    except Exception as err:
        print(err)

print(args.root_path)
root_path=args.root_path+'/simple-reactjs-app/build'
upload_objects()

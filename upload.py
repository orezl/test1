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

        for path, subdirs, files in os.walk(root_path):
            path = path.replace("\\","/")
            directory_name = path.replace(root_path,"")
            for file in files:
                my_bucket.upload_file(os.path.join(path, file), directory_name+'/'+file)

    except Exception as err:
        print(err)

print(args.root_path)
root_path=args.root_path+'/simple-reactjs-app/build'
upload_objects()

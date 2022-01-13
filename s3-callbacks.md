# S3 Callbacks

VoiceBase is able to return the results of your requests into your Amazon S3 bucket
without you having to provide AWS credentials to VoiceBase. This is achieved
by providing a pre-signed URL in the callback configuration when you submit the
media for processing to us. Customers also need to give VoiceBase permissions to write to their bucket, using an IAM role.

## Permissions for VoiceBase to write to customer s3 bucket

Customers will need to give VoiceBase permission to write to their s3 bucket, and this is done by the customer creating an IAM role and then allowing VoiceBase to assume that role.

### Steps for the customer:

- Navigate to IAM Management.
- Navigate to Roles.
- Select the "Create role" button.
- Select "Another AWS Account".
- Enter the VoiceBase AWS AccountId in the AccountId field 
- Select Require external ID, and enter the organizationId of your VoiceBase account in the externalId field. (Ask VoiceBase Support for this ID)
- Select "Next: Permissions".
- Create a Policy with the following permissions:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject*",
                "s3:PutObject*",
                "s3:DeleteObject*"
            ],
            "Resource": [
                "arn:aws:s3:::[s3-bucket-name]",
                "arn:aws:s3:::[s3-bucket-name]/*"
            ]
        }
    ]
}
```
where the s3-bucket-name is the S3 bucket you want to deliver files into.

- Attach the policy to the role you're creating.
- Select "Next:Tags".
- Select "Next: review".
- Enter a role name and description.
- Select "Save".
- Use the "Role ARN" (e.g. arn:aws:iam::999533888199:role/s3-delivery-role) as the role in subsequent media post requests.

## VoiceBase Callback Configuration

When posting calls to VoiceBase for processing, you trigger S3 Delivery by including the
relevant instructions in the Callback section of the configuration document that you 
send with each API request. The following four JSON attributes are used to control S3 
Delivery:
- s3Delivery. Set to true to trigger S3 Delivery
- url. The base URL of your S3 destination bucket, without a trailing slash, for 
example: http://s3-us-east-1.amazonaws.com/your-bucket-name
- role. The ARN of the IAM Role you created earlier, for example: arn:aws:iam::999533888199:role/s3-delivery-role
- prependFolder. This value will be used to create the S3 object key for each object that 
we save to your S3 bucket. For example, if your bucket URL is "http://s3-us-east-
1.amazonaws.com/your-bucket-name" and your prependFolder value is "voicebase-
output", then VoiceBase will create S3 keys that begin with "http://s3-us-east-
1.amazonaws.com/your-bucket-name/voicebase-output/"

## How to generate a pre-signed URL with Python using Boto3

The following code shows how to generate a pre-signed URL using boto3 as the AWS client library.
Note that the "method" must be set to "PUT".

You must provide a Content-Type header with a value that matches the content type of the results
to be received. Refer to [callback](https://voicebase.readthedocs.io/en/stable/how-to-guides/callbacks.html) documentation. 

You must provide ample time between the time you create the
pre-signed URL and the expected time your processing request to VoiceBase will complete.  The
sample code expires the URL after 24 hours (86400 seconds).

_presigned.py_
```python
import boto3
import requests

# Get the service client.
session = boto3.Session(aws_access_key_id="XXX", aws_secret_access_key="XXX")
s3 = session.client('s3')

bucket = 'your-bucket-name'
objectName = 'desired/object/name/analytics.json'
mimeType = 'application/json'

# Generate the URL for a PUT of the 'desired-object-name' into 'your-bucket-name'
url = s3.generate_presigned_url(
    ClientMethod='put_object',
    Params={
        'Bucket': bucket,
        'Key': objectName,
        'ContentType' : mimeType
    },
    ExpiresIn=86400,
    HttpMethod='PUT'
   )
print url
```

Generate the presigned URL
```bash
python presigned.py
```

Use the pre-signed URL in the configuration when submitting media to the /v3 API. 

## Configuration Example

```json
  "publish": {
    "callbacks": [
      {
        "url" : "https://your-bucket-name.s3.amazonaws.com/desired/object/name/analytics.json?AWSAccessKeyId=AKIAJZZZZXSCGJXMUGGA&content-type=application%2Fjson&Expires=1499476130&Signature=UwcWOfLWLpvtj1LibHd0Na5Fw%2FM%3D",
        "type" : "analytics",
        "role":"arn:aws:iam::xxxxxxxxxx:role/s3-delivery-role",
        "prependFolder":"my_files",
        "method" : "PUT",
        "include" : [ "transcript", "knowledge", "metadata", "prediction", "streams" ]
      }
    ]
  }
```









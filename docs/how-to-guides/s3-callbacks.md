# S3 Callbacks
Sends transcription results to an S3 URL when media post is finished. 

* Send transcription and other other results to S3
* Send audio file with redacted words to S3 (Not documented)

## Setting Up S3
Before we use this feature, S3 must be configured to receive the results.

### Install S3 Tools 
Install and configure the S3cmd to give you access to the S3 environment.
```bash
> brew install s3cmd
> s3cmd --configure 

Access Key: <Access Key>
Secret Key: <Secret Key>
Default Region [US]: 
Encryption password: <provide password and remember>
Path to GPG program: <gpg folder>
Use HTTPS protocol: Y
HTTP Proxy server name: 
Test access with supplied credentials? [Y/n] n
Save settings? [y/N] y
```

### Create S3 Bucket
Create S3 bucket and verify that it exists.
```bash
> s3cmd mb s3://voicebase-dev-s3-export-sink-for-dev 
> s3cmd ls s3://voicebase-dev-s3-export-sink-for-dev
```

### Test S3, Sign URL, and create test media post curl

Test S3
```bash
> cd ~/dev
> git clone https://github.com/voicebase/voicebase-s3-export-node.git
> cd voicebase-s3-export-node
> cp s3test.mp3 .
> node index.js --config ~/.s3cfg --bucket voicebase-dev-s3-export-sink-for-dev --region us-east-1 --verbose --simulate ~/dev/voicebase-s3-export-node/s3test.mp3
******************
Source File: /Users/me/dev/voicebase-s3-export-node/s3test.mp3
Target Key: s3test.json
Pre-Signed Url: https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481659471&Signature=JEk%2FVeKJC0iTjbkvicTsdQaIHWE%3D

Simulated PUT callback for s3test to https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481659471&Signature=JEk%2FVeKJC0iTjbkvicTsdQaIHWE%3D:
          {"success":true,"warnings":[{"message":"This data for s3test is simulated, and not real."}],"callback":{"status":"simulated"},"media":{}}
          Response: 200
```

Create test media post curl
```bash
> node index.js --config ~/.s3cfg --bucket voicebase-dev-s3-export-sink-for-dev --region us-east-1 --verbose --dry-run ~/dev/voicebase-s3-export-node/s3test.mp3
******************
Source File: /Users/me/dev/voicebase-s3-export-node/s3test.mp3
Target Key: s3test.json
Pre-Signed Url: https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481659940&Signature=3aAsNXHJVdsFPSmSYJvjbES7hIM%3D

curl --header 'Authorization: Bearer $token' \
    https://apis.voicebase.com/v2-beta/media \
    --form media=@s3test.mp3 \
    --form 'configuration={"configuration":{"executor":"v2","publish":{"callbacks":[{"method":"PUT","url":"https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.mp3.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481659940&Signature=3aAsNXHJVdsFPSmSYJvjbES7hIM%3D","include":["transcripts","keywords","topics","metadata"]}]}}}'
```

Media Post Configuration
The following configuration file (callback.redact.json) was saved from the previous step:
```json
{
    "configuration":{
        "executor":"v2",
        "publish": {
            "callbacks": [ {
                "url" : "https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481588861&Signature=swJ%2FnY4qXxjqO5ST9nIeaADQWFQ%3D",
                "method" : "PUT",
                "attachments": {
                  "redactedAudio": "http://requestb.in/19mr7993323"
                }
            } ]
        }
    }
}
```

## Processing Media
### Post Media
```bash
> curl https://apis.qa.voicebase.com/v2-beta/media \
    --header "Authorization: Bearer $TOKEN" \ 
    --form media=@s3test.mp3 \
    --form 'configuration=@callback.redact.json'
```

### View Results
```bash
> s3cmd ls s3://voicebase-dev-s3-export-sink-for-dev
2016-12-13 19:04       137   s3://voicebase-dev-s3-export-sink-for-dev/s3test.mp3.json
> s3cmd get s3://voicebase-dev-s3-export-sink-for-dev/s3test.mp3.json
> cat s3test.mp3.json | jq
{
  "_links": {
    "self": {
      "href": "https://apis.qa.voicebase.com/v2-beta/media/32f388fa-330b-4c6b-8969-8b1daf34ca30"
    }
  },
  "callback": {
    "success": true,
    "warnings": [],
    "event": {
      "status": "finished"
    },
    "errors": []
  },
  "media": {
    "metadata": {
      "length": {
        "milliseconds": 5070,
        "descriptive": "5.0 sec"
      },
      "contentType": "audio/x-wav"
    },
    "keywords": {
      "words": [
        {
          "t": {
            "unknown": [
              "2.35"
            ]
          },
          "name": "beneath",
          "relevance": "5.74952226429e-19"
        }
      ]
    },
    "transcripts": {
      "srt": "1\n00:00:02,16 --> 00:00:05,07\nThis is beneath you and sometimes\nI think you'll come to an end.\n\n",
      "words": [
        {
          "p": 0,
          "s": 2160,
          "c": 0.15,
          "e": 2220,
          "w": "This"
        },
        ...
      ],
      "text": "This is beneath you and sometimes I think you'll come to an end. "
    },
    "mediaId": "32f388fa-330b-4c6b-8969-8b1daf34ca30",
    "status": "finished"
  }
}
```

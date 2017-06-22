# S3 Callbacks
Sends transcription results to an S3 URL when media post is finished. 

* Send transcription and other other results to S3
* Send audio file with redacted words to S3 (Not documented)

** Note: Export your api `TOKEN` prior to running any of the following examples.
         
```bash
export TOKEN='Your Api Token'
```

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
          {"media":{"status":"simulated"}}
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
    --form 'configuration={"publish":{"callbacks":[{"method":"PUT","url":"https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.mp3.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481659940&Signature=3aAsNXHJVdsFPSmSYJvjbES7hIM%3D","include":["transcripts","keywords","topics","metadata"]}]}}'
```

Media Post Configuration
The following configuration file (callback.redact.json) was saved from the previous step:
```json
{
    "publish": {
        "callbacks": [ {
            "url" : "https://voicebase-dev-s3-export-sink-for-dev.s3.amazonaws.com/s3test.json?AWSAccessKeyId=AKIAJM42DSXOTO53WC6Q&Content-Type=application%2Fjson&Expires=1481588861&Signature=swJ%2FnY4qXxjqO5ST9nIeaADQWFQ%3D",
            "method" : "PUT"
        } ]
    }
}
```

## Processing Media
### Post Media
```bash
> curl https://apis.qa.voicebase.com/v3/media \
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
  "mediaId": "710a4041-b78a-46ae-b626-773b90316c3b",
  "status": "finished",
  "contentType": "audio/mpeg",
  "length": 201636,
  "metadata": {},
  "knowledge": {
    "keywords": [{
      "keyword": "credit card",
      "relevance": 0.880797077978,
      "mentions": [{
        "speakerName": "unknown",
        "occurrences": [{
          "s": "60.074"
        }, {
          "s": "63.696"
        }]
      }]
    }, {
      "keyword": "phone",
      "relevance": 3.13913279205E-17,
      "mentions": [{
        "speakerName": "unknown",
        "occurrences": [{
          "s": "64.376"
        }, {
          "s": "201.41"
        }]
      }]
    }, {
      "keyword": "machines",
      "relevance": 1.56288218933E-18,
      "mentions": [{
        "speakerName": "unknown",
        "occurrences": [{
          "s": "18.809"
        }]
      }]
    }, {
      "keyword": "business",
      "relevance": 1.56288218933E-18,
      "mentions": [{
        "speakerName": "unknown",
        "occurrences": [{
          "s": "51.065"
        }]
      }]
    },{
      "keyword": "toronto",
      "relevance": 5.74952226429E-19,
      "mentions": [{
        "speakerName": "unknown",
        "occurrences": [{
          "s": "47.115"
        }]
      }]
    }],
    "topics": [{
      "topicName": "Machines",
      "relevance": 16.012355953635,
      "keywords": [ {
        "keyword": "Machine",
        "relevance": 1.0,
        "mentions": [{
          "speakerName": "unknown",
          "occurrences": [{
            "s": "18.809"
          }]
        }]
      }, {
        "keyword": "Mobile phone",
        "relevance": 0.506181823917995,
        "mentions": [{
          "speakerName": "unknown",
          "occurrences": [{
            "s": "64.376"
          }, {
            "s": "201.41"
          }]
        }]
      }]
    }]
  },
  "transcript": {
    "confidence": 0.25199372833392564,
    "words": [{
      "c": 0.263,
      "e": 1609,
      "p": 0,
      "s": 1370,
      "w": "Hi"
    }],
    "alternateFormats": [{
      "format": "dfxp",
      "contentType": "application/ttaf+xml",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "...."
    }, {
      "format": "webvtt",
      "contentType": "text/vtt",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "...."
    }, {
      "format": "srt",
      "contentType": "text/srt",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "...."
    }, {
      "format": "text",
      "contentType": "text/plain",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "...."
    }],
  "streams": [{
    "streamName": "original",
    "streamLocation": "https://media.voicebase.com/edd441bb-a1c8-4605-a0a8-0b73899d129c/710a4041-b78a-46ae-b626-773b90316c3b.mp3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20170622T193008Z&X-Amz-SignedHeaders=host&X-Amz-Expires=899&X-Amz-Credential=AKIAJGBJWCBBZHQ52U3A%2F20170622%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=99d220e89739b7179fb16e7ecaa713b538a945cc34bcf053dbbea204f30cbdcf"
  }]}
}
```

# Callbacks

VoiceBase can optionally make a callback request to a specific url when media upload processing is complete.

## Uploading Media with Callbacks Enabled

To request a processing-completed callback from VoiceBase, include a JSON configuration attachment with your media POST. The configuration attachment should contain the key:

```json

{
  "publish": {
    "callbacks": [
      {
        "url" : "https://example.org/callback",
      },
      {
        "url" : "https://example.org/callback",
        "method" : "POST",
        "include" : [ "transcript", "knowledge", "metadata", "prediction", "streams", "spotting" ]
      },
      {
        "url" : "https://example.org/callback/srt",
        "method" : "PUT",
        "type" : "transcript",
        "format" : "srt"
      },
      {
        "url" : "https://example.org/callback/media",
        "method" : "PUT",
        "type" : "media",
        "stream": "original"
      }
    ]
  }
}

```

### Configuration Description

- `publish` : object for publish-specific configuration
    - `callbacks` : array of callbacks, with one object per callback desired
        - `[n]` : callback array element
            - `url` : the https url for delivering a callback notification
            - `method` : the HTTPS method for callback delivery, with the following supported values:
                - `POST`: deliver callbacks as an HTTP POST (default)
                - `PUT`: deliver callbacks as an HTTP PUT
            - `type` : Type of results to callback
                - `analytics`: the result analytics in json format (default)
                - `transcript`: the transcript in specific format, see `format` attribute
                - `media`: the media, see `stream` attribute
            - `format` : the format of the callback of type 'transcript'
                - `json`: transcript in json format (application/json)
                - `text`: transcript in text format (text/plain)
                - `srt`: transcript in srt format (text/srt)
                - `webvtt`: transcript in webvvt format (text/vtt)
                - `dfxp`: transcript in dfxp format (application/ttaf+xml)
            - `include` :  array of data to include with the callback of type 'analytics', with the following supported values. If include is omitted the callback will return all results:
                - `metadata` : include supplied metadata, often useful for correlated to records in a different system
                - `transcript`: include transcripts for the media on all formats
                - `knowledge` : include topics and keywords for the media
                - `prediction` : include prediction information for the media based on supplied predictors
                - `spotting` : include spotted groups information for the media based on supplied keyword groups
                - `streams` : include links for the media
            - `stream` : the media stream of type 'media'
                - `original`: the original media
                - `redacted-audio`: the redacted media

The following table shows the Content-Type of the requests when we call you back with the results. This header is important if you are providing pre-signed URLs generated for a service like Amazon AWS S3

| Type       | Format | Content-Type header |
|:----------:|:------:|:-------------------:|
| analytics  |        | application/json         |
| transcript | text   |  text/plain              |
| transcript | json   | application/json         |
| transcript | srt    | text/srt                 |
| transcript | dfxp   | application/ttaf+xml	   |
| transcript | webvtt | text/vtt                 |
| media      |        | application/octet-stream |



## Example cURL Request with Callback

For example, to upload media from a local file called recording.mp3 and receive a callback at https://example.org/callback, make the following POST request using curl, or an equivalent request using a tool of your choice:

```bash

curl https://apis.voicebase.com/v3/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    --form configuration='{
          "publish": {
            "callbacks": [
              {
                "url" : "https://example.org/callback",
                "method" : "POST",
                "include" : [ "transcript", "knowledge", "metadata", "prediction", "streams" ]
              }
            ]
          }
      }'

```

When using callbacks, you can still query the status of the media processing using a GET request to /v3/media/{mediaId}.

### Callback Retry Logic

If a success response is not achieved on the first attempt, VoiceBase will do the following:

1) Retry immediately up to two times.
2) Put the callback delivery on schedule to re-attempt in 15 minutes, and the time doubled until it hits 16 hours between reattempts (in total, VoiceBase will stop after 36 hours).

If the file has not been accepted after step b) the status of the media file will change to 'finished' and VoiceBase will stop attempting.

### IP Whitelist

All egress traffic flows from our servers out through one of these three (currently) NAT gateways. The IPs are,
52.6.224.43
52.6.208.178
52.2.171.140

## Callback Data

When media processing is complete, VoiceBase will call back your specified endpoint by making an HTTPS POST request. The body is a JSON object with the following data:


```json
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

### Data Description

- `_links` : HAL metadata with a URL for the corresponding media item
    - `self` : section for the media item
        - `href` : URL for the media item
- `media` : the requested data for the media item
    - `mediaId` : the unique VoiceBase id for the media item
    - `status` : the status of processing for the media item
    - `contentType` : the media item content type
    - `length` : the media item length
    - `metadata` : the metadata for the media item, typically for correlation to external systems (present if requested when media is uploaded)
    - `transcripts` : the transcript(s) for the media (present if requested when media is uploaded)
    - `knowledge` : the topics and keywords for the media (present if requested when media is uploaded)
    - `predictions` : the predictions results for the media
    - `streams` : links for the results of the media

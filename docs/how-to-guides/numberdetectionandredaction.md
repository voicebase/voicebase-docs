# Number Detection and Redaction

Voicebase allows you to detect and optionally redact numbers from the transcript and media files.  The information is detected with approximately a ?% accuracy and defined by a beginning timestamp and ending timestamp for the detected data.  

##  Output

- Transcript
    - The JSON redaction will have the section replaced by "[redacted]"
- Audio
    - The audio redaction will play a "tone":270 and "gain":0.5

## How to Use It

### Detection Request

First, POST to /media.

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2", "transcripts":{"voiceFeatures":"true"}, "detections":[{"model":"?????"}]}}'

```

Which adds a section to the analytics output similar to the following (the s and e are start and end timestamps of the detected numbers, in milliseconds, respectively):

```json

{ 
  "latest": {
    "revision": "026ca936-0018-4c5b-8683-36cf1ff7833e",
    "predictions": [],
    "detections": [
      {
        "type": "????",
        "e": 181280,
        "s": 127830
      }
    ]
  }
}

```

### Redaction Request

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2", "transcripts":{"voiceFeatures":"true"}, \
        "detections":[{"model":"????","redact":{"transcripts":"[redacted]"}}]}}'

```

### Redaction from analytics and audio request

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2", "transcripts":{"voiceFeatures":"true"}, \
        "detections":[{"model":"????","redact":{"transcripts":"[redacted]","audio":{"tone":270,"gain":0.5}}}]}}'

```


You can use /media/{mediaid} to collect detection results. The response will be of this form:


```json
  {  
    "predictions": {
      "latest": {
        "revision": "2f7bc52d-01e4-4f8d-54f2-3c0e416c856b",
        "predictions": [],
        "detections": [
          {
            "type": "????I",
            "e": 134250,
            "s": 85240
          }
        ]
      }
    }
  }
```


If redaction is set, the transcript words will be redacted in the /media/{mediaid} response as well,


```json
{
  "w": "[redacted]",
  "e": 131080,
  "s": 130880,
  "c": 0.953,
  "p": 304
}
```


To collect the redacted audio use /v2-beta/media/{mediaid}/streams, the response will be of the form:

```json

{
  "_links": {
    "self": {
      "href": "/v2-beta/media/{mediaid}/streams"
    }
  },
  "streams": {
    "original": "<<your-link>>"
  }
}

```

where <<your-link>> contains the redacted audio file.
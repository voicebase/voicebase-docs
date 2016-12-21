# PCI, SSN, PII Redaction


Placeholder for redaction

### Redaction Request

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2", "transcripts":{"voiceFeatures":"true"}, \
        "detections":[{"model":"SSN","redact":{"transcripts":"[redacted]"}}]}}'

```

### Redaction from analytics and audio request

To redact sensitive information from a media file, upload it to Voicebase, with detections added to the configuration.

```json
{ 
    "detections": {
        "model":"SSN",
        "redact":{
            "transcripts":"[redacted]",
            "audio": {
                "tone":270,
                "gain":0.5
            }
        }
    }
}
```

TODO Explanation of the configuration.

Make a POST request to the /media resource with redaction configuration included.

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2", "transcripts":{"voiceFeatures":"true"}, \
        "detections":[{"model":"SSN","redact":{"transcripts":"[redacted]","audio":{"tone":270,"gain":0.5}}}]}}'

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


To download the redacted audio use /v2-beta/media/{mediaid}/streams, the response will be of the form:

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


##  Output

- Transcript
    - The JSON redaction will have the section replaced by "[redacted]"
- Audio
    - The audio redaction will play a "tone":270 and "gain":0.5
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


- `detections` : the detections sub-section of the configuration tree.
    - `model` : The name of the model. (TODO is this right ?)
    - `redact` : The redaction specification
        - `transcripts` : transcripts should be redacted.  The value is always `[redacted]`.  Note that this is a string literal, not an array.
        - `audio` : audio specification of the redaction
            - `tone` : TODO
            - `gain` : TODO
            
            
### Examples
            
** Note: Export your api `TOKEN` prior to running any of the following examples.

```bash
export TOKEN='Your Api Token'
```

#### Requesting Redaction and Downloading Results
         
Make a `POST` request to the `/media` resource with `redaction` configuration included.

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer ${TOKEN}" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2", "transcripts":{"voiceFeatures":"true"}, \
        "detections":[{"model":"SSN","redact":{"transcripts":"[redacted]","audio":{"tone":270,"gain":0.5}}}]}}'

```

Export your api `TOKEN` prior to running any of the following examples.

```bash
export MEDIA_ID='The mediaId returned in the POST request response'
```

Make a `GET` request on the `/media/${MEDIA_ID}` resource to collect `detection` results. The response will be of this form:

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


If `redaction` is set, the transcript words will be redacted in the `/media/${MEDIA_ID}` resource response as well,


```json
{
  "w": "[redacted]",
  "e": 131080,
  "s": 130880,
  "c": 0.953,
  "p": 304
}
```


To download the redacted audio make a `GET` request to the `/v2-beta/media/${MEDIA_ID}/streams` resource.  The response will be of the form:

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
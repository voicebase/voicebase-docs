# Aligner

Voicebase allows you to align a human edited transcript with a previously run machine-generated transcript.  

## How to Use It

First, make a POST request to the /media resource.

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2","transcripts":{"voiceFeatures":"true"}}}'

```

The response contains the mediaId you will use when aligning (e.g., 7eb7964b-d324-49cb-b5b5-76a29ea739e1, as below):

```json

{
  "_links": {
    "self": {
      "href": "/v2-beta/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1"
    }
  },
  "mediaId": "7eb7964b-d324-49cb-b5b5-76a29ea739e1",
  "status": "accepted",
  "metadata": {}
}

```

Now retrieve the text transcript by making a GET request to the /media/${mediaId} resource, where ${mediaId} equals the mediaId returned from the POST request.

```

curl -v -s https://apis.voicebase.com/v2-beta/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1/transcripts/latest \
  --header "Authorization: Bearer XXXXX" --header "Accept: text/plain"
 
```

You may receive a 404 response indicating that the alignment of the new transcript with the original transcript and the recalculation of analytics and predictions is not complete.

```json
{
    "status": 404,
    "warnings": {
        "message": "Transcripts only become available when a media item has status finished."},
    "reference":"e072fda3-d66e-48a6-9f9e-643937165e39"
}

```


When processing is complete on the media, you will receive the plain text transcript transcribed by Voicebase.  Save it to an ascii text file.  

```
Old transcript in file.
```

You notice that the names are garbled, so you edit the plain text transcript in the file with your corrections.

```
Old transcript in file.
```


Now make a POST request to the /media/${mediaId} resource as follows


```bash
curl -v -s https://apis.voicebase.com/v2-beta/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1 \
  --header "Authorization: Bearer XXXXX" \
  --X POST \
  --form 'configuration={"configuration":{ "executor":"v2"}}' \
  --form transcript=@transcript.json
```


Finally, make a GET request on the /media/${mediaId} resource to download the latest analigned transcripts and configured analytics and predictions.

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1 \
  --header "Authorization: Bearer XXXXX"
```

Note that the simple act of including a transcript with the POST triggers the alignment configuration.
# Aligner

VoiceBase allows you to align a human edited transcript with a previously run machine-generated transcript.  

## Examples

Note: Export your api token prior to running any of the following examples.

```bash
export TOKEN='Your Api Token'
```

### Correcting a machine transcript and re-processing analytics and callbacks.

First, make a POST request to the /media resource.

```bash
curl -v -s https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}" \
  --form media=@musicVoiceTone.wav \
  --form configuration='{}'

```

The response contains the mediaId you will use when aligning (e.g., 7eb7964b-d324-49cb-b5b5-76a29ea739e1, as below):

```json

  {
    "_links": {
      "self": {
        "href": "/v3/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1"
      },
      "progress": {
        "href": "/v3/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1/progress"
      },
      "metadata": {
        "href": "/v3/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1/metadata"
      }
    },
    "mediaId": "7eb7964b-d324-49cb-b5b5-76a29ea739e1",
    "status": "accepted",
    "dateCreated": "2017-06-22T18:23:02Z",
    "dateFinished": "2017-06-22T18:23:58Z",
    "mediaContentType": "audio/mp3",
    "length": 10031,
    "metadata": {}
  }

```


Export `MEDIA_ID`

```bash
export MEDIA_ID='7eb7964b-d324-49cb-b5b5-76a29ea739e1'
```

Make a request to the `/media/$MEDIA_ID/transcript/text` resource, including the `Accept: text/plain` header to retrieve the text transcript.

```bash
curl -v -s https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript/text \
  --header "Authorization: Bearer ${TOKEN}" --header "Accept: text/plain"

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

When processing is complete on the media, you will receive the plain text transcript transcribed by VoiceBase.  Save it to an ascii text file named `transcript.txt`.  

```
Old transcript in file.
```

You notice that the names are garbled, so you edit the plain text transcript in the file with your corrections.

```
New text transcript in file.
```


Now make a POST request to the `/media/${MEDIA_ID}` including a `configuration` and a `transcript` attachment.


```bash
curl -v -s https://apis.voicebase.com/v3/media/$MEDIA_ID \
  --header "Authorization: Bearer ${TOKEN}" \
  -X POST \
  --form configuration='{}' \
  --form transcript=@transcript.text
```

Finally, make a GET request on the `/media/${MEDIA_ID}` resource to download the latest aligned transcripts and configured analytics and predictions.

```bash
curl -v -s https://apis.voicebase.com/v3/media/$MEDIA_ID \
  --header "Authorization: Bearer ${TOKEN}"
```

Note that the simple act of including a transcript with the POST triggers the alignment configuration.

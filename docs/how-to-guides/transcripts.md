# Transcripts

Once processing is complete, transcripts can be retrieved in several formats.

Note: Export a mediaId and your api token prior to running any of the following examples.

```bash
export MEDIA_ID='The media id of a \
    processed media file (`status` = `finished`)'
export TOKEN='Your Api Token'
```


## JSON Transcript

Retrieve a JSON-formatted transcript with metadata using a `GET` against the `transcripts` collection under the `media` item. By convention, the transcript for most common scenarios is called `latest`.

Make a GET on the /media/$MEDIA_ID/transcripts/latest resource.

```sh
  curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" 
```

TODO Detailed description of json transcript format.

## Plain Text Transcript

To download a transcript as plain text, add an `Accept` HTTP header with the value `text/plain`.

```sh
curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/plain"
```

## SRT transcript

To retrieve a transcripts as plain text, add an `Accept` HTTP header with the value `text/srt`.

```sh
curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/srt"
```

The [closedcaptioning](closed-captioning.html) section has a detailed discussion of the SRT transcript format.
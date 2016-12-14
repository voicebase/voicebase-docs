# Transcripts

## JSON Transcript

Retrieve a JSON-formatted transcript with metadata using a `GET` against the `transcripts` collection under the `media` item. By convention, the transcript for most common scenarios is called `latest`.

In the example below, replace:
  - `$MEDIA_ID` with the media id of a processed media file (`status` = `finished`)
  - `$TOKEN` with your Bearer token

```sh
  curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" 
```

## Plain Text Transcript

To retrieve a transcripts as plain text, add an `Accept` HTTP header with the value `text/plain`.

In the example below, replace:
  - `$MEDIA_ID` with the media id of a processed media file (`status` = `finished`)
  - `$TOKEN` with your Bearer token

```sh
curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/plain"
```

## SRT transcript


To retrieve a transcripts as plain text, add an `Accept` HTTP header with the value `text/srt`.

In the example below, replace:
  - `$MEDIA_ID` with the media id of a processed media file (`status` = `finished`)
  - `$TOKEN` with your Bearer token

```sh
curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/srt"
```

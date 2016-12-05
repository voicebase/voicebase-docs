# Swearword Filter

With this feature you have the ability to filter out words deemed to be bad or swear words from the transcript output for English transcriptions. After the transcript is produced, the swear word filter will compare the transcript to the list of swear words. If a match is found the swear word will be redacted from the transcript with "..." .

Note: When the beta label is removed from the V2 platform the swear word filter will always be on with the option to turn it off.

## How to Use It

To enable swearword filtering, configure the media post configuration with the swearFilter parameter set to 'true' in "transcripts":

```json
{ "configuration":{ "executor":"v2", "transcripts":{ "engine":"premium", "swearFilter": true } } }
```

### Example

To enable the swearword filter for a media document:

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer $TOKEN" \
  --form media=@recording.mp3 \
  --form 'configuration={ "configuration":{ "executor":"v2", "transcripts":{ "engine":"premium", "swearFilter": true } }'
```

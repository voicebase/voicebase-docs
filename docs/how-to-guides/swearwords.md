# Swear Word Filter

You can filter out a preset list of offensive words ("swear words") from English transcriptions. After the transcript is produced, the swear word filter redacts words on the disallowed list with "..." .


## How to Use It

To enable the swear word filtering, configure the media post configuration with the swearFilter parameter set to `true` in the `"transcripts"` section:

```json
{ 
  "configuration": {
    "transcripts": {
      "swearFilter": true 
    }
  }
}
```

## Examples

** Note: Export your api `TOKEN` prior to running the following example.
         
```bash
export TOKEN='Your Api Token'
```

### Enable the swear word filter

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --form media=@recording.mp3 \
  --form 'configuration={ 
    "configuration": {
      "transcripts": {
        "swearFilter": true 
      }
    }
  }' \
  --header "Authorization: Bearer ${TOKEN}"
```

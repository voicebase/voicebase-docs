# Swear Word Filter

You can filter out a preset list of offensive words ("swear words") from English transcriptions. After the transcript is produced, the swear word filter redacts words on the disallowed list with "..." .


## How to Use It

To enable the swear word filtering, configure the media post configuration with the swearFilter parameter set to `true` in the `"transcript"` section:

```json
{
    "transcript": {
      "contentFiltering": {
            "enableProfanityFiltering": true
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
curl https://apis.voicebase.com/v3/media \
  --form media=@recording.mp3 \
  --form configuration='{ 
    "transcript": {
      "contentFiltering": {
            "enableProfanityFiltering": true
      }
    }
  }' \
  --header "Authorization: Bearer ${TOKEN}"
```

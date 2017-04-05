# Number Detection and Redaction

VoiceBase can detect and redact numbers from your recordings.

## Enabling Number Detection

To enable PCI detection, add the PCI detector to your configuration when POSTing to /media.

```json
{  
  "configuration": { 
    "detections": [ 
      {  
        "model": "Number"
      }
    ]
  }
}
```

### Number Detection Response

When Number detection is enabled, the predictions section of the /media resource will contain the regions where PCI is detected.

```json
{
  "detections": [
    {
      "type": "Number",
      "e": 181280,
      "s": 127830
    }
  ]
}
```

## Enabling Number Redaction

### Number Redaction Response

## Enabling Audio Redaction

## Complete Examples

```bash
curl https://apis.voicebase.com/v2-beta/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    | tee media-post-response.json | jq '.'

export MEDIA_ID=$( jq --raw-output '.mediaId' < media-post-response.json )
echo "Uploaded file with mediaId = ${MEDIA_ID}"
```
# PCI Detection and Redaction

VoiceBase can detect and redact Payment Card Information (PCI) such as credit card numbers, expiration dates, and CVVs from your recordings.

## Enabling PCI Detection

To enable PCI detection, add the PCI detector to your configuration when POSTing to /media.

```json
{  
  "configuration": { 
    "detections": [ 
      {  
        "model": "PCI"
      }
    ]
  }
}
```

### PCI Detection Response

When PCI detection is enabled, the predictions section of the /media resource will contain the regions where PCI is detected.

```json
{
  "detections": [
    {
      "type": "PCI",
      "e": 181280,
      "s": 127830
    }
  ]
}
```

## Enabling PCI Redaction

### PCI Redaction Response

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
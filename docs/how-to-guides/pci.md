# PCI Detection and Redaction

VoiceBase can detect and redact Payment Card Information (PCI) such as credit card numbers, expiration dates, and CVVs from your recordings.

## Enabling PCI Detection

To enable PCI detection, add the PCI detector to your configuration when POSTing to /v3/media.

IMPORTANT NOTE: Currently, the PCI detector requires to disable number formatting.

```json
{  
  "transcript": {
    "formatting" : {
      "enableNumberFormatting" : false
    }
  },
  "prediction": {
    "detectors": [
      { "detectorName": "PCI" }
    ]
  }
}
```

### PCI Detection Response

When PCI detection is enabled, the predictions section of the /media resource will contain the regions where PCI is detected.

```json
{  
  "prediction": {
    "detectors": [
      {
        "detectorId": "c3f8b516-5f20-43fd-a085-ec48ab4fbb59",
        "detections": [
          {
            "detectorClass": 1,
            "detectorClassLabel": "PCI",
            "detectedSegments": [
              {
                "occurrences": [
                  { "s": 362000, "e": 410055 },
                  { "s": 575390, "e": 629607 }
                ]
              }
            ]
          }
        ]
      }
    ]
  }
}
```

## Enabling PCI Redaction

### PCI Redaction Response

## Enabling Audio Redaction

## Complete Examples

```bash
curl https://apis.voicebase.com/v3/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    --form configuration='{  
      "transcript": {
        "formatting" : {
          "enableNumberFormatting" : false
        }
      },
      "prediction": {
        "detectors": [
          { "detectorName": "PCI" }
        ]
      }
    }'
    | tee media-post-response.json | jq '.'

export MEDIA_ID=$( jq --raw-output '.mediaId' < media-post-response.json )
echo "Uploaded file with mediaId = ${MEDIA_ID}"
```

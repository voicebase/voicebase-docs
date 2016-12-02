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

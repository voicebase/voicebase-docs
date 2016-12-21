# PCI, SSN, PII Detection

VoiceBase allows you to detect sensitive data in your recordings and, optionally, [redact it](pci-ssn-pii-redaction.html)) from the recordings, transcripts, and analytics.



The API offers the following three detectors for sensitive data:

- Payment Card Information (PCI) Detector
    - Detects PCI sensitive numbers, including:
        - Credit Card, Debit Card, and Payment Card numbers
        - Card expiration dates
        - CVV validation codes
- Social Security Number (SSN) Detector
    - Detects Social security numbers
- Number Detector
    - Detects numbers, to be used for Personally Identifiable Information (PII) numbers that do not fall into above categories

## Detected Regions

When detection for sensitive data is enabled, the API returns detected regions as part of analytics for the recording. For example, in a recording with two regions detected as PCI and one region detected as SSN, the analytics would contain:

```json
{  
  "predictions": {
    "latest": {
      "detections": [
        { "type": "PCI", "s": 85240, "e": 101450 },
        { "type": "PCI", "s": 130013, "e": 141711 },
        { "type": "SSN", "s": 189204, "e": 197912 }
      ]
    }
  }
}
```

For each detection, the API returns three data points:
- `type`: The type of sensitive data detected
- `s`: The start time of the detected region, in milliseconds
- `e`: The start end of the detected region, in milliseconds 

## PCI Detector

To enable it, add PCI detector to your configuration when you make a POST request to the /media resource.

```json
{  
  "configuration": { 
    "detections": [ 
      { "model": "PCI" }
    ]
  }
}
```

## SSN Detector

To enable it, add the SSN detector to your configuration when you make a POST request to the /media resource.

```json
{  
  "configuration": { 
    "detections": [ 
      { "model": "SSN" }
    ]
  }
}
```

## Number Detector

To enable it, add the Number detector to your configuration when you make a POST request to the /media resource.

```json
{  
  "configuration": { 
    "detections": [ 
      { "model": "Number" }
    ]
  }
}
```


## Examples

### Enabling the detectors

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --form media=@recording.mp3 \
  --form configuration='{
    "configuration": {
      "detections": [ 
        { "model": "PCI" },
        { "model": "SSN" },
        { "model": "Number" }
      ]
    }
  }' \
  --header "Authorization: Bearer ${TOKEN}" 
```


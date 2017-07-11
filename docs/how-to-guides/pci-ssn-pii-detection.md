# PCI, SSN, PII Detection

VoiceBase allows you to detect sensitive data in your recordings (and, optionally, [redact it](pci-ssn-pii-redaction.html)) from the recordings, transcripts, and analytics.

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
      },
      {
        "detectorId": "e79c540f-0d47-484e-859e-30d1ae6e4009",
        "detections": [
          {
            "detectorClass": 1,
            "detectorClassLabel": "ssn",
            "detectedSegments": [
              {
                "occurrences": [
                  { "s": 202293, "e": 229835 }
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

For each detection, the API returns three data points:
- `detectorName` and/or `detectorId`: The type of sensitive data detected
- `detections`: array of the detected regions
- `s`: The start time of the detected region, in milliseconds
- `e`: The start end of the detected region, in milliseconds

## PCI Detector

To enable it, add PCI detector to your configuration when you make a POST request to the /v3/media resource.

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

## SSN Detector

To enable it, add the SSN detector to your configuration when you make a POST request to the /v3/media resource.

IMPORTANT NOTE: Currently, the SSN detector requires to disable number formatting.

```json
{  
  "transcript": {
    "formatting" : {
      "enableNumberFormatting" : false
    }
  },
  "prediction": {
    "detectors": [
      { "detectorName": "SSN" }
    ]
  }
}
```

## Number Detector

To enable it, add the Number detector to your configuration when you make a POST request to the /v3/media resource.

IMPORTANT NOTE: Currently, the Number detector requires to disable number formatting.

```json
{  
  "transcript": {
    "formatting" : {
      "enableNumberFormatting" : false
    }
  },
  "prediction": {
    "detectors": [
      { "detectorName": "Number" }
    ]
  }
}
```


## Examples

** Note: Export your api `TOKEN` prior to running the following example.

```bash
export TOKEN='Your Api Token'
```

### Enabling the detectors

```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}"  \
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
      { "detectorName": "SSN" }
      { "detectorName": "Number" }
    ]}
  }'
```

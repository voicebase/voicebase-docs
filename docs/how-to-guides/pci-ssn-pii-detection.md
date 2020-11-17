# PCI, SSN, PII Detection

VoiceBase allows you to detect and/or [redact](pci-ssn-pii-redaction.html) sensitive data in your recordings, transcripts, and analytics. 

PCI and related detectors are based on machine learned models of real calls where both a caller and an agent are audible. This gives higher reliability and adaptability to real world situations than deterministic models, but also means that for accurate results the audio being processed for PCI, SSN, or PII detection must reflect a real transaction, not a test audio. An actual phone order may reflect some amount of conversation, followed by a product and quantity, the agent giving a total, asking for the card type and number, expiration date and possibly CVV code, and this is type of data the PCI and related detectors have been trained on.

In contrast, the Number Detector is rule-based and will detect any portion of the conversation containing numbers. 

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

VoiceBase offers three detectionLevel parameters within the PCI model for detection or redaction: "entireRegion", "probableNumbers", and "numbersOnly". The "entireRegion" parameter is the default if no parameters are indicated in the configuration. 

The "entireRegion" parameter detects sensitive portions of the conversation and typically will mark some buffer before and after, so some portion of the pre and post PCI interval may also show as detected or redacted.

The "probableNumbers" parameter detects the segments of the conversation containing digits within the PCI portion of the conversation, and results contain minimal buffering. While this approach is more precise than the default, it relies on recognition of the speech as numbers or words that sound sufficiently like numbers. For example, an expiration date of: 08/2017 will be redacted, but *August* 2017 will result in only the year '2017' marked as PCI. 

The "numbersOnly" parameter is similar to "probableNumbers" but there is no buffering, resulting in more of the non-PCI portions of a conversation remaining in the transcript.

## Support for Spanish

When uploading audio files in Spanish, the detectorLevel parameters are as above, but the model names are "PCI-Spanish" and "SSN-Spanish". "Number" is the model name for "Number Detector" for both English and Spanish files.

## Custom Models

VoiceBase offers [custom](https://info.voicebase.com/contact-sales) PCI or SSN models for customers who would like specialized models trained on their own data, resulting in even greater accuracy than our standard model. 

## Detected Regions

When detection for sensitive data is enabled, the API returns detected regions as part of analytics for the recording. For example, in a recording with two regions detected as PCI and one region detected as SSN, the analytics would contain:

```json
{  
  "prediction": {
    "detectors": [
      {
        "detectorId": "abcdefg-1f10-11f2-a085-ec48ab4fbb59",
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

To enable it, add PCI detector and optional detectionLevel parameter to your configuration when you make a POST request to the /v3/media resource. 

IMPORTANT NOTE: Currently, the PCI detector requires number formatting to be disabled.

```json
{  
  "transcript": {
    "formatting" : {
      "enableNumberFormatting" : false
    }
  },
  "prediction": {
      "detectors": [{
        "detectorName": "PCI",
        "parameters": [{
          "parameter": "detectionLevel",
          "value": "probableNumbers"
        }]
   }]
 }
}
```

## SSN Detector

To enable it, add the SSN detector to your configuration when you make a POST request to the /v3/media resource.

IMPORTANT NOTE: Currently, the SSN detector requires number formatting to be disabled.

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

IMPORTANT NOTE: Currently, the Number detector requires number formatting to be disabled.

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

Sample configuration
--------------------

Please see notes below for details about specific lines.



.. code-block:: json
  :linenos:
  :emphasize-lines: 4, 6, 7, 35, 38, 43, 44, 48, 51, 56, 63

  {
    "speechModel": {
      "language": "en-US",
      "features": [  "advancedPunctuation"  ]
    },
    "ingest": {
      "stereo": {
        "left": {
          "speakerName": "Agent"
        },
        "right": {
          "speakerName": "Caller"
        }
      }
    },
    "prediction": {
      "detectors": [
        {
          "detectorName": "PCI",
          "redactor": {
            "transcript": {
              "replacement": "[redacted]"
            },
            "audio": {
              "tone": 270,
              "gain": 0.5
            }
          }
        }
      ]
    },
    "spotting": {
      "groups": [
        {
            "groupName": "finance"
        },
        {
            "groupName": "databases"
        }
      ]
    },
    "knowledge": {
        "enableDiscovery": true,
        "enableExternalDataSources": true
    },
    "transcript": {
        "formatting": {
          "enableNumberFormatting": true
        },
        "contentFiltering": {
          "enableProfanityFiltering": true
        }
    },
    "vocabularies": [
      {
        "vocabularyName": "earningsCalls"
      },
      {
        "terms": [
          {
            "term": "VoiceBase",
            "soundsLike": [ "voice base" ],
            "weight": 1
          },
          {
            "term": "Bob Okunski"
          },
          {
            "term": "Chuck Boynton"
          },
          {
            "term": "Tom Werner"
          }
        ]
      }
    ],
    "publish": {}
  }

Notes:

- line 4 (``"features": [  "advancedPunctuation"  ]``): Advanced Punctuation is supported in v3 US English only.
- line 6 (``"ingest": {``): speakerName and stereo are mutually exclusive
- line 7 (``"stereo": {``): for mono scenarios, specify ``"speakerName": "Speaker"`` instead of ``stereo`` - all channels will be mixed into a single audio channel prior to speech recognition processing
- line 35 (``"groupName": "finance"``): this spotting group must be created before it is used
- line 38 (``"groupName": "databases"``): this spotting group must be created before it is used
- line 43 (``"enableDiscovery": true``): Default is false - knowledge discovery is disabled by default
- line 44 (``"enableExternalDataSources": true``): Default is true - only effective if enableDiscovery is true
- line 48 (``"enableNumberFormatting": true``): Default is true
- line 51 (``"enableProfanityFiltering": true``): Default is false
- line 56 (``"vocabularyName": "earningsCalls"``): this vocabulary must be created before it is used
- line 63 (``"weight": 1``):  weights range from 0 to 5, 0 being standard weight

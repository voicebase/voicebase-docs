Sample configuration
--------------------

Please see notes below for details about specific lines.



.. code-block:: json
  :linenos:
  :emphasize-lines: 4, 6, 7, 35, 40, 45, 48, 53, 60

  {
    "speechModel": {
      "language": "es-US",
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
              "tone": 170,
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
        }
      ]
    },
    "knowledge": {
        "enableDiscovery": true
     
    },
    "transcript": {
        "formatting": {
          "enableNumberFormatting": false
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
            "term": "Malala Yousafzai"
          }
        ]
      }
    ],
    "publish": {
    "enableAnalyticIndexing" : true
    }
  }

Notes:

- line 4 (``"features": [  "advancedPunctuation"  ]``): Advanced Punctuation is supported in English and Spanish only.
- line 6 (``"ingest": {``): speakerName and stereo are mutually exclusive
- line 7 (``"stereo": {``): for mono scenarios, specify ``"speakerName": "Speaker"`` instead of ``stereo`` - all channels will be mixed into a single audio channel prior to speech recognition processing
- line 35 (``"groupName": "finance"``): this spotting group must be created before it is used
- line 40 (``"enableDiscovery": true``): Default is false - knowledge discovery is disabled by default
- line 45 (``"enableNumberFormatting": false``): Default is true
- line 48 (``"enableProfanityFiltering": true``): Default is false
- line 53 (``"vocabularyName": "earningsCalls"``): this vocabulary must be created before it is used
- line 60 (``"weight": 1``):  weights range from 0 to 5, 0 being default weight
- line 69 (``"enableAnalyticIndexing" : true``): this publishes the media file to the Analytic Workbench

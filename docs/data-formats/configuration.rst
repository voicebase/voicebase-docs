Sample configuration
--------------------

Please see notes below for details about specific lines.



.. code-block:: json
  :linenos:
  :emphasize-lines: 5,6,34,37,42,43,47,50,55,62

  {
    "speechModel": {
      "language": "en-US"
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

- line 5 (``"ingest": {``): speakerName and stereo are mutually exclusive
- line 6 (``"stereo": {``): for mono scenarios, specify ``"speakerName": "Speaker"`` instead of ``stereo`` - all channels will be mixed into a single audio channel prior to speech recognition processing
- line 34 (``"groupName": "finance"``): this spotting group must be created before it is used
- line 37 (``"groupName": "databases"``): this spotting group must be created before it is used
- line 42 (``"enableDiscovery": true``): Default is false - knowledge discovery is disabled by default
- line 43 (``"enableExternalDataSources": true``): Default is true - only effective if enableDiscovery is true
- line 47 (``"enableNumberFormatting": true``): Default is true
- line 50 (``"enableProfanityFiltering": true``): Default is false
- line 55 (``"vocabularyName": "earningsCalls"``): this vocabulary must be created before it is used
- line 62 (``"weight": 1``):  weights range from 0 to 5, 0 being standard weight

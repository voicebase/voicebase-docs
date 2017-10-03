# Moving to the v3 API

We have made a lot of changes to the VoiceBase API to improve readability and usability by our customers. If you are accustomed to using the version 2 API, there are some changes you will need to be aware of as you create code for the VoiceBase API version 3.


## Changes to Defaults

* Number formatting is now *on* by default in v3.  - We thought users would appreciate phone numbers, dates, times, dollar amounts being formatted instead of spelled out.
* Knowledge (system generated keywords and topics) is *off* by default in v3.  - This feature is powerful, but not always useful. Rather than give a bunch of extra data in the JSON, we thought returning transcripts faster would be preferred in v3. *You can always run Knowledge later* if you decide to use this feature by using the new [reprocessing](reprocessing.md) feature.

## Changes to Formatting
* All time values are reported in milliseconds for consistency
* File type and length are no longer contained in the metadata object, permitting the entirety of the metadata object to contain user-created metadata.

## Changes to the Configuration File
* Configuration is no longer wrapped in a ‘configuration’ object.
* Metadata is not wrapped in a ‘metadata’ object in the config file - it is now form field in the POST body or its own resource: https://apis.voicebase.com/v3/media/{{mediaId}}/metadata

*Note:* Posting media from a URL must specify ‘mediaURL’ instead of ‘media’ in the media POST. This allows better error validation.


### Languages
are now set under ‘speechModel’

v3:

```json
{
    "speechModel": {
        "language" : "en-US"
    }
}
```

v2-beta:

```json
{
    "configuration": {
        "language" : "en-US"
    }
}
```

### Stereo
Is now set under ‘stereo’ instead of ‘ingest’ and speaker is set by ‘speakerName’ instead of ‘speaker’

v3:

```json
{
    "ingest": {
        "stereo" : {
            "left" : { "speakerName": "Customer" },
            "right": { "speakerName": "Agent" }
        }
    }
}
```

v2-beta:

```json
{
    "configuration": {
        "ingest" : {
            "channels" : {
                "left" : {
                    "speaker" : "Customer"
                },
                "right" : {
                    "speaker" : "Agent"
                }
            }
        }
    }
}
```

### PCI Detection & Redaction
Is now set under 'prediction', 'detectors'
Clarifying that PCI detection and redaction relies on the machine-learning prediction models and adding specificity to what is being executed as part of the request.
PCI model is now specified under "detectorName", rather than model, clarifying that "PCI" is the name of the data detector.
"redact" has been renamed "redactor", clarifying that the contained object is configuration for the media redactor.

v3:

```json
{
    "prediction": {
        "detectors": [ {
            "detectorName" : "PCI",
            "redactor": {
                "transcript": { "replacement": "[redacted]" },
                "audio" : { "tone": 270, "gain": 0.5 }
            }
        } ]
    }
}
```

v2-beta:

```json
{
    "detections": [ {
        "model" : "PCI",
        "redact" : {
            "transcripts": "[redacted]",
            "audio": {
                "tone": 270,
                "gain": 0.5
            }
        }
    } ]
}
```

### Keyword Spotting
Is now set under ‘spotting’ not ‘keywords’ and groups have a key of ‘groupName’.
*Note:* This allows you to create a Keyword Spotting Group and populate it from within the configuration.

v3:

```json
{
    "spotting": {
            "groups": [ { "groupName": "data-science", "keywords": ["array", "of", "keywords"] } ]
    }
}
```

v2-beta:

```json
{
    "configuration" : {
        "keywords": {
            "groups": {
              [ "data-science" ]
            }
        }
    }
}
```

*NOTE:* v2-beta requires that the 'data-science' Keyword group already be created. The above v2-beta example merely calls it for use. For steps on configuring keywork groups in v2-beta, see: [keyword groups](http://voicebase-dev.readthedocs.io/en/v2-beta/how-to-guides/keyword-spotting.html)

### Number Formatting
Is now set under ‘transcript’, ‘formatting’ and no longer under ‘transcripts’.
The key is now ‘enableNumberFormatting’ instead of ‘formatNumbers’ to keep syntax similar to other v3 options.
*Note:* Number formatting is enabled by default in the v3 API, so enabling it in the configuration file is not necessary. You may set 'enableNumberFormatting' to 'false' do not wish to use the formatter on your transcripts.

v3:

```json
{
    "transcript": {
        "formatting": {
            "enableNumberFormatting": true
        }
    }
}
```

v2-beta:

```json
{
    "configuration": {
        "transcripts": {
            "formatNumbers": true
        }
    }
}
```

### Swear Word Filter
Is now set under ‘transcript’, ‘contentFiltering’ not ‘transcripts’
The key is now ‘enableProfanityFiltering’ instead of ‘swearFilter’

v3:

```json
{
    "transcript": {
        "contentFiltering": {
            "enableProfanityFiltering": true
        }
    }
}
```

v2-beta:

```json
{
    "configuration": {
        "transcripts": {
            "swearFilter": true
        }
    }
}
```


### Custom Vocabulary
Is now set under ‘vocabularies’ instead of ‘transcripts’,’vocabularies’ and terms now have a key ‘term’ and the value is the custom vocabulary term.

v3:

```json
{
    "vocabularies": [ {
        "terms": [ { "term": "Bryon" }, { "term": "VoiceBase"} ]
    } ]
}
```

v2-beta:


```json
{
  "configuration": {
    "transcripts": {
      "vocabularies": [
        {
          "terms": [ "Bryon", "VoiceBase" ]
        }
      ]
    }
  }
}
```

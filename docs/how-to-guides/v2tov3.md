# Moving to the v3 API

The /v3 API is an updated API “dialect” you can use to interact with the VoiceBase platform. /v3 joins /v2-beta as the currently supported API dialects for the VoiceBase platform. The /v3 API dialect incorporates a wide range of improvements and suggestions from our customers, and should be easier to learn and easier to use.
We recommend that you migrate your apps to /v3 in order to take advantage of the new improvements and upcoming new features. If you are accustomed to using the /v2 API, the new /v3 API will look familiar, but with some changes you will need to be aware of as you migrate your code. The changes are outlined below, or you can instead review the entire sample
[media](/en/v3/data-formats/media.html) response.


## Changes to Defaults

* Number formatting is now *on* by default in v3.  - We thought users would appreciate phone numbers, dates, times, dollar amounts being formatted instead of spelled out. You can of course turn off number formatting if you choose. See: [number formatting](number-formatting.html).
* Knowledge (system generated keywords and topics) is *off* by default in v3.  This feature is powerful, but may not be required for your use case. Rather than give a bunch of extra data in the JSON, we thought returning transcripts faster would be preferred in v3. *You can always run Knowledge later* if you decide to use this feature by using the new [reprocessing](reprocessing.html) feature.

## Changes to Formatting
* All duration values are reported in milliseconds for consistency
* File type and length have been moved the metadata object to the top-level response object, permitting the entirety of the metadata object to contain only user-created metadata.

## Changes to the Configuration File
* Configuration is no longer wrapped in a ‘configuration’ object.
* Metadata is not wrapped in a ‘metadata’ object in the config file - it is now form field(s) in the POST body.

*Note:* Posting media from a URL must specify ‘mediaURL’ instead of ‘media’ in the media POST. This allows better error validation.


### Languages
Languages are now configured under ‘speechModel’

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
Stereo is now configured under ‘stereo’ instead of ‘ingest’ and speaker is set by ‘speakerName’ instead of ‘speaker’

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
PCI Detection & Redaction is now configured under 'prediction', 'detectors'
Clarifying that PCI detection and redaction rely on the machine-learning prediction models and adding specificity to what is being executed as part of the request.
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
Keyword Spotting is now configured under ‘spotting’ not ‘keywords’ and groups have a key of ‘groupName’.

v3:

```json
{
    "spotting": {
      "groups": [ { "groupName": "data-science" } ]
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

*NOTE:* v3 and v2-beta require that the 'data-science' Keyword group already be created. The above example merely calls it for use. For steps on configuring keyword groups in v2-beta, see:[keyword groups](/en/v3/how-to-guides/keyword-spotting.html)

For steps on configuring keyword groups in v2-beta, see: [keyword groups](/en/v2-beta/how-to-guides/keyword-spotting.html)

### Number Formatting
Number Formatting is now configured under ‘transcript’, ‘formatting’ and no longer under ‘transcripts’.
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
Swear Word Filter is now configured under ‘transcript’, ‘contentFiltering’ not ‘transcripts’
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
Custom Vocabulary is now configured under ‘vocabularies’ instead of ‘transcripts’,’vocabularies’ and terms now have a key ‘term’ and the value is the custom vocabulary term.

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

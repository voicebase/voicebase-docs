Sample configuration
--------------------

Note: You will need to remove comments preceded by '//'


.. code-block:: json
  :linenos:

    {
        "speechModel": {
            "language": "en-US"
        },
        "priority": "low | medium | high",

        "ingest" {
            // speakerName, stereo and channels are mutually exclusive.
            "speakerName": "Speaker", // All channels will be mixed into a single audio channel prior to speech recognition processing
            "stereo": { // This is a shortcut to specify an "channels" with 2 elements (Is it worth to provide this shortcut?)
                "left": {
                    "speakerName": "Agent"
                },
                "right": {
                    "speakerName": "Caller"
                }
            },
        },
        "prediction": {
            "classifiers": [{
                    "classifierId": "f95a01b8-bc62-4a97-920a-61460ca7837c"
                }, {
                    "classifierName": "Appointment-Made"
                }, {
                    "classifierName": "Interested-Customer"
                }
            ]
            "detectors": [{
                    "detectorName": "PCI"
                    "redactor": {
                        "transcript": {
                            "replacement": "[redacted]"
                        },
                        "audio": {
                            "tone": 270,
                            "gain": 0.5
                        }
                    }
                }, {
                    "detectorId": "dc37f348-82a8-4c50-88e1-4eaa916e779b"
                }
            ]
        },

        "spotting": {
            "groups": [{
                    "groupName": "finance"
                }, {
                    "groupName": "databases"
                }
            ]
        },
        "knowledge": {
            "enableDiscovery": true | false, // Default is false
            "enableExternalDataSources": true | false // Only has effect if enableDiscovery is true. Default is true.
        },
        "transcript": {
            "formatting": {
                "enableNumberFormatting": true // Default is true.
            }
            "contentFiltering": {
                "enableProfanityFiltering": true // Default is false
            }
        },
        {
            "vocabularies": {
                "recognition": [{
                        "vocabularyName": "earningsCalls"
                    }, {
                        "terms": [{
                                "term": "VoiceBase",
                                "soundsLike": [ "voice base" ],
                                "weight": 1 //0 to 5. 0 being standard weight.
                            }, {
                                "term": "Bob Okunski"
                            }, {
                                "term": "Chuck Boynton"
                            }, {
                                "term": "Tom Werner"
                            }
                        ]
                    }
                ]
            }
        }
        "vocabularies": [],
        "publish": {}
    }

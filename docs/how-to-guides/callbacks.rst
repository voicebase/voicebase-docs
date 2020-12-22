Callbacks
=========

VoiceBase can optionally make a callback request to a specific url when
media upload processing is complete.

Uploading Media with Callbacks Enabled
--------------------------------------

To request a processing-completed callback from VoiceBase, include a
JSON configuration attachment with your media POST. The configuration
attachment should contain the publish key, for example as below:

  *Notes:*

  - Each callback in the set below will result in a unique call to the specified server upon media completion.
  - If "type" is not specified: "analytics" is assumed and all sections will be included (transcript, knowledge, metadata, prediction, streams, spotting)

.. code:: json


    {
      "publish": {
        "callbacks": [
          {
            "url" : "https://example.org/callback"
          },
          {
            "url" : "https://example.org/callback",
            "method" : "POST",
            "include" : [ "knowledge", "metadata", "prediction", "spotting", "streams", "transcript", "metrics", "speakerSentiments", "conversation", "categories", "messages" ]
          },
          {
            "url" : "https://example.org/callback/vtt",
            "method" : "PUT",
            "type" : "transcript",
            "format" : "webvtt"
          },
          {
            "url" : "https://example.org/callback/srt",
            "method" : "PUT",
            "type" : "transcript",
            "format" : "srt"
          },
          {
            "url" : "https://example.org/callback/media",
            "method" : "PUT",
            "type" : "media",
            "stream": "original"
          }
        ]
      }
    }

Configuration Description
~~~~~~~~~~~~~~~~~~~~~~~~~

-  ``publish`` : object for publish-specific configuration

   -  ``callbacks`` : array of callbacks, with one object per callback
      desired

      -  ``[n]`` : callback array element

         -  ``url`` : the https url for delivering a callback
            notification
         -  ``method`` : the HTTPS method for callback delivery, with
            the following supported values:

            -  ``POST``: deliver callbacks as an HTTP POST (default)
            -  ``PUT``: deliver callbacks as an HTTP PUT

         -  ``type`` : Type of results to callback

            -  ``analytics``: the result analytics in json format
               (default)
            -  ``transcript``: the transcript in specific format, see
               ``format`` attribute
            -  ``media``: the media, see ``stream`` attribute

         -  ``format`` : the format of the callback of type 'transcript'

            -  ``json``: transcript in json format (application/json)
            -  ``text``: transcript in text format (text/plain)
            -  ``webvtt``: transcript in webvvt format (text/vtt)
            -  ``srt``: transcript in srt format (text/srt)
            -  ``dfxp``: transcript in dfxp format
               (application/ttaf+xml)

         -  ``include`` : array of data to include with the callback of
            type 'analytics', with the following supported values. If
            "include" is omitted the callback will return all sections:

            -  ``metadata`` : include supplied metadata, often useful
               for correlated to records in a different system
            -  ``transcript``: include transcripts for the media on all
               formats.
            -  ``knowledge`` : include topics and keywords for the media
            -  ``prediction`` : include prediction information for the
               media based on supplied predictors
            -  ``spotting`` : include spotted groups information for the
               media based on supplied keyword groups
            -  ``streams`` : include links for the media

         -  ``stream`` : the media stream of type 'media'

            -  ``original``: the original media
            -  ``redacted-audio``: the redacted media

The following table shows the Content-Type of the requests when we call
you back with the results. This header is important if you are providing
pre-signed URLs generated for a service like Amazon AWS S3

============= ======== ====================
Type          Format   Content-Type header
============= ======== ====================
analytics        -     application/json
transcript      text   text/plain
transcript      json   application/json
transcript      srt    text/srt
transcript      dfxp   application/ttaf+xml
transcript     webvtt  text/vtt
media            -     application/octet-stream
============= ======== ====================

If the media fails to be processed, you will only receive the callbacks of type "analytics" describing the error that prevented the media from being processed.
Callbacks of type "transcript" and "media" will be ignored.

Example cURL Request with Callback
----------------------------------

For example, to upload media from a local file called recording.mp3 and
receive a callback at https://example.org/callback, make the following
POST request using curl, or an equivalent request using a tool of your
choice:

.. code:: bash


    curl https://apis.voicebase.com/v3/media \
        --header "Authorization: Bearer $TOKEN" \
        --form media=@recording.mp3 \
        --form configuration='{
              "publish": {
                "callbacks": [
                  {
                    "url" : "https://example.org/callback",
                    "method" : "POST",
                    "include" : [ "transcript", "knowledge", "metadata", "prediction", "streams" ]
                  }
                ]
              }
          }'

When using callbacks, you can still query the status of the media
processing using a GET request to /v3/media/{mediaId}.

Callback Retry Logic
~~~~~~~~~~~~~~~~~~~~

If a success response is not achieved on the first attempt, VoiceBase will retry
the callback URL provided according to the following schedule until a success
response or the schedule ends:

============= ===================== =========================
Retry number  Time since last retry Time since initial try
============= ===================== =========================
1             Immediate             0
2             Immediate             <1 min
3             Immediate             <1 min
4             15 min                15 min
5             30 min                45 min
6             1 hour                1 hour  45 min (105 min)
7             2 hours               3 hours 45 min (223 min)
8             4 hours               7 hours 45 min (465 min)
9             8 hours               15 hours 45 min (945 min)
============= ===================== =========================

IP Whitelist
~~~~~~~~~~~~

For VoiceBase US all egress traffic flows from our servers out through one of these three
(currently) NAT gateways. The IPs are, 52.6.244.43, 52.6.208.178, 52.2.171.140

For VoiceBase EU all egress traffic flows from our servers out through one of these three
(currently) NAT gateways. The IPs are, 34.248.80.158, 52.210.18.246, 54.72.141.175

Callback Data
-------------

When media processing is complete, VoiceBase will call back your
specified endpoint by making an HTTPS POST request. The body is a JSON
object with the following data:

.. code:: json


 {
  "_links": {},
  "formatVersion": "3.0.7",
  "mediaId": "efbb8c49-87f0-4f6c-9ce9-781599918f8c",
  "accountId": "710d1652-63a4-4355-8e9a-523ddacd3066",
  "accountName": "ACME Inc",
  "status": "finished",
  "dateCreated": "2017-04-28T21:12:55.563Z",
  "dateFinished": "2018-07-19T11:34:45.134Z",
  "timeToLiveInSeconds": 1200,
  "expiresOn": "2018-10-04T00:41:06.145Z",
  "metadata": {
    "title": "Inbound call 2018-07-01 from 15081231234",
    "description": "Inbound call to 1-800-599-1234, ACME Support Center",
    "externalId": "inbound-dd9e7002-4a5a-43b3-bd46-73a66362db29",
    "extended": {
      "anything": "goes here",
      "nested": {
        "is": 0,
        "also": 0,
        "accepted": 0
      }
    }
  },
  "mediaContentType": "audio/mpeg",
  "length": 66900, // Duration in ms of the audio
  "knowledge": {
    "keywords": [
      {
        "keyword": "Microsoft",
        "relevance": 0.433,
        "mentions": [
          {
            "speakerName": "Speaker 1",
            "occurrences": [
              {
                "s": 34234,
                "e": 34234,
                "exact": "Microsoft"
              }
            ]
          }
        ]
      }
    ],
    "topics": [
      {
        "topicName": "Algorithms",
        "relevance": 0.4353,
        "subtopics": [],
        "keywords": []
      }
    ]
  },
  "spotting": {
    "groups": [
      {
        "groupName": "Competitors",
        "spotted": false,
        "score": "0.4439",
        "spottedKeywords": [
          {
            "keyword": "Microsoft",
            "relevance": 1,
            "mentions": [
              {
                "speakerName": "Speaker 1",
                "occurrences": [
                  {
                    "s": 34234,
                    "e": 34234,
                    "exact": "Microsoft"
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  },
  "prediction": {
    "classifiers": [
      {
        "classifierId": "3e8dee45-ae2a-432f-b5ff-aa2513986f23",
        "classifierName": "SaleCompleted",
        "classifierVersion": "1.0",
        "classifierDisplayName": "Sales Completed",
        "classifierType": "binary",
        "predictedClassLabel": "completed",
        "predictionScore": 0.929,
        "predictedClass": 1
      }
    ],
    "detectors": [
      {
        "detectorId": "99179da8-2ef4-4478-92d0-f296399a90b7",
        "detectorName": "PCI",
        "detectorVersion": "1.0",
        "detectorDisplayName": "Detects credit card data",
        "detectorType": "binary",
        "detections": [
          {
            "detectorClass": 1,
            "detectorClassLabel": "pci",
            "detectedSegments": [
              {
                "speakerName": "Speaker 1",
                "occurrences": [
                  {
                    "s": 34322,
                    "e": 458375
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  },
  "metrics": [
    {
      "metricGroupName": "groupX",
      "metricValues": [
        {
          "metricName": "xyz",
          "metricValue": 200
        }
      ]
    }
  ],
  "categories": [
    {
      "categoryName": "abc",
      "categoryValue": 0
    }, {
      "categoryName": "def",
      "categoryValue": 1,
      "categoryMatches": [
        {
          "speakerName": "caller",
          "occurrences": [
            {
              "s": 24251,
              "e": 24981,
              "exact": "hello"
            }, {
              "s": 26491,
              "e": 30571,
              "exact": "hi"
            }
          ]
        }, {
          "speakerName": "agent",
          "occurrences": [
            {
              "s": 24251,
              "e": 24981,
              "exact": "greetings"
            }, {
              "s": 26491,
              "e": 30571,
              "exact": "how are you"
            }
          ]
        }
      ]
    }
  ],
  "conversation": {
    "speakerVerbNounPairs": [
      {
        "speakerName": "Agent",
        "verbNounPairs": [
          {
            "s": 6679,
            "e": 7260,
            "verb": "call",
            "noun": "team"
          }, {
            "s": 44279,
            "e": 45099,
            "verb": "have",
            "verbNeg": "not",
            "noun": "question"
          }, {
            "s": 807908,
            "e": 808918,
            "verb": "like",
            "noun": "service",
            "question": true
          }
        ]
      }, {
        "speakerName": "Caller",
        "verbNounPairs": [
          {
            "s": 16250,
            "e": 17340,
            "verb": "need",
            "noun": "help"
          }, {
            "s": 901234,
            "e": 902786,
            "verb": "provide",
            "noun": "justification",
            "nounNeg": "no"
          }, {
            "s": 1002560,
            "e": 1003010,
            "verb": "work",
            "verbNeg": "not",
            "noun": "internet"
          }
        ]
      }
    ]
  },
  "speakerSentiments": [
    {
      "speakerName": "Caller",
      "sentimentValues": [
        {
          "s": 4558,
          "e": 7064,
          "v": -0.5434
        }, {
          "s": 9373,
          "e": 10345,
          "v": 0.7039
        }
      ]
    }, {
      "speakerName": "Agent",
      "sentimentValues": [
        {
          "s": 7464,
          "e": 9373,
          "v": 0.4328
        }, {
          "s": 12937,
          "e": 14627,
          "v": -0.3294
        }
      ]
    }
  ],
  "transcript": {
    "confidence": 1.0,
    "words": [
      {
        "p": 3,
        "c": 0.845,
        "s": 13466,
        "e": 15648,
        "m": "turn|punc",
        "v": 34,
        "w": "supercalifragilisticexpialidocious",
        "frq": [
          {
            "e": 1.344,
            "f": 234.0
          }, {
            "e": 2.344,
            "f": 340.0
          }
        ]
      }
    ],
    "voiceActivity": [
      {
        "speakerName": "Speaker 1",
        "occurrences": [
          {
            "s": 13000,
            "e": 150547
          }, {
            "s": 163746,
            "e": 258726
          }
        ]
      }
    ],
    "alternateFormats": [
      {
        "format": "srt",
        "contentType": "text/srt",
        "contentEncoding": "base64",
        "charset": "utf-8",
        "data": "A Base64 encoded transcript"
      }
    ]
  },
  "streams": [
    {
      "status": "HTTP Status of the stream. Are we using this?",
      "streamName": "original",
      "streamLocation": "https://somewhere.voicebase.com/xyzt&amp;expires=12344",
    }
  ],
  "encryption": {
    "publishKeyId": "11e13265-e688-428b-b7bb-708c12a30a41",
    "publicKeyHash": "A SHA256"
  }
}

Data Description
~~~~~~~~~~~~~~~~

-  ``_links`` : HAL metadata with a URL for the corresponding media item

   -  ``self`` : section for the media item

      -  ``href`` : URL for the media item

-  ``media`` : the requested data for the media item

   -  ``mediaId`` : the unique VoiceBase id for the media item
   -  ``status`` : the status of processing for the media item
   -  ``mediaContentType`` : the media item content type
   -  ``length`` : the media item length
   -  ``metadata`` : the metadata for the media item, typically for
      correlation to external systems (present if requested when media
      is uploaded)
   -  ``transcript`` : the transcript(s) for the media (present if
      requested when media is uploaded)
   -  ``knowledge`` : the topics and keywords for the media (present if
      requested when media is uploaded)
   -  ``predictions`` : the predictions results for the media
   -  ``streams`` : links for the results of the media

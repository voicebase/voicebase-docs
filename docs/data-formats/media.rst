media
-----

Below is a sample of the media response.


.. code-block:: json
  :linenos:

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


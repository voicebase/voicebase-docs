# Stereo

When a recording is in stereo, where each speaker is recorded in one of the
channels, a better transcript can be obtained by instructing VoiceBase to process
each channel independently.

## Enabling stereo transcription

To enable transcription per channel, add the "ingest" configuration when POSTing
to /media and specify the label to use for each channel.

```json
{
  "configuration": {
      "ingest":
      {
        "channels":
        {
          "left":
          {
            "speaker": "Customer"
          },
          "right":
          {
            "speaker": "Agent"
          }
        }
      }
  }
}
```

## Effects on Transcripts

When stereo processing is enabled, the word-by-word JSON transcript will contain
additional nodes indicating the change of turn on the speaker. These nodes are
identified by the attribute "m" set to "turn" and the attribute "w" set to the
speaker's label provided in the configuration for one of the channels. The words
following a turn node belong to the speaker identified by it until a new turn
node appears in the transcript.

```json
  "transcripts": {
    "latest": {
      "revision": "775b7de7-d6f2-4447-b1d4-67fd87a06db9",
      "engine": "standard",
      "confidence": 0.9585561312642723,
      "words": [
          {
            "p": 176,
            "s": 55893,
            "c": 0.574,
            "e": 56103,
            "w": "street"
          },
          {
            "p": 177,
            "s": 57353,
            "c": 1,
            "e": 58163,
            "w": "Agent",
            "m": "turn"
          },
          {
            "p": 178,
            "s": 57353,
            "c": 0.346,
            "e": 57483,
            "w": "what's"
          }
     ]
   }
 }
```

The plain text version of the transcript will show each segment of the conversation
prefixed with the speaker name (E.g. 'Agent:' or  'Customer')

```bash
curl -v   https://apis.voicebase.com/v2-beta/media/${MEDIA_ID}/transcripts/latest \
        --header "Authorization: Bearer $TOKEN" \
        --header "Accept: text/plain"
```

---
**Agent:** Well this is Michael thank you for calling A.B.C. cable services.
How may I help you today. **Customer:** Hi I'm calling because I'm interested
in buying new cable services from my home but I want to know what your different
packages are and what the different prices are **Agent:** OK great guest to
start up.  Do you have an existing cable provider you currently using. **Customer:**
Yeah I am using Dish Network for T.V. and I have eighteen T for my internet but
I want to move to a service that has both of them for a low price.

---


The SRT version of the transcript will also contain the speaker names provided in
the configuration.

```bash
curl -v   https://apis.voicebase.com/v2-beta/media/${MEDIA_ID}/transcripts/latest \
        --header "Authorization: Bearer $TOKEN" \
        --header "Accept: text/srt"
```

```
1
00:00:02,76 --> 00:00:05,08
Agent: Well this is Michael
thank you for calling A.B.C.

2
00:00:05,08 --> 00:00:07,03
Cable services. How may I help you today.

3
00:00:08,28 --> 00:00:11,93
Customer: Hi I'm calling because I'm
interested in buying new cable services from

4
00:00:11,93 --> 00:00:16,43
my home but I want to know what your different
packages are and what the different

5
00:00:16,43 --> 00:00:17,01
prices are

6
00:00:18,20 --> 00:00:22,54
Agent: OK great guest to start up. Do
you have an existing cable provider you

7
00:00:22,54 --> 00:00:23,16
currently using.

8
00:00:23,34 --> 00:00:27,25
Customer:. Yeah I am using
Dish Network for T.V.

9
00:00:27,25 --> 00:00:31,09
And I have eighteen T for my
internet but I want to move to

10
00:00:31,09 --> 00:00:34,66
a service that has both
of them for a low price.
```

Note that When a configuration includes a callback, the document posted contains
not only the JSON word-by-word transcription, but also the plain text and SRT
transcripts.

## Effects on Keywords and Topics

When processing a file in stereo, you will get keywords and topics detected
independently on each channel. For example, the start time of a keyword on a
recording processed as a single channel would appear under the "unknown" label:

```json
{
"keywords": {
   "latest": {
     "revision": "775b7de7-d6f2-4447-b1d4-67fd87a06db9",
     "words": [
          {
            "t": {
              "unknown": [
                "5.09",
                "10.92",
                "234.55",
                "282.243"
              ]
            },
            "name": "cable service",
            "relevance": "0.952574126822"
          }
      ]
    }
  }
}
```
When the recording is processed in stereo, the start time appear under each speaker's
label specified in the configuration:

```json
  ...
   "keywords": {
      "latest": {
        "revision": "775b7de7-d6f2-4447-b1d4-67fd87a06db9",
        "words": [
          {
            "t": {
              "Customer": [
                "10.921"
              ],
              "Agent": [
                "5.08",
                "234.55",
                "282.239"
              ]
            },
            "name": "cable service",
            "relevance": "0.880797077978"
          }
        ]
      }
    }
```

A similar change occurs on the reporting of topics.
```json
              {
                "internalName": [
                  "contract"
                ],
                "score": 0.594602944702319,
                "t": {
                  "Customer": [
                    "208.263"
                  ],
                  "Agent": [
                    "211.81",
                    "219.16"
                  ]
                },
                "name": "Contract"
              }
```

## Effects on Audio Redaction

Audio redaction of PCI will redact the audio in both channels regardless of what channel
the PCI detected data occurred.

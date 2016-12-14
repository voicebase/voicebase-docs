# Stereo

Recording and processing conversations (such a phone calls) in stereo can significant improve transcription accuracy and analytical insight. To realize the benefit, each speaker is recorded on a different channel (left or right), and the speaker metadata is provided to VoiceBase when uploading the recording.

## Enabling stereo transcription

To enable one speaker per channel stereo transcription, add the "ingest" configuration when POSTing to /media and specify the label to use for each channel.

```json
{
  "configuration": {
    "ingest": {
      "channels": {
        "left": {
          "speaker": "Customer"
        },
        "right": {
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
{
  "transcripts": {
    "latest": {
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
            "w": "what"
          }
      ],
      "confidence": 0.958
    }
  }
}
```

The plain text version of the transcript will show each segment of the conversation prefixed with the speaker name (e.g. 'Agent:' or  'Customer')

```bash
curl https://apis.voicebase.com/v2-beta/media/${MEDIA_ID}/transcripts/latest \
    --header "Accept: text/plain" \
    --header "Authorization: Bearer ${TOKEN}" 
```

---
**Agent:** Well this is Michael thank you for calling A.B.C. cable services.
How may I help you today. 

**Customer:** Hi I'm calling because I'm interested in buying new cable service.

**Agent:** OK great let's get started.  

...

---


The SRT version of the transcript will also contain the speaker names provided in
the configuration.

```bash
curl https://apis.voicebase.com/v2-beta/media/${MEDIA_ID}/transcripts/latest  \
    --header "Accept: text/srt" \
    --header "Authorization: Bearer ${TOKEN}"
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
interested in buying new cable services.

4
00:00:12,64 --> 00:00:16,43
Agent: OK great let's get started.

```

## Effects on Keywords and Topics

When processing a file in stereo, you will get keywords and topics detected
independently on each channel. For example, the start time of a keyword on a
recording processed as a single channel would appear under the "unknown" label:

```json
{
  "keywords": {
    "latest": {
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
          "relevance": "0.953"
        }
      ]
    }
  }
}
```

When the recording is processed in stereo, the start time appears under each speaker's label specified in the configuration:

```json
{
  "keywords": {
    "latest": {
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
          "relevance": "0.881"
        }
      ]
    }
  }
}
```

A similar change occurs in the topics data .
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

Audio redaction of PCI will redact the audio in both channels, irrespective of which channel contains the detected PCI data.

## Examples

### Processing in Stereo
```bash
curl https://apis.voicebase.com/v2-beta/media  \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
        "ingest": {
          "channels": {
            "left": {
              "speaker": "Customer"
            },
            "right":
            {
              "speaker": "Agent"
            }
          }
        }
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```

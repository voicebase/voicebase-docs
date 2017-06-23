# Stereo

Recording and processing conversations (such a phone calls) in stereo can significantly improve transcription accuracy and analytical insight. To realize the benefit,  each speaker is recorded on a different channel (left or right), and the speaker metadata is provided to VoiceBase when uploading the recording.

## Enabling stereo transcription

To enable one speaker per channel stereo transcription, add the "ingest" configuration when making a POST request to the /media resource and specify the label to use for each channel.

```json
{
  "ingest": {
    "stereo": {
       "left": { "speaker": "Customer" },
      "right": { "speaker": "Agent"    }
    }
  }
}
```

    - `ingest` : the ingest sub-section.
        - `stereo` : specification of the stereo channels.  Both child sections are required.
            - `left` : specification of the left channel.
                - `speaker` : the name of left channel speaker.
            - `right` : specification of the right channel.
                - `speaker` : the name of right channel speaker.


## Effects on Transcripts

When stereo processing is enabled, the word-by-word JSON transcript will contain additional nodes indicating the change of turn on the speaker. These nodes are identified by the attribute "m" set to "turn" and the attribute "w" set to the speaker's label provided in the configuration for one of the channels. The words following a turn node belong to the speaker identified by it until a new turn node appears in the transcript.

```json
{
  "transcript" : {
    "confidence": 0.958,
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
    ]
  }
}
```

The plain text version of the transcript will show each segment of the conversation prefixed with the speaker name (e.g. 'Agent:' or  'Customer')

```bash
curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/transcript/text \
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
curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/transcript/srt  \
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
independently on each channel. The occurrences of the keywords are grouped by
speaker.

```json
{
  "knowledge": {
    "keywords": [
      {
        "name": "cable service",
        "relevance": "0.953",
        "mentions": [
          {
            "speakerName" : "Agent",
            "occurrences" : [
                { "s" : 5090, "e": 6070, "exact": "cable service" }
              ]
          },
          {
            "speakerName" : "Customer",
            "occurrences" : [
                { "s" : 234550, "e": 235700, "exact": "cable product" },
                { "s" : 347567, "e": 349000, "exact": "cable services" }
              ]
          }
        ]
      }
    ]
  }
}
```

## Effects on Audio Redaction

Audio redaction of PCI will redact the audio in both channels, irrespective of which channel contains the detected PCI data.

## Examples

### Processing in Stereo
```bash
curl https://apis.voicebase.com/v3/media  \
    --form media=@recording.mp3 \
    --form 'configuration=
      "{
        "ingest": {
          "stereo": {
            "left" : { "speaker": "Customer" },
            "right": { "speaker": "Agent"    }
          }
        }
      }' \
    --header "Authorization: Bearer ${TOKEN}"
```

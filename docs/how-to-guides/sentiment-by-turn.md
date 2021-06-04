# Sentiment by Turn

## Overview

Sentiment by Turn allows the user to track sentiment between the caller and agent on stereo calls. For more value, Sentiment by Turn may be configured with [Verb-Noun Pairs](verb-noun.html) so the user can understand the topical drivers of positive and negative sentiment.


## Prerequisites for Use

- Calls MUST be processed in [stereo](stereo.html)  for agent and caller specific metrics (otherwise, these metrics always return 0)
- The `Agent` SHOULD have a speaker name that is one of: `Agent`, `Service`, `Representative`, `Operator`, `Salesperson`, `CallCenter`, `ContactCenter`
- The `Caller` SHOULD have a speaker name that is one of: `Caller`, `Client`, `Customer`, `Prospect`
- If the speaker names are not specified as above, the first speaker is assumed to be the agent, and the second speaker is assumed to be the caller 
- [Advanced Punctuation](formatting.html) MUST be enabled.
- English and Spanish are the only supported [languages](languages.html) for this feature.

## Configuration

```json
{
  "speechModel": {
    "language": "es-US",
    "features": [  "advancedPunctuation"  ]
  },
  "ingest": {
    "stereo": {
       "left": { "speakerName": "Caller" },
      "right": { "speakerName": "Agent"    }
    }
  },
   
   "speakerSentiments":true

}
```

## Output

```json
{ 
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
  ]
}
```

The sample output above contains the fields `s`,`e`,and `v`, which are outputs from the VoiceBase sentiment engine. Their definitions are as follows:

- `s`: The start timestamp of the segment in milliseconds
- `e`: The end timestamp of the segment in milliseconds
- `v`: The sentiment score assigned to the segment 

 For more information on sentiment values, see [Conversation Metrics](conversation-metrics.html).

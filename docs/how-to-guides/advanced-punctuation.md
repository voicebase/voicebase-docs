# Advanced Punctuation

VoiceBase enables you to apply an advanced punctuation engine to the English language transcripts output from the VoiceBase speech engine. The English transcripts will have a more thorough application of periods and include commas as well as question marks.

## Using Advanced Punctuation

To enable advanced punctuation, set in the `configuration`'s `speechModel` section, include `"advancedPunctuation"` in the `features` array when make a call to `POST /media`.

```json
{
  "speechModel": {
    "features": [
        "advancedPunctuation"
    ]
  }
}
```

The `configuration` contains the following fields:
- `speechModel`: speech model section
- `features`: speech model features to enable

## Advanced Punctuation Results

Results of advanced punctuation are included with responses from `GET /v3/media/{mediaId}` API, and in callbacks. The punctuation uses the same format, appears in the `transcript`'s `words` array with a value of `punc` in the `m` (metadata) field. Advanced Punctuation augments and improves the usage of `.`, `,`, and `?`.

For example:

```json
{
  "mediaId": "bc14632d-e81b-4673-992d-5c5fb6573fb8",
  "status": "finished",
  "dateCreated": "2017-06-22T19:18:49Z",
  "dateFinished": "2017-06-22T19:19:27Z",
  "mediaContentType": "audio/x-wav",
  "length": 10031,
  "transcript": {
     "words":[
        {
          "p":0,
          "s":700,
          "c":0.1,
          "e":3000,
          "w":"agent",
          "m":"turn"
        },
        {
          "p":1,
          "s":700,
          "c":0.537,
          "e":870,
          "w":"Hello"
        },
        {
          "p":2,
          "s":900,
          "c":0,
          "e":900,
          "w":",",
          "m":"punc"
        },
        {
           "p":3,
           "s":950,
           "c":0.1,
           "e":990,
           "w":"How"
        },
        {
           "p":4,
           "s":1020,
           "c":0.975,
           "e":1060,
           "w":"are"
        },
        {
          "p":5,
          "s":1070,
          "c":0.975,
          "e":1120,
          "w":"you"
        },
        {
          "p":6,
          "s":1300,
          "c":0,
          "e":1300,
          "w":"?",
          "m":"punc"
        }
     ]
  }
}
```

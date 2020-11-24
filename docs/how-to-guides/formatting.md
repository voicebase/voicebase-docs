# Formatting and Punctuation

Formatting for US phone numbers and digits is enabled by default, though you may optionally disable it.

Additional punctuation may be added to your US-English transcript by adding the correct tag to your configuration.

## Advanced Punctuation

By default VoiceBase transcripts provide minimal formatting, and you may optionally include an additional advanced formatting feature.
Advanced Punctuation may be added to your transcripts by including `"advancedPunctuation"` in the `features` array of your config file.

Please note that Advanced Punctuation is only available for US-English at this time.

```json
{
  "speechModel" : {
        "language": "en-US",
        "features" : [  "advancedPunctuation"  ]
  }
}
```
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



## Number Formatting

VoiceBase can transcribe numbers found in the transcription be displayed in digit form. Number formatting is enabled by default.

To explicitly disable number-formatting, include the following snippet in your configuration:

```json
{  
   "transcript": {  
      "formatting":{  
         "enableNumberFormatting": false
      }
   }
}
```

Number formatting allows options for transcription preference around phone numbers, currency, addresses, and more. The current version transcribes number words to symbols and US phone number formatting.

For example, with number formatting disabled, a transcript might read:

>"**Agent:** The total of your bill comes to one hundred thirty eight dollars and sixty five cents"

When number formatting is enabled it will read:

>"**Agent:** The total of your bill comes to $138.65"

Additionally, VoiceBase can detect phone numbers and format them into a US phone number format within the transcript.

With number formatting disabled, a plain-text transcript will look like:

>"Hi this is Brian from VoiceBase please give me a call back at six five zero eight nine seven five one seven zero thank you."


A plain-text transcript with number formatting enabled:

>"Hi this is Brian from VoiceBase please give me a call back at 650-897-5170 thank you."

And an excerpt of the number-formatted JSON response:

For simplicity the following keys & respective values have been omitted - start time ('s'), end time ('e'), confidence ('c').

```json
          {
            "p": 12,
            "w": "call"
          },
          {
            "p": 13,
            "w": "back"
          },
          {
            "p": 14,
            "w": "at"
          },
          {
            "p": 15,
            "w": "650-897-5170"
          },
```
As you can see in the JSON response, the phone number will be returned in one word value with the time-stamp beginning at the first digit said and ending at the last digit.

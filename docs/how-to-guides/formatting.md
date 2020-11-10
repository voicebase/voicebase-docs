# Formatting and Punctuation

In v3, formatting for US phone numbers and digits is enabled by default, though you may optionally disable it.

Additional punctuation may be added to your US-English transcript by adding the correct tag to your configuration.

## Advanced Punctuation

By default VoiceBase transcripts include minimal formatting, though v3 includes features for more robust transcript formatting.
Advanced Punctuation may be added to your transcripts by adding the following feature to your config file.

Please note that Advanced Punctuation is only available for US-English at this time.

```json
{
  "speechModel" : {
        "language": "en-US",
        "features" : [  "advancedPunctuation"  ]
  }
}
```



## Number Formatting

VoiceBase can transcribe numbers found in the transcription be displayed in digit form. In v3, number formatting is enabled by default.

To explicitly enable number-formatting, include the following snippet in your configuration:

```json
{  
   "transcript": {  
      "formatting":{  
         "enableNumberFormatting": true
      }
   }
}
```

Number formatting allows options for transcription preference around phone numbers, currency, addresses, and more. The current version transcribes number words to symbols and US phone number formatting.

For example, with a default configuration, a transcript might read:

>"**Agent:** The total of your bill comes to one hundred thirty eight dollars and sixty five cents"

When number formatting is enabled it will read:

>"**Agent:** The total of your bill comes to $138.65"

Additionally, VoiceBase can detect phone numbers and format them into a US phone number format within the transcript.

Without number formatting enabled, a plain-text transcript will look like:

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

# Voice Features

VoiceBase enables you to generate information regarding the volume, energy and
frequency of each word in the transcripts output from the VoiceBase speech engine.

## Using Voice Features

To enable voice features, set in the `configuration`'s `speechModel` section, include `"voiceFeature"` in the `features` array when make a call to `POST /media`.

```json
{
  "speechModel": {
    "features": [
        "voiceFeatures"
    ]
  }
}
```

The `configuration` contains the following fields:
- `speechModel`: speech model section
- `features`: speech model features to enable

## Voice Features Results

When you GET the media results, the response will add to the per word results an array, `“frq”` that includes the frequency, `“f”` and energy, `“e”` values for the dominant and secondary peaks for the word and a volume, `“v”` value for the word.

`“f”` is the frequency in Hertz. The maximum value is 8khz or 16khz depending on the format that was provided.

`“e”` is the relative energy (amplitude) of the frequency. The value will be between 0 and 1.

`“v”` is the relative volume. The higher the louder. Volume is determined by a formula where `v = A * M`. A is the average between the words timing and the frequencies amplitude and M is the maximum amplitude value from any frequency and spectrum frames within the words. The value can be unlimited but it is mostly between 0 and 2. Any value greater than 2 can be cropped to 2.

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
            "p": 0,
            "s": 1880,
            "c": 0.461,
            "frq": [
              {
                "e": 1,
                "f": 260.942
              },
              {
                "e": 0.347,
                "f": 521.807
              }
            ],
            "e": 2180,
            "v": 14.876,
            "w": "Because"
          }
     ]
  }
}
```

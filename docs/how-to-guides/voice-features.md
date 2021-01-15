# Voice Features

This optional feature returns a set of per-word metrics, used in data science to serve as input attributes to a predictive model.
Voice Features is supported for all regions of English as well as US and Latin American Spanish.

## Uses for Voice Features

Voice Features metrics may be used in multiple ways. One example would be determining that a caller raised their voice and spoke at a higher pitch during a call, suggesting they may be upset. Making this determination requires that you process these per-word metrics to: 1) Create a function that transforms per-word metrics into utterance or time-leveled metrics  2) Gather baseline values for the caller 3) Track changes over time relative to the baseline  4) Set thresholds, and assign meaning to them.  

## Enabling Voice Features

Enable Voice Features by including `"voiceFeatures"` in the `features` array under `speechModel` when making a call to `POST /media`.

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

When you GET the media results, the response will include the `“frq”` array, populated with `“f”`(frequency),`“e”`(energy), and `“v”`(volume) values for  each word. 

`“f”` is the frequency in Hertz,computed from the dominant and secondary peaks of each word. The maximum value is 8khz or 16khz, depending on submitted audio.

`“e”` is the relative energy (amplitude) of the frequency. The value will be between 0 and 1.

`“v”` is the relative volume. Volume is determined by a formula where `v = A * M`. A is the average between the words timing and the frequencies amplitude and M is the maximum amplitude value from any frequency and spectrum frames within the words. The value can be unlimited but it is typically between 0 and 2. Any value greater than 2 can be cropped to 2.

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

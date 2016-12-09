# Aligner

Voicebase allows you to align a human edited transcript with a previously run machine-generated transcript.  

## How to Use It

First, POST to /media.

```bash
curl -v -s https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer XXXXX" \
  --form media=@musicVoiceTone.wav \
  --form 'configuration={"configuration":{ "executor":"v2","transcripts":{"voiceFeatures":"true"}}}'

```

The response contains the mediaId you will use when aligning (e.g., 7eb7964b-d324-49cb-b5b5-76a29ea739e1, as below):

```json

{
  "_links": {
    "self": {
      "href": "/v2-beta/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1"
    }
  },
  "mediaId": "7eb7964b-d324-49cb-b5b5-76a29ea739e1",
  "status": "accepted",
  "metadata": {}
}

```

Secondly, when the previous job is finished, retrieve the words section of the transcript using GET /media/{mediaId} once the first job is complete.  Edit it.  And save it to a file named transcript.json. 

```json
[
  {
    "p": 0,
    "s": 2160,
    "c": 0.148,
    "frq": [
      {
        "e": -0.114,
        "f": 0
      },
      {
        "e": 0,
        "f": 0
      }
    ],
    "e": 2220,
    "v": 23.603,
    "w": "This"
  },
  {
    "p": 1,
    "s": 2220,
    "c": 0.759,
    "frq": [
      {
        "e": 0.239,
        "f": 87.033
      },
      {
        "e": 0.459,
        "f": 124.299
      }
    ],
    "e": 2350,
    "v": 28.883,
    "w": "is"
  },
  {
    "p": 2,
    "s": 2350,
    "c": 0.786,
    "frq": [
      {
        "e": 0.848,
        "f": 87.033
      },
      {
        "e": 0.176,
        "f": 347.897
      }
    ],
    "e": 2560,
    "v": 29.286,
    "w": "between"
  },
  {
    "p": 3,
    "s": 2560,
    "c": 0.153,
    "frq": [
      {
        "e": 1,
        "f": 285.787
      },
      {
        "e": 0.376,
        "f": 559.073
      }
    ],
    "e": 2850,
    "v": 19.618,
    "w": "you"
  },
  {
    "p": 4,
    "s": 2850,
    "c": 0.445,
    "frq": [
      {
        "e": 0.396,
        "f": 248.52
      },
      {
        "e": 1,
        "f": 484.54
      }
    ],
    "e": 3110,
    "v": 35.714,
    "w": "and"
  },
  {
  }
]
```


Then one would make a POST to /media/{mediaId} as follows:


```bash
curl -v -s https://apis.voicebase.com/v2-beta/media/7eb7964b-d324-49cb-b5b5-76a29ea739e1 \
  --header "Authorization: Bearer XXXXX" \
  --X POST \
  --form 'configuration={"configuration":{ "executor":"v2"}}' \
  --form transcript=@transcript.json
```


Finally, when the new job is complete, GET /media/{mediaId} will provide the aligned transcript and will have run any downstream tasks based on the new transcript (keywords, predictions, ...)  

Note that the simple act of including a transcript with the POST triggers alignment.
# Keywords and Topics


VoiceBase can discover the keywords, key phrases, and topics in your recording using a processing known as semantic indexing. The results are known as "semantic keywords and topics".

VoiceBase also supports keyword and key phrase spotting. You can define groups of keywords or key phrases, which are flagged when they are spotted in the recording. For more details, see [Keyword Spotting](keyword-spotting.html).

## Semantic Keywords and Topics

Semantic keywords and topics are discovered automatically (for [languages where the feature is supported](languages.html)) and returned with the analytics. For example, the `media.keywords.latest.words` section may contain an entry like the following:

```json
{
  "name": "subscription",
  "t": {
    "caller": [
      "34.48",
      "57.34"
    ],
    "agent": [
      "40.01"
    ]
  },
  "relevance": "0.17"
}
```

In this example, the keyword `subscription` was spoken by the caller around 34 and 57 seconds into the recording, and by the agent around 40 seconds into the recording.

### Relevance

Semantic keywords and topics are scored for relevance. The `relevance` score ranges from 0.0 to 1.0, with higher scores indicating higher relevance.

Keyword relevance is computed by matching detected keywords and key phrases to an extensive taxonomy of potential keywords (VoiceBase's semantic index). The relevance algorithm generally produces higher scores for more frequent, closely matching, and distinctive keywords, while producing lower scores for very common keywords found in the recording.

Topic relevance is computed by grouping discovered keywords into topics of interest... TODO

## Disabling Semantic Keywords and Topics

Adding keywords and topics to your media post configuration, enables semantic keywords and topic extraction.

The configuration attachment should contain the key:

 - `configuration` : root object for configuration data
    - `keywords` : object for keyword-specific configuration
        - `semantic` : flag to control semantic keywords
    - `topics` : object for topic-specific configuration
        - `semantic` : flag to control semantic topics

For example:

```json
{  
  "configuration": {
    "keywords": {  
      "semantic": false,
    },
    "topics": {
      "semantic": false
    }
  }
}
```


## Examples

### Example: Defining and spotting a keyword group


Define a `keyword group` by making a PUT request to the `/definitions/keywords/groups/data` resource.

```bash

curl https://apis.voicebase.com/v2-beta/definitions/keywords/groups/data \
  --request PUT \
  --header "Content-Type: application/json" \  
  --data '{ "name" : "data", "keywords" : [ "data science", "big data", "data mining" ] }' \
  --header "Authorization: Bearer ${TOKEN}"
```

Upload media from a local file called recording.mp3 and spot keywords using the `data` group, make the following POST request to `/media`

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer ${TOKEN}" \
  --form media=@recording.mp3 \
  --form 'configuration={ "configuration": { "keywords": { "groups": [ "data" ] } } }'
```

### Example: Disabling semantic keywords and topics

The following is an example of posting a media document with semantic `keywords` and `topics` extraction disabled.

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer $TOKEN" \
  --form media=@recording.mp3 \
  --form 'configuration={"configuration":{
    "keywords":{ "semantic": false },
    "topics":{ "semantic": false }
  }}'
```

# Keywords and Topics


VoiceBase can discover the keywords, key phrases, and topics in your recording using a processing known as semantic indexing. The results are known as "semantic knowledge discovery" and it includes keywords and topics.

VoiceBase also supports keyword and key phrase spotting. You can define groups of keywords or key phrases, which are flagged when they are spotted in the recording. For more details, see [Keyword Spotting](keyword-spotting.html).

## Semantic Keywords and Topics

Semantic keywords and topics are discovered automatically (for [languages where the feature is supported](languages.html)) and returned with the analytics under the section "knowledge" For example, the `knowledge.keywords` section may contain an entry like the following:

```json
{
  "keyword": "subscription",
  "relevance": 0.17,
  "mentions" : [
     {
       "speakerName" : "caller",
       "occurrences" : [
          { "s": 34480, "e": 35545, "exact": "subscription" },
          { "s": 57340, "e": 59034, "exact": "membership" }
       ]
     },
     {
       "speakerName" : "agent",
       "occurrences" : [
          { "s": 40010, "e": 42100, "exact": "subscription" }
       ]
     }

  ]
}
```

In this example, the keyword `subscription` was spoken by the caller around 34 and 57 seconds into the recording, and by the agent around 40 seconds into the recording.

Topics are reported by grouping a set of keywords that relate to each other. For example, the section `knowledge.topics` may contain an entry like this:

```json
{
  "topicName": "Solar energy",
  "subTopics": [ ],
  "relevance": 0.004,
  "keywords": [
    {
      "keyword": "solar power",
      "relevance": 0.17,
      "mentions" : [
         {
           "speakerName" : "caller",
           "occurrences" : [
              { "s": 34480, "e": 35545, "exact": "solar power" },
              { "s": 57340, "e": 59034, "exact": "solar engergy" }
           ]
         },
         {
           "speakerName" : "agent",
           "occurrences" : [
              { "s": 40010, "e": 42100, "exact": "solar power" }
           ]
         }

      ]
    },
    {
      "keyword": "solar water heating",
      "relevance": 0.17,
      "mentions" : [
         {
           "speakerName" : "caller",
           "occurrences" : [
              { "s": 134480, "e": 135545, "exact": "solar water heater" },
              { "s": 157340, "e": 159034, "exact": "solar thermal collector" }
           ]
         }
      ]
    }
  ]
}
```



### Relevance

Semantic keywords and topics are scored for relevance. The `relevance` score ranges from 0.0 to 1.0, with higher scores indicating higher relevance.

Keyword relevance is computed by matching detected keywords and key phrases to an extensive taxonomy of potential keywords (VoiceBase's semantic index). The relevance algorithm generally produces higher scores for more frequent, closely matching, and distinctive keywords, while producing lower scores for very common keywords found in the recording.

Topic relevance is computed by grouping discovered keywords into topics of interest applying a similar relevance algorithm to the aggregate.

## Disabling Semantic Keywords and Topics

Adding keywords and topics to your media post configuration, enables semantic keywords and topic extraction.

The configuration attachment should contain the key:

 - `knowledge` : Settings for Knowledge Discovery
    - `enableDiscovery` : Switch for enabling/disabling knowledge discovery. Default is false.
    - `enableExternalDataSources` : Switch for allowing the search on sources external to VoiceBase. Users concerned about data privacy or PCI requirements can turn this off. Default is true.

For example:

```json
{  
  "knowledge": {
    "enableDiscovery": true,
    "enableExternalDataSources" : true
  }
}
```


## Examples


### Example: Enabling semantic knowledge discovery

The following is an example of posting a media document with semantic `keywords` and `topics` extraction enabled.

```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer $TOKEN" \
  --form media=@recording.mp3 \
  --form configuration='{
    "knowledge": {
      "enableDiscovery": true,
      "enableExternalDataSources" : false
     }
  }'
```

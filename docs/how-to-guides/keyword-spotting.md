# Keyword and Phrase Spotting

VoiceBase supports keyword and phrase spotting within your transcript. You can define groups of keywords (or key phrases), which are flagged when they are spotted in the recording.

VoiceBase can also discover the keywords, key phrases, and topics in your recording using a processing known as semantic indexing. For more details, view [Keywords and Topics](keywords-and-topics.html).

## Managing Keyword Spotting Groups

VoiceBase allows you to specify pre-defined groups of keywords (or key phrases), which can be used to flag recordings of interest using keyword spotting.

To define new keyword group, or update an existing keyword group, simply PUT the group under '/definition/spotting/groups'. The body of the PUT request is a JSON object (`Content-Type: application/json`) that contains two keys:

 - `groupName` : the name of the keyword group
 - `keywords` : an array of the included keywords

For example, to create group `big-data` that includes the keywords `data science`, `big data`, and `data mining`, make the following PUT request using curl, or an equivalent request using a tool of your choice:

```bash
curl https://apis.voicebase.com/v3/definition/spotting/groups/data-science \
  --request PUT \
  --header "Content-Type: application/json" \  
  --data '{ "groupName" : "data-science", "keywords" : [ "data science", "machine learning", "data mining", "classification" ] }' \
  --header "Authorization: Bearer ${TOKEN}"
```

## Displaying Keyword Spotting Groups

To display keyword groups that you have created make the following GET request using curl, or an equivalent request using a tool of your choice:

```bash
curl https://apis.voicebase.com/v3/definition/spotting/groups/data-science \
  --request GET \
  --header "Authorization: Bearer ${TOKEN}"
```

The response will look like the following:

```json
{
	"groupName": "data-science",
	"keywords": [ "data science", "machine learning", "data mining", "classification" ]
}
```

Revision is the uniqueID that VoiceBase uses applies to each keyword group that can be used to monitor the group.

## Enabling Keyword Spotting

To upload media with keyword spotting enabled, include a JSON configuration attachment with your media POST. The configuration attachment should contain the key:

    - `spotting` : object for keyword-spotting configuration
        - `groups` : array of keyword-spotting groups

For example:

```json
{
    "spotting": {
      "groups": [ { "groupName": "data-science" } ]
    }  
}
```
When keyword spotting is enabled, this adds extra analytics to the response. For example:

```json
{
  "spotting": {
    "groups": [
          {
            "groupName" : "data-science",
            "score" : 0,
            "spotted" : true,
            "spottedKeywords": [
              {
                "keyword" : "data science",
                "mentions" : [
                  {
                    "speakerName" : "Alice",
                    "occurrences" : [
                      { "s" : 4620 , "exact": "data science" }
                    ]
                  }
                ]
              },
              {
                "keyword" : "data science",
                "mentions" : [
                  {
                    "speakerName" : "Bob",
                    "occurrences" : [
                      { "s" : 5730 , "exact": "machine learning" }
                    ]
                  }
                ]
              }
          ]
        }
      ]
  }
}
```
## Examples

### Example: Defining and enabling a keyword spotting group

Define a `keyword group` by making a PUT request to the `/definition/spotting/groups/data-science` resource.

```bash

curl https://apis.voicebase.com/v3/definition/spotting/groups/data-science \
  --request PUT \
  --header "Content-Type: application/json" \  
  --data '{ "groupName" : "data-science", "keywords" : [  "data science", "machine learning", "data mining", "classification" ] }' \
  --header "Authorization: Bearer ${TOKEN}"
```

Upload media from a local file called recording.mp3 and spot keywords using the `data-science` group, make the following POST request to `/media`

```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}" \
  --form media=@recording.mp3 \
  --form configuration='{ "spotting": { "groups": [ { "groupName" : "data-science"  } ] } }'
```

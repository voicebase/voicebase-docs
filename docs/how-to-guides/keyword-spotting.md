# Keyword Spotting

VoiceBase supports keyword (and key phrase) spotting. You can define groups of keywords (or key phrases), which are flagged when they are spotted in the recording.

VoiceBase can also discover the keywords, key phrases, and topics in your recording using a processing known as semantic indexing. For more details, view [Keywords and Topics](keywords-and-topics.html).

## Managing Keyword Spotting Groups

VoiceBase allows you to specify pre-defined groups of keywords (or key phrases), which can be used to flag recordings of interest using keyword spotting.

To define new keyword group, or update an existing keyword group, simply PUT the group under /definitions/keywords/groups. The body of the PUT request is a JSON object (`Content-Type: application/json`) that contains two keys:

 - `name` : the name of the keyword group
 - `keywords` : an array of the included keywords

For example, to create group `data` that includes the keywords `data science`, `big data`, and `data mining`, make the following PUT request using curl, or an equivalent request using a tool of your choice:

```bash
curl https://apis.voicebase.com/v2-beta/definitions/keywords/groups/data \
  --request PUT \
  --header "Content-Type: application/json" \  
  --data '{ "name" : "data", "keywords" : [ "data science", "big data", "data mining" ] }' \
  --header "Authorization: Bearer ${TOKEN}"
```

## Displaying Keyword Spotting Groups

To display keyword groups that you have created make the following GET request using curl, or an equivalent request using a tool of your choice:

```bash
curl https://apis.voicebase.com/v2-beta/definitions/keywords/groups/data \
  --request GET \
  --header "Authorization: Bearer ${TOKEN}"
```

The response will look like the following:

```json
{
	"name": "data",
	"revision": "24f20f87-e05d-437a-8436-38e16280d464",
	"keywords": [ "data science", "big data", "data mining" ]
}
```

Revision is the uniqueID that VoiceBase uses applies to each keyword group that can be used to monitor the group.

## Enabling Keyword Spotting

To upload media with keyword spotting enabled, include a JSON configuration attachment with your media POST. The configuration attachment should contain the key:

 - `configuration` : root object for configuration data
    - `keywords` : object for keyword-specific configuration
        - `groups` : array of keyword-spotting groups

For example:

```json
{
  "configuration": {
    "keywords": {
      "groups": [ "data" ]
    }  
  }
}
```
When keyword spotting is enabled, this adds extra analytics to the response. For example:

```json
{
  "media": {
    "keywords": {
      "latest": {
        "groups": [
          {
            "keywords": [
              {
                "t": {
                  "unknown": [
                    4.62
                  ]
                },
                "name": "data science"
              },
              {
                "t": {
                  "unknown": [
                    6.68
                  ]
                },
                "name": "data mining"
              }
            ],
            "name": "data",
            "type": "group"
          }
        ]
      }
    }
  }
}
```
## Examples

### Example: Defining and enabling a keyword spotting group

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

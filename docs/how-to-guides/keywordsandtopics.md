# Keywords and Topics


Voicebase can automatically extract a specified or semantically extracted
set of keywords and associated topics from transcript.

## Enabling Keywords and Topics

Adding keywords and topics to your media post configuration, enables semantic keywords and topic extraction.

```json
{  
  "configuration": {
    "keywords":
      {  
        "semantic": true,
        "groups" : ['array', 'of', 'keyword', 'groups', 'you', 'have', 'defined']
      },
    "topics" : {
        "semantic": true
      }
    }
  }
}
```

**configuration.keywords.semantic** enables or disables semantic keyword extraction.
**configuration.topcs.semantic** enables or disables semantic keyword extraction.
**configuration.keywords.groups** allows you to specify the keyword groups you have defined.

The configuration items are independent.  If you are only interested in identifying specific words or phrases, you would  only specify configuration.keywords.groups, for example:

```json
{  
  "configuration": {
    "keywords": {
        "semantic": false,
        "groups" : ['array', 'of', 'keyword', 'groups', 'you', 'have', 'defined'],
      },
    "topics" : {
        "semantic": false
      }
    }
  }
}
```


## Keyword Group Management

Voicebase allows you to specify pre-defined keyword groups which you can later use for targeted keyword extraction, as we see in the above example.

To define new keyword group, or update an existing keyword group, simply PUT the group under /v2-beta/definitions/keywords/groups. The body of the PUT request is a JSON object (Content-Type: application/json) that contains two keys:

 - name : the name of the keyword group
 - keywords : an array of the included keywords

For example, to create group 'data' that includes the keywords data science, big data, and data mining, make the following PUT request using curl, or an equivalent request using a tool of your choice:

```bash
curl https://apis.voicebase.com/v2-beta/definitions/keywords/groups/data \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/json" \
  --request PUT \
  --data '{ "name" : "data", "keywords" : [ "data science", "big data", "data mining" ] }'
```

## Uploading Media with Keyword Spotting Enabled

To upload media with keyword spotting enabled, include a JSON configuration attachment with your media POST. The configuration attachment should contain the key:

 - configuration : root object for configuration data
    - keywords (child of configuration): object for keyword-specific configuration
        - groups (child of keywords): array of keyword-spotting groups



## Complete Examples

### Example 1

For example, to upload media from a local file called recording.mp3 and spot keywords using the data group, make the following POST request using curl, or an equivalent request using a tool of your choice:

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer $TOKEN" \
  --form media=@recording.mp3 \
  --form 'configuration={"configuration":{"keywords":{"groups":["data"]}}}'
```


### Example 2

The following is an example of posting a media document with semantic keywords and topics extraction enabled.

```bash
curl https://apis.voicebase.com/v2-beta/media \
  --header "Authorization: Bearer $TOKEN" \
  --form media=@recording.mp3 \
  --form 'configuration={"configuration":{"keywords":{"semantic":true}, \
  "topics":{"semantic":true}}}'
```

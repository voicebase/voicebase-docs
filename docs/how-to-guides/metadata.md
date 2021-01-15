# Working with Metadata

Transcriptions may be organized by providing additional information
about a recording submitted by a POST request to /v3/media

Media can be submitted with additional information that helps you organize and
search your transcriptions based on it. The additional information is
supplied by providing a form attribute named "metadata" with a JSON document

Here is a sample metadata

```json
{
  "title" : "Call with John Smith from Acme Inc",
  "description" : "Contacting customer for offering additional services",
  "externalId" : "CRM-9473-2393470-3",
  "extended" : {
       "call" : {
         "date" : "2017-05-01",
         "phone" : "+1-307-388-2123"
       },
       "upselling" : true
  }
}
```

Metadata is composed of the following items, all of them are optional:

- `title`  A title for your recording.
- `description` A description of the recording.
- `externalId` A tag value. It may refer to an identifier on another system. Voicebase does not enforce uniqueness on it, you may have several recordings submitted with the same value for this attribute.
- `extended` Free JSON document. This must be a JSON object, not a primitive nor an array.

# Associating a request with Metadata

In addition to the configuration, specify the "metadata" form attribute in your request.

```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}"  \
  --form media=@recording.mp3  \
  --form configuration='{ }' \
  --form metadata='{
        "title" : "Gathering Leaves by Robert Frost",
        "externalId" : "A12345"
    }'
```
Metadata will be returned as part of your calls to GET /v3/media/{mediaId} and
GET /v3/media

Metadata will be included in callbacks of type "analytics" that do not specify
the "include" attribute and those that explicitly request the "metadata" section
through the "include" attribute.

Later on, you can search for media recordings based on the values on the submitted
metadata. For example, the following request search for recordings tagged with "A12345"
as the "externalId":

```bash
curl https://apis.voicebase.com/v3/media?externalId=A12345 \
  --header "Authorization: Bearer ${TOKEN}"  
```
You may also use the "query" attribute
```bash
curl https://apis.voicebase.com/v3/media?query=Frost  \
  --header "Authorization: Bearer ${TOKEN}"
```
The search above would match recordings where the word "Frost" occurred on the
transcript, title or description. If you want to restrict the matches to only
the title, then you must submit the query as

     title:Frost

which encoded would look like:     
```bash
curl https://apis.voicebase.com/v3/media?query=title%3AFrost  \
  --header "Authorization: Bearer ${TOKEN}"
```

# Pass through Metadata

You may like to attach some metadata to a VoiceBase job and have VoiceBase remember that metadata throughout the life of the job to eventually pass back to you in the results. The metadata can be passed back in a callback or through polling.

Using the 'extended' section of the metadata will allow you to attach any arbitrary JSON that you like. For example, you may like to have metadata from your phone system attached as you pass a new call recording through VoiceBase. That metadata would then be delivered to a destination with transcription and analytic results.

You could achieve that like this,

```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}"  \
  --form media=@recording.mp3  \
  --form configuration='{ }' \
  --form metadata='{
  "extended" : {
       "agent" : "${AGENT}",
	   "date" : "${DATE}",
	   "time" : "${TIME}",
	   "ani" : "${ANI}",
	   "dispcode" : "${DISPCODE}",
	   "campaign" : "${CAMPAIGN}"
  }
}'
```

Which would add an additional section to your JSON results (both polling and callback) that looks like this,

{
    "metadata": {
		"extended" {
			"agent" : "Your-Agent",
			"date" : "Your-Date",
			"time" : "Your-Time",
			"ani" : "Your-ANI",
			"dispcode" : "Your-Dispcode",
			"campaignId" : "Your-Campaign"
		}
	}
}


# ExternalId

You are able to add your own ID to media you sent into VoiceBase. That ID will remain with the job as long as it is in VoiceBase. This most commonly acts as an identifier on another system.

In addition to having the reference permanently attached to the job, some VoiceBase API calls allow filtering by externalId.

An externalId can be added as a value to the key externalId in the metadata JSON

```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}"  \
  --form media=@recording.mp3  \
  --form configuration='{ }' \
  --form metadata='{
        "externalId" : "A12345"
    }'
```

You can GET jobs by externalId,

```bash
curl https://apis.voicebase.com/v3/media?externalId=A12345 \
  --header "Authorization: Bearer ${TOKEN}"
    }'
```

Your externalId can be unique, but VoiceBase does not force uniqueness on externalId. If you have multiple jobs with the same externalId, then multiple jobs will be returned when you make the GET above.


# Metadata Filter

You are able to index your own metadata which will allow you to filter GET results based on metadata.

For example, you might like to collect your media, but only where your campaign ID is 1234.

First, you must pre-emptively index campaignId, 

Use the PUT /definition/media/search api endpoint to do so.

```bash
curl https://apis.voicebase.com/v3/definition/media/search \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/json" \
  --request PUT \
  --data '{ "fields" : [ "extended.campaignId" ] }'
```
  
You can then do a metadata-scoped GET

```bash
curl --header “Authorization: Bearer ${TOKEN}” \
https://apis.voicebase.com/v3/media?extendedFilter=campaignId%3A1234
```

Keep in mind that only media processed AFTER your metadata was indexed will be returned.

For all filtering options, pagination, etc see our search page.


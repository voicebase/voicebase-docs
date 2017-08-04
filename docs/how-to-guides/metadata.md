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
         "phone" : "+1-307-388-2123",
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

# Transcripts

Once processing is complete, transcripts can be retrieved in several formats.

## JSON Transcript

Retrieve a JSON-formatted transcript with metadata using a `GET` against the `transcript` resource under the `media` item.

Make a GET on the /media/$MEDIA_ID/transcript resource.

```sh
  curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript
    --header "Authorization: Bearer ${TOKEN}"
```

##### Example Response
In this example, the agent spoke first, and said "Hello" and the caller spoke second and said "Hi".
Speaker identification is enabled by multi-channel audio, where each channel is associated with a specific speaker. For more information on how to use multi-speaker audio, see the [stereo](stereo.md) section.

###### How to read it
* "p" = Position (word # in the transcript)
* "c" = Confidence (A value between 0-1 that relates to the confidence percent ex: 0.88 = 88%.  When the metadata flag is present confidence contains an arbitrary value.)
* "s" = Start time (milliseconds)
* "e" = End time (milliseconds)
* "w" = The word itself (When the metadata flag is present "w" refers to the speaker)
* "m" = metadata (In this case when "m": "turn" it is detecting a change in speaker)

```json
{
  "mediaId": "bc14632d-e81b-4673-992d-5c5fb6573fb8",
  "status": "finished",
  "dateCreated": "2017-06-22T19:18:49Z",
  "mediaContentType": "audio/x-wav",
  "length": 10031,
  "transcript": {
     "words":[  
        {  
           "p":1,
           "c":0.1,
           "s":2200,
           "e":2350,
           "w":"agent: ",
           "m":"turn"
        },
        {  
           "p":2,
           "c":0.537,
           "s":2200,
           "e":2300,
           "w":"Hello"
        },
        {  
           "p":52,
           "c":0.1,
           "s":2400,
           "e":2550,
           "w":"caller: ",
           "m":"turn"
        },
        {  
           "p":53,
           "c":0.975,
           "s":2400,
           "e":2500,
           "w":"Hi"
        }
     ]
  }
}
```

## Plain Text Transcript



##### Example Response

The plaintext response will contain only the words from the transcript, without formatting.

```
To find the source of success we started at work we asked people to identify who they thought
were their most effective colleagues in fact over the past twenty five years we have asked
over twenty thousand people to identify the individuals in their organizations who could
really get things done
```

##### Example cURL

To download a transcript as plain text, make a GET on the /media/$MEDIA_ID/transcript/text resource specifying an `Accept` HTTP header with the value `text/plain`.

```sh
curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript/text \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/plain"
```

Alternatively, the text transcript can be retrieved with the JSON transcript by adding the `includeAlternateFormat` query parameter in the request set to the value 'text'

```sh
curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript?includeAlternateFormat=text \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: application/json"
```

In this case, the transcript will contain the additional section  'alternateFormats', the 'data' attribute contains the text transcript encoded in Base64.

```json
{
  "alternateFormats": [
    {
      "format": "text",
      "contentType": "text/plain",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "VG8gZmluZCB0aGUgc291cmNlIG9mIHN1Y2Nlc3Mgd2Ugc3RhcnRlZCBhdCB3b3JrIHdlIGFza2VkIHBlb3BsZSB0byBpZGVudGlmeSB3aG8gdGhleSB0aG91Z2h0DQp3ZXJlIHRoZWlyIG1vc3QgZWZmZWN0aXZlIGNvbGxlYWd1ZXMgaW4gZmFjdCBvdmVyIHRoZSBwYXN0IHR3ZW50eSBmaXZlIHllYXJzIHdlIGhhdmUgYXNrZWQNCm92ZXIgdHdlbnR5IHRob3VzYW5kIHBlb3BsZSB0byBpZGVudGlmeSB0aGUgaW5kaXZpZHVhbHMgaW4gdGhlaXIgb3JnYW5pemF0aW9ucyB3aG8gY291bGQNCnJlYWxseSBnZXQgdGhpbmdzIGRvbmU="
    }
  ]
}
```

## SRT transcript

To retrieve a transcript as a SRT file which is useful for closed captioning or timing the transcript with the audio,  make a GET on the /media/$MEDIA_ID/transcript/srt resource specifying an `Accept` HTTP header with the value `text/srt`.

The [closed captioning](closed-captioning.html) section has a detailed discussion of the SRT transcript format.

##### Example Response

```
1
00:00:00,05 --> 00:00:05,81
To find the source of success we started
at work we asked people to identify who

2
00:00:05,82 --> 00:00:10,90
they thought were their most effective
colleagues in fact over the past twenty five

3
00:00:10,91 --> 00:00:16,13
years we have asked over twenty thousand
people to identify the individuals in their

4
00:00:16,14 --> 00:00:20,93
organizations who could really get things
done we wanted to find those who were not
```

##### Example cURL

```sh
curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript/srt \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/srt"
```

Alternatively, the SRT transcript can be retrieved with the JSON transcript by adding the `includeAlternateFormat` query parameter in the request.

```sh
curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript?includeAlternateFormat=srt \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: application/json"
```

In this case, the SRT transcript is returned encoded with Base64 within the JSON

```json
{
  "alternateFormats": [
    {
      "format": "srt",
      "contentType": "text/srt",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "MQ0KMDA6MDA6MDAsMDUgLS0+IDAwOjAwOjA1LDgxDQpUbyBmaW5kIHRoZSBzb3VyY2Ugb2Ygc3VjY2VzcyB3ZSBzdGFydGVkDQphdCB3b3JrIHdlIGFza2VkIHBlb3BsZSB0byBpZGVudGlmeSB3aG8NCg0KMg0KMDA6MDA6MDUsODIgLS0+IDAwOjAwOjEwLDkwDQp0aGV5IHRob3VnaHQgd2VyZSB0aGVpciBtb3N0IGVmZmVjdGl2ZQ0KY29sbGVhZ3VlcyBpbiBmYWN0IG92ZXIgdGhlIHBhc3QgdHdlbnR5IGZpdmUNCg0KMw0KMDA6MDA6MTAsOTEgLS0+IDAwOjAwOjE2LDEzDQp5ZWFycyB3ZSBoYXZlIGFza2VkIG92ZXIgdHdlbnR5IHRob3VzYW5kDQpwZW9wbGUgdG8gaWRlbnRpZnkgdGhlIGluZGl2aWR1YWxzIGluIHRoZWlyDQoNCjQNCjAwOjAwOjE2LDE0IC0tPiAwMDowMDoyMCw5Mw0Kb3JnYW5pemF0aW9ucyB3aG8gY291bGQgcmVhbGx5IGdldCB0aGluZ3MNCmRvbmUgd2Ugd2FudGVkIHRvIGZpbmQgdGhvc2Ugd2hvIHdlcmUgbm90DQo="
    },
  ]
}
```

## WebVTT transcript

WebVTT is a W3C standard for displaying timed text in HTML 5 utilizing the <track> element.
To retrieve a transcript as a WebVTT file which is useful for closed captioning or timing the transcript with the audio,  make a GET on the /media/$MEDIA_ID/transcript/webvtt resource specifying an `Accept` HTTP header with the value `text/vtt`.

The [closed captioning](closed-captioning.html) section has a detailed discussion of the WebVTT and SRT transcript formats.

##### Example Response

```
WEBVTT

1
00:00:00.05 --> 00:00:05.81
To find the source of success we started
at work we asked people to identify who

2
00:00:05.82 --> 00:00:10.90
they thought were their most effective
colleagues in fact over the past twenty five

3
00:00:10.91 --> 00:00:16.13
years we have asked over twenty thousand
people to identify the individuals in their

4
00:00:16.14 --> 00:00:20.93
organizations who could really get things
done we wanted to find those who were not
```

##### Example cURL

```sh
curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript/webvtt \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/vtt"
```

Alternatively, the SRT transcript can be retrieved with the JSON transcript by adding the `includeAlternateFormat` query parameter in the request.

```sh
curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript?includeAlternateFormat=webvtt \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: application/json"
```

In this case, the WebVTT transcript is returned encoded with Base64 within the JSON

```json
{
  "alternateFormats": [
    {
      "format": "webvtt",
      "contentType": "text/vtt",
      "contentEncoding": "Base64",
      "charset": "utf-8",
      "data": "MQ0KMDA6MDA6MDAsMDUgLS0+IDAwOjAwOjA1LDgxDQpUbyBmaW5kIHRoZSBzb3VyY2Ugb2Ygc3VjY2VzcyB3ZSBzdGFydGVkDQphdCB3b3JrIHdlIGFza2VkIHBlb3BsZSB0byBpZGVudGlmeSB3aG8NCg0KMg0KMDA6MDA6MDUsODIgLS0+IDAwOjAwOjEwLDkwDQp0aGV5IHRob3VnaHQgd2VyZSB0aGVpciBtb3N0IGVmZmVjdGl2ZQ0KY29sbGVhZ3VlcyBpbiBmYWN0IG92ZXIgdGhlIHBhc3QgdHdlbnR5IGZpdmUNCg0KMw0KMDA6MDA6MTAsOTEgLS0+IDAwOjAwOjE2LDEzDQp5ZWFycyB3ZSBoYXZlIGFza2VkIG92ZXIgdHdlbnR5IHRob3VzYW5kDQpwZW9wbGUgdG8gaWRlbnRpZnkgdGhlIGluZGl2aWR1YWxzIGluIHRoZWlyDQoNCjQNCjAwOjAwOjE2LDE0IC0tPiAwMDowMDoyMCw5Mw0Kb3JnYW5pemF0aW9ucyB3aG8gY291bGQgcmVhbGx5IGdldCB0aGluZ3MNCmRvbmUgd2Ugd2FudGVkIHRvIGZpbmQgdGhvc2Ugd2hvIHdlcmUgbm90DQo="
    },
  ]
}
```

## Retrieving transcript in several formats in a single request

You may specify several formats to be returned in the same request, just add 'includeAlternateFormat' in the query string as many times as needed:

```sh
export FIELDS='?includeAlternateFormat=srt&includeAlternateFormat=webvtt'

curl https://apis.voicebase.com/v3/media/$MEDIA_ID/transcript${FIELDS} \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: application/json"
```

Valid formats are: text, srt, dfxp, webvtt

_Attribution:_ SRT and Plaintext transcripts are generated from Audible dictation of [Crucial Conversations](http://www.audible.com/pd/Business/Crucial-Conversations-Audiobook/B009RQZDHS?source_code=GPAGBSH0508140001&mkwid=sDishsy3J_dc&pcrid=90539104740&pmt=&pkw=&cvosrc=ppc%20cse.google%20shopping.342766860&cvo_crid=90539104740&cvo_pid=23455575420) under fair-use.
The [closed captioning](closed-captioning.html) section has a detailed discussion of the WebVTT & SRT transcript formats.

# Transcripts

Once processing is complete, transcripts can be retrieved in several formats.

## JSON Transcript

Retrieve a JSON-formatted transcript with metadata using a `GET` against the `transcripts` collection under the `media` item. By convention, the transcript for most common scenarios is called `latest`.

Make a GET on the /media/$MEDIA_ID/transcripts/latest resource.

```sh
  curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" 
```

##### Example Response
In this example, the agent spoke first, and said "Hello" and the caller spoke second and said "Hi".
Speaker identification is enabled by multi-channel audio, where each channel is associated with a specific speaker. For more information on how to use multi-speaker audio, see the [stereo](stereo.md) section.

###### How to read it
* "p" = Position (word # in the transcript)
* "c" = Confidence (A value between 0-1 that relates to the confidence percent ex: 0.88 = 88%.  When the metadata flag is present confidence contains an arbireary value.)
* "s" = Start time (milliseconds)
* "e" = End time (milliseconds)
* "w" = The word itself (When the metadata flag is present "w" refers to the speaker)
* "m" = metadata (In this case when "m": "turn" it is detecting a change in speaker)

```json
{  
   "transcripts":{  
      "latest":{  
         "revision":"1aa96aa6-7400-45c5-b390-3c5ff2476779",
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
}
```

## Plain Text Transcript

To download a transcript as plain text, add an `Accept` HTTP header with the value `text/plain`.

##### Example Response

The plaintext response will contain only the words from the transcript, without formatting.

```
To find the source of success we started at work we asked people to identify who they thought
were their most effective colleagues in fact over the past twenty five years we have asked
over twenty thousand people to identify the individuals in their organizations who could
really get things done
```

##### Example cURL

```sh
curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/plain"
```

## SRT transcript

To retrieve a transcripts as a SRT file which is useful for closed captioning or timing the transcript with the audio, add an `Accept` HTTP header with the value `text/srt`.

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
curl https://apis.voicebase.com/v2-beta/media/$MEDIA_ID/transcripts/latest \
    --header "Authorization: Bearer ${TOKEN}" \
    --header "Accept: text/srt"
```




_Attribution:_ SRT and Plaintext transcripts are generated from Audible dictation of [Crucial Conversations](http://www.audible.com/pd/Business/Crucial-Conversations-Audiobook/B009RQZDHS?source_code=GPAGBSH0508140001&mkwid=sDishsy3J_dc&pcrid=90539104740&pmt=&pkw=&cvosrc=ppc%20cse.google%20shopping.342766860&cvo_crid=90539104740&cvo_pid=23455575420) under fair-use.
The [closed captioning](closed-captioning.html) section has a detailed discussion of the SRT transcript format.

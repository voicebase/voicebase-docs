# Closed Captioning

VoiceBase can generate subtitles or closed captions for your video project, by allowing you to retrieve the transcript of your audio or video file using the WebVTT or SubRip Text (SRT) format.

No special configuration is required. All transcripts are always available in four formats: JSON word-by-word, plain text, WebVTT and SRT.

## WebVTT format
WebVTT is a W3C standard which may be used for displaying timed text within the HTML5 <track> element.
A WebVTT file will begin with WEBVTT after an optional UTF-8 byte order mark. The timecode format used is hours:minutes:seconds.milliseconds with hours being optional and time units fixed to two zero-padded digits and fractions fixed to three zero-padded digits (00:00:00.000).  The fractional separator used is the full-stop.


Example:

```
WEBVTT

1
00:00:01.44 --> 00:00:04.25
Customer: Hi this is C.S.V. Shipping
company Brian speaking how can I help you.

2
00:00:05.61 --> 00:00:08.48
Agent: This is Henry A
We spoke earlier I got a quote from you guys.


```

## GET a WebVTT Transcript

Export `MEDIA_ID` and `TOKEN`

```bash
export MEDIA_ID='7eb7964b-d324-49cb-b5b5-76a29ea739e1'
export TOKEN='Your Api Token'
```

and provide the `Accept` HTTP header with the value `"text/vtt"` when requesting the transcript.

```bash
curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/transcript/webvtt \
  --header "Accept: text/vtt" \
  --header "Authorization: Bearer ${TOKEN}"
```


## SRT subtitle format

An SRT file contains formatted lines of plain text in groups separated by a blank line. Subtitles are numbered sequentially, starting at 1. The timecode format used is hours:minutes:seconds,milliseconds with time units fixed to two zero-padded digits and fractions fixed to three zero-padded digits (00:00:00,000).  The fractional separator used is the comma.

1. A number indicating which subtitle it is in the sequence.
2. The time that the subtitle should appear on the screen, and then disappear.
3. The subtitle itself.
4. A blank line indicating the start of a new subtitle.

Example:

```
1
00:00:02,76 --> 00:00:05,08
Agent: Well this is Michael
thank you for calling A.B.C.

2
00:00:05,08 --> 00:00:07,03
Cable services. How may I help you today.

3
00:00:08,28 --> 00:00:11,93
Customer: Hi I'm calling because I'm
interested in buying new cable services.

4
00:00:12,64 --> 00:00:16,43
Agent: OK great let's get started.

```

## GET an SRT format

Export `MEDIA_ID` and `TOKEN`

```bash
export MEDIA_ID='7eb7964b-d324-49cb-b5b5-76a29ea739e1'
export TOKEN='Your Api Token'
```

and provide the `Accept` HTTP header with the value `"text/srt"` when requesting the transcript.

```bash
curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/transcript/srt \
  --header "Accept: text/srt" \
  --header "Authorization: Bearer ${TOKEN}"
```

## Callbacks

Note that when posting a media file with a configuration including a
[callback](callbacks.html), the results posted to the callback URL always contain
the JSON (word-by-word), the plain text, WebVTT and SRT transcripts.

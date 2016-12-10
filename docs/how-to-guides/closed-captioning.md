# Closed Captioning

VoiceBase can generate subtitles or closed captions for your video project, by
allowing you to retrieve the transcript of your audio or video file using the
SubRip Text (SRT) format.

You do not need any special configuration. All transcripts are always available
in three formats: JSON word-by-word, plain text and SRT.

## SRT subtitle format

An SRT file contains formatted lines of plain text in groups separated by a
blank line. Subtitles are numbered sequentially, starting at 1. The timecode
format used is hours:minutes:seconds,milliseconds with time units fixed to two
zero-padded digits and fractions fixed to three zero-padded digits (00:00:00,000).
The fractional separator used is the comma.

1. A number indicating which subtitle it is in the sequence.
2. The time that the subtitle should appear on the screen, and then disappear.
3. The subtitle itself.
4. A blank line indicating the start of a new subtitle.

Example:

```
1
00:00:02,76 --> 00:00:05,08
Well this is Michael
thank you for calling A.B.C.

2
00:00:05,08 --> 00:00:07,03
Cable services. How may I help you today.

3
00:00:08,28 --> 00:00:11,93
Hi I'm calling because I'm
interested in buying new cable services from

4
00:00:11,93 --> 00:00:16,43
my home but I want to know what your different
packages are and what the different

5
00:00:16,43 --> 00:00:17,01
prices are
```

## Retrieving a transcript in SRT format

Provide the **Accept** HTTP header with the value `"text/srt"` when requesting the
transcript.

```bash
curl -v   https://apis.voicebase.com/v2-beta/media/${MEDIA_ID}/transcripts/latest \
        --header "Authorization: Bearer $TOKEN" \
        --header "Accept: text/srt"
```
## Retrieving a transcript in SRT format using a callback

Note that when posting a media file with a configuration including a
[callback](callbacks.html), the results posted to the callback URL always contain
the JSON (word-by-word), the plain text and SRT transcripts.

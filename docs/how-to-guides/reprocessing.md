# Reprocessing your files

VoiceBase allows you to re-run the post-processing with different options.

A common use-case for this is to align a previously generated machine transcript with a human edited or new machine transcript, then re-running knowledge extraction with the new more accurate transcript. This is documented in the [aligner](aligner.md) section.

You may also use the reprocessing feature to re-process different configuration options without requesting a new transcript.

For example, you may use the reprocessing feature to:
* Enable Knowledge Extraction, if you previously did not have this set
* Enable PCI Detection / Redaction if you decide you would like to remove PCI from your transcripts and / or audio files.
* Enable Number Formatting, if you previously set this to disabled.
* Run new machine learning models on existing media files.

*Please Note:* Custom Vocabulary modifies the speech engine with a custom set of terms for audio processing. Since the speech engine is not run during reprocessing, Custom Vocabulary is not updated.

## Examples

Assume that MEDIA_ID='7eb7964b-d324-49cb-b5b5-76a29ea739e1' is a valid media ID of a previously uploaded file for transcription.


Make a POST request to `/media/${MEDIA_ID}` including a `configuration` attachment. Do *not* include a 'media' attachment or 'mediaUrl'


```bash
curl -v -s https://apis.voicebase.com/v3/media/$MEDIA_ID \
  --header "Authorization: Bearer ${TOKEN}" \
  -X POST \
  --form configuration='{}'
```

Then, make a GET request on the `/media/${MEDIA_ID}` resource to download the latest transcripts and configured analytics and predictions.

```bash
curl -v -s https://apis.voicebase.com/v3/media/$MEDIA_ID \
  --header "Authorization: Bearer ${TOKEN}"
```

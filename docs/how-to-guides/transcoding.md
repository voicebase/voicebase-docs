# Transcoding

## Overview

Transcoding is offered as an option to customers who wish to change the codec of a file uploaded to the VoiceBase platform. Reasons to use this option may include playing calls in browsers or BI tools that have codec limitations, or customer requirements to compress files due to concerns about file size. 

The VoiceBase platform may need to transcode files if doing so is required to redact a file when that file's format is not supported. In that case, the platform will transcode the original file into a WAV file, perform the redaction and store this as the redacted file.

## Configuration

To transcode a file, add the "publish" configuration when making a POST request to the /media resource:


```json
{
   "publish" : {
      "audioTranscode" : { 
         "onlyIfRedacted" : true,
         "fileFormat": "mp3|wav|flac|opus|ogg",
         "codec" : "mp3|pcm|vorbis..."
      }
   }
}
```

The "onlyIfRedacted" attribute indicates that the audio should be transcoded only if the audio is required to be redacted. Its default value is "false".

The "fileFormat" attribute is used for the original codec of the file. Its default value is "wav". 

The "codec" attribute refers to the target codec. Its default value depends on the fileFormat, as does its set of supported values.
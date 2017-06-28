
# Visual Voicemail


VoiceBase is able to return automatic transcripts for voicemail recordings which can then be delivered via email or SMS.

Below is an optimized configuration for fast and accurate voicemail transcription. This includes features that benefit shorter forms of audio, however they are all optional.

* **Disable [Phrase Groups and Topic Extraction](keywordsandtopics.md):** Disabling semantic knowledge discovery improves turnaround time and is generally not needed for short files.
* **Enable [Number Formatting](numberformatting.md):** This will format numbers as digits instead of words and adds US phone number formatting which will enable click-to-call for users.
* **Use [Callbacks](callbacks.md):** By using callbacks, our servers will send the data as soon as processing is finished. You won't have to wait until the next polling interval.


## Sample configuration for Voicemail with a callback endpoint receiving JSON
```json
{  
   "knowledge": {
     "enableDiscovery" : false
   },
  "transcript": {  
    "enableNumberFomatting" : true
  },       
  "publish":{  
     "callbacks": [  
        {  
           "url": "https://example.com/transcription",
           "method": "POST",
           "type": "analytics",
           "include":[  
              "transcript"
           ]
        }
     ]
  }
}
```


## Sample configuration for Voicemail with a callback endpoint receiving plain text

You may want a callback just with the text transcript. In this case, you should use a PUT operation to a unique URL that is associated with the recording on your system and the endpoint must accept content type "text/plain"


```json
{  
   "knowledge": {
     "enableDiscovery" : false
   },
  "transcript": {  
    "enableNumberFomatting" : true
  },       
  "publish":{  
     "callbacks": [  
        {  
           "url": "https://example.com/transcription/recording-7d66f194786d",
           "method": "PUT",
           "type": "transcript",
           "format": "text"
        }
     ]
  }
}
```


Now your customers can quickly scan and read through the important parts of their voicemail messages without having to listen to every single recording in their inbox!
Here's a quick [how-to video](https://youtu.be/K9NeLdOAdY4) using Twilio recording.

# Custom Vocabulary

##### Summary
VoiceBase allows you to customize the speech engine to correctly recognize words and phrases that you would not find in a standard dictionary. Using this, you can have the flexibility of a highly tuned, and even more accurate speech engine for specific verticals and vernacular. You may add custom terms to the speech engine vocabulary, create 'sounds like' spellings which more accurately reflect how an uncommon word may sound, and add a weighting factor which will fine-tune preferential recognition of custom terms.

##### Use Case
The Custom Vocabulary feature is most useful for:
* Jargon
* Proper Nouns (names, products, companies, street and city names, etc.)
* Acronyms
* Non-dictionary words
* Hyphenated words
* Multi-word phrases

Let's consider a simple message:

> Hi this is Bryon from VoiceBase.

Let's look at how to use Custom Vocabulary to help ensure that Bryon (an uncommon spelling) and VoiceBase are correctly recognized. The name Bryon can be input from a CRM system, along with street names, product names, or company names.

Using the ad-hoc method of Custom Vocabulary we can add these terms as part of the request configuration file:

```json
{
  "configuration": {
    "transcripts": {
      "vocabularies": [
        {
          "terms" : [
            "Bryon",
            "VoiceBase"
          ]
        }
      ]
    }
  }
}
```

When processed with the Custom Vocabulary configuration, the returned transcript would read:

> “Hi, this is Bryon from VoiceBase.”

#### Sounds Like and Weighting
Let us suppose the recording contains the word 'gnocchi', and we wish this to be properly transcribed. If gnocchi is not in the standard speech dictionary, we may wish to add it through Custom Vocabulary. English employs many words taken directly from other languages, complete with their native spelling. Since 'gnocchi' follows Italian pronunciation, 'gn' is pronounced similar to the Spanish ñ and 'cchi' is pronounced 'key'. This could prove troublesome for any speech engine, so VoiceBase allows you to add a spelling which represents how the word would sound. Utilizing Sounds Like, the speech engine can more precisely identify the term in the recording even if the custom term has an unusual pronunciation. The Sounds Like term for 'gnocchi' may look more like 'nyohki'. Since gnocchi is commonly mispronounced in English, we may even want to add alternate ways to pronounce gnocchi. We may add: 'nokey', and 'nochi'. __Up to 100 sounds like terms__ may be added for each custom term. This would be written in the terms array as: "gnocchi; nyohki, nokey, nochi".

##### Weighting
Weighting may optionally be used to increase the likelihood that terms are recognized by the speech engine. Terms are weighted with an integer value from 0 to 5, with 0 being default. Each increase in the weighting value will increase the likelihood that the speech engine will select the Custom Vocabulary term, but also will increase the likelihood of false positive. With weighting added to the custom term, the custom vocabulary string becomes: "gnocchi; nyohki, nokey, nochi; 2". Weighting may be used with or without Sounds Like.

##### Phrases
Phrases may also be added using Custom Vocabulary as way to ensure that common or scripted phrases are properly recognized. We may wish to add common phrases for our recordings: “Thank you for calling VoiceBase” and “what’s in your calls?”. By adding 'Bryon from VoiceBase' and 'Bryon M.', we can ensure that Bryon's name is properly recognized, and allows recognition of the more common Brian in the same recording when the rest of the custom phrase is not present.

#### Acronyms
Acronyms may be added to the Custom Vocabulary for processing your recording. The VoiceBase speech engine will recognize acronyms when periods are placed between the letters, such as: 'Q.E.D.' or 'C.E.O.'. **Remember:** For the purpose of recognizing acronyms, the VoiceBase speech engine follows The New York Times’ style guide, which recommends following each segment with a period when when letters are pronounced individually, as in ‘C.E.O.’, but not when pronounced as a word, such as ‘NATO’ or 'NAFTA'. It is therefore important to remember that acronyms which are spelled __must__ have a period following each letter. If you would like your transcription to read differently, you may use Sounds Like to accomplish this by adding the spelled acronym (including punctuation) as the Sounds Like term, as in: “CEO; C.E.O.”


There are two ways to upload custom vocabulary terms to VoiceBase:

### Ad-Hoc Scenario

If you have a recording to transcribe and want to add ad hoc custom terms specifically for that file, upload the file with the following configuration:
```json
{
  "configuration": {
    "transcripts": {
      "vocabularies": [
        {
          "terms" : [
            "Jiohn Cleese",
            "Eric Idle",
            "Michael Palin;4",
            "gnocchi;nyohki,nokey,nochi;2",
            "Bryon from VoiceBase",
            "Bryon M.",
            "CEO;C.E.O."			  
          ]
        }
      ]
    }
  }
}
```

### Pre-Defined List

You can add a re-usable custom vocabulary list to your VoiceBase account with a PUT request to /definitions/transcripts/vocabularies/($VOCABLISTNAME) with Content-Type application/JSON and the following body:

```json
{
  "vocabulary" : {
    "name": "earningsCalls",
    "terms": [
      "AFFO;A.F.F.O.",
      "APAC;Aypack",
      "CapEx",
      "Bryon from VoiceBase"
    ]
  }
}
```

From this example, the Custom Vocabulary list is named “earningsCalls”, and can be now be used in configurations attached with all media uploads.  To attach a pre-defined custom vocabulary list to media files, use the configuration below:   (**Note** this can also be combined with adhoc terms)

```json
{  
  "configuration":{  
    "transcripts":{  
      "vocabularies": [  
        {  
          "name": "earningsCalls"
        }
      ]
    }
  }
}
```

## Limitations

* Currently, Custom Vocabulary has a limit of 1000 terms per file processed. Greater than 1000 terms may result in noticeable degradation in turnaround time and accuracy.
* Custom Vocabulary terms and phrases are limited to 64 characters.
* Up to 100 Sounds Like spellings may be added to each Custom Vocabulary term.
Only single words may be used with Sounds Like, though a phrase may be used to describe how a single word sounds.
Acronyms which are spelled must contain periods between each letter (C.E.O.), or use Sounds Like. Acronyms which are said as words must be written as words (NATO).


**Note:** VoiceBase allows you to create vocabularies specific for each recording. In this way, you can submit names of people, streets, cities, products, and industry or company specific terms from a CRM system or other data source which are useful in this call, but will not affect others.


## Example cURL Request

```bash
curl https://apis.voicebase.com/v2-beta/definitions/transcripts/vocabularies/earningsCalls \
  --request PUT \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${TOKEN}" \
  --data '{  
    "vocabulary": {  
      "name": "earningsCalls",
      "terms": [
        "AFFO;A.F.F.O.",
        "APAC;Aypack",
        "CapEx"
      ]
    }
  }'
```

## Example successful response to PUT request

```json
{
  "_links": {
    "self": {
      "href": "/v2-beta/definitions/transcripts/vocabularies/earningsCalls"
    }
  },
  "name": "earningsCalls",
  "revision": "4c15602e-3966-4b05-81f0-0d4f18436dee",
  "terms": [
    "AFFO;A.F.F.O.",
    "APAC;Aypack",
    "CapEx"
  ]
}
```

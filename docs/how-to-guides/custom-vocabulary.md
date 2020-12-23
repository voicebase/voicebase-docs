# Custom Vocabulary

##### Summary
VoiceBase allows you to customize the speech engine to correctly recognize words and phrases that you would not find in a standard dictionary. Using this, you can have the flexibility of a highly tuned, and even more accurate speech engine for specific verticals and vernacular. You may add custom terms to the speech engine vocabulary, create 'sounds like' spellings which more accurately reflect how an uncommon word may sound, and add a weighting factor which will fine-tune preferential recognition of custom terms.  We have recently augmented the power of custom vocabulary by allowing you to specify a 'script' instead of a set of terms.  Think of scripts as contextually-rich terms.  Scripts, like terms, are made up of words, but the order and their context is relevant.  Our speech engine becomes more accurate, as the scripts essentially train the speech engine on what to expect.  

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

Let's look at how to use Custom Vocabulary terms to help ensure that Bryon (an uncommon spelling) and VoiceBase are correctly recognized. The name Bryon can be input from a CRM system, along with street names, product names, or company names.

Using the ad-hoc method of Custom Vocabulary we can add these terms as part of the request configuration file:

```json
{
  "vocabularies": [
    {
      "terms" : [
        {
          "term": "Bryon"
        },
        {
          "term": "VoiceBase"
        }      
      ]
    }
  ]
}
```

When processed with the Custom Vocabulary configuration, the returned transcript would read:

> “Hi, this is Bryon from VoiceBase.”

#### Sounds Like and Weighting
Let's suppose a recording starts with an agent saying "Hi this is C.S.V. Shipping Comnpany" but the speech engine does not recognize "C.S.V." and mistranscribes the opening as "Hi this is just the shipping company." The best practice to correct this would be to employ the mistranscription as a "soundsLike" term, so since the error appears as "just the", this would be configured as:

```json

{
  "soundsLike": [
    "just the"
  ],
  "term": "C.S.V."
}

```

__Up to 100 Sounds Like terms__ separated by commas may be added for each custom term.

##### Weighting
Weighting may optionally be used to increase the likelihood that terms are recognized by the speech engine. Terms are weighted with an integer value from 0 to 5, with 0 being default. Each increase in the weighting value will increase the likelihood that the speech engine will select the Custom Vocabulary term, but also will increase the likelihood of false positives. With weighting added to the custom term "gnocchi", the custom vocabulary string becomes:

```json

{
  "soundsLike": [
    "nyohki", "nokey"
  ],
  "weight": 2,
  "term": "gnocchi"
}

```

Weighting may be used with or without Sounds Like. 
Please note: Weighting is not supported with the [Europa](speech-engine.html) Speech Engine.

##### Phrases
Phrases may also be added using Custom Vocabulary as way to ensure that common or scripted phrases are properly recognized. We may wish to add common phrases for our recordings: “Thank you for calling VoiceBase” and “what’s in your calls?”. By adding 'Bryon from VoiceBase' and 'Bryon M.', we can ensure that Bryon's name is properly recognized, and allows recognition of the more common Brian in the same recording when the rest of the custom phrase is not present. Custom Phrases result in the speech engine evaluating the phrase as a unit and generally are tolerant of pronunciation variances in any one term.  *Note:* Custom Phrases *should not* contain Sounds Like terms, and multi-term Custom Vocabulary entries will have Sounds Like ignored. An individual term may be added to the Custom Vocabulary list with its own Sounds Like if required.

#### Acronyms
Acronyms may be added to the Custom Vocabulary for processing your recording. The VoiceBase speech engine will recognize acronyms when periods are placed between the letters, such as: 'Q.E.D.' or 'C.E.O.'. **Remember:** For the purpose of recognizing acronyms, the VoiceBase speech engine follows The New York Times’ style guide, which recommends following each segment with a period when when letters are pronounced individually, as in ‘C.E.O.’, but not when pronounced as a word, such as ‘NATO’ or 'NAFTA'. It is therefore important to remember that acronyms which are spelled __must__ have a period following each letter. If you would like your transcription to read differently, you may use Sounds Like to accomplish this by adding the spelled acronym (including punctuation) as the Sounds Like term, as in:

```json

{
  "soundsLike": [
    "C.E.O."
  ],
  "term": "CEO"
}

```

There are two ways to upload custom vocabulary terms to VoiceBase:

### Ad-Hoc Scenario

If you have a recording to transcribe and want to add ad hoc custom terms specifically for that file, upload the file with the following configuration:
```json
{
  "vocabularies": [
    {
      "terms" : [
        {
          "soundsLike": [
            "A.F.F.O."
          ],
          "term": "AFFO",
          "weight": 2
        },
        {
          "soundsLike": [
            "Aypack"
          ],
          "term": "APAC",
          "weight": 2
        },
        {
          "term": "CapEx"
        }			  
      ]
    }
  ]
}
```

### Pre-Defined List

You can add a re-usable custom vocabulary list to your VoiceBase account with a PUT request to /v3/definition/vocabularies/($VOCAB-LIST-NAME) with Content-Type application/json and the following body:

```json
{
  "vocabularyName": "earningsCalls",
  "terms": [
    {
      "soundsLike": [
        "A.F.F.O."
      ],
      "term": "AFFO",
      "weight": 2
    },
    {
      "soundsLike": [
        "Aypack"
      ],
      "term": "APAC",
      "weight": 2
    },
    {
      "term": "CapEx"
    }
  ]
}
```

From this example, the Custom Vocabulary list is named “earningsCalls”, and can be now be used in configurations attached with all media uploads.  To attach a pre-defined custom vocabulary list to media files, use the configuration below:   (**Note** This feature can also be combined with ad-hoc terms.)

```json
{
  "vocabularies": [
    {
      "vocabularyName" :  "earningsCalls"
    }
  ]
}
```

## Limitations

* Currently, Custom Vocabulary has a limit of 1000 terms per file processed. Greater than 1000 terms may result in noticeable degradation in turnaround time and accuracy.
* Custom Vocabulary terms and phrases are limited to 64 characters.
* Up to 100 Sounds Like spellings may be added to each Custom Vocabulary term.
Only single words may be used with Sounds Like, though a phrase may be used to describe how a single word sounds.
Acronyms which are spelled must contain periods between each letter (A.F.F.O.), or use Sounds Like. Acronyms which are said as words must be written as words (NATO).
* Sounds Like may not contain multi-term phrases.


**Note:** VoiceBase allows you to create vocabularies specific for each recording. In this way, you can submit names of people, streets, cities, products, and industry or company specific terms from a CRM system or other data source which are useful in this call, but will not affect others.


## Example cURL Request

```bash
curl https://apis.voicebase.com/v3/definition/vocabularies/earningsCalls \
  --request PUT \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${TOKEN}" \
  --data '{
      "vocabularyName": "earningsCalls",
      "terms": [
        {
          "soundsLike": [
            "A.F.F.O."
          ],
          "term": "AFFO",
          "weight": 2
        },
        {
          "soundsLike": [
            "Aypack"
          ],
          "term": "APAC",
          "weight": 2
        },
        {
          "term": "CapEx"
        }
      ]
    }'
```


## Example successful response to PUT request

```json
{

  "_links": {
    "self": {
      "href": "/v3/definition/vocabularies/earningsCalls"
    }
  },
  "vocabularyName": "earningsCalls",
  "terms": [
    {
      "term": "AFFO",
      "soundsLike": [
        "A.F.F.O."
      ],
      "weight": 2
    },
    {
      "term": "APAC",
      "soundsLike": [
        "Aypack"
      ],
      "weight": 2
    },
    {
      "term": "CapEx"
    }
  ]
}
```

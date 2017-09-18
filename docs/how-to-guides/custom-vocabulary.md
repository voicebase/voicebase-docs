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
          "term": "Voicebase"
        }      
      ]
    }
  ]
}
```

When processed with the Custom Vocabulary configuration, the returned transcript would read:

> “Hi, this is Bryon from VoiceBase.”

#### Sounds Like and Weighting
Let us suppose the recording contains the word 'gnocchi', and we wish this to be properly transcribed. If gnocchi is not in the standard speech dictionary, we may wish to add it through Custom Vocabulary. English employs many words taken directly from other languages, complete with their native spelling. Since 'gnocchi' follows Italian pronunciation, 'gn' is pronounced similar to the Spanish ñ and 'cchi' is pronounced 'key'. This could prove troublesome for any speech engine, so VoiceBase allows you to add a spelling which represents how the word would sound. Utilizing Sounds Like, the speech engine can more precisely identify the term in the recording even if the custom term has an unusual pronunciation. The Sounds Like term for 'gnocchi' may look more like 'nyohki'. Since gnocchi is commonly mispronounced in English, we may even want to add alternate ways to pronounce gnocchi. We may add: 'nokey', and 'nochi'. __Up to 100 sounds like terms__ may be added for each custom term. This would be written in the terms array as:

```json

{
  "soundsLike": [
    "nyohki", "nokey", "nochi"
  ],
  "term": "gnocchi"
}

```


##### Weighting
Weighting may optionally be used to increase the likelihood that terms are recognized by the speech engine. Terms are weighted with an integer value from 0 to 5, with 0 being default. Each increase in the weighting value will increase the likelihood that the speech engine will select the Custom Vocabulary term, but also will increase the likelihood of false positive. With weighting added to the custom term, the custom vocabulary string becomes:

```json

{
  "soundsLike": [
    "nyohki", "nokey", "nochi"
  ],
  "weight": 2
  "term": "gnocchi"
}

```

Weighting may be used with or without Sounds Like.

##### Phrases
Phrases may also be added using Custom Vocabulary as way to ensure that common or scripted phrases are properly recognized. We may wish to add common phrases for our recordings: “Thank you for calling VoiceBase” and “what’s in your calls?”. By adding 'Bryon from VoiceBase' and 'Bryon M.', we can ensure that Bryon's name is properly recognized, and allows recognition of the more common Brian in the same recording when the rest of the custom phrase is not present.

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

You can add a re-usable custom vocabulary list to your VoiceBase account with a PUT request to /v3/definition/vocabularies/($VOCABLISTNAME) with Content-Type application/json and the following body:

```json
{
  "name": "earningsCalls",
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


**Note:** VoiceBase allows you to create vocabularies specific for each recording. In this way, you can submit names of people, streets, cities, products, and industry or company specific terms from a CRM system or other data source which are useful in this call, but will not affect others.


## Example cURL Request

```bash
curl https://apis.voicebase.com/v3/definition/vocabularies/earningsCalls \
  --request PUT \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${TOKEN}" \
  --data '{
      "name": "earningsCalls",
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
  "name": "earningsCalls",
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

# Custom Vocabulary Script Examples

Using the ad-hoc method of Custom Vocabulary scripts we can add these scripts as part of the request configuration file.  Note that the following configuration contains a saved custom vocabulary (must be a script type), and an adhoc custom vocabulary script:

```json
{
  "vocabularies": [
    {  
      "vocabularyName" : "sunpower" 
    },
    {  
    "scripts" : [
       { "script":
          "Thanks for calling up write law to ensure the highest level of service for our clients calls may be monitored or recorded a client services rep will be with you in a moment. Hello upright law bankruptcy law firm. I just called this number is on the website and it was a let me throw out my little application for example please I am. Sure well I can just go ahead you have for you know. OK, I can use my first name for me that is ok, I ask H. ok Kisha you are OK Can you spell your last name for me. He isn't call you are OK And is there a good email to reach you out you know what's going to be my last name and then my first name thirty one remembers. That you. All were close to one OK spur Kisha three one eight eight a G. Mail dot com. Perfect I think is the best number to reach you out and yes it is OK I have six twenty two one zero two nine four nine five yes it is what state and zip code he located in Kisha. Illinois. Code six two zero three five six two zero three five. So here it upright law one of the things we care most about is our clients' stories so what's your story today what's got you no position when you're looking into declaring a bankruptcy. Bought a car a few years ago. Found. It had been pulled out of the lake during Hurricane Katrina. Pulled it out revamped as they could. For twenty one grand and then paid on it for the most part totaled and. The money went for them and I went to court a couple years ago and signed a document that I would not. I would not be taken back to court for the day ever it was over and done with you know and I could be relieved or well I just received a seven thousand dollars garnishment in the mail this morning. I don't have. Them pulled out of my. Character and I don't think. I've made up my other that for the most part but. The point where. I messed up my credit when I was really really. Like for the just and the back of the waters. OK And. Garnishment when it was starting. To wear. Terribly there was a court date and I had no knowledge of it which I understand they may have posted it in a public forum. I work my life away I don't have time to try. OK well. OK yeah the concern is just the doing a bankruptcy will stop a garnishment. But it will I be after the for the full bankruptcy gets rolling so a lot of people are like I'm being garnished I want to do bankruptcy but then they don't have the money for the bankruptcy because they're being tarnished but even if the government hasn't started yet and we don't know when it's starting hopefully we can beat the garnishment here right because I haven't started but I don't rule in their favor but didn't say when they were in a store and as far as I can go home or tax I'm. OK You know that's not the only one but you know I'm mad when I was like you and I have no I don't now and I can't live on the back. For sure I mean that's it's honestly what we hear a lot here at the firm it's people who are like they've got debts when they were eighteen got their first credit card annihilated their credit and now they're an adult may have a life back on track those they can't keep up with the debts and then I mean it's. Unfortunately life nowadays and but I mean that's why we're here it's to help people out of situations like that. So how much debt would you say that you're in overall Well the car let alone i was talking about seventeen grams so. Yeah it's bad there's like three small car and then there's a. Couple other things I have got to be over twenty grand OK yeah definitely something we can help out with here and so I mean you tell me the story about how we got to where we are today would you like the story to be afterwards is there anything you'd like to accomplish from this bankruptcy clears Yes I can I ask. You you know like you know I'd like to buy something and be stable. And then turn around and I'm running around and doing all that you know. I don't like to pay for law school or some kind of money on the. Well how do I get a scholarship to oil or kill but I was too stupid to take it so. I will. Cash it let's let's if we can get it as I mean it looks like a situation is definitely kind of situation we could help out with. A couple logistical questions just to make sure you're in the position where you'll be able to work with us if. You have an active debit card the use yes I do OK and you said you're collecting income when is your next payday. February third of February third So next Wednesday is it right. And. And so. Everything looks good to me here I have one more question for you sure on a scale of one to ten with one being still really kind of unsure about this whole bankruptcy thing and ten being the deftly want to go back up again today. How motivated you say or if I think your financial situation. There given I have. To know so then what I can do now because I can put you through to one of our senior client consultants just OK and what they do is they work with the details of our the bankruptcy that we will tell you how much it costs how long it's going to take the answer any question you have about it and at the end of that conversation if everything sounds good in the sounds like when you want to move forward with we can even get the paperwork started today OK OK. OK And then just go ahead and stand in line here this can be a brief silence then I'll be back in the call with my senior quite consult and I'll make sure the two of you are connected and then I take it here OK OK OK just go and so I we connected. Hi kesa Carlo this is Joey my senior client and so he's one of our best he's going to take everything from here it was a pleasure speaking with you. Thank you to tell the nice even. You to. Kiss your good evening hello Mr My name is Joe we go from a bankruptcy attorney here I understand from Christian your instant interested in get the bankruptcy started today yes. OK. Like I said I'm one of our attorneys here and what I'd like to do spend about a couple minutes with you getting a little deeper picture of what's going on figure out exactly what we want to do here in your in your bankruptcy what's going to be your best option and then get that started OK. OK So let me ask you I'm looking over your information here what's going on with your debt how did we get to this point. I bought a car when I was like. Are Now I ask her sleep when I want to go. I paid twenty one grand for and I was very clear and I won Grand Am. Learning theory of Hurricane Katrina so that's where we're at with that. And basically for me in the twenty one I scared myself pretty bad and what really upsets me is that I got back company I got them bad like they called me they didn't ask who I was or how we knew anything nothing no many Miranda nothing and I called the attorney general and they let them do their own investigation so nothing ever came of that and. It's something. OK And I mean what's going on today I mean what's going on with this point today that this is the day you're sort of getting more s"
        }
        
      ]
    }
  ]
}
```

## Example cURL Request to create a saved custom vocabulary of the type 'scripts'.  Note that when saving a scripts custom vocabulary, you must specify the vocabulary type (vocabularyType).  For the purposes of backwards compatibility, we do not require you to specify the vocabulary type when you specify terms.  Also note that as of now you may not mix scripts and terms in a single request (though you will, mostly likely, in the future).  In other words, you may not include both 'terms' and 'scripts' in a saved custom vocabulary.  In a request, you may not mix a saved custom vocabulary with terms and adhoc-scripts in the same request.

```bash
curl https://apis.voicebase.com/v3/definition/vocabularies/sunpower \
  --request PUT \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${TOKEN}" \
  --data '{  
    "vocabularyName" : "sunpower",
    "vocabularyType" : "scripts",
    "scripts" : [
        { "script": "Drop in for another eighteen months or so before I really quit. So why'd I drop out. It started before I was born. My biological mother was a young unwed graduate student and she decided to put me up for adoption. She felt very strongly that I should be adopted by college graduates so everything was all set for me to be adopted at birth by a lawyer and his wife except that when I popped out they decided at the last minute that they really wanted a girl so my parents who were on a waiting list got a call in the middle of the night asking we have got an unexpected baby boy, do you want him? They said of course. My biological mother found out later that my mother had never graduated from college and that my father had never graduated from high school, she refused to sign the final adoption papers. She only relented a few months later when my parents promised them."},
       { "script":
          "Thanks for calling up write law to ensure the highest level of service for our clients calls may be monitored or recorded a client services rep will be with you in a moment. Hello upright law bankruptcy law firm. I just called this number is on the website and it was a let me throw out my little application for example please I am. Sure well I can just go ahead you have for you know. OK, I can use my first name for me that is ok, I ask H. ok Kisha you are OK Can you spell your last name for me. He isn't call you are OK And is there a good email to reach you out you know what's going to be my last name and then my first name thirty one remembers. That you. All were close to one OK spur Kisha three one eight eight a G. Mail dot com. Perfect I think is the best number to reach you out and yes it is OK I have six twenty two one zero two nine four nine five yes it is what state and zip code he located in Kisha. Illinois. Code six two zero three five six two zero three five. So here it upright law one of the things we care most about is our clients' stories so what's your story today what's got you no position when you're looking into declaring a bankruptcy. Bought a car a few years ago. Found. It had been pulled out of the lake during Hurricane Katrina. Pulled it out revamped as they could. For twenty one grand and then paid on it for the most part totaled and. The money went for them and I went to court a couple years ago and signed a document that I would not. I would not be taken back to court for the day ever it was over and done with you know and I could be relieved or well I just received a seven thousand dollars garnishment in the mail this morning. I don't have. Them pulled out of my. Character and I don't think. I've made up my other that for the most part but. The point where. I messed up my credit when I was really really. Like for the just and the back of the waters. OK And. Garnishment when it was starting. To wear. Terribly there was a court date and I had no knowledge of it which I understand they may have posted it in a public forum. I work my life away I don't have time to try. OK well. OK yeah the concern is just the doing a bankruptcy will stop a garnishment. But it will I be after the for the full bankruptcy gets rolling so a lot of people are like I'm being garnished I want to do bankruptcy but then they don't have the money for the bankruptcy because they're being tarnished but even if the government hasn't started yet and we don't know when it's starting hopefully we can beat the garnishment here right because I haven't started but I don't rule in their favor but didn't say when they were in a store and as far as I can go home or tax I'm. OK You know that's not the only one but you know I'm mad when I was like you and I have no I don't now and I can't live on the back. For sure I mean that's it's honestly what we hear a lot here at the firm it's people who are like they've got debts when they were eighteen got their first credit card annihilated their credit and now they're an adult may have a life back on track those they can't keep up with the debts and then I mean it's. Unfortunately life nowadays and but I mean that's why we're here it's to help people out of situations like that. So how much debt would you say that you're in overall Well the car let alone i was talking about seventeen grams so. Yeah it's bad there's like three small car and then there's a. Couple other things I have got to be over twenty grand OK yeah definitely something we can help out with here and so I mean you tell me the story about how we got to where we are today would you like the story to be afterwards is there anything you'd like to accomplish from this bankruptcy clears Yes I can I ask. You you know like you know I'd like to buy something and be stable. And then turn around and I'm running around and doing all that you know. I don't like to pay for law school or some kind of money on the. Well how do I get a scholarship to oil or kill but I was too stupid to take it so. I will. Cash it let's let's if we can get it as I mean it looks like a situation is definitely kind of situation we could help out with. A couple logistical questions just to make sure you're in the position where you'll be able to work with us if. You have an active debit card the use yes I do OK and you said you're collecting income when is your next payday. February third of February third So next Wednesday is it right. And. And so. Everything looks good to me here I have one more question for you sure on a scale of one to ten with one being still really kind of unsure about this whole bankruptcy thing and ten being the deftly want to go back up again today. How motivated you say or if I think your financial situation. There given I have. To know so then what I can do now because I can put you through to one of our senior client consultants just OK and what they do is they work with the details of our the bankruptcy that we will tell you how much it costs how long it's going to take the answer any question you have about it and at the end of that conversation if everything sounds good in the sounds like when you want to move forward with we can even get the paperwork started today OK OK. OK And then just go ahead and stand in line here this can be a brief silence then I'll be back in the call with my senior quite consult and I'll make sure the two of you are connected and then I take it here OK OK OK just go and so I we connected. Hi kesa Carlo this is Joey my senior client and so he's one of our best he's going to take everything from here it was a pleasure speaking with you. Thank you to tell the nice even. You to. Kiss your good evening hello Mr My name is Joe we go from a bankruptcy attorney here I understand from Christian your instant interested in get the bankruptcy started today yes. OK. Like I said I'm one of our attorneys here and what I'd like to do spend about a couple minutes with you getting a little deeper picture of what's going on figure out exactly what we want to do here in your in your bankruptcy what's going to be your best option and then get that started OK. OK So let me ask you I'm looking over your information here what's going on with your debt how did we get to this point. I bought a car when I was like. Are Now I ask her sleep when I want to go. I paid twenty one grand for and I was very clear and I won Grand Am. Learning theory of Hurricane Katrina so that's where we're at with that. And basically for me in the twenty one I scared myself pretty bad and what really upsets me is that I got back company I got them bad like they called me they didn't ask who I was or how we knew anything nothing no many Miranda nothing and I called the attorney general and they let them do their own investigation so nothing ever came of that and. It's something. OK And I mean what's going on today I mean what's going on with this point today that this is the day you're sort of getting more s"
        }
        
  ]
}'
```

Example Response:

```{
    "vocabularyName": "sunpower",
    "vocabularyType": "scripts",
    "scripts": [
        {
            "script": "Drop in for another eighteen months or so before I really quit. So why'd I drop out. It started before I was born. My biological mother was a young unwed graduate student and she decided to put me up for adoption. She felt very strongly that I should be adopted by college graduates so everything was all set for me to be adopted at birth by a lawyer and his wife except that when I popped out they decided at the last minute that they really wanted a girl so my parents who were on a waiting list got a call in the middle of the night asking we have got an unexpected baby boy, do you want him? They said of course. My biological mother found out later that my mother had never graduated from college and that my father had never graduated from high school, she refused to sign the final adoption papers. She only relented a few months later when my parents promised them."
        },
        {
            "script": "Thanks for calling up write law to ensure the highest level of service for our clients calls may be monitored or recorded a client services rep will be with you in a moment. Hello upright law bankruptcy law firm. I just called this number is on the website and it was a let me throw out my little application for example please I am. Sure well I can just go ahead you have for you know. OK, I can use my first name for me that is ok, I ask H. ok Kisha you are OK Can you spell your last name for me. He isn't call you are OK And is there a good email to reach you out you know what's going to be my last name and then my first name thirty one remembers. That you. All were close to one OK spur Kisha three one eight eight a G. Mail dot com. Perfect I think is the best number to reach you out and yes it is OK I have six twenty two one zero two nine four nine five yes it is what state and zip code he located in Kisha. Illinois. Code six two zero three five six two zero three five. So here it upright law one of the things we care most about is our clients' stories so what's your story today what's got you no position when you're looking into declaring a bankruptcy. Bought a car a few years ago. Found. It had been pulled out of the lake during Hurricane Katrina. Pulled it out revamped as they could. For twenty one grand and then paid on it for the most part totaled and. The money went for them and I went to court a couple years ago and signed a document that I would not. I would not be taken back to court for the day ever it was over and done with you know and I could be relieved or well I just received a seven thousand dollars garnishment in the mail this morning. I don't have. Them pulled out of my. Character and I don't think. I've made up my other that for the most part but. The point where. I messed up my credit when I was really really. Like for the just and the back of the waters. OK And. Garnishment when it was starting. To wear. Terribly there was a court date and I had no knowledge of it which I understand they may have posted it in a public forum. I work my life away I don't have time to try. OK well. OK yeah the concern is just the doing a bankruptcy will stop a garnishment. But it will I be after the for the full bankruptcy gets rolling so a lot of people are like I'm being garnished I want to do bankruptcy but then they don't have the money for the bankruptcy because they're being tarnished but even if the government hasn't started yet and we don't know when it's starting hopefully we can beat the garnishment here right because I haven't started but I don't rule in their favor but didn't say when they were in a store and as far as I can go home or tax I'm. OK You know that's not the only one but you know I'm mad when I was like you and I have no I don't now and I can't live on the back. For sure I mean that's it's honestly what we hear a lot here at the firm it's people who are like they've got debts when they were eighteen got their first credit card annihilated their credit and now they're an adult may have a life back on track those they can't keep up with the debts and then I mean it's. Unfortunately life nowadays and but I mean that's why we're here it's to help people out of situations like that. So how much debt would you say that you're in overall Well the car let alone i was talking about seventeen grams so. Yeah it's bad there's like three small car and then there's a. Couple other things I have got to be over twenty grand OK yeah definitely something we can help out with here and so I mean you tell me the story about how we got to where we are today would you like the story to be afterwards is there anything you'd like to accomplish from this bankruptcy clears Yes I can I ask. "
        }
    ],
    "_links": {
        "self": {
            "href": "https://apis.voicebase.com/v3/definition/vocabularies/sunpower"
        }
    }
}```

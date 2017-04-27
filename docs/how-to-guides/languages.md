# Languages

VoiceBase supports several spoken languages and dialects.

**The following languages and dialects are supported in the V2 (Beta) API:**

| Language              | code  | Supported Frequency |
|-----------------------|:-----:|:-------------------:|
| English US            | en-US | 8, 16 |
| English United Kingdom | en-UK | 8, 16 |
| English Australian    | en-AU | 8,16  |
| Spanish - Latin America | es-LA| 8, 16 |
| Portugese Brazil      | pt-BR | 8     |


### Feature Support by Language

| Language              | Transcription | Keywords | Topics | Predictions | Custom Vocabulary | Number Formatting | Callbacks | PCI Detect/Redact | 
|----------             |:-------------:|:--------:|:------:|:-----------:|:-----------------:|:-----------------:|:---------:|:------------------|
| English US            | x             | x         | x     | x         |       x           |       x           |       x   |   x   |
| English United Kingdom| x             | x         | x     | x         |       x           |       x           |       x   |    x  |
| English Australian    | x             |   x       |   x   |   x       |       x           |       x           |       x   |   x   |
| Spanish - Latin America| x            |
| Portugese Brazil      | x             |         




## Configuring Language Support

Use the language configuration parameter to set the language. Omitting the parameter defaults the language to U.S. English (`en-US`).

For example, to transcribe a recording in Australian English:

```json
{  
  "configuration": { 
    "language":"en-AU"
  }
}
```

- `configuration` : The root configuration section.
    - `language` : The language code.
        - `en-US` : US English
        - `en-UK` : UK English
        - `en-AU` : Austrialian English
        - `es-LA` : Latin American Spanish
        - `pt-BR` : Brazilian Portuguese
                        
## Disabling Semantic Keywords and Topics

[Semantic keywords and topics](keywordsandtopics.html) are not currently supported with Spanish and Portuguese. When transcribing in these languages, disable these options in your configuration.

```json
{
  "configuration": {
  "language": "es-LA",
    "keywords": {
      "semantic": false
    },
    "topics": {
      "semantic": false
    }
  }
}
```

- `configuration` : The root configuration section.
    - `language` : The language code.
        - `es-LA` : Latin American Spanish
        - `pt-BR` : Brazilian Portuguese
    - `keywords` : The keywords sub-section
        - `semantic` : The semantic keywords sub-section
            - `false` : The value is false to indicate no semantic keywords.
    - `topics` : The topics sub-section
        - `semantic` : The semantic topics sub-section
            - `false` : The value is false to indicate no semantic topics.
  

## Examples

** Note: Export your api `TOKEN` prior to running any of the following examples.
         
```bash
export TOKEN='Your Api Token'
```

### U.S. English

```bash
curl https://apis.voicebase.com/v2-beta/media \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
        "language": "en-US",
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```

### U.K. English
```bash
curl https://apis.voicebase.com/v2-beta/media \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
        "language": "en-UK",
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```

### Australian English
```bash
curl https://apis.voicebase.com/v2-beta/media \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
        "language": "en-AU",
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```

### Latin American Spanish
```bash
curl https://apis.voicebase.com/v2-beta/media  \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
        "language": "es-LA",
        "keywords": {
          "semantic": false
        },
        "topics": {
          "semantic": false
        }
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```

### Brazilian Portuguese
```bash
curl https://apis.voicebase.com/v2-beta/media  \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
        "language": "pt-BR",
        "keywords": {
          "semantic": false
        },
        "topics": {
          "semantic": false
        }
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```


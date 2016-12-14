# Languages

VoiceBase supports several spoken languages and dialects.

**Languages supported in the V2 (Beta) API:**
* English
  * U.S. English (en-US) - *default*
  * U.K. English (en-UK)
  * Australian English (en-AU)
* Spanish
  * Latin America (es-LA)
* Portuguese
  * Brazil (pt-BR)

## Configuring Language Support

Use the language configuration parameter to set the language. Omitting the parameter defaults the language to U.S. English (`en-US`).

Doe 

```json
{  
  "configuration": { 
    "language":"en-AU"
  }
}
```

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

## Examples

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


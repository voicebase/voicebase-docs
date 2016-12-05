# Language Support
VoiceBase includes support for several languages and dialects besides U.S. English.

**Languages supported:**
* English
  * U.S. English (en-US) - *default*
  * U.K. English (en-UK)
  * Australian English (en-AU)
* Spanish (Keywords and Topics not Supported)
  * Latin America (es-LA)
* Portuguese (Keywords and Topics not Supported)
  * Brazil (pt-BR)

## Configuring Language Support
Use the language configuration parameter to set the language.  

```json
{  
  "configuration": { 
    "language": "en-AU"
  }
}
```

### Remove Keywords and Topics Support where Necessary
Keywords and Topics are not supported for Spanish or Portuguese, and must be removed by setting the semantic configuration to false for both keywords and topics. 

```json
{
  "configuration":{
  "language":"es-LA",
  "keywords": {
    "semantic": false
  },
  "topics": {
    "semantic": false
  }
}
```

## Complete Examples
### U.S. English
```json
curl https://apis.voicebase.com/v2-beta/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration":{
        "language":"en-US",
      }
    }
```
### Australian English
```json
curl https://apis.voicebase.com/v2-beta/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration":{
        "language":"en-AU",
      }
    }
```
### Latin American Spanish
```json
curl https://apis.voicebase.com/v2-beta/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration":{
        "language":"es-LA",
        "keywords": {
          "semantic": false
        },
        "topics": {
          "semantic": false
        }
      }
    }
```

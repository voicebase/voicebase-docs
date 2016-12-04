# Keywords and Topics


Voicebase can automatically extract a specified or semantically extracted 
set of keywords and associated topics from transcript.  

## Enabling Keywords and Topics

Adding keywords and topics to your media post configuration, enables semantic keywords and topic extraction.

```json
{  
  "configuration": { 
    "keywords": { 
      {  
        "semantic": true,
        "groups" : ['array', 'of', 'keyword', 'groups', 'you', 'have', 'defined'],
        
      },
       "topics" : {
        "semantic": true
      }
    }
  }
}
```

configuration.keywords.semantic enables or disables semantic keyword extraction.
configuration.topcs.semantic enables or disables semantic keyword extraction.
configuration.keywords.groups allows you to specify the keyword groups you have defined.

The configuration items are independent.  If you are only interested in identifying specific words or phrases, you would  only specify configuration.keywords.groups, for example:

```json
{  
  "configuration": { 
    "keywords": { 
      {  
        "semantic": false,
        "groups" : ['array', 'of', 'keyword', 'groups', 'you', 'have', 'defined'],
        
      },
       "topics" : {
        "semantic": false
      }
    }
  }
}
```



## Keyword Group Management

Voicebase allows you to specify pre-defined keyword groups which you can later use for targeted keyword extraction, as we see in the above example.

    Reference to data classes.

## Complete Examples



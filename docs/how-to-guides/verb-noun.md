# Verb-Noun Pairs

## Overview

Noun-Verb Pairs enables analysts and business users to organically discover topics of discussion within calls, email, chat, survey and social media without having to create [categories](categories.html). POS, specifically noun-verbs-pairs, pulls out the nouns and each noun's associated verb from each text sentence. The nouns are then paired with their associated verbs together from a call, set of calls, or text files to visualize the groupings of nouns (by count) and their associated verbs (by count) for each noun.

"Neg" and "Noun-neg" are optional fields. When present, they indicate a negative modifier for the verb or noun, respectively. 

When the Verb-Noun Pairs feature is combined with [Sentiment by Turn](sentiment-by-turn.html), nouns and verbs pairings will be able to carry a sentiment score and display sentiment by noun and verb cluster so the user can understand the topical drivers of positive and negative sentiment.

## Configuration

```json
{ 
   "speakerSentiments":true,
   "conversation":{ 
      "verbNounPairsEnabled":true
   }
}
```

## Output

```json
{
"noun-verb-pairs": [
{"timestamp": {"s": 6679, "e": 7260}, "V": "call", "N": "team", "speaker": "agent"}, 
{"timestamp": {"s": 16250, "e": 17340}, "V": "need", "N": "help", "speaker": "caller"}, 
{"timestamp": {"s": 44279, "e": 45099}, "V": "have", "N": "question", "neg": "not", "speaker": "caller"},
{"timestamp": {"s": 807908, "e": 808918}, "V": "work", "N": "internet", "neg" : "not", "speaker": "caller"},
{"timestamp": {"s": 901234, "e": 902786}, "V": "work", "N": "internet", "neg" : "not", "speaker": "caller"},
{"timestamp": {"s": 1002560, "e": 1003010}, "V": "work", "N": "internet", "neg" : "never", "speaker": "caller"},
{"timestamp": {"s": 1167845, "e": 1169252}, "V": "provide", "N": "justification", "noun-neg" : "no", "speaker": "agent"},
{"timestamp": {"s": 1223475, "e": 1224005}, "V": "like", "N": "service", "question" : true, "speaker": "agent"}
]
}
```
Corresponding sample text for each of the above pairs is given below:

- Calling team
- Need help with my account
- I do not have a question
- The stupid internet doesn"t work
- My internet is not working  
- My internet never works
- They provide no justification
- Do they like our service

Please note that "N", "V" and "neg" words are replaced by their lemma. For example, "working", "works", "worked" will all be denoted as "work" only and "doesn't" will have "neg" value as "not". This means that both "internet doesn't work" and "internet is not working" will have the same values. 





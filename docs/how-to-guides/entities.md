# Entity Extraction

## Overview

VoiceBase Entity Extraction locates named entities mentioned in an audio file, then classifies them into pre-defined categories such as person names, organizations, locations, time expressions, quantities, and monetary values.

Available entities include "location", "person", "organization", "money", "number", "phone", "time", and "date". 


## Configuration

To add entities to your transcript, include the following configuration when making a POST request to the /media resource:

```json
{ "entity" : { "enableEntityExtraction" : true } } 
```

The returned transcript will contain entities in the following format:

```json
{
	"entities": [{
			"text": "four one five eight zero nine nine",
			"type": "phone",
			"formattedText": "4158099",
			"s": 32582,
			"e": 36183
		},
		{
			"text": "Aisha",
			"type": "person",
			"s": 2160,
			"e": 2490
		},
		{
			"text": "San Francisco",
			"type": "location",
			"s": 2760,
			"e": 3030
		},
		{
			"text": "VoiceBase",
			"type": "organization",
			"s": 43075,
			"e": 43705
		},
		{
			"type": "money",
			"formattedText": "$240.00",
			"text": "two hundred forty",
			"s": 55549,
			"e": 57779,
			"money": {
				"whole": 240,
				"centi": 0
			}
		},
		{
			"type": "date",
			"text": "July",
			"s": 165739,
			"e": 166299
		},
		{
			"type": "date",
			"text": "second",
			"s": 166309,
			"e": 166799
		},
		{
			"type": "time",
			"text": "one",
			"s": 168219,
			"e": 168509
		},
		{
			"type": "time",
			"text": "o'clock",
			"s": 168519,
			"e": 168989
		}

	]
}
```

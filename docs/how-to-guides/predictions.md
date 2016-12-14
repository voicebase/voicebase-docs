# Classifiers (Predictions)

VoiceBase enables you to take advantage of machine learning to make business predictions from a recording. This can help

VoiceBase runs the classifier when the recording is proccessed, and return a predicted class and confidence score. Common use cases of classifiers include:

- Identifying leads and prospects
- Automating quality control
- Predicting customer churn
- Detecting appointments, estimates, and orders
- Marking calls sent to voice mail


## Adding a classifier
Please contact your VoiceBase Account Team if you are interested in adding a
classifier to your account, and we can guide you through the process.

## Listing classifiers

A list of classifiers available in your account can be obtained as follows:
```bash
curl https://apis.voicebase.com/v2-beta/definitions/predictions/models \
     --header "Authorization: Bearer ${TOKEN}"
```

An example response:

```json
{
  "_links" : {
    "self" : { "href": "/v2-beta/definitions/predictions/models" }
  },
  "models" : [
    {
      "name": "sales-lead",
      "displayName": "Sales Lead",
      "modelId": "c8b8c1f7-e663-4a05-a6b5-7e1109ee2947",
      "type": "binary",
      "classes": [
        "sales-lead",
        "not-a-sales-lead"
      ]
    }
  ]
}
```

## Using a classifier

Enable a classifier by providing the prediction model revision identifier
in the `predictions` section of the `configuration` when POSTing to /media

```json
{
  "configuration": {
      "predictions": [
        { "model" : "c8b8c1f7-e663-4a05-a6b5-7e1109ee2947" }
      ]
  }
}
```

When you GET the media results, the response will include the `predictions`
section.

```json
{
  "media": {
    "predictions": {
      "latest": {
        "predictions": [
          {
            "model": "c8b8c1f7-e663-4a05-a6b5-7e1109ee2947",
            "class": "sales-lead",
            "score": 1.729,
            "type": "binary"
          }
        ],
        "detections": []
      }
    }
  }
}
```


## Examples

### Example: Using a classifier

```bash
curl https://apis.voicebase.com/v2-beta/media \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
          "predictions": [
            { "model" : "630c31d0-f116-47a4-8b9f-3e7ac6313463" }
          ]
      }
    }' \
    --header "Authorization: Bearer ${TOKEN}"
```

# Classifiers (Predictions)

Classifier are used to identify an event or categorize a recording. VoiceBase
uses machine-learning techniques to build a model and then predict the presence
of a signal.

VoiceBase returns the event prediction result along with a confidence score in the JSON
data after the call has been processed. A few examples of events we typically
score include: “Hot Lead” / “Non-Prospect”, “Appointment Scheduled”,
“Order Placed”, “Complaint”, “Answering Machine Detected”.

## Adding a classifier
Each classifier require a training set of data before it can be enabled. Please,
contact your VoiceBase Sales Representative if you are interested on adding a
classifier to your account and for details on providing the training set.

## Listing classifiers
Since most classifiers are trained for specific customer, the list of classifiers
is unique to your VoiceBase account.

A list of classifiers available in your account can be obtained as follows:
```bash
curl -v   https://apis.voicebase.com/v2-beta/definitions/predictions/models \
        --header "Authorization: Bearer $TOKEN" \
        --header "Accept: application/json"
```

```json
{
  "_links" : {
    "self" : { "href": "/v2-beta/definitions/predictions/models" },
    "items" : { "href" : "/v2-beta/definitions/predictions/models/{modelName}" }
  },
  "models" : [
    {
      "name" : "sales-lead",
      "revision" : "630c31d0-f116-47a4-8b9f-3e7ac6313463",
      "outcome" : {
        "type" : "probability"
      },
      "training" : {
        "media" : {
          "f1cdae9b-36ab-4c78-a3ba-d4437109c633" : {
            "sales-lead" : 0.0
          },
          "81144267-0aae-46d6-854b-f342dd030910" : {
            "sales-lead" : 0.0
          },
          "cabab530-73f1-4f0b-a3ea-36c4e3d25fa4" : {
            "sales-lead" : 0.0
          },
          "11bd5a3b-344b-4bd7-9272-fd634304c743" : {
            "sales-lead" : 0.0
          },
          "58f0c032-8067-4dce-ab6e-88db39d3e980" : {
            "sales-lead" : 0.0
          },
          "3ec121a8-f89b-496b-932b-8f1e33c34e9c" : {
            "sales-lead" : 1.0
          },
          "a940898b-d895-4edc-90af-b457b1bbaac8" : {
            "sales-lead" : 1.0
          },
          "7c587b94-e0cf-4bf6-b0f4-804ee60d823d" : {
            "sales-lead" : 1.0
          },
          "c3338d81-10f7-461e-b8b9-169810e6c27a" : {
            "sales-lead" : 1.0
          },
          "833323a4-fd18-4f28-8da6-d17931a5ef13" : {
            "sales-lead" : 1.0
          }
        }
      }
    }
  ]
}
```

## Enabling a classifier

Enable a classifier by providing the prediction model revision identifier
in the `"predictions"` section of the `configuration` when POSTing to /media

```json
{
  "configuration": {
      "predictions": [
        { "model" : "630c31d0-f116-47a4-8b9f-3e7ac6313463" }
      ]
  }
}
```

When you GET the media results, the response will include the `"predictions"`
section.
```json
{
"predictions": {
      "latest": {
        "revision": "2c24f68c-7020-4914-9c8a-98c5d8c0fd8c",
        "predictions": [
          {
            "score": -1.729735968273066,
            "type": "binary",
            "class": "sales-lead",
            "model": "630c31d0-f116-47a4-8b9f-3e7ac6313463"
          }
        ],
        "detections": []
      }
    }
}
```


## Complete examples

```bash
curl https://apis.voicebase.com/v2-beta/media \
    --header "Authorization: Bearer $TOKEN" \
    --form media=@recording.mp3 \
    --form 'configuration={
      "configuration": {
          "predictions": [
            { "model" : "630c31d0-f116-47a4-8b9f-3e7ac6313463" }
          ]
      }
    }'
```

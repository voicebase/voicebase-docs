# Classifiers (Predictions)

VoiceBase enables you to take advantage of machine learning to make business predictions from a recording.

VoiceBase runs the classifier when the recording is processed, and return a predicted class and confidence score. Common use cases of classifiers include:

- Identifying leads and prospects
- Automating quality control
- Predicting customer churn
- Detecting appointments, estimates, and orders
- Marking calls sent to voice mail


## Adding a classifier
Please contact your VoiceBase Account Team if you are interested in adding a
classifier to your account, and we can guide you through the process.

## Listing classifiers

A list of classifiers available in your account can be obtained as follows by making a GET request on the `/definitions/predictions/models` resource.

```bash
curl https://apis.voicebase.com/v3/definitions/predictions/classifiers \
     --header "Authorization: Bearer ${TOKEN}"
```

An example response:

```json
{
  "_links" : {
    "self" : { "href": "/v3/definitions/predictions/classifiers" }
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

- `models` : array of classifier model objects.
    - `[n]` : a `model` object.
        - `name` : the key name of the classifier.
        - `displayName` : the display name of the classifier.
        - `modelId` : The unique identifier of the classifier.
        - `type` : The model type, one of:
            - `binary` : A binary classifier
            - `multi` : A classifier with multiple classes (TODO: verify the type)
        - `classes` : an array classes that the model detects.

## Using a classifier

Enable a classifier by providing the classifier model revision identifier
in the `predictions` section of the `configuration` when POSTing to /media.
A classifier can be referred by its name or by its revision identifier.
Classifiers referred by name are provided by VoiceBase.


```json
{
  "prediction": {
    "classifiers": [
      { "classifierId" : "c8b8c1f7-e663-4a05-a6b5-7e1109ee2947" },
      { "classifierName": "sentiment" } 
    ]
  }
}
```



  - `prediction` : Prediction section
    - `classifiers` : List of classifiers to run
        - `[n]` : A classifier item.
            - `classifierId` : The unique identifier of a classifier model.
            - `classifierName` : The unique name of a classifier model.

When you GET the media results, the response will include the `prediction`
section.

```json
{
  "prediction": {
      "classifiers": [
        {
          "classifierDisplayName": "Sales Lead",
          "classifierId": "c8b8c1f7-e663-4a05-a6b5-7e1109ee2947",
          "classifierName": "sales-lead",
          "classifierType": "binary",
          "predictedClass" : 0,
          "predictedClassLabel": "not-a-sales=lead",
          "predictionScore" : 1.729  
        }
      ]
   }
}
```

- `prediction` : Prediction section
  - `classifiers` : List of results for each requested classifier
   - `[n]` : A classifier result.
      - `classifierId` : The unique identifier of the classifier model
      - `classifierName`: The classifier model name
      - `predictedClass` : The class of the prediction, as a index number
      - `predictedClassLabel` : The name of the class
      - `predictionScore` : Probability score.
      - `classifierType` : The type of the classifier.

## Examples

### Example: Using a classifier

```bash
curl https://apis.voicebase.com/v3/media \
    --form media=@recording.mp3 \
    --form configuration='{
        "prediction":
          "classifiers" : [
             { "classifierId" : "630c31d0-f116-47a4-8b9f-3e7ac6313463" }
           ]
      }' \
    --header "Authorization: Bearer ${TOKEN}"
```

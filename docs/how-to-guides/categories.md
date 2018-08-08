# Categories

VoiceBase enables you to apply speech analytics to a recording and categorize it according to business definitions. Each definition is called a category and it consists of a conditional statement that is applied to the transcription results and any corresponding metadata provided with the recording.

VoiceBase runs the categories when the recording is processed, and returns a boolean result where a 1 equals a match for the category definition and 0 when it does not match.

## Adding a category

To define or update a category, make a `PUT` request against the `/definition/categories/{categoryName}` resource.

The JSON body of the request contains the category definition. For example:

```json
{
  "categoryDescription": "This category looks for participants saying hello",
  "query": "SELECT * FROM media MATCH 'hello'",
  "notes": "Notes about creating or maintaining the category can be added here",
  "tags": [
    "hello",
    "greeting",
    "example"
  ],
  "version": "0.0.1"
}
```

The body of the category definition contains the following fields:

- `categoryName`: The key name of the category. The name may not contain any spaces.
- `categoryDescription`: The optional description of the category. The description is a string that is limited to ? characters including spaces.
- `query`: A condition for evaluating a recording transcription and the accompanying metadata. The condition is written using the VBQL syntax.
- `notes` : Optional information that helps the users and managers of the category further understand the category. The notes is a string that is limited to 4,000 characters including spaces.
- `tags` : An optional array of terms that helps users and managers of the category further understand the category. Each tag is string that is limited to 64 characters with maximum of 32 tags. The tags are not used anywhere else in the VoiceBase platform.
- `version`: An optional string value that helps the users and managers of the category further understand the version of the category. A version is unique to the account and is not used anywhere else in the VoiceBase platform.


## Listing categories

To list defined categories, make a `GET` request against the `/definition/categories` resource.

For example, if the account has `hello` and `goodbye` categories defined, the response would be (fields omitted for clarity):

```json
{
  "categories": [
    {
      "categoryName": "hello",
      "categoryDescription": "This category looks for participants saying hello"
    },
    {
      "categoryName": "goodbye",
      "categoryDescription": "This category looks for participants saying goodbye"
    }
  ]
}
```

## Computing all categories

To enable categorization (computing categories), add a `categories` section to your `configuration` when POSTing to /media. The `categories` configuration is an array. To request that all categories be computed, add a single element consisting of a JSON object with the `allCategories` flag set to `true`.

```json
{
  "categories": [
    { "allCategories": true }
  ]
}
```

The `configuration` contains the following fields:

- `categories`: The configuration section for categorization
- `allCategories`: A flag that indicates all categories should be computed

## Computing specific categories

To enable categorization (computing categories) for a specific subset of categories, add a `categories` section to your `configuration` when POSTing to /media. The `categories` configuration is an array. For each category to compute, add an element consisting of a JSON
object with the `categoryName` key set to the name of the category.

For example:

```json
{
  "categories": [
    { "categoryName": "hello" },
    { "categoryName": "goodbye" }
  ]
}
```

The `configuration` contains the following fields:

- `categories`: The configuration section for categorization
- `categoryName`: The name of a specific category to compute


## Results for categories

Results of categorization (computing categories) are included with responses from `GET /v3/media/{mediaId}` API, and in callbacks.

For example:

```json
{
  "categories": [
    { "categoryName": "hello", "categoryValue": 1 },
    { "categoryName": "goobye", "categoryValue": 0 }
  ]
}
```

This section contains the following fields:

- `categories`: the response section for categories
- `categoryName`: the name of the category computed
- `categoryValue`: the result of computing the category (`0` = no match, `1` = match)

*Note:* Category values are represented as `0` and `1` rather than `false` and `true`
to help in aggregation use cases common in reporting.

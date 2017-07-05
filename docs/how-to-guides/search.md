# Search

VoiceBase can search across uploaded media documents **and** related results and metadata.  This is intended for light use.  We recommend building your own search if you have many end users.

To search media documents, one makes a GET request on the `/media` resource with any combination of the following acceptable query parameters:

- `query` : Free text search
- `after` : Document uploaded after this mediaId
- `externalId` : Documents with the specified external id in the metadata.
- `extendedFilter` : A special filter which is of the form 'extendedFilter=Name|Value' which allows you to filter by extended metadata.
- `onOrAfterDate` : Created on or before this date. Acceptable format: [ISO8601](http://t.sidekickopen06.com/e1t/c/5/f18dQhb0S7lC8dDMPbW2n0x6l2B9nMJW7t5XZs8pTd2PN1qwvy8cV_HYW63JXmj56dN3wf47T3Y802?t=https://en.wikipedia.org/wiki/ISO_8601&si=5704743390019584&pi=f6509585-0574-49d3-b691-b930efd9d8ab) dates in either short form (YYYY-MM-DD) or including time (YYYY-MM-DDThh:mm:ssZ).
- `onOrBeforeDate` : Created on or before this date. Acceptable format: [ISO8601](http://t.sidekickopen06.com/e1t/c/5/f18dQhb0S7lC8dDMPbW2n0x6l2B9nMJW7t5XZs8pTd2PN1qwvy8cV_HYW63JXmj56dN3wf47T3Y802?t=https://en.wikipedia.org/wiki/ISO_8601&si=5704743390019584&pi=f6509585-0574-49d3-b691-b930efd9d8ab) dates in either short form (YYYY-MM-DD) or including time (YYYY-MM-DDThh:mm:ssZ).
- `limit` : Limit of media documents returned.
- `sortOrder` : Sort order of media documents by date.
    - `asc` : Ascending by date.  Oldest to Newest.
    - `desc` : Descending by date.  Newest to Oldest.


## Examples

** Note: Export your api `TOKEN` prior to running any of the following examples.
         
```bash
export TOKEN='Your Api Token'
```

### Simple Search

To execute a search, make a GET request to the “media” collection with a “query” parameter.  For example, to look for media where the word "bill" is relevant:

```bash
curl https://apis.voicebase.com/v3/media?query=bill \
  --header "Authorization: Bearer ${TOKEN}"
```

### Compound Expression Search

To search for media containing the terms any of the terms “bill”, “charge”, “recurring payment”, first create a query expression using the OR operator, double-quoting multi-word phrases (and optionally double-quoting single words).

```bash
“bill” OR “charge” OR “recurring payment”
```

Next, url-encode the expression:

```bash
%22bill%22%20OR%20%22charge%22%20OR%20%22recurring%20payment%22
```

Then use the encoded expression as the query parameter.

```bash
   export QUERY='%22bill%22%20OR%20%22charge%22%20OR%20%22recurring%20payment%22'
   curl --header “Authorization: Bearer ${TOKEN}” \
        'https://apis.voicebase.com/v3/media?query=${QUERY}'
```


### Metadata-Scoped Search

To scope the search to records containing a specific metadata value, add a metadata filter parameter. For example, to search for the word “bill” among only media with a “customerId” of “10101”:

```bash
curl --header “Authorization: Bearer ${TOKEN}” \
https://apis.voicebase.com/v3/media?extendedFilter=customerId|10101&query=bill
```

#### Searchable Field Definitions

To enable search over an extended metadata field, you must explicitly make the field searchable.  Use the PUT /definition/media/search api endpoint to do so.

```bash
curl https://apis.voicebase.com/v3/definition/media/search \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/json" \
  --request PUT \
  --data '{ "fields" : [ "extended.customerId" ] }'
```

### Time-Range Restricted Search

To restrict a search to media for a specific time range, add filters for lower and/or upper bounds on the creation time and date of the media. For example, to find media only for the month of January 2016:

```bash
curl --header “Authorization: Bearer ${TOKEN}” \
https://apis.voicebase.com/v3/media?onOrAfterDate=2016-01-01&onOrBeforeDate=2016-02-01&query=bill
```

VoiceBase supports [ISO8601](http://t.sidekickopen06.com/e1t/c/5/f18dQhb0S7lC8dDMPbW2n0x6l2B9nMJW7t5XZs8pTd2PN1qwvy8cV_HYW63JXmj56dN3wf47T3Y802?t=https://en.wikipedia.org/wiki/ISO_8601&si=5704743390019584&pi=f6509585-0574-49d3-b691-b930efd9d8ab) dates in either short form (YYYY-MM-DD) or including time (YYYY-MM-DDThh:mm:ssZ).

### Search Pagination

VoiceBase V2 uses cursor-based pagination to achieve pages that are stable even as media is concurrently added to the collection. Each page is governed by two parameters: “after”, indicating the “mediaId” that immediately precedes the page, and “limit” which determines the size of the page (maximum implicit size is 1000). For example, if the first page ends with the “mediaId” of “f1ea0482-af9b-45d1-bd00-5eac31cd8259”, the next page of 100 results is:

** Note: Export the mediaId for which you want more recent results.
         
```bash
export MEDIA_ID='The pivot mediaId'
```

Make a GET request on the `/media` resource with the `after` query paramater set.

```bash
curl --header “Authorization: Bearer ${TOKEN}” \
https://apis.voicebase.com/v3/media?after=${MEDIA_ID}
```

### Search with compound expressions, metadata-scoping, time-range, and pagination

To achieve metadata-scoping, date range filters, compound expressions and pagination, all three expressions can be combined as shown in this GET request on the `/media` resource with the `onOrBeforeDate`, `onOrAfterDate`, `after`, `limit`, and `query` parameters included.

```bash
curl --header “Authorization: Bearer ${TOKEN}” \
https://apis.voicebase.com/v3/media?extendedFilter=customerId|10101&onOrAfterDate=2016-01-01&onOrBeforeDate=2016-02-01&limit=100&after=8d109ced-2627-4427-8d8f-24a30f6b86b3&query=%22bill%22%20OR%20%22charge%22%20OR%20%22recurring%20payment%22
```
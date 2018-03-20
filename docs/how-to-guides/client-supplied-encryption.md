# Client Supplied Encryption

PKI (Public Key Infrastructure) encryption technology is leveraged to provide additional security for customers using the VoiceBase platform. The customer provides us with their PGP "public key", which can be used to encrypt the data, but not to decrypt it. The customer keeps their "private key" and never sends it to VoiceBase. When the media is processed, we encrypt the results using the customer's "public key" for storage and delivery to the customer. The customer receives the encrypted data, and uses the "private key" to decrypt and use the results.

Users may create a PGP key using PGP or GPG tools. We recommend to use an "RSA and RSA" key with 2048 bits, with one-year crypto-period.

### Upload the public key to VoiceBase

```bash
curl -s "https://apis.voicebase.com/v3/security/public-keys"
--header "Authorization: Bearer $TOKEN"
--header "Content-Type: application/octet-stream"
--data-binary @./my-public-key.asc
```

The upload will return a "publicKeyId". Use this ID when uploading the media.
At this point the key is ready to be used.

### Using POST /v3/media with a public key

Add the publicKeyId in your v3 API Configuration:

```json
{
    "encryption" : {
        "publicKeyId" : "the unique identifier"
     },
    "searchability" : {
        "searchable" : false
    }
}
```

#### Behavior of GETs, POSTs and DELETE when Client Supplied Encryption has been applied:

```GET /v3/media?query={query}``` Because the media is encrypted, you will be unable to search by words in the transcript or metadata.

```GET /v3/media/{mediaId}``` will display processing progress, but will not show the transcript contents.
mediaQuery — will not index or show encrypted media.
mediaGetById — Will work as normal until the media has finished processing.

```GET /v3/media/{mediaId}/transcript``` Will return a 404 if the media is encrypted.

```GET /v3/media/{mediaId}/streams``` Will list the streams available. It will only return original-encrypted or redacted-encrypted as streams, rather than original or redacted, if encryption was applied.

```GET /v3/media/{mediaId}/streams/{streamName}``` Will return the audio or video stream specified. *Note:* names of available streams are given by the previous API endpoint.

```GET /v3/media/{mediaId}/progress``` Will return processing progress.

```GET /v3/media/{mediaId}/metadata``` Will return 404 as the media metadata is encrypted.

```DELETE /v3/media/{mediaId}``` Will delete media.

```POST /v3/media/``` Will allow you to post media to the API.

```POST /v3/media/{mediaId}``` Alignment and reprocessing will fail as the original media is encrypted.

### Encryption Key Management

``` GET /v3/security/public-keys ```
Returns a list of the (public) encryption keys available. This only returns href to the URLs with the keys

```POST /v3/security/public-keys```
Stores the (public) encryption key. The body must be the PEM format of the public key. You will get back a publicKeyId, which is a UUID.

```GET /v3/security/public-keys/{publicKeyId}```
Returns the current (public) encryption key as it was originally provided through the POST operation

```DELETE /v3/security/public-keys/{publicKeyId}```
Deletes the (public) encryption key associated with the publicKeyId.

# HTTPS Request Security

VoiceBase uses an advanced Web Application Firewall (WAF) to detect and reject
requests that are likely to pose a security risk.

In order to validate and filter out security threats as early as possible,
VoiceBase has additional requirements for HTTPS requests. Requiring clients to
follow these requirements allows us to monitor, mitigate and response to
security threats, keeping the system secure for all legitimate users.

Sending requests to VoiceBase that do not follow these requirements can result
in suspension of your credentials and/or blocking of your traffic.

This page uses MUST, MUST NOT, SHOULD, and SHOULD NOT as defined in RFC 2119.

## All requests

The following requirements apply to all requests, regardless of type:

- All API requests to VoiceBase MUST contain a valid `Authorization` header, with a
valid Scheme. The only supported scheme is `Bearer` (OAuth Bearer tokens).

## GET requests

The following requirements apply to `GET` requests:

- `GET` requests MUST NOT contain a body, expect when the body is a query string.
- `GET` requests SHOULD include an `Accept` header that includes the type
returned by the API as acceptable (most APIs return `application/json`).
Omitting the Accept header is interpreted as `Accept: */*`, but this is not
recommended.

## PUT requests

The following requirements apply to `PUT` requests:

- `PUT` requests MUST specify the `Content-Type` of the body
- `PUT` requests MUST specify the `Content-Length` of the body
- `PUT` request type size MUST match the specified `Content-Type`
- `PUT` request body size MUST match the specified `Content-Length`
- `PUT` requests over 1MB in size SHOULD use Chunked-Transfer encoding
and 100-Continue

### API-Specific Details

All currently available `PUT` APIs support `application/json` as the required
`Content-Type`.

## POST requests

The following requirements apply to `POST` requests:

- `POST` requests MUST specify the `Content-Type` of the body
- `POST` requests MUST specify the `Content-Length` of the body
- `POST` request type size MUST match the specified `Content-Type`
- `POST` request body size MUST match the specified `Content-Length`,
  unless Chunked-Transfer is used
- `POST` requests with Chunked-Transfer encoding MUST specify the `Content-Length` of each chunk
- `POST` requests over 1MB in size SHOULD use Chunked-Transfer encoding
and 100-Continue

### API-Specific Details

Except for multi-part `POST` APIs specified below, all currently available
`POST` APIs support `application/json` as the required `Content-Type`.

### Multi-part POST requests

The following additional requirements apply to multi-part POST requests:
- Attachment names MUST be unique
- Attachments MUST specify a `Content-Type` and `Content-Length`
- Attachment length MUST match the specified `Content-Length`
- Attachment type MUST match the specified `Content-Type`

Currently available Multi-part POST APIs are: `/media` and `/media/{mediaId}`.
These APIs support `multipart/form-data` as the required `Content-Type`.

## DELETE requests

The following requirements apply to `DELETE` requests:

- `DELETE` requests MUST NOT contain a body, expect when the body is a query string.
- `DELETE` requests SHOULD include an `Accept` header that includes the type
returned by the API as acceptable (most APIs return `application/json`).
Omitting the `Accept` header is interpreted as `Accept: */*`, but this is not
recommended.

## TLS Security

Requests must use TLS v1.2 protocol. We continually
update our TLS policies to maintain a grade of A- of better from SSL Labs.

Requests that specify weaker TLS security are rejected.

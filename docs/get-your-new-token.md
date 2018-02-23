# Obtaining Your New API Token

After you've set up your account with a new password, you will be able to create and manage API tokens from the [VoiceBase Developer Portal](https://apis.voicebase.com/developer-portal/). After you have signed in, click the "Bearer Token Management" tile.

![Token Management Screen Shot](https://github.com/Daniel085/bucket/raw/master/tokenmgmt.png)

## Add a New Token
After you have navigated to the Bearer Token Management, click the "New Token" button to create a new token. After clicking 'Create Token', you will be shown the following screen.

Download or copy the Bearer Token to your clipboard so that you can quickly update your API calls.

![Dev Portal Screen Shot](https://github.com/Daniel085/bucket/raw/master/tokenConfirm.png)

## Updating Your Code
Once you have obtained your new API token, simply replace all occurrences of your old API token with the new bearer token. In this example shell script, the token is tha value declared in the first line.

```sh
  export TOKEN = AbCd123456.FE87d6c54b32A1

  curl https://apis.voicebase.com/v3/media \
    --header "Authorization: Bearer ${TOKEN}" \
    | jq
```

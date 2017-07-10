# Priority

With this feature you have the ability modulate the processing priority of your POST request to /v3/media

Media can be submitted with 3 different priority levels: "low", "normal" and "high".

For SLA and pricing information contact [Voicebase Sales](http://info.voicebase.com/contact-sales) to learn more.


```json
{
  "priority" : "normal"
}
```


```bash
curl https://apis.voicebase.com/v3/media \
  --header "Authorization: Bearer ${TOKEN}"  \
  --form media=@recording.mp3 \
  --form configuration='{
      "priority": "low"
    }'
```

# Conversation Metrics

VoiceBase enables you to apply to a recording predefined algorithms that compute metrics useful for tracking the quality of the conversation in the recording. Each metric is applied to the transcription results, uses the word timing and words themselves and the numeric results for each metric are provided with the json output.

## Using Conversation Metrics

Enable conversation metrics for the account by setting the “metricGroupName” for each group in the “metrics” section of the “configuration” when POSTing to /media. The configuration may have one, two, three or all four of the metric groups in the POST.

```json
{
  "metrics": [
    { "metricGroupName": "overtalk" },
    { "metricGroupName": "sentiment" },
    { "metricGroupName": "talk-style-tone-and-volume" },
    { "metricGroupName": "talk-time-and-rate" }
  ]
}
```
The `metrics` section of the configuration contains the following fields:
- `metrics`: The metrics section
- `metricGroupName`: The name of the metric group (available groups are:
  `"overtalk"`, `"sentiment"`, `"talk-style-tone-and-volume"`, and
  `"talk-time-and-rate"`)

## Results for Metrics

Results of metrics are included with response from the `GET /v3/media/{mediaId}`
API, and in callbacks.

For example (data omitted for clarity):

```json
{
  "metrics": [
    {
      "metricGroupName": "overtalk",
      "metricValues": [
        {
          "metricName": "overtalk-ratio",
          "metricValue": 0.04
        },
        {
          "metricName": "overtalk-incidents",
          "metricValue": 2
        }
      ]
    },
    {
      "metricGroupName": "sentiment",
      "metricValues": [
        {
          "metricName": "agent-sentiment",
          "metricValue": 0.56
        },
        {
          "metricName": "caller-sentiment",
          "metricValue": 0.67
        }
      ]
    }
  ]
}
```

This section contains the following fields:

- `metrics`: The response section for metrics
- `metricGroupName`: The name of the metric group
- `metricValues`: The array of metrics and their values for the call
- `metricName`: The name for the specific metric
- `metricValue`: The value of the specific metric for the call

## Metric Definitions

The definition of each available metric is included below.

### Overtalk Metrics (6 metrics)

- `overtalk-incidents`: The number of times that the agent and caller talked at the same time, expressed as an integer from zero to n.
- `agent-overtalk-incidents`: The number of times that the agent began talking while the caller was already talking, expressed as an integer from zero to n. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-overtalk-incidents`: The number of times that the caller began talking while the agent was already talking, expressed as an integer from zero to n. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `overtalk-ratio`: The percentage of the total call duration where the agent and caller talked at the same time, expressed as a number from 0 to 1 with .01 resolution, with 0.1 corresponding to overtalk for 10% of the call. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-overtalk-ratio`: The percentage of the call where the agent and caller talked at the same time, and where the caller began talking first (e.g. the agent talked over the caller) expressed as a number from 0 to 1 with .01 resolution. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-overtalk-ratio`: The percentage of the call where the agent and caller talked at the same time, and where the agent began talking first, expressed as a number from 0 to 1 with .01 resolution. This metric applies only to Stereo calls, and will return a zero for all other types of calls.

### Talk Time and Rate Metrics (18 metrics)

- `agent-talk-ratio`: The percentage of non-silence time that the agent was talking, expressed as a number from 0 to 1 with .01 resolution. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-talk-ratio`: The percentage of non-silence time that the caller was talking, expressed as a number from 0 to 1 with .01 resolution. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `silence-ratio`: The percentage of time where neither the caller nor the agent were talking, expressed as a number from 0 to 1 with .01 resolution.
- `silence-incidents`: The number of times that neither the agent nor the caller were talking, where the duration was >4 seconds, expressed as an integer from zero to n.
- `agent-talk-rate`: The average rate of speech for the agent over the entire call, with times when the other part is talking and significant pauses removed, expressed as word per minute (WPM) as an integer from zero to n. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-talk-rate`: The average rate of speech for the agent over the entire call, with times when the other part is talking and significant pauses removed, expressed as word per minute (WPM) as an integer from zero to n. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-to-caller-talk-rate-ratio`: A measure of agent talk rate compared to the caller talk rate, expressed as ratio. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-intra-call-change-in-talk-rate`: A measure of the talk rate for the agent, as measured above, from the first 1/3 of the call compared to the rate from the last 1/3 of the call, expressed as a number from zero to positive n, where 1.0 represents no change on talk rate and .3 represents a 70% decrease in talk rate. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-intra-call-change-in-talk-rate`: A measure of the talk rate for the caller, as measured above, from the first 1/3 of the call compared to the rate from the last 1/3 of the call, expressed as a number from zero to positive n, where 1.0 represents no change in talk rate and .3 represents a 70% decrease in talk rate. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-average-streak`: The average time for all streaks of an agent talking, expressed in seconds. A streak starts with the first word spoken by the caller at the beginning of a call or the next word spoken after a pause of 3 seconds or more and ends with a pause of 3 seconds or more or the end of the call. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-longest-streak`: The total time for the longest streak of an agent talking, expressed in seconds. A streak starts with the first word spoken by the agent at the beginning of a call or the next word spoken after a pause of 3 seconds or more and ends with a pause of 3 seconds or more or the end of the call. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-median-streak`: The streak talking time value where half the agent talking streaks are below this value and half are above this value. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `average-streak`: The average time for all streaks of both an agent and a caller talking, expressed in seconds. A streak starts with the first word spoken by the caller at the beginning of a call or the next word spoken after a pause of 3 seconds or more and ends with a pause of 3 seconds or more or the end of the call.
- `caller-average-streak`: The average time for all streaks of a caller talking, expressed in seconds. A streak starts with the first word spoken by the caller at the beginning of a call or the next word spoken after a pause of 3 seconds or more and ends with a pause of 3 seconds or more or the end of the call. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-longest-streak`: The total time for the longest streak of a caller talking, expressed in seconds. A streak starts with the first word spoken by the caller at the beginning of a call or the next word spoken after a pause of 3 seconds or more and ends with a pause of 3 seconds or more or the end of the call. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-median-streak`: The streak talking time value where half the caller talking streaks are below this value and half are above this value. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `longest-streak`: The total time for the longest streak of an agent or caller talking, expressed in seconds. A streak starts with the first word spoken by the caller at the beginning of a call or the next word spoken after a pause of 3 seconds or more and ends with a pause of 3 seconds or more or the end of the call.
- `median-streak`: The streak talking time value where half of all talking streaks are below this value and half are above this value.

### Talk Style Tone and Volume Metrics (8 metrics)

*Note:* These metrics require the “voice features” feature enabled in the configuration that goes with the processing request sent to the VoiceBase /v3 endpoint.

- `agent-intra-call-change-in-pitch`: A ratio for the intra call change in pitch of the agent where the ratio is calculated by taking the average pitch for the last third of the agent’s words divided by the average pitch of the first third of the agent’s words. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-intra-call-change-in-relative-voice-volume-energy`: A ratio for the intra call change in volume of the agent where the ratio is calculated by taking the average volume for the last third of the agent’s words divided by the average volume of the first third of the agent’s words. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-relative-voice-volume-energy`: The measure of how energetically an agent speaks. The metric is the average volume of the agent’s words divided by a fixed average volume of a good agent (=4.33). This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `agent-voice-dynamism-std-dev-score`: The measure of the standard deviation for all the agent’s words in a transcription. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-intra-call-change-in-pitch`: A ratio for the intra call change in pitch of the caller where the ratio is calculated by taking the average pitch for the last third of the agent’s words divided by the average pitch of the first third of the caller’s words. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-intra-call-change-in-relative-voice-volume-energy`: A ratio for the intra call change in volume of the caller where the ratio is calculated by taking the average volume of the last third of the caller’s words divided by the average volume of the first third of the caller’s words. This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-relative-voice-volume-energy`: The measure of how energetically an agent speaks. The metric is the average volume of the agent’s words divided by a fixed average volume of a good caller (=7.57). This metric applies only to Stereo calls, and will return a zero for all other types of calls.
- `caller-voice-dynamism-std-dev-score`: The measure of the standard deviation for all the caller’s words in a transcription. This metric applies only to Stereo calls, and will return a zero for all other types of calls.

### Specific Sentiment Metrics (6 metrics)

*Note:* Sentiment scores are calculated with a combination of machine classification and NLP for sentences in the transcript.

- `agent-intra-call-change-in-sentiment`: A score that compares the sentence sentiment values of the agent for the first 3rd of the transcript to the last 3rd of the transcript.
- `agent-sentiment`: A score that compares all the sentence sentiment values of the agent for the transcript.
- `call-sentiment`: A score that compares all the sentence sentiment values for the transcript.
- `call-change-in-sentiment`: A score that compares the sentence sentiment values for the first 3rd of the transcript to the last 3rd of the transcript.
- `caller-intra-call-change-in-sentiment`: A score that compares the sentence sentiment values of the caller for the first 3rd of the transcript to the last 3rd of the transcript.
- `caller-sentiment`: A score that compares all the sentence sentiment values of the caller for the transcript.

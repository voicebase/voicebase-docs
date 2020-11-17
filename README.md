# VoiceBase V3 API Documentation

This repository contains developer documentation for the VoiceBase V3 API.

The documentation is indeed to be rendered using Sphinx docs using the ReadTheDocs theme, for display on readthedocs.io

## Developer pre-requisites

Starting with a working Python 2.7 installation, install required packages:

```bash
pip install sphinx
pip install sphinx_rtd_theme
pip install recommonmark
```

## Building and previewing the documentation

To build and preview the documentation, navigate to the `docs/` sub-directory and run:

```bash
make html
open _build/html/index.html
```

You can also run:

```bash
watch.sh
```

To rebuilding the documentation continuously on changes.

## Deployment

When deployed, this documentation appears at [http://voicebase.readthedocs.io/en/v3/](http://voicebase.readthedocs.io/en/v3/).

## Language Guide

### A high-level example story

VoiceBase `transcribes` and `analyzes` `recordings` you `upload` to the API. The `transcript` is available in JSON, plain text, and SRT formats, and the `analytics` includes `keywords`, `topics`, and `predictions`.

To get started, `upload` a `recording` by making a POST request to the /media `resource`. The API returns a unique mediaId for the `item`. You can `poll` for completion, or `subscribe` to callbacks by providing an HTTPS `endpoint` in your `configuration`.

You can also `customize` VoiceBase by defining common keywords or phrases to `spot`, selecting `models` to `predict` business outcomes or `detect` key data, and `defining` custom `vocabularies` for use in transcription.

### Common Language: Nouns

- `recording` - the media file (audio or video) to transcribe or analyze
- `configuration` - JSON document with processing instructions
- `metadata` - JSON document with metadata
- `transcript` - output of transcription (can be preceded by type e.g. plain text transcript, SRT transcript or JSON transcript)
- `analytics` - terms for higher-level results (e.g keywords, predictions)
- `model` - a predictive model
- `vocabulary` - a custom vocabulary for transcription
- `keyword group` - a group of keyword or phrases for spotting

### Common Language: Verbs

- `upload` - POST a recording to VoiceBase for transcript and analysis
- `transcribe` - generate a transcript
- `analyze` - generate some or all non-transcript analytics (keywords, predictions)
- `spot` - using (keyword, topics, or entity) spotting to flag items of interest
- `extract` - generate keywords, topics, or entities using semantic indexing
- `predict` - generate predictions (e.g. by running classifiers)
- `detect` - generate positional predictions (e.g. PCI detection)
- `poll` - query a resource in a poll awaiting an asynchronous operation
- `subscribe` - provide a callback destination
- `define` - set up a reference entity (keyword group, custom vocabulary)
- `customize` - broad term for changing VoiceBase's default

### Technical Language: Nouns

- `endpoint` - a top-level API (e.g. v3 or a callback sink; not common)
- `resource` - a specific REST resource (e.g. /media or /definitions/transcript)
- `section` - a subset of a JSON document, usually identified by its path (e.g. the predictions.latest.detections section of the analytics)
- `collection` - a resource that represents many similar things (e.g. /media)
- `item` - one member of a collection (e.g. /media/{mediaId})

### Technical Language: Verbs

- HTTP verbs: Do not use HTTP verbs as english verbs (conjugating them is awkward)
- Instead: Make a VERB request to /noun resource (or: accomplish X by making a Y request to /Z resource).
- Use common language to describe the *what*, and technical language to describe the *how*. (e.g. `Upload a recording to VoiceBase by making a POST request to the /media resource.`)

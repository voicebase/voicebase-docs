# Analytics Workbench

## Overview

The VoiceBase Analytics Workbench is a tool customers may use to investigate their uploaded data. Here, users may create Queries and [Categories](categories.html) with VoiceBase's proprietary SQL-like language (VBQL) and listen to media files using the VoiceBase Call Player.

VoiceBase's Analytics Workbench is available to current customers in their VoiceBase [account](https://app.voicebase.com/app/workbench). 

## Configuration

To publish media to the Analytics Workbench, include the following `configuration` when making a POST to /media:

```json
    "publish": {
    "enableAnalyticIndexing" : true
    }
```
For a complete guide to indexing in the Analytics Workbench and VoiceBase platform, see the steps [here](https://support.voicebase.com/indexing_how-to.html).

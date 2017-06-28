API Overview
============

VoiceBase provides APIs for speech recognition and speech analytics. Our customers use the APIs to transcribe
recordings with high accuracy, discover the keywords and topics discussed, and predict business outcomes.

#############
Authorization
#############

The VoiceBase V3 REST API is secured using OAuth Bearer tokens. Bearer tokens are issued and managed
through the `Developer Portal <https://apis.voicebase.com/developer-portal>`_.

For details on getting your first token, see the `How to Get Your Bearer Token <../how-to-guides/hello-world.html#how-to-get-your-bearer-token>`_
section of the `Hello, World How-To Guide <../how-to-guides/hello-world.html>`_.

#############
Core Workflow
#############

The core workflow of the API is to generate transcriptions and analytics from voice recordings. This workflow
is asynchronous, and a typical usage is to:

1. Upload a voice recording, starting the transcription and analysis process
2. Wait for completion, using periodic polling for status or callbacks
3. Process or retrieve results, including the transcript, keywords, topics and predictions

To achieve scalability, this workflow runs for multiple recordings in parallel.

##############
REST Call Flow
##############

A typical pattern of REST API calls to accomplish the workflow is to:

.. code-block:: http
  :linenos:

  POST /media

The body of POST request is `MIME multipart <https://www.w3.org/Protocols/rfc1341/7_2_Multipart.html>`_, with three parts:

One of:

- *media*: the voice recording attachment or,
- *mediaUrl*: URL where the API can retrieve the voice recording

and optionally:

- *configuration*: (optional) a JSON object with customized processing instructions
- *metadata*: (optional) a JSON object with metadata

The API will return a unique identifier for the new object, called a **mediaId**.

.. code-block:: http
  :linenos:
  :lineno-start: 2

  GET /media/{mediaId}/progress

This call retrieves status and progress information. When the processing is finished, the transcript and analytics can be retrieved.

.. code-block:: http
  :linenos:
  :lineno-start: 3

  GET /media/{mediaId}

The API supports `Callbacks <../how-to-guides/callbacks.html>`_ instead of polling for status, and this pattern is recommended for production integrations.

###############
Getting Started
###############

The `Hello, World How-To Guide <../how-to-guides/hello-world.html>`_ provides a practical introduction to getting started with the VoiceBase V3 REST API.

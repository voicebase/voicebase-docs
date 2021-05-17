Hello, World
============

This Quickstart tutorial gets you up and running with your first transcription and speech analytics.


The examples assume you have these prerequisites:

- *Your Bearer token* 
- *jq* for working with JSON (see: :ref:`A Quick Note on Tools <tools>` for details)
- *curl* (comes with most Linux systems, see: :ref:`A Quick Note on Tools <tools>` for details)

.. _token:

How to Get Your Bearer Token
----------------------------

Sign into your VoiceBase `account <https://app.voicebase.com>`__.
Go to Settings/Bearer Tokens and click *Add Bearer Token*.

.. image:: /_static/BearerToken.png
   :width: 550

Save your token in a secure location; it won't be visible in your account after its initial creation.

Verify your Bearer Token and tools are working
----------------------------------------------

Start by verifying your Bearer token is working by running the following from a command prompt. Please remember to insert your Bearer token after *TOKEN=* in the first line of the example. You can also find more detailed instructions on :ref:`Understanding Your First Request <understanding_step1>` below.

.. code-block:: sh
  :linenos:
  :emphasize-lines: 3

  export TOKEN= # Insert your VoiceBase Bearer token after TOKEN=

  curl https://apis.voicebase.com/v3/media \
    --header "Authorization: Bearer TOKEN" \
    | jq

You should see a response like this:

.. code-block:: json

  {
    "_links": {
      "self": {
        "href": "/v3/media"
      }
    },
    "media": []
  }

Upload a media file for transcription and analysis
--------------------------------------------------

To upload a recording for transcription and analysis, POST to /media with the recording as an attachment named media (you can also provide a URL to your recording instead using the form field 'mediaUrl').

Using local media:

.. code-block:: sh
  :linenos:
  :emphasize-lines: 2

  curl https://apis.voicebase.com/v3/media \
    --form 'media=@hello-world.mp3' \
    --header "Authorization: Bearer ${TOKEN}" \
    | tee media-post.json \
    | jq .

Using a remote media URL:

.. code-block:: sh
  :linenos:
  :emphasize-lines: 2

  curl https://apis.voicebase.com/v3/media \
    --form 'mediaUrl=http://myServer.com/mediaFile.mp3' \
    --header "Authorization: Bearer ${TOKEN}" \
    | tee media-post.json \
    | jq .



The response includes a *mediaId* (assigned by the API) and a status of *accepted*.

.. code-block:: json
  :emphasize-lines: 7

  {
    "_links": {
      "self": {
        "href": "/v3/media/10827f19-7574-4b54-bf9d-9387999eb5ec"
      },
      "progress": {
        "href": "/v3/media/10827f19-7574-4b54-bf9d-9387999eb5ec/progress"
      },
      "metadata": {
        "href": "/v3/media/10827f19-7574-4b54-bf9d-9387999eb5ec/metadata"
      }
    },
    "mediaId": "10827f19-7574-4b54-bf9d-9387999eb5ec",
    "status": "accepted",
    "dateCreated": "2021-04-22T18:23:02Z",
    "dateFinished": "2021-04-22T18:23:58Z",
    "mediaContentType": "audio/mp3",
    "length": 10031,
    "metadata": {}
  }

You can poll for status until the processing is done (for production, we recommend using `Callbacks <callbacks.html>`__).

.. code-block:: sh
  :linenos:
  :emphasize-lines: 7

  export MEDIA_ID=$( cat media-post.json | jq --raw-output .mediaId )
  export STATUS=$( cat media-post.json | jq --raw-output .status )

  while [[ ${STATUS} != 'finished' && ${STATUS} != 'failed' ]]; do
    sleep 1
    STATUS=$(
      curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/progress \
        --header "Authorization: Bearer ${TOKEN}" \
        | jq --raw-output .progress.status
    )
    echo "Got status: ${STATUS} for mediaId: ${MEDIA_ID} on $( date )"
  done

Get your transcript and analytics
---------------------------------

You can retrieve the JSON version of the transcript and all analytics with a simple API call.

.. code-block:: sh
  :linenos:
  :emphasize-lines: 1

  curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/transcript \
    --header "Authorization: Bearer ${TOKEN}" \
    | jq .

You can also retrieve a plain-text version using *transcript/text* and the *Accept* HTTP header.

.. code-block:: sh
  :linenos:
  :emphasize-lines: 1-2

  curl https://apis.voicebase.com/v3/media/${MEDIA_ID}/transcript/text \
    --header 'Accept: text/plain' \
    --header "Authorization: Bearer ${TOKEN}"


.. _understanding_step1:

Understanding Your First Request
--------------------------------

The root URL of the VoiceBase V3 API is **https://apis.voicebase.com/v3**. Every recording you submit for analysis appears in the **/media** collection and is viewable in the 'Media Browser' tab. The first request is to GET the **/media** collection (which will be empty when you first sign up). Pagination default limit is set to 100. 

.. code-block:: sh
  :linenos:

  export TOKEN= # Insert your VoiceBase Bearer token after TOKEN=

  curl https://apis.voicebase.com/v3/media?limit=10 \
    --header "Authorization: Bearer ${TOKEN:?'(hint: insert your token after export TOKEN=)'}" \
    | jq

If you're running this for the first time, the API returns:

.. code-block:: json

  {
    "_links": {
      "self": {
        "href": "/v3/media"
      }
    },
    "media": []
  }

All successful responses from the API will include an *_links* section with `HAL`_ metadata that helps navigate the API.

.. _HAL: https://en.wikipedia.org/wiki/Hypertext_Application_Language

.. code-block:: json
   :emphasize-lines: 2

  {
    "_links": { }
  }

The *media* section the list of media in your account. If you have previously uploaded media, it will appear in the list.

.. code-block:: json
  :emphasize-lines: 2

  {
    "media": []
  }

Understanding Your First Upload
-------------------------------

The next step is to upload a recording to the API for transcription and analysis, but making a POST to /media, with the recording as an attachment named media.

.. code-block:: sh
  :linenos:
  :emphasize-lines: 2

  curl https://apis.voicebase.com/v3/media \
    --form media=@hello-world.mp3 \
    --header "Authorization: Bearer ${TOKEN}" \
    | jq

When you add the *--form media=@filename.mp3* parameters, *curl* automatically sets the HTTP method to *POST* and the *Content-Type* to *multipart/form-data*. This is equivalent to the more explicit:

.. code-block:: sh
  :linenos:
  :emphasize-lines: 4-5

  curl https://apis.voicebase.com/v3/media \
    --form media=@hello-world.mp3 \
    --header "Authorization: Bearer ${TOKEN}" \
    --request POST \
    --header "Content-Type: multipart/form-data" \
    | jq

Finally, many operations will rely on providing a configuration JSON attachment with additional processing instructions. Omitting the attachment is equivalent to including the following default configuration:

.. code-block:: sh
  :linenos:
  :emphasize-lines: 3

  curl https://apis.voicebase.com/v3/media \
    --form media=@hello-world.mp3 \
    --form configuration='{}' \
    --header "Authorization: Bearer ${TOKEN}" \
    | jq

The 'How-to' guides in this documentation show configurations for each feature of the VoiceBase platform, including an overall`sample <https://configuration.html>`__.

.. _tools:

A Quick Note on Tools
---------------------

- **curl**: The examples in this documentation make use of `curl`_ for making HTTP requests to the API.
- **jq**: The `jq`_ tool helps parse JSON responses and work with JSON data.

.. _curl: https://curl.haxx.se/docs/manpage.html
.. _jq: http://stedolan.github.io/jq/




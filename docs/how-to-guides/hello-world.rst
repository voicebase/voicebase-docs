Hello, World
============

The goal of this Quickstart tutorial is to get your and running with your first transcription and related speech analytics.

Examples in this tutorial are presented using commands from bash (see: :ref:`A Quick Note on Tools <tools>` for details). They also assume that the *TOKEN* environment variable is set to your Bearer token (see: :ref:`How to Get Your Bearer Token <token>` for details).

.. code-block:: sh
  :linenos:

  curl https://apis.voicebase.com/v2-beta/media?limit=1 \
    --header "Authorization: Bearer ${TOKEN}" \
    | jq

This construct 

.. _tools:

#####################
A Quick Note on Tools
#####################

- **curl**: The examples in this documentation make heavy use of `curl`_ for making HTTP requests to the API.
- **jq**: The `jq`_ tool helps parse JSON responses and work with JSON data.

.. _curl: https://curl.haxx.se/docs/manpage.html
.. _jq: http://stedolan.github.io/jq/

.. _token:

############################
How to Get Your Bearer Token
############################



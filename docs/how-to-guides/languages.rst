Languages
=========

VoiceBase supports the following languages and dialects.


**Feature Support by Language:**

Note: en-UK and en-AU use the en-US functions for Keywords, Topics, Number Formatting and PCI.


===================  =====  =============  ========= ===============  ===============  ===========  ==== ==============
Language             Code   Transcription  Callbacks  NumFormatting   Keywords&Topics   Predictions  PCI  VoiceFeatures
===================  =====  =============  ========= ===============  ===============  ===========  ==== ==============
English US           en-US      √             √            √                √             √          √         √
English UK           en-UK      √             √            √                √             √          √         √
English AU           en-AU      √             √            √                √             √          √         √
French               fr-FR      √             √            √                √
German               de-DE      √             √            √
Italian              it-IT      √             √            √
Portuguese Brazil    pt-BR      √             √            √
Spanish LatinAm      es-LA      √             √            √                √             √          √         √
Spanish Spain        es-ES      √             √            √                √             √          √
Spanish US           es-US      √             √            √                              √          √         √
Spanish Mexico       es-MX      √             √            √                √             √          √         √
===================  =====  =============  ========= ================  ===============  ===========  ===================


Configuring Language Support
----------------------------

Use the language configuration parameter to set the language. Omitting
the parameter defaults the language to U.S. English (``en-US``).

For example, to transcribe a recording in Australian English:

.. code:: json

    {
      "speechModel" : {
        "language" : "en-AU"
      }
    }

-  ``language`` : The language code. Refer to the table above.


Disabling Semantic Keywords and Topics
--------------------------------------

`Semantic keywords and topics <keywordsandtopics.html>`__ are not
currently supported with German, Italian, or Portuguese, please disable the feature in your configuration for these languages.

.. code:: json

    {
      "knowledge": {
        "enableDiscovery" : false
    }



Examples
--------

\*\* Note: Export your api ``TOKEN`` prior to running any of the
following examples.

.. code:: bash

    export TOKEN='Your Api Token'


U.S. English for Voicemail
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    curl https://apis.voicebase.com/v3/media \
        --form media=@recording.mp3 \
        --form configuration='{
          "speechModel" : {
            "language" : "en-US"
            "extensions" : [ "voicemail" ]
          }
        }' \
        --header "Authorization: Bearer ${TOKEN}"

U.K. English
~~~~~~~~~~~~

.. code:: bash

    curl https://apis.voicebase.com/v3/media \
        --form media=@recording.mp3 \
        --form configuration='{
         "speechModel" : {
            "language" : "en-UK"
          }
        }' \
        --header "Authorization: Bearer ${TOKEN}"

Europa speech engine 
--------------------

Rather than using the UK English or Australian English language options, you may want to try our premium speech engine, `Europa <speech_engine.html>`__.       

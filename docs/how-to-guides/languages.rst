Languages
=========

VoiceBase supports several spoken languages and dialects.

**Languages supported in the V2 (Beta) API:**

===================  =====  ======
Language             Code   Supported Frequencies
===================  =====  ======
English US           en-US  8, 16
English UK           en-UK  8, 16
English Australian   en-AU  8, 16
Portuguese, Brazil   pt-BR  8
Spanish, Latin Am.   es-LA  8, 16
===================  =====  ======



**Feature Support by Language:**

Note: en-UK and en-AU use the en-US functions for Keywords, Topics, Number Formatting and PCI.

=====================  ==========  ==========  ==========  ==============  ===============
Feature                English US  English UK  English AU  Portuguese, BR  Spanish, LatAm.
Transcription              √		√		√		√		√
Callbacks		   √		√		√		√		√
Number Formatting	   √		√		√
Knowledge Extraction	   √		√		√
Prediction		   √		√		√
PCI			   √		√		√
=====================  ==========  ==========  ==========  ==============  ===============


Configuring Language Support
----------------------------

Use the language configuration parameter to set the language. Omitting
the parameter defaults the language to U.S. English (``en-US``).

For example, to transcribe a recording in Australian English:

.. code:: json

    {
      "speechModel" : {
        "language" : "en-US"
      }
    }

-  ``configuration`` : The root configuration section.

   -  ``language`` : The language code.

      -  ``en-US`` : US English
      -  ``en-UK`` : UK English
      -  ``en-AU`` : Austrialian English
      -  ``es-LA`` : Latin American Spanish
      -  ``pt-BR`` : Brazilian Portuguese

Disabling Semantic Keywords and Topics
--------------------------------------

`Semantic keywords and topics <keywordsandtopics.html>`__ are not
currently supported with Spanish and Portuguese. When transcribing in
these languages, don't enable these options in your configuration.

.. code:: json

    {
      "knowledge": {
        "enableDiscovery" : false,  // Default is false
    }

Examples
--------

\*\* Note: Export your api ``TOKEN`` prior to running any of the
following examples.

.. code:: bash

    export TOKEN='Your Api Token'

U.S. English
~~~~~~~~~~~~

.. code:: bash

    curl https://apis.voicebase.com/v3/media \
        --form media=@recording.mp3 \
        --form configuration='{
          "speechModel" : {
            "language" : "en-US"
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

Australian English
~~~~~~~~~~~~~~~~~~

.. code:: bash

    curl https://apis.voicebase.com/v3/media \
        --form media=@recording.mp3 \
        --"speechModel" : {
            "language" : "en-AU"
          }
        }' \
        --header "Authorization: Bearer ${TOKEN}"

Latin American Spanish
~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    curl https://apis.voicebase.com/v3/media  \
        --form media=@recording.mp3 \
        --form configuration='{
          "speechModel" : {
            "language" : "en-LA"
          }
        }' \
        --header "Authorization: Bearer ${TOKEN}"

Brazilian Portuguese
~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    curl https://apis.voicebase.com/v3/media  \
        --form media=@recording.mp3 \
        --form configuration='{
          "speechModel" : {
            "language" : "pt-BR"
          }
        }' \
        --header "Authorization: Bearer ${TOKEN}"

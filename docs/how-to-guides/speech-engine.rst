Speech Engines
==============

VoiceBase offers three distinct proprietary speech engines, each tuned to address different use cases. The table below shows feature support by engine.

**Europa - Premium Engine**

VoiceBase's premium engine, Europa, gives the highest accuracy and is trained on a wide range of regional accents for English. It performs well for US English audio, as well as international use cases with combinations of English speakers from the UK, India, Singapore, and other regions. 

No specific configuration is required when using its default language, US English. The default is the same for all regions and dialects of English.

Europa also supports Spanish. It is trained mainly with European Spanish, but also with other variants. 
Europa Spanish may be configured as any one of the following: "language":"es-ES", "es-MX" or "es-US". The resulting transcript will be the same regardless of which variant is configured. 


**Titan**

The Titan engine is trained on call center audio, making it a great choice for US based customers working with agent/customer calls. It supports US English only.

**Proteus**

The Proteus engine is our default, general engine trained on a wide range of audio. All languages and features are supported with the default engine.

**Feature support by engine:**

=====================  ======  ========  ======
Feature                Europa  Proteus   Titan 
=====================  ======  ========  ====== 
categories               √        √        √      
custom vocabulary        √        √        √    
number formatting        √        √        √    
keywords-and-topics      √        √        √       
keyword-spotting         √        √        √     
languages              en,es      √      en-US 
pci-ssn-pii-detection    √        √        √    
pci-ssn-pii-redaction    √        √        √        
stereo                   √        √        √    
swear word filter        √        √        √    
voice features                    √        √    
voicemail                         √            
=====================  ======  ========  ======

Europa supports English and Spanish. 
Please note that number formatting may not be disabled on the Europa speech engine.
`Custom Vocabulary <custom-vocabulary.html>`_ is supported with Europa, but the "Weighting" feature is not.

Configuration 
-------------

Enable a specific speech engine by including the ``model`` parameter under ``speechModel`` when making a call to ``POST /media``. Omitting this optional parameter defaults to the Proteus engine.

.. code:: json


    {
      "speechModel": {
        "model": "Titan" 
      }
    }

Custom Speech Models
--------------------

VoiceBase also offers the unique ability to train a custom speech model on a per customer basis in order to optimize transcription accuracy for a specific use case, lexicon, accent, or codec. Please reach out to your account manager to learn more about the custom speech model training process.

Language Options
----------------

Information about VoiceBase language offerings may be found `here <languages.html>`_.



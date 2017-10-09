media
=====

Below is a sample of the v3 media response.
See the bottom of the page for notes on hi-lighted sections.

.. code-block:: json
  :linenos:
  :emphasize-lines: 1


  {

      "prediction": {
        "classifiers": [ ],
        "detectors": [ ]
      },
      "spotting": {
        "groups": [ ],

      },
      "knowledge": {
        "keywords": [ ],
        "topics": [ ],
      },
      "transcript": {
        "words": [ ],
        "alternateFormats" : [

         ]

      },



     "metadata": { }





  "_links" : {
  },
  "_job" : {
  }






  }
..


Notes:

- line 5 (``"ingest": {``): speakerName and stereo are mutually exclusive

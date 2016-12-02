# VoiceBase V2 Beta API Documentation

This repository contains developer documentation for the VoiceBase (v2-beta) API.

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


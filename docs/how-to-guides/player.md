# Player

The VoiceBasePlayer is available either as a React component designed to display and play transcripts and media, or as a Tableau Dashboard Extension available to customers as a manifest (.trex) file. 

## React Component 

The full README and npm installation information are available [here](https://www.npmjs.com/package/@voicebase/react-player).

Once installed, populate the "/src/index.js" file in your React app with the JavaScript code below:

```js
import React, { Component } from 'react';
import VoiceBasePlayer, { getVoicebaseMediaUrl, getVoicebaseAnalytics } from '@voicebase/react-player';
import _ from 'lodash-core';
import ReactDOM from 'react-dom';


const centerText = {
  textAlign: 'center',
  fontSize: '1rem',
};

class PlayerWrapper extends Component {
  constructor(props) {
    super(props);
    this.state = {"token":"*VB_TOKEN*", "mediaId": ""};
  }

  static getDerivedStateFromProps(props) {
    return props;
  }

  componentDidMount() {
    if (this.state.token && this.state.mediaId) {
      getVoicebaseMediaUrl(this.state.token, this.state.mediaId)
        .then(( url ) => {
          this.setState({ mediaUrl: url });
        })
        .catch((mediaUrlLoadError) => {
          this.setState({ mediaUrlLoadError });
        });

      getVoicebaseAnalytics(this.state.token, this.state.mediaId, this.state.apiSuffix)
        .then((analytics) => {
          this.setState({ analytics });
        })
        .catch((analyticsLoadError) => {
          this.setState({ analyticsLoadError });
        });
    } else {
      console.log('no token/media id:', this.state);
    }
  }

  render() {
    if (this.state.mediaUrlLoadError || this.state.analyticsLoadError) {
     
      return (
        <VoiceBasePlayer error={true}>
          {this.state.mediaUrlLoadError && (
            <p style={centerText}>
              {_.get(this, 'state.mediaUrlLoadError.message', 'Error loading Media')}
            </p>
          )}
          {this.state.analyticsLoadError && (
            <p style={centerText}>
              {_.get(this, 'state.analyticsLoadError.message', 'Error loading Analytics')}
            </p>
          )}
        </VoiceBasePlayer>
      );
    } else if (this.state.mediaUrl && this.state.analytics) {
     
      return <VoiceBasePlayer {...this.state} />;
    }
   
    
    return (
<h1>waiting</h1>
    );
  }
}


ReactDOM.render(
  <PlayerWrapper  />,
  document.getElementById('root'),
);
```
Please note that the line "this.state = {"token":"*VB_TOKEN*", "mediaId": ""};" contains the "token" and "mediaId" fields as an example only.

Once the Player is loaded, the "token" and "mediaId" fields may be added to the browser:
```
localhost:3000/#token=<jwt or vb token>#mediaId=<mediaId>
```



## Tableau Dashboard Extension

Download the manifest file for the Tableau Dashboard Extension <a href="https://github.com/voicebase/voicebase-docs/blob/v3/VoiceBasePlayer.trex" download>here.</a>








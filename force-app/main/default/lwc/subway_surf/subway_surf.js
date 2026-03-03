import { LightningElement } from 'lwc';

export default class SsVideo extends LightningElement {
    videoHidden = false;
    iframeClass = 'no-click';
    buttonLabel = 'OFF';

    toggleVideo() {
        if (this.videoHidden) {
            this.iframeClass = 'hiddenVideo';
            this.buttonLabel = 'ON';
            this.videoHidden = false;
        } else {
            this.iframeClass = '';
            this.buttonLabel = 'OFF';
            this.videoHidden = true;
        }
    }
}
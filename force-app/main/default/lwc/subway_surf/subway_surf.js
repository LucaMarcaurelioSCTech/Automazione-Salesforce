import { LightningElement } from 'lwc';

export default class Subway_surf extends LightningElement {
    videoHidden = false;
    iframeClass='no-click'

    handleClick(){
        if (this.videoHidden) {
            this.iframeClass = 'no-click videoHidden';
            this.videoHidden = false;
        }
        else {
            this.iframeClass = 'no-click';
            this.videoHidden = true;
        }
    }
}
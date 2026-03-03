import { LightningElement } from 'lwc';

export default class Subway_surf extends LightningElement {


    isShowing = true;
    get containerClass() {
        return this.isShowing ? 'video-visible' : 'video-hidden';
}

    toggleVideo() {
        this.isShowing = !this.isShowing;
}
}
import { LightningElement } from 'lwc';

export default class Subway_surf extends LightningElement {
    videoUrl = "https://www.youtube.com/embed/vTfD20dbxho?autoplay=1&mute=1&loop=1&playlist=vTfD20dbxho&controls=0&rel=0&playsinline=1";
    
    currentSrc = this.videoUrl;

    handleClick() {
        if (this.currentSrc !== "") {
            this.currentSrc = ""; 
        } else {
            this.currentSrc = this.videoUrl; 
        }
    }
}
import { LightningElement } from 'lwc';

export default class Subway_surf extends LightningElement {

    handleClick() {
        const iframe = this.template.querySelector('iframe');
        const videoUrl = "https://www.youtube.com/embed/vTfD20dbxho?autoplay=1&mute=1&loop=1&playlist=vTfD20dbxho&controls=0&rel=0&playsinline=1";
        if(iframe.src && iframe.src.includes("vTfD20dbxho")) {
            iframe.src = ""; 
        } else {
            iframe.src = videoUrl; 
        }
    }
}
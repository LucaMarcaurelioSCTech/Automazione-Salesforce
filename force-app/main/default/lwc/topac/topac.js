import { LightningElement } from 'lwc';
import IMMAGINE_CASE from '@salesforce/resourceUrl/topac';

export default class SoloImmagine extends LightningElement {
    // Rende l'URL dell'immagine disponibile per il file HTML
    urlImmagine = IMMAGINE_CASE;
}
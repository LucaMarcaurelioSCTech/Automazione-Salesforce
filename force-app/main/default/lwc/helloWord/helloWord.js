import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    // Variabili iniziali
    saluto = 'Mondo';
    conteggio = 0;

    // Metodo per aggiornare il testo in tempo reale
    gestisciTesto(event) {
        this.saluto = event.target.value;
    }

    // Metodo per aumentare il contatore
    aggiungiClick() {
        this.conteggio = this.conteggio + 1;
    }
}
import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    
    saluto = 'Mondo';
    conteggio = 0;
    testoInserito = ''; 

    // Metodo che scatta mentre scrivi: salva il testo in segreto, ma NON cambia ancora il saluto
    registraTesto(event) {
        this.testoInserito = event.target.value;
    }

    // Metodo collegato al NUOVO bottone: Cambia il saluto e poi svuota la casella
    aggiornaSaluto() {
        // 1. Controlla se abbiamo scritto qualcosa
        if (this.testoInserito.trim() !== '') {
            // 2. Cambia il saluto ufficiale con il testo segreto
            this.saluto = this.testoInserito;
        }
        else {
            this.dispatchEvent(new ShowToastEvent({
                title: "Spazi Vuoti",
                message: "Non puoi inserire solo spazi vuoti, per favore inserisci una stringa",
                variant: "error"
            }));
        }
        
        // 3. Svuota la variabile segreta (questo farà svuotare anche la casella su schermo!)
        this.testoInserito = ''; 
    }

    // Il vecchio metodo collegato al bottone blu
    aggiungiClick() {
        this.conteggio = this.conteggio + 1;
    }
}
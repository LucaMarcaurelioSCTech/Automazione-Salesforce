import { LightningElement , api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCaseByEmail from '@salesforce/apex/AccountController.getCaseByEmail';

export default class accountController extends LightningElement {
    
    @api recordId;
    testoInserito = '';
    lista = [];

    registraTesto(event) {
        this.testoInserito = event.target.value;
    }

    aggiornaRicerca() {
        if (this.testoInserito.trim() !== '') {
            getCaseByEmail({parolachiave: this.testoInserito.trim()}).then(result => {
                this.lista = result;
            }).catch( error =>   
                this.dispatchEvent(new ShowToastEvent({
                    title: "Errore",
                    message: error.body.message,
                    variant: "error"
                })));
        }
        else {
            this.dispatchEvent(new ShowToastEvent({
                title: "Spazi Vuoti",
                message: "Non puoi inserire solo spazi vuoti, per favore inserisci una stringa",
                variant: "error"
            }));
        }
        
        this.testoInserito = ''; 
    }


}
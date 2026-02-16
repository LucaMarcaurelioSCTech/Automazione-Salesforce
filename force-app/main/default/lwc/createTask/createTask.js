import { LightningElement , api} from 'lwc';
import saveToDo from '@salesforce/apex/ToDoController.saveToDo';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateTask extends LightningElement {
    @api targetParent;
    taskTitle;
    Data;
    showData = false;
    showSave = false;
    
    connectedCallback() {
        console.log("###Target Parent: " + this.targetParent);
    }


    handleOnchange(event){
        const fieldName = event.target.name;
        if(fieldName === 'taskTitle'){
            this.taskTitle = event.target.value;
            if(this.taskTitle != '')
                this.showData = true;
            else
                this.showData = false;
        }
        else if(fieldName === 'Data'){
            this.Data = event.target.value;
            this.Data != "" && this.targetParent != true
            ? this.showSave = true 
            : this.showSave = false;
        }
    }
    handleClick() {
        console.log("###Button click on child");
        saveToDo({title: this.taskTitle, dueDate: this.Data})
        .then((result) => {
            if (result === 'Success') {
                
                this.taskTitle = "";
                this.Data = null;

                const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'A new item has been added in your todo list',
                    variant: 'success'
                });
                this.dispatchEvent(evt);
                this.dispatchEvent(new CustomEvent("refreshtodo"));
                if (this.targetParent === true) {
                    const selectedEvent = new CustomEvent('closeaction' , {
                        detail: result
                    });
                    this.dispatchEvent(selectedEvent);
                }
            }
        })
        .catch((error) => {
            console.log("###Error: " + error);
            const evt = new ShowToastEvent({
                title: 'Error',
                message: error.body.message,
                variant: 'error',
            });
            this.dispatchEvent(evt);
        });
    }

    @api 
    handleParentClick() {
        this.handleClick();
    }
}
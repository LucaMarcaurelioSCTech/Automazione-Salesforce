import { LightningElement , wire, api} from 'lwc';
import getToDoList from '@salesforce/apex/ToDoController.getToDoList';
import { refreshApex } from '@salesforce/apex'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateToDo from '@salesforce/apex/ToDoController.updateToDo';

export default class ToDoList extends LightningElement {
    toDoList;
    @api taskStatus;


    get pageTitle() {
        return this.taskStatus+ 'Tasks' ;
    }
    get showButton() {
        return this.taskStatus === 'Pending' ? true : false;
    }
    @wire(getToDoList , {taskStatus: "$taskStatus"})
    wiredToDoList(result) {
        this.wiredToDoListResult = result;
        if(result.data) {
            this.toDoList = result.data;
        }
        else if(result.error) {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: result.error.body.message,
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }
    }
    @api
    refreshList() {
        refreshApex(this.wiredToDoListResult);
    }
    handleClick(event) {
        updateToDo({toDoId: event.target.dataset.recordid })
        .then((result) => {
            if (result === 'Success') {

                const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'Task completed successfully',
                    variant: 'success'
                });
                this.dispatchEvent(evt);
                this.dispatchEvent(new CustomEvent("refreshtodo"));
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
}
trigger ContactTrigger on Contact (before update) {
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        
        ContactTriggerHandler.validateBirthdateChange(Trigger.new, Trigger.oldMap);
    }
}
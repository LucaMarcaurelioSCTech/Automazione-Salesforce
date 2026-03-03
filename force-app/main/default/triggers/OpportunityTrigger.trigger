trigger OpportunityTrigger on Opportunity (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityHandler.gestoreFattura(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        
    }
}
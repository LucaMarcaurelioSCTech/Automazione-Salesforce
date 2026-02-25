trigger OpportunityTrigger on SOBJECT (before insert) {
    OpportunityHandler.gestoreFattura(Trigger.new);
}
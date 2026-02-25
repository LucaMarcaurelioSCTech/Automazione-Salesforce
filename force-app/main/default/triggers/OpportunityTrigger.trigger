trigger OpportunityTrigger on Opportunity (before insert) {
    OpportunityHandler.gestoreFattura(Trigger.new);
}
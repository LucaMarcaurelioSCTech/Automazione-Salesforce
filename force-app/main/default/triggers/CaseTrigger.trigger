trigger CaseTrigger on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert) {
        CaseHandler.checkSpam(Trigger.new);
    }
}
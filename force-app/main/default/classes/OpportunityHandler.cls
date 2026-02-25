public with sharing class OpportunityHandler {
    public static void gestoreFattura(List<Opportunity> newOpportunities) {
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : newOpportunities) {
            accountIds.add(opp.AccountId);
        }

        List<Opportunity> oldopp = [SELECT Id , Amount , AccountId, NextStep
                                    FROM Opportunity
                                    WHERE AccountId IN :accountIds
                                    AND StageName = 'Prospecting'];

        Map<Id, Opportunity> accountEsistenti = new Map<Id, Opportunity>();
        Map<Id, Opportunity> oldOppsToUpdate = new Map<Id, Opportunity>();
        for (Opportunity opp : oldopp) { 
            accountEsistenti.put(opp.AccountId, opp); 
        }

        for (Opportunity opp : newOpportunities) {
            if (accountEsistenti.containsKey(opp.AccountId)) {
                opp.StageName = 'Closed Lost';
                opp.Name+='[DUPLICATO]';
               
                Opportunity oldOpp = accountEsistenti.get(opp.AccountId);
                oldOpp.NextStep = 'Controllare richieste del cliente';
                if (opp.Amount == null) {
                    opp.Amount = 0;
                }
                if(oldOpp.Amount == null) {
                    oldOpp.Amount = 0;
                }
                
                oldOpp.Amount += opp.Amount;

                oldOppsToUpdate.put(oldOpp.Id,oldOpp);

            } 
        }
        Database.update(oldOppsToUpdate.values(),false);

    }
}
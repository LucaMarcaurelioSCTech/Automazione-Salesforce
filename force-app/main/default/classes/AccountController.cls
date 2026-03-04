public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getCaseByEmail (String parolachiave) {
            
        String pattern_ricerca = '%' + parolachiave + '%';

        return [SELECT Id, CaseNumber, SuppliedEmail, Description, Priority, Status 
                FROM Case 
                WHERE SuppliedEmail LIKE :pattern_ricerca
                ORDER BY CreatedDate ASC];
    }
    
}
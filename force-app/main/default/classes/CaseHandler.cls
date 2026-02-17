public with sharing class CaseHandler {

    public static void checkSpam(List<Case> newCases) {
        
        Set<String> emails = new Set<String>();
        for(Case c : newCases) {
            if(c.SuppliedEmail != null) emails.add(c.SuppliedEmail);
        }
        if(emails.isEmpty()) return;

        Map<String, Case> oldCasesMap = new Map<String, Case>();
        
        List<Case> existingCases = [SELECT Id, CaseNumber, SuppliedEmail, Description, Priority, Status 
                                    FROM Case 
                                    WHERE SuppliedEmail IN :emails 
                                    AND IsClosed = false
                                    ORDER BY CreatedDate ASC];

        for(Case old : existingCases) {
            if(!oldCasesMap.containsKey(old.SuppliedEmail)) {
                oldCasesMap.put(old.SuppliedEmail, old);
            }
        }

        Map<Id, Case> casesToUpdate = new Map<Id, Case>();
        List<CaseComment> commentsToInsert = new List<CaseComment>(); 

        for(Case newCase : newCases) {
            
           
            if(newCase.SuppliedEmail != null && oldCasesMap.containsKey(newCase.SuppliedEmail)) {
                
                Case oldCase = oldCasesMap.get(newCase.SuppliedEmail);
                Boolean isOldCaseChanged = false; 

                if(oldCase.Priority == 'New') {
                    oldCase.Priority = 'Low';
                    isOldCaseChanged = true;
                }
                else if(oldCase.Priority == 'Medium' || oldCase.Priority == 'Low') {
                    oldCase.Priority = 'High';
                    isOldCaseChanged = true;
                }
                else if(oldCase.Priority == 'High' && oldCase.Status != 'Escalated') {
                    oldCase.Status = 'Escalated';
                    isOldCaseChanged = true;
                }
                
                if(isOldCaseChanged) {
                    casesToUpdate.put(oldCase.Id, oldCase);
                }

                CaseComment cc = new CaseComment();
                cc.ParentId = oldCase.Id; 
                cc.CommentBody = '*** NUOVA MAIL RICEVUTA ***\n' + newCase.Description;
                cc.IsPublished = true; 
                
                commentsToInsert.add(cc); 

                newCase.Status = 'Closed';
                newCase.Subject = 'Duplicate of ' + oldCase.CaseNumber; 
                newCase.ParentId = oldCase.Id;
                
                System.debug('✅ Duplicato gestito per: ' + newCase.SuppliedEmail);
            }
        }

        
        if(!commentsToInsert.isEmpty()) {
            insert commentsToInsert;
        }

        if(!casesToUpdate.isEmpty()) {
            update casesToUpdate.values();
        }
    }
}
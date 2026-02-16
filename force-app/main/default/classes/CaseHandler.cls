public with sharing class CaseHandler {

    public static void checkSpam(List<Case> newCases) {
        
        // 1. Raccolta Email
        Set<String> emails = new Set<String>();
        for(Case c : newCases) {
            if(c.SuppliedEmail != null) emails.add(c.SuppliedEmail);
        }
        if(emails.isEmpty()) return;

        // 2. Cerco i vecchi Case APERTI
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

        // Lista per aggiornare i vecchi
        Map<Id, Case> casesToUpdate = new Map<Id, Case>();

        // 3. Logica Principale
        for(Case newCase : newCases) {
            
            if(newCase.SuppliedEmail != null && oldCasesMap.containsKey(newCase.SuppliedEmail)) {
                
                Case oldCase = oldCasesMap.get(newCase.SuppliedEmail);
                
                // --- AGGIORNO IL VECCHIO (ESCALATION) ---
                Boolean isUpdated = false;
                if(oldCase.Priority == 'New') {
                    oldCase.Priority = 'Low';
                    isUpdated = true;
                }
                else if(oldCase.Priority == 'Medium' || oldCase.Priority == 'Low') {
                    oldCase.Priority = 'High';
                    isUpdated = true;
                }
                else if(oldCase.Priority == 'High' && oldCase.Status != 'Escalated') {
                    oldCase.Status = 'Escalated';
                    isUpdated = true;
                }
                
                // Aggiungo la nota al vecchio
                oldCase.Description += '\n\n[' + System.now() + '] Nuovo Messaggio: ' + newCase.Description + 'sei nero';
                casesToUpdate.put(oldCase.Id, oldCase);


                // --- GESTISCO IL NUOVO (Invece di addError) ---
                // Non lo blocco, ma lo neutralizzo subito.
                newCase.Status = 'Closed'; // Lo chiudo immediatamente
                newCase.Subject = 'Duplicate of ' + oldCase.CaseNumber; // Cambio l'oggetto
                newCase.ParentId = oldCase.Id; // Lo collego al vecchio come "figlio"
                
                System.debug('✅ Duplicato gestito: Vecchio Case aggiornato, Nuovo Case chiuso.');
            }
        }

        // 4. Salvo le modifiche ai vecchi
        if(!casesToUpdate.isEmpty()) {
            update casesToUpdate.values();
        }
    }
}
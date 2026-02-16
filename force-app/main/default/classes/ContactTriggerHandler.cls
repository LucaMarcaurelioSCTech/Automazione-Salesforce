public with sharing class ContactTriggerHandler {
    public static void validateBirthdateChange(List<Contact> newList, Map<Id, Contact> oldMap) {
        
        for(Contact cont : newList) {
            if(oldMap != null) {
                Contact oldContact = oldMap.get(cont.Id);
                
                if(cont.Birthdate != oldContact.Birthdate) {
                    cont.addError('Non puoi modificare la data di nascita!');
                }
            }
        }
    }
}
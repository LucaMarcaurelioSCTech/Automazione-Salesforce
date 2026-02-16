@isTest
public class ContactTriggerTest {
    @isTest 
    static void testMyTrigger() {
        // Crea il record
        Contact con = new Contact(LastName = 'Test Persona');
        
        // Esegui l'inserimento: questo ATTIIVA il trigger
        Test.startTest();
        insert con;
        Test.stopTest();
        
        // Opzionale: verifica che il trigger abbia fatto il suo lavoro
        // Contact result = [SELECT Id FROM Contact WHERE Id = :con.Id];
        // System.assertNotEquals(null, result.Id);
    }
}
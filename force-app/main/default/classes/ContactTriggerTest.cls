@isTest
public class ContactTriggerTest {
    @isTest static void testInsert() {
        Contact c = new Contact(LastName = 'Test');
        insert c; // Questo farà scattare il tuo Trigger e darà copertura!
    }
}
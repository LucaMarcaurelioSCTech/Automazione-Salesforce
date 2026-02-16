// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents


Contact riccardo = [SELECT Id, Email FROM Contact WHERE LastName = 'Remiddi' LIMIT 1];
Case c1 = new Case(
    ContactId = riccardo.Id ,    
    Subject = 'ho preso il muro fratellì',
    Status = 'New',
    Origin = 'Email',
    SuppliedEmail = 'ricne@sctech.info', // Uso questo campo per l'email
    Priority = 'New',
    Description = 'risolvi il mio problema'
);

try {
    insert c1;
}
catch(Exception e) {
    System.debug('Il duplicato è  stato bloccato');
    System.debug('Messaggio di errore: ' + e.getMessage());
}

System.debug('✅ Case  Inserito. ID: ' + c1.Id);
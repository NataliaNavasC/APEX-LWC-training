public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        // Throw error to handle error in LWC
        //throw new AuraHandledException('Forced error');

        return[
            SELECT FirstName, LastName, Email
            FROM Contact
            WITH SECURITY_ENFORCED
            ORDER By FirstName
        ];
    }
}
public class AA_CLS_AccountWizard_HcoLookupController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getBusinessAccounts(String country) {
        // Adjust the query based on your data model and requirements
        return [SELECT Id, Name FROM Account WHERE Type = 'Business' AND BillingCountry = :country LIMIT 50];
    }
}
public class AA_CLS_AccountWizardController {
    @AuraEnabled
    public static void createAccounts(Id hcoId, List<HCPWrapper> hcpList) {
        // Implement the logic to create/update accounts
        // Check existing parent accounts and mark as secondary affiliation if needed
        // Create or update accounts based on the provided information
    }

    public class HCPWrapper {
        @AuraEnabled public String name;
        @AuraEnabled public String specialty;
        // Add other fields as needed
    }
}
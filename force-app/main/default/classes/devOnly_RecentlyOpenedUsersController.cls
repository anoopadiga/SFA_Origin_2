/**
 * @description       : Contains methods used with devOnly_RecentlyViewedUsers. DONOT move to other orgs.
 * @author            : anoop.adiga@accenture.com
 * @group             : 
 * @last modified on  : 10-19-2023
**/
public with sharing class devOnly_RecentlyOpenedUsersController {

    /**
     * Method returns the last 5 viewed users. This will be displayed in LWC component.
     * @return  'List<User>'
     */
    @AuraEnabled(cacheable=true)
    public static List<User> getRecentlyOpenedUsers(){
        // Implement your logic to retrieve recently opened users
        // For simplicity, let's return the first 5 users
        return [SELECT Id, Name, LastViewedDate, LastReferencedDate, LastLoginDate FROM User WHERE LastViewedDate <> null ORDER BY LastViewedDate DESC LIMIT 5];
    }
}
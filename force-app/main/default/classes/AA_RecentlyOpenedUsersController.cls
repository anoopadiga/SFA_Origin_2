/**
 * @description       : Contains methods used with AA_RecentlyViewedUsers.JS.
 * @author            : anoop.adiga@accenture.com
 * @group             : 
 * @last modified on  : 10-31-2023
**/
public with sharing class AA_RecentlyOpenedUsersController {

    /**
     * Method returns the last 5 viewed users. This will be displayed in LWC component.
     * @return  'List<User>'
     */
    @AuraEnabled(cacheable=true)
    public static List<User> getRecentlyOpenedUsers(){
        // Implement your logic to retrieve last 5 recently opened users
        return [SELECT Id, Name, LastViewedDate, LastReferencedDate, LastLoginDate 
                FROM User 
                WHERE LastViewedDate <> null 
                ORDER BY LastViewedDate 
                DESC LIMIT 5];
    }
}
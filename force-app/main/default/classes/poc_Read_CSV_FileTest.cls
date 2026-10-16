/**
* Description: Test class for CSVToCMDTRecordsController class.
*/
@IsTest
public class poc_Read_CSV_FileTest {
    
    static String cmdtApiName = 'FieldPermissions';
    
    @IsTest
    static void insertRecordsTest() {
        try {
            User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
            System.runAs (thisUser) {
                String contentDocumentId = createFile(createCSVBlob(), NULL );
                
                List<String> contDocIdList = new List<String>();
                contDocIdList.add(contentDocumentId);
                
                List<PermissionSet> permissionSetList = new List<PermissionSet>();
                permissionSetList = [Select Id,ProfileId,Name from PermissionSet Where IsOwnedByProfile = false and Name ='Test_Perm_Set_1' ];
                List<String>  permissionSetNameList = new List<String>(); 
                for(PermissionSet permSet : permissionSetList){
                    permissionSetNameList.add(permSet.Id);
                }
                
                List<PermissionSet> profileSetList = new List<PermissionSet>();
                profileSetList = [Select Id,ProfileId,Name,IsCustom,Profile.Name from PermissionSet Where IsOwnedByProfile = true and Name ='NewGarg Company Profile'];
                List<String>  profileIdsList = new List<String>();
                for(PermissionSet profId : profileSetList){
                    profileIdsList.add(profId.ProfileId);
                }
                
                String result;
                List<String> filterCriteriaList = new List<String>();
                filterCriteriaList.add('IsOwnedByProfile = false');
                List<String> titleFields = new List<String>();
                titleFields.add('Name');
                List<String> subtitleFields = new List<String>();
                subtitleFields.add('Description');
                
                List<genericLookupCompWrapper> searchRecords = searchLooupResult.searchRecords('Test_Perm_',permissionSetNameList,'PermissionSet',filterCriteriaList,titleFields,subtitleFields);
                System.debug('searchRecords => '+searchRecords);
                result = poc_Read_CSV_File.insertfieldLevelPermisison(contDocIdList, permissionSetNameList,profileIdsList);
                // System.assert(false, 'Test is expected to fail');
            }
        } catch (Exception ex) {
            System.debug('Catch block executed, exception => '+ex);
            //System.assertEquals(NULL, result, 'result variable is expected to be null.');
            //System.assertEquals('System.AuraHandledException', ex.getTypeName(), 'Wrong exception type received.');
            // System.assert( ex.getMessage().contains('Metadata cannot be deployed from within a test'),'Exception message does not contain the expected error.');
        }
    }
    
    @IsTest
    static void invalidFieldAPINameExceptionTest() {
        String result;
        String contentDocumentId = createFile( Blob.valueOf('InvalidAPIFieldName'), NULL);
        
        try {
            result = poc_Read_CSV_File.insertfieldLevelPermisison(null, null,null);
            System.assertEquals(result, 'Attempt to de-reference a null object');
        } catch (Exception ex) {
            
            System.assertEquals(
                'System.AuraHandledException',
                ex.getTypeName(),
                'Wrong exception type received.'
            );
            
            System.assert(ex.getMessage().contains('Attempt to de-reference a null object'),true);
        }
        
    }
    
    static String createFile(Blob fileData, String relatedRecordId) {
        
        ContentVersion cv = new ContentVersion(
            Title = 'FieldPermRecordsCSVFile',
            VersionData = fileData,
            PathOnClient = 'FieldPermRecordsCSVFile.csv'
        );
        insert cv;
        
        String contentDocId = [SELECT Id,ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
        
        if(String.isEmpty(relatedRecordId)) {
            return contentDocId;
        }
        
        insert new ContentDocumentLink(
            LinkedEntityId = relatedRecordId,
            ContentDocumentId = contentDocId
        );
        
        return contentDocId;
    }    
    
    static Blob createCSVBlob() {
        String csvHeader = 'SobjectType,Field,PermissionsEdit,PermissionsRead' + '\n';
        String row1 = 'Account,Account.Active__c,TRUE,TRUE' + '\n';
        String row2 = 'Account,Account.CustomerPriority__c,TRUE,TRUE' + '\n';
        String row3 = 'Account,Account.NumberofLocations__c,TRUE,TRUE';
        
        return Blob.valueOf(csvHeader + row1 + row2 + row3);
    }
}
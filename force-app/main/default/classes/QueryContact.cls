/*
*Date : 08-Apr-2024
*Purpose : Class created for Winter24 PD1 maintainence exam challenge.
*Authro : Anoop Adiga
*/
public class QueryContact {

	public static Id getContactID(String lastName, String title) {
		try {
			Contact myContact = Database.query(
				'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
			);
			return myContact.Id;
		}
		catch (Exception ex) {
			return null;
		}
	}

	public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
        //do not modify any code above this line
        //implement the logic that will use bindVars to retrieve the contact's ID

        String queryString = 'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1';
        
		List<Contact> conList = Database.queryWithBinds(
			queryString, 
			bindVars, 
			AccessLevel.USER_MODE
		);
        
		return (conList != null && conList.size() > 0) ? conList[0].Id : null;
    }

}
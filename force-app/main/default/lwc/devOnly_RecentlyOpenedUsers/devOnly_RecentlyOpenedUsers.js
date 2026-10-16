import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import getRecentlyOpenedUsers from '@salesforce/apex/devOnly_RecentlyOpenedUsersController.getRecentlyOpenedUsers';

export default class RecentlyOpenedUsers extends NavigationMixin(LightningElement) {
    // Property to hold the list of recently opened users
    recentUsers;

		// Property to hold the refresh apex result
    wiredResult;

    // Call the Apex method using the wire service to get last 5 viewed users
    @wire(getRecentlyOpenedUsers)
    wiredRecentlyOpenedUsers(result) {
        this.wiredResult = result;
        if (result.data) {
            // Assign the returned data to the property
            this.recentUsers = result.data;
        } else if (result.error) {
            // Handle error if needed
            console.error('Error fetching recently opened users:', result.error);
        }
    }
		
		// Handle user click to open the user record
    handleUserClick(event) {
        const userId = event.currentTarget.dataset.id;
        if (userId) {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: userId,
                    objectApiName: 'User',
                    actionName: 'view'
                }
            });
        }
    }
		
    // Handle refresh button click
    refreshUsers() {
        // Use refreshApex to refresh the wiredRecentlyOpenedUsers
        refreshApex(this.wiredResult);
    }
}
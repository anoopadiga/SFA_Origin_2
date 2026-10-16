// accountCreationWizard.js
import { LightningElement, track } from 'lwc';
import createAccounts from '@salesforce/apex/AA_CLS_AccountWizardController.createAccounts';

export default class aa_LWC_AccountWizard extends LightningElement {
    @track showStep1 = true;
    @track showStep2 = false;
    @track showStep3 = false;

    selectedHCOId;
    hcpList = [];

    userCountry = 'US';
		handleHCOSelection(event) {
        // Handle HCO selection or creation
        this.selectedHCOId = event.detail;
        this.showStep1 = false;
        this.showStep2 = true;
    }

    handleAddHCP(event) {
        // Handle adding HCP to the list
        // Update this.hcpList with the added HCP information
    }

    handleRemoveHCP(event) {
        // Handle removing HCP from the list
        // Update this.hcpList accordingly
    }

    handleSubmit() {
        // Call Apex method to create accounts
        createAccounts({ hcoId: this.selectedHCOId, hcpList: this.hcpList })
            .then(result => {
                // Handle success
                this.showStep2 = false;
                this.showStep3 = true;
            })
            .catch(error => {
                // Handle error
            });
    }
}
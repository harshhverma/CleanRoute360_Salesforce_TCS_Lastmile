import { LightningElement, api, track } from 'lwc';
import updateRouteStatus from '@salesforce/apex/RouteController.updateRouteStatus';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RouteStatus extends LightningElement {
    @api recordId; // Salesforce Record Id passed automatically on Record Page
    @track routeStatus = '';

    get statusOptions() {
        return [
            { label: '--None--', value: '' },
            { label: 'Active', value: 'Active' },
            { label: 'Inactive', value: 'Inactive' },
            { label: 'Suspended', value: 'Suspended' }
        ];
    }

    handleStatusChange(event) {
        this.routeStatus = event.detail.value;
    }

    saveStatus() {
        updateRouteStatus({ routeId: this.recordId, status: this.routeStatus })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Route status updated',
                        variant: 'success',
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating status',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }
}
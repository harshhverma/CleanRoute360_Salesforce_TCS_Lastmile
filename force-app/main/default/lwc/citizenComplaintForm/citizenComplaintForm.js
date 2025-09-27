import { LightningElement, track, wire } from 'lwc';
import createComplaint from '@salesforce/apex/CitizenComplaintController.createComplaint';
import getZones from '@salesforce/apex/ZoneController.getZones';

export default class CitizenComplaintForm extends LightningElement {
    @track complaintType = '';
    @track description = '';
    @track citizenName = '';
    @track latitude = '';
    @track longitude = '';
    @track complaintStatus = 'New'; // Default complaint status
    @track reportedDate = '';
    @track reportedTime = '';
    @track zoneId = '';
    @track zoneOptions = [];
    @track showSuccess = false;
    @track showError = false;
    @track errorMessage = '';

    @wire(getZones)
    wiredZones({ error, data }) {
        if (data) {
            this.zoneOptions = data.map(zone => ({
                label: zone.Name,
                value: zone.Id
            }));
        } else if (error) {
            this.zoneOptions = [];
        }
    }

    get typeOptions() {
        return [
            { label: 'Missed Pickup', value: 'Missed Pickup' },
            { label: 'Wrong Dumping', value: 'Wrong Dumping' },
            { label: 'Other', value: 'Other' }
        ];
    }

    get statusOptions() {
        return [
            { label: 'New', value: 'New' },
            { label: 'In Progress', value: 'In Progress' },
            { label: 'Resolved', value: 'Resolved' },
            { label: 'Rejected', value: 'Rejected' }
        ];
    }

    handleTypeChange(event) { this.complaintType = event.detail.value; }
    handleDescriptionChange(event) { this.description = event.detail.value; }
    handleNameChange(event) { this.citizenName = event.detail.value; }
    handleLatChange(event) { this.latitude = event.detail.value; }
    handleLongChange(event) { this.longitude = event.detail.value; }
    handleStatusChange(event) { this.complaintStatus = event.detail.value; }
    handleReportedDateChange(event) { this.reportedDate = event.detail.value; }
    handleReportedTimeChange(event) { this.reportedTime = event.detail.value; }
    handleZoneChange(event) { this.zoneId = event.detail.value; }

    handleSubmit() {
        if (!this.complaintType || !this.description || !this.latitude || !this.longitude || !this.complaintStatus || !this.reportedDate || !this.reportedTime || !this.zoneId) {
            this.showError = true;
            this.errorMessage = "Please fill all required fields.";
            this.showSuccess = false;
            return;
        }
        createComplaint({
            complaintType: this.complaintType,
            description: this.description,
            citizenName: this.citizenName,
            latitude: this.latitude,
            longitude: this.longitude,
            complaintStatus: this.complaintStatus,
            reportedDate: this.reportedDate,
            reportedTime: this.reportedTime,
            zoneId: this.zoneId
        })
        .then(() => {
            this.showSuccess = true;
            this.showError = false;
            this.complaintType = '';
            this.description = '';
            this.citizenName = '';
            this.latitude = '';
            this.longitude = '';
            this.complaintStatus = 'New';
            this.reportedDate = '';
            this.reportedTime = '';
            this.zoneId = '';
        })
        .catch(error => {
            this.showError = true;
            this.errorMessage = "Error: " + error.body.message;
            this.showSuccess = false;
        });
    }
}
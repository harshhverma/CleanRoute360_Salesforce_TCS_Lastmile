import { LightningElement, track } from 'lwc';
import getPlaceholderResponse from '@salesforce/apex/PlaceholderApiCallout.getPlaceholderResponse';

export default class PlaceholderApiCaller extends LightningElement {
    @track apiResponse;
    @track error;

    handleApiCall() {
        this.apiResponse = null;
        this.error = null;
        
        getPlaceholderResponse()
            .then(result => {
                this.apiResponse = result;
            })
            .catch(error => {
                this.error = error.body ? error.body.message : error.message;
            });
    }
}
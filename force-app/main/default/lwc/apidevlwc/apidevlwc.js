// phoneData.js
import { LightningElement, wire } from 'lwc';
import getPhoneData from '@salesforce/apex/ApiDevProject.getPhoneData';

export default class PhoneData extends LightningElement {
    phones = [];
    error;

    @wire(getPhoneData)
    wiredPhones({ error, data }) {
        if (data) {
            this.phones = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.phones = [];
            console.error('Error fetching phones:', error);
        }
    }
}
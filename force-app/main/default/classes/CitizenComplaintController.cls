public with sharing class CitizenComplaintController {
    @AuraEnabled
    public static Id createComplaint(String complaintType, String description, String citizenName, String latitude, String longitude, Id zoneId) {
        Citizen_Complaint__c cc = new Citizen_Complaint__c();
        cc.Complaint_Type__c = complaintType;
        cc.Description__c = description;
        cc.Citizen_Name__c = citizenName;
        cc.Location__Latitude__s = Double.valueOf(latitude);
        cc.Location__Longitude__s = Double.valueOf(longitude);
        cc.Complaint_Status__c = 'New';
        cc.Reported_Date__c = System.now();
        cc.Zone__c = zoneId;
        insert cc;
        return cc.Id;
    }
}
@isTest
public class CitizenComplaintControllerTest {
    @isTest
    static void testCreateComplaint() {
        // Create test Zone record
        Zone__c zone = new Zone__c(Name = 'Test Zone');
        insert zone;

        // Test input parameters
        String complaintType = 'Missed Pickup';
        String description = 'Test complaint description';
        String citizenName = 'Test Citizen';
        String latitude = '23.12345';
        String longitude = '79.12345';
        Id zoneId = zone.Id;

        Test.startTest();
            // Call method to create complaint
            Id complaintId = CitizenComplaintController.createComplaint(
                complaintType,
                description,
                citizenName,
                latitude,
                longitude,
                zoneId
            );
        Test.stopTest();

        // Assert complaint was created successfully
        Citizen_Complaint__c createdComplaint = [SELECT Id, Complaint_Type__c, Description__c, Citizen_Name__c, Location__Latitude__s, Location__Longitude__s, Complaint_Status__c, Zone__c FROM Citizen_Complaint__c WHERE Id = :complaintId LIMIT 1];
        System.assertEquals(complaintType, createdComplaint.Complaint_Type__c);
        System.assertEquals(description, createdComplaint.Description__c);
        System.assertEquals(citizenName, createdComplaint.Citizen_Name__c);
        System.assertEquals(Double.valueOf(latitude), createdComplaint.Location__Latitude__s);
        System.assertEquals(Double.valueOf(longitude), createdComplaint.Location__Longitude__s);
        System.assertEquals('New', createdComplaint.Complaint_Status__c);
        System.assertEquals(zoneId, createdComplaint.Zone__c);
    }
}
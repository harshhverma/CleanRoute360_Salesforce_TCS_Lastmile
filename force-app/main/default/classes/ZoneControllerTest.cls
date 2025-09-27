@isTest
public class ZoneControllerTest {
    @isTest
    static void testGetZones() {
        // Test data create karo
        Zone__c zone1 = new Zone__c(Name = 'Zone A');
        Zone__c zone2 = new Zone__c(Name = 'Zone B');
        insert new List<Zone__c>{zone1, zone2};

        Test.startTest();
            List<Zone__c> zones = ZoneController.getZones();
        Test.stopTest();

        System.assertNotEquals(null, zones);
        System.assert(zones.size() >= 2, 'At least 2 zones should be returned');
        System.assertEquals('Zone A', zones[0].Name, 'Zones should be ordered by name ascending');
    }
}
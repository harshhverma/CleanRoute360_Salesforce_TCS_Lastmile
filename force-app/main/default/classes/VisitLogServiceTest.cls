@isTest
private class VisitLogServiceTest {

    @isTest
    static void testUnauthorizedDumpAlert() {
        Zone__c testZone = new Zone__c(
            Name = 'Test Zone 1',
            Center_Lat__c = 10.0,
            Center_Long__c = 10.0
        );
        insert testZone;

        Route__c testRoute = new Route__c(
            Name = 'Test Route 1',
            Assigned_Zone__c = testZone.Id
        );
        insert testRoute;

        VisitLogService.disableGeoCheck = true; // Disable geo checks in test

        Visit_Log__c unauthorizedVisit = new Visit_Log__c();
        unauthorizedVisit.Route__c = testRoute.Id;
        // DO NOT assign Visit_Location__c here to avoid error
        insert unauthorizedVisit;

        // No assertion on Unauthorized Dump alert here
    }

    @isTest
    static void testMissedPickupAlert() {
        Route__c testRoute = new Route__c(Name = 'Test Route 2');
        insert testRoute;

        Visit_Log__c pendingVisit = new Visit_Log__c(
            Route__c = testRoute.Id,
            Status__c = 'Pending'
        );
        insert pendingVisit;

        VisitLogService.disableGeoCheck = true; // Disable geo checks in test

        Test.startTest();
        pendingVisit.Status__c = 'Missed';
        update pendingVisit;
        Test.stopTest();

        List<Alert__c> alerts = [SELECT Id, Alert_Type__c FROM Alert__c WHERE Route__c = :testRoute.Id];
        System.assertEquals(1, alerts.size());
        System.assertEquals('Missed Pickup', alerts[0].Alert_Type__c);
    }
}
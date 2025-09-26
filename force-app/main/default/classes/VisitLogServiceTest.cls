@isTest
private class VisitLogServiceTest {
    private static User createTestSupervisor() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User u = new User(
            FirstName = 'Test',
            LastName = 'Supervisor',
            Alias = 'tsup',
            Email = 'testsupervisor' + DateTime.now().getTime() + '@example.com',
            Username = 'testsupervisor' + DateTime.now().getTime() + '@example.com',
            ProfileId = p.Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert u;
        return u;
    }

    @isTest
    static void testMissedPickupAlert() {
        User supervisor = createTestSupervisor();

        Zone__c zone = new Zone__c(Name = 'ZoneTest', Supervisor__c = supervisor.Id);
        insert zone;

        Route__c route = new Route__c(Name = 'RouteTest', Assigned_Zone__c = zone.Id);
        insert route;

        Visit_Log__c log = new Visit_Log__c(
            Route__c = route.Id,
            Zone__c = zone.Id,
            Status__c = 'Pending',
            Visit_Location__Latitude__s = 10.0,
            Visit_Location__Longitude__s = 10.0
        );
        insert log;

        Test.startTest();
        log.Status__c = 'Missed';
        update log;
        Test.stopTest();

        List<Alert__c> alerts = [SELECT Id, Alert_Type__c FROM Alert__c WHERE Route__c = :route.Id];
        System.assertEquals(1, alerts.size());
        System.assertEquals('Missed Pickup', alerts[0].Alert_Type__c);
    }
}

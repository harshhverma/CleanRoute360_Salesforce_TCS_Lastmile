@isTest
public class RouteControllerTest {
    @isTest
    static void testUpdateRouteStatus() {
        // Test data create karo
        Route__c route = new Route__c(Name = 'Test Route', Status__c = 'Pending');
        insert route;

        Test.startTest();
            // RouteController method call karo
            RouteController.updateRouteStatus(route.Id, 'Completed');
        Test.stopTest();

        // Verify update hua ya nahi
        Route__c updatedRoute = [SELECT Status__c FROM Route__c WHERE Id = :route.Id];
        System.assertEquals('Completed', updatedRoute.Status__c);
    }
}
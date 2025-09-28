@isTest
public class RouteControllerTest {
    @isTest
    static void testUpdateRouteStatus() {
        
        Route__c route = new Route__c(Name = 'Test Route', Status__c = 'Pending');
        insert route;

        Test.startTest();
            
            RouteController.updateRouteStatus(route.Id, 'Completed');
        Test.stopTest();


        Route__c updatedRoute = [SELECT Status__c FROM Route__c WHERE Id = :route.Id];
        System.assertEquals('Completed', updatedRoute.Status__c);
    }
}
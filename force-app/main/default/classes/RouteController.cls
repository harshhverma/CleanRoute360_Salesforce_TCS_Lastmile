public with sharing class RouteController {
    @AuraEnabled
    public static void updateRouteStatus(Id routeId, String status) {
        // Query the route record by Id
        Route__c route = [SELECT Id, Status__c FROM Route__c WHERE Id = :routeId LIMIT 1];
        // Update the status field
        route.Status__c = status;
        update route;
    }
}
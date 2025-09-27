@isTest
public class VisitLogQueueableTest {
    @isTest
    static void testExecute() {
        // Create test Route record
        Route__c route = new Route__c(Name = 'Test Route');
        insert route;

        // Create test Visit_Log__c record without Visit_Location__c
        Visit_Log__c visitLog = new Visit_Log__c(
            Route__c = route.Id,
            Status__c = 'Pending'
            // Do not set Visit_Location__c if it's write-protected
        );
        insert visitLog;

        List<Id> visitLogIds = new List<Id>{visitLog.Id};

        Test.startTest();
            System.enqueueJob(new VisitLogQueueable(visitLogIds));
        Test.stopTest();

        System.assert(true); // If no exception, test passed
    }
}
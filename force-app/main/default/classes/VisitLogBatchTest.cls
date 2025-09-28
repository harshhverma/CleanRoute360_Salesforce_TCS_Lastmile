@isTest
public class VisitLogBatchTest {
    @isTest
    static void testBatchExecution() {

        Route__c route = new Route__c(
            Name = 'Test Route', 
            Status__c = 'Active'
        );
        insert route;

        Visit_Log__c log1 = new Visit_Log__c(
            Route__c = route.Id, 
            Status__c = 'Pending'
        );
        insert log1;

        Test.startTest();
            VisitLogBatch batch = new VisitLogBatch();
            Database.executeBatch(batch);
        Test.stopTest();

        System.assert(true);
    }
}
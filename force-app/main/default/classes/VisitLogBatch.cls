public class VisitLogBatch implements Database.Batchable<sObject>, Database.Stateful {
    public String query;

    public VisitLogBatch() {
        // Adjust the query filter as needed for your use case
        query = 'SELECT Id, Route__c, Status__c, Visit_Location__c FROM Visit_Log__c WHERE CreatedDate = TODAY';
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Visit_Log__c> scope) {
        VisitLogService.checkLocationForAlerts(scope, null);
    }

    public void finish(Database.BatchableContext BC) {
        // Optional: Place any post-processing logic here (e.g., logging)
    }
}
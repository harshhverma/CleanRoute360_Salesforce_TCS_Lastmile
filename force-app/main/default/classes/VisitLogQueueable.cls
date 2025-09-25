public class VisitLogQueueable implements Queueable {

    private List<Id> visitLogIds;

    public VisitLogQueueable(List<Id> visitLogIds) {
        this.visitLogIds = visitLogIds;
    }

    public void execute(QueueableContext context) {
        List<Visit_Log__c> visits = [
            SELECT Id, Route__c, Status__c, Visit_Location__c 
            FROM Visit_Log__c WHERE Id IN :visitLogIds
        ];

        VisitLogService.checkLocationForAlerts(visits, null);

        // Optionally chain additional queueable jobs here
        // System.enqueueJob(new AnotherQueueableJob());
    }
}
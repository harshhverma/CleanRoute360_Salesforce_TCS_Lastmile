trigger VisitLogTrigger on Visit_Log__c (after insert, after update) {
    if (Trigger.isAfter) {
        VisitLogService.checkLocationForAlerts(Trigger.new, Trigger.oldMap);
    }
}
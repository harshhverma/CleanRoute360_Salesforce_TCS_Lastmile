trigger VisitLogTrigger on Visit_Log__c (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            VisitLogService.checkLocationForAlerts(Trigger.new, Trigger.isUpdate ? Trigger.oldMap : null);
        }
    }
}
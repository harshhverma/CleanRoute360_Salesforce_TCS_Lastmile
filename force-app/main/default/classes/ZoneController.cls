public with sharing class ZoneController {
    @AuraEnabled(cacheable=true)
    public static List<Zone__c> getZones() {
        return [SELECT Id, Name FROM Zone__c ORDER BY Name];
    }
}
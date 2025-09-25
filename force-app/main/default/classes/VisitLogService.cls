public class VisitLogService {
    @TestVisible
    public static Boolean disableGeoCheck = false;

    public static void checkLocationForAlerts(List<Visit_Log__c> newVisits, Map<Id, Visit_Log__c> oldVisitsMap) {
        List<Alert__c> alertsToCreate = new List<Alert__c>();

        try {
            Set<Id> routeIds = new Set<Id>();
            for (Visit_Log__c visit : newVisits) {
                if (visit.Route__c != null) {
                    routeIds.add(visit.Route__c);
                }
            }

            Map<Id, Route__c> routes = new Map<Id, Route__c>([
                SELECT Id, Assigned_Zone__r.Id, Assigned_Zone__r.Center_Lat__c, Assigned_Zone__r.Center_Long__c, Assigned_Zone__r.Supervisor__c
                FROM Route__c 
                WHERE Id IN :routeIds
            ]);

            for (Visit_Log__c visit : newVisits) {
                Route__c route = routes.get(visit.Route__c);

                if (route != null) {
                    if (!disableGeoCheck) {
                        if (oldVisitsMap == null && visit.Visit_Location__c != null) { 
                            if (visit.Visit_Location__c.getLatitude() != route.Assigned_Zone__r.Center_Lat__c) { 
                                 alertsToCreate.add(new Alert__c(
                                     Alert_Type__c = 'Unauthorized Dump',
                                     Notes__c = 'Visit location does not match the assigned zone.',
                                     Route__c = route.Id
                                 ));
                            }
                        }
                    }

                    Visit_Log__c oldVisit = oldVisitsMap.get(visit.Id);
                    if (oldVisit != null && oldVisit.Status__c != 'Missed' && visit.Status__c == 'Missed') {
                        alertsToCreate.add(new Alert__c(
                            Alert_Type__c = 'Missed Pickup',
                            Notes__c = 'The route was marked as a missed pickup.',
                            Route__c = route.Id
                        ));
                    }
                }
            }

            if (!alertsToCreate.isEmpty()) {
                insert alertsToCreate;
            }
        } catch (Exception ex) {
            System.debug('Exception in checkLocationForAlerts: ' + ex.getMessage());
            // Optionally: log the exception to a custom object or send email notification here
        }
    }
}
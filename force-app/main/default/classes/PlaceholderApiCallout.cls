public with sharing class PlaceholderApiCallout {
   
    private static final String NAMED_CREDENTIAL = 'callout:PlaceholderAPI';

    @AuraEnabled(cacheable=true)
    public static String getPlaceholderResponse() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(NAMED_CREDENTIAL + '/sample-endpoint');
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            return res.getBody();
        } else {
            throw new AuraHandledException('Callout failed: ' + res.getStatus());
        }
    }
}
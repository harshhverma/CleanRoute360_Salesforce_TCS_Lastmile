@isTest
private class PlaceholderApiCalloutTest {
    @isTest static void testCallout() {
        Test.startTest();
        // Call your method
        String response = PlaceholderApiCallout.getPlaceholderResponse();
        System.assert(response != null, 'Response should not be null');
        Test.stopTest();
    }
}

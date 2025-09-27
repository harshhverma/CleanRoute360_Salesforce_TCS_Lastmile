@isTest
public class PlaceholderApiCalloutTest {
    
    // Mock class for HTTP Response
    class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"message":"Success"}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetPlaceholderResponse() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Call the method
        String response = PlaceholderApiCallout.getPlaceholderResponse();

        System.assertNotEquals(null, response);
        System.assert(response.contains('Success'), 'Response should contain Success message');
    }
}
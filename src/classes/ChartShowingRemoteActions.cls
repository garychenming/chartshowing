public with sharing class ChartShowingRemoteActions
{
    private static final String BASIC_KIVIVM_URL = 'https://api.64clouds.com';

    public ChartShowingRemoteActions(ChartShowingAppController controller) {}

    @RemoteAction
    public static String getData()
    {
        String endpoint = BASIC_KIVIVM_URL + '/v1/getServiceInfo?veid=738304&api_key=' + ChartShowingSettings__c.getOrgDefaults().APIKey__c;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = (new Http()).send(request);
        String body = response.getBody();
        Map<String, Object> keyToValue = (Map<String, Object>)JSON.deserializeUntyped(body);
        Long currentUsedDataByBite = (Long)keyToValue.get('data_counter');
        Decimal currentUsedDataByGB = currentUsedDataByBite / 1024.0 / 1024.0 / 1024.0;
        String currentUsedData = String.valueOf(currentUsedDataByGB).left(4) + 'GB';
        BasicInfo basicInfo = new BasicInfo(endpoint, body, currentUsedData);
        return JSON.serialize(basicInfo);
    }

    public class BasicInfo
    {
        public BasicInfo(String url, String body, String currentUsedData)
        {
            this.Url = url;
            this.Body = body;
            this.CurrentUsedData = currentUsedData;
        }

        public String Url { get; set; }
        public String Body { get; set; }
        public String CurrentUsedData { get; set; }
    }
}
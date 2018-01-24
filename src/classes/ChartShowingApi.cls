public with sharing class ChartShowingApi
{
    private static final String BASIC_KIVIVM_URL = 'https://api.64clouds.com';

    public ChartShowingApi() {}

    public ChartShowing getInfoFromServer()
    {
        String endpoint = BASIC_KIVIVM_URL + '/v1/getServiceInfo?veid=738304&api_key=' + ChartShowingSettings__c.getOrgDefaults().APIKey__c;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = (new Http()).send(request);
        String body = response.getBody();
        Map<String, Object> keyToValue = (Map<String, Object>)JSON.deserializeUntyped(body);
        ChartShowing chartShowing = new ChartShowing(keyToValue);
        return chartShowing;
    }

    public class ChartShowing
    {
        public ChartShowing(Map<String, Object> keyToValue)
        {
            this.Type = (String)keyToValue.get('vm_type');
            this.HostName = (String)keyToValue.get('hostname');
            this.NodeIP = (String)keyToValue.get('node_ip');
            this.NodeAlias = (String)keyToValue.get('node_alias');
            this.NodeLocation = (String)keyToValue.get('node_location');
            this.LocationIPv6Ready = (Boolean)keyToValue.get('location_ipv6_ready');
            this.Plan = (String)keyToValue.get('plan');
            this.PlanMonthlyData = (Long)keyToValue.get('plan_monthly_data');
            this.MonthlyDataMultiplier = (Integer)keyToValue.get('monthly_data_multiplier');
            this.PlanDisk = (Long)keyToValue.get('plan_disk');
            this.PlanRAM = (Long)keyToValue.get('plan_ram');
            this.PlanSwap = (Long)keyToValue.get('plan_swap');
            this.PlanMaxIPv6s = (Integer)keyToValue.get('plan_max_ipv6s');
            this.OperatingSystem = (String)keyToValue.get('os');
            this.Email = (String)keyToValue.get('email');
            this.DataCounter = (Long)keyToValue.get('data_counter');
            this.DataNextReset = (Long)keyToValue.get('data_next_reset');
            //this.IPAddresses = (List<String>)keyToValue.get('ip_addresses');
            this.RDNSAPIAvailable = (Boolean)keyToValue.get('rdns_api_available');
            this.Suspended = (Boolean)keyToValue.get('suspended');
            this.Error = (Integer)keyToValue.get('error');
        }

        public String Type { get; set; }
        public String HostName { get; set; }
        public String NodeIP { get; set; }
        public String NodeAlias { get; set; }
        public String NodeLocation { get; set; }
        public Boolean LocationIPv6Ready { get; set; }
        public String Plan { get; set; }
        public Long PlanMonthlyData { get; set; }
        public Integer MonthlyDataMultiplier { get; set; }
        public Long PlanDisk { get; set; }
        public Long PlanRAM { get; set; }
        public Long PlanSwap { get; set; }
        public Integer PlanMaxIPv6s { get; set; }
        public String OperatingSystem { get; set; }
        public String Email { get; set; }
        public Long DataCounter { get; set; }
        public Long DataNextReset { get; set; }
        public List<String> IPAddresses { get; set; }
        public Boolean RDNSAPIAvailable { get; set; }
        public Boolean Suspended { get; set; }
        public Integer Error { get; set; }
    }
}
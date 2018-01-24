public with sharing class ChartShowingRemoteActions
{
    public ChartShowingRemoteActions(ChartShowingAppController controller) {}

    @RemoteAction
    public static String getData()
    {
        try
        {
            ChartShowingApi chartShowingApi = new ChartShowingApi();
            ChartShowingApi.ChartShowing chartShowing = chartShowingApi.getInfoFromServer();
            ChartShowingUtil.insertNewRecord(chartShowing.DataCounter, false);

            Decimal currentUsedDataByGB = chartShowing.DataCounter / 1024.0 / 1024.0 / 1024.0;
            String currentUsedData = String.valueOf(currentUsedDataByGB).left(5) + 'GB';
            BasicInfo basicInfo = new BasicInfo(chartShowing.Email, chartShowing.OperatingSystem, currentUsedData);
            return JSON.serialize(basicInfo);
        }
        catch(Exception ex)
        {
            return '"ok":false,error' + JSON.serialize(ex);
        }
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
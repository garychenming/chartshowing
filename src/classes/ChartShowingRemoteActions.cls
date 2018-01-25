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
            currentUsedDataByGB = currentUsedDataByGB.setScale(2);
            BasicInfo basicInfo = new BasicInfo(chartShowing.Email, chartShowing.OperatingSystem, currentUsedDataByGB);
            return JSON.serialize(basicInfo);
        }
        catch(Exception ex)
        {
            return '"ok":false,error' + JSON.serialize(ex);
        }
    }

    public class BasicInfo
    {
        public BasicInfo(String url, String body, Decimal currentUsedData)
        {
            this.Url = url;
            this.Body = body;
            this.CurrentUsedData = currentUsedData;
        }

        public String Url { get; set; }
        public String Body { get; set; }
        public Decimal CurrentUsedData { get; set; }
    }
}
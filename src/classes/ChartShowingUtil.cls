public with sharing class ChartShowingUtil
{
    public ChartShowingUtil() {}

    public static void insertNewRecord(Long currentUesdData, Boolean isAutoCreated)
    {
        ChartShowing__c chartShowing = new ChartShowing__c(
            CurrentUsedData__c = currentUesdData,
            IsAutoCreated__c = isAutoCreated
        );

        insert chartShowing;
    }
}
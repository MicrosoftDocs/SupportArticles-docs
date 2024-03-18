---
title: PowerPivot for SharePoint 2016 scheduled data refresh fails with the error The operation has timed out
description: Fixes the timeout issue that you cannot schedule a workbook to refresh after you create a PowerPivot workbook with data sources.
author: helenclu
ms.author: luche
ms.reviewer: randring
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:spsexperts
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# PowerPivot scheduled data refresh fails with the error "The operation has timed out"

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

## Symptoms

Assume that you create a PowerPivot workbook with one or more data sources and upload the workbook to Microsoft SharePoint Server 2016. When you schedule the workbook to refresh, the refresh fails with the following error:

**The operation has timed out.**

If you expand the refresh history, you will notice that the failed data source refresh runs for exactly 100 seconds.

:::image type="content" source="media/powerpivot-scheduled-data-refresh-fails/data-refresh-history.png" alt-text="Screenshot shows that the failed data source refresh runs for exactly 100 seconds on the data refresh history page." border="false":::

You may notice that some of your data sources succeed, or that the refresh succeeds intermittently if all the data sources refresh in less than 100 seconds.

In the SharePoint Unified Logging Service (ULS) logs, you see the actual error, but it seems that it doesn't relate to anything meaningful as far as a cause.
```
DateTime w3wp.exe (0x00000) 0x59D4 PowerPivot Service Data Refresh 99 High EXCEPTION: System.Net.WebException: The operation has timed out at System.Web.Services.Protocols.WebClientProtocol.GetWebResponse(WebRequest request)
```
You will likely see a correlating event (**EventID: 5214**) in the Application Event logs.

If you have multiple workbooks that are pulling from the same source, and one workbook is slowing the data source down, this will cause other queries to wait or slow (past the 100s), you may see multiple workbooks fail.

## Cause

This issue occurs because SharePoint 2016 limits a single PowerPivot data source to a refresh duration of 100 seconds.

> [!NOTE]
> This can also be caused by slow or underperforming data sources if you think your data should be refreshing under 100 seconds. If you are pulling a small amount of data from a complex data source that takes a long time to query, you can consider alternative workarounds because increasing the timeout may not be the best option.

## Workarounds

1. Optimize your queries to run faster.
1. Query less data.
1. Add hardware to your data source to process queries faster.
1. Use PowerShell to increase the default time out setting.

   - Run the following commands in a SharePoint 2016 Administrator enabled PowerShell prompt, modifying the "new_time_out_value" section to the desired timeout value.

     ```powershell
     $farm = Get-SPFarm
     
     #The time out value "new_time_out_value" is in milliseconds, so be very careful to not set it too low!!!

     $farm.Properties.Add("WopiProxyRequestTimeout", new_time_out_value);

     $farm.Update();

     #to double-check the setting (make sure it is of type Int32, otherwise you will need to remove the property an add it again

     $farm.Properties["WopiProxyRequestTimeout"].GetType()
     ```

   - Run the following command to set a different value in the future or if you are having issues with the setting.

     ```powershell
     $farm = Get-SPFarm
     
     $farm.properties.Remove("WopiProxyRequestTimeout")
      
     $farm.Properties.Add("WopiProxyRequestTimeout", new_time_out_value);

     $farm.update()
     ```

> [!NOTE]
> Increase this time out value at your own risk! We realize that the new default time out is very low. But you should also be aware of the amount of data that you are pulling vs the time that it should take to pull that data. Setting this time out too high and allowing users to pull large amounts of data can cause performance issues for PowerPivot, SharePoint and Office Online Server. You will also be limited by the default timeouts for SharePoint, SQL and your external data sources. This time out value may not always be the answer. There are more workarounds and optimization options, depending on the type of data that you are pulling.

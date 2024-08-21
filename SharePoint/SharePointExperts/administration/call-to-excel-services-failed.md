---
title: Call to Excel Services failed with a scheduled data refresh
description: Fixes the Call to Excel Services failed error when you run a scheduled data refresh by using PowerPivot.
author: helenclu
ms.author: luche
ms.reviwer: zakirh
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Service Applications (except Search)
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# "Call to Excel Services failed" error when you run a scheduled data refresh by using PowerPivot

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

When you run a scheduled data refresh on a workbook that has a Power Query connection to a data source by using PowerPivot for Microsoft SharePoint 2013, you may receive a "Call to Excel Services failed" error.

## Cause

Data refreshes for Power Query connections are not supported in SharePoint Server 2013 on-premises. So both data refresh in the browser and scheduled data refresh will show an error if the workbook has a data connection that's created by using Power Query.

## Workaround

To work around this issue, connect to a data source that doesn't use Power Query. To do this, create a data connection by using PowerPivot and then connect to it.

To determine whether the workbook currently has a Power Query data connection or not, view the connection string in Excel by going to **Data** > **Connections** > **Properties** > **Definition**. If the provider is **Microsoft.Mashup.OleDb.1**, this indicates that the data connection was made by using Power Query.

In Excel 2016, the connection may be created by using the **Get & Transform** or **Get Data** feature. This may use the **Microsoft.Mashup.OleDb.1** provider, for example, when combining data from multiple sources.

:::image type="content" source="media/call-to-excel-services-failed/connection-properties-provider.png" alt-text="Screenshot of the Connection Properties dialog box. Under the Definition tab, check if the provider is Microsoft.Mashup.OleDb.1." border="false":::


## More information

Data refresh for Power Query connections is supported by Power BI for Microsoft 365 (SharePoint Online). For more information, see [Scheduled Data Refresh for Power Query](https://powerbi.microsoft.com/blog/scheduled-data-refresh-for-power-query/).

Interactive browser refresh and scheduled data refresh for Power Query connections are supported on-premises with PowerPivot for SharePoint 2016. It has the following minimum product requirements:

- SQL Server 2016 PowerPivot Analysis Services with Cumulative Update 1 (CU1)
- PowerPivot for SharePoint 2016 add-in
- Office Online Server November 2016 release
- The Release to Manufacturing (RTM) version of SharePoint Server 2016

> [!NOTE]
> The interactive data refresh won't work with Windows authentication. It requires a Secure Store ID to be configured to use for the refresh.

Data that is loaded from a Power Query connection needs to be added to the data model. Otherwise, the refresh will fail because PowerPivot is required in this refresh process, and only workbooks with a data model are processed by PowerPivot.

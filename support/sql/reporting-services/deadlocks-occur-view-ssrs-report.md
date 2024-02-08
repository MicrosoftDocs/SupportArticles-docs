---
title: Deadlocks occur when you view an SSRS report
description: This article provides resolutions for the deadlocks that occur when you try to view an SSRS report in SharePoint integrated mode. You receive a time-out error when you try to view the report from a customized SharePoint page.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
ms.reviewer: calton
---
# Database deadlocks occur when you try to view an SSRS report in the SharePoint integrated mode after you update a data source

This article provides resolutions for the deadlocks that occur when you try to view a SQL Server Reporting Services (SSRS) report in SharePoint integrated mode.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2691331

## Symptoms

Consider the following scenario:

- You configure an instance of Microsoft SSRS to use the SharePoint integrated mode.
- You create a report that has multiple data sources.
- You deploy the report to a SharePoint website.
- You update one of the data sources.
- You try to view the report from a customized SharePoint page. The report is embedded in an IFrame control of the page by using direct URL access to the SSRS proxy endpoint as follows:

    http://<**Server Name**>/<**Site Name**>/_vti_bin/ReportServer/<**Report Name**>.rdl?<**Report URL Parameters**>

In this scenario, you may experience one or more of the following symptoms.

- Symptom 1

    Database deadlocks occur on one of the following stored procedures in the back-end Report Server database:

  - `[dbo].[GetDataSources]`
  - `[dbo].[DeleteDataSources]`

- Symptom 2

    You receive one of the following error messages:

  - Error Message 1
    > An error occurred within the report server database. This may be due to a connection failure, timeout or low disk condition within the database. (rsReportServerDatabaseError)

  - Error Message 2
    > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.

- Symptom 3

    The SharePoint pages are very slow to load when you try to access SharePoint site content.

## Cause

This issue occurs because the data source is not synchronized correctly after you update it.

## Resolution

To work around this issue, use one of the following methods:

- Method 1

    View the report directly from the SharePoint document library after you update the report data source. This makes sure the data source is synchronized correctly before you view the report through the SSRS proxy endpoint.

- Method 2

    Use a Report Viewer web part to display the report.

---
title: 'We cannot locate a server to load the workbook Data Model error in PowerPivot for SharePoint 2016'
description: Fixes an error that occurs when you try to render workbooks and slice data in PowerPivot.
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
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# "We cannot locate a server to load the workbook Data Model" error in PowerPivot

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

## Symptoms

Assume that you install PowerPivot for Microsoft SharePoint 2016 or Power BI Report Server, and use SQL Server 2017 as the data model server (Analysis Services in SharePoint mode). You also have configured Office Online Server and all the other dependencies. When you try to render workbooks and slice data, you receive the following error message:

> We cannot locate a server to load the workbook Data Model.

## Analysis

In the Unified Logging Service (ULS) logs on the Office Online Server, you will see errors that are similar with the following while reproducing the error:

```
DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Monitorable Uncaught CLR exception crossing the Interop boundary: Microsoft.AnalysisServices.Streaming.ServerNotFoundException: There are no servers available or actively being initialized. at  <<TRUNCATED STACK FOR LENGTH>><<CORRELATION ID>> 

DateTime w3wp.exe (0x0000) 0x0000 Excel Online External Data by6b8 Medium OLEDBConnection::InitConnection: There are no servers available or actively being initialized. <<CORRELATION ID>>

DateTime w3wp.exe (0x0000) 0x0000 Excel Online Excel Calculation Services akdn Verbose OperationSite.PrepareComplete: Caught Exception when running operation Microsoft.Office.Excel.Server.CalculationServer.Operations.ApplySlicerSelectionOperation, WebMethod: ApplySlicerSelection. Error was Id=NoStreamingServers; Microsoft.Office.Excel.Server.CalculationServer.OperationFailedException: We cannot locate a server to load the workbook Data Model. at Microsoft.Office.Excel.Server.CalculationServer.Operations.Operation.RunOperationAsync() at Microsoft.Office.Excel.Server.CalculationServer.Operations.OperationSite.PrepareComplete(PrepareAsyncArgs args) <<CORRELATION ID>>
```

These errors just can indicate that data models can't be created on the PowerPivot Analysis Services server. They can't help very much with the diagnosis. To find a root cause, a deeper look at the log is required and some background on Excel Services is needed.

When Excel Services starts for the first time, it performs a series of checks against the defined PowerPivot instances prior to initialization. If one fails, that server is taken out of the pool of available servers. After the three main checks, it does a query for available memory. This is based on the performance counters that are applied to the server during the SQL Server Analysis Services (SSAS) installation. Because PowerPivot is so reliant on performance-based counters, if the counters are missing and the memory check fails, the initialization of the server will also fail. This goes back to one of the errors we saw earlier: "There are no servers available or actively being initialized."

So, you may see this list of checks in the logs at any given time. But if, you run a restart-service **wacsm** command and are logging during the restart, you will see the following (you may need to engage Excel somehow to get this to pop up):

```
DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Medium Checking Server Configuration (SERVERNAME\POWERPIVOT)

DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Medium --> Check Administrator Access (SERVERNAME\POWERPIVOT): Pass.

DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Medium --> Check Server Version (SERVERNAME\POWERPIVOT): Pass (14.0.1.439 >= 11.0.2800.0).

DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Medium --> Check Deployment Mode (SERVERNAME\POWERPIVOT): Pass.

DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Medium Check Server Configuration (SERVERNAME\POWERPIVOT): Pass.

DateTime w3wp.exe (0x0000) 0x0000 Excel Online Data Model 27 Medium SSPM: Initialization failed on server SERVERNAME\POWERPIVOT: Microsoft.AnalysisServices.AdomdClient.AdomdErrorResponseException: The '\MSOLAP$POWERPIVOT:Memory\Memory Limit High KB' performance counter could not be found. System error -1073738824 <<TRUNCATED STACK>>
```

## Cause

Performance counters are missing. This is a known issue with the Tabular model of SQL Server Analysis Services 2017 (SSAS 2017) after you apply [**Cumulative Update 1 for SQL Server 2017**](https://support.microsoft.com/en-us/help/4038634/cumulative-update-1-for-sql-server-2017) or [**Cumulative Update 2 for SQL Server 2017**](https://support.microsoft.com/en-us/help/4052574/cumulative-update-2-for-sql-server-2017). Subsequently, if you install another instance on top of it, or even uninstall or reinstall, the performance counters will still not be installed on the server.

## Resolution

This issue is fixed in the Cumulative Update 3 for SQL Server 2017. See [**FIX: Performance Counters are missing after the installation of SSAS 2017 in tabular mode**](https://support.microsoft.com/en-us/help/4056328/performance-counters-are-missing-after-the-installation-of-ssas-2017).

To fix this issue, we recommend that you install the [**latest cumulative update for SQL Server 2017**](https://www.microsoft.com/en-us/download/details.aspx?id=56128).

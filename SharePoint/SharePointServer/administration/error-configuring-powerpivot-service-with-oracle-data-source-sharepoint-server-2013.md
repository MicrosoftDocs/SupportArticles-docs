---
title: Error when configuring a PowerPivot service with an Oracle data source in SharePoint Server 2013
description: Resolves an error when configuring a PowerPivot service with an Oracle data source in SharePoint Server 2013.
author: helenclu
ms.author: luche
ms.reviewer: 
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Error when configuring a PowerPivot service with an Oracle data source in SharePoint Server 2013

## Symptoms
When you attempt to configure a PowerPivot-scheduled refresh with an Oracle data source in SharePoint Server 2013, you see the following error while adding the Oracle-related SSID under data source credentials:

> The provided Secure Store target application is either incorrectly configured or does not exist.

The Unified Logging Service (ULS) will also display the following details:

```
02/06/2019 01:13:15.80 w3wp.exe (Servername:0x85F8) 0x41E0 SharePoint Server Database fdz2 VerboseEx SQL IO Statistics: Procedure proc_sss_GetRestrictedCredentials, Table 'SSSApplication'. Scan count 0, logical reads 4, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0. 423dbd9e-5d81-e070-ca0c-21267ad6b241

01:13:15.80 w3wp.exe (Servername:0x85F8) 0x41E0 Secure Store Service Secure Store elm4 High SQL command failed: Sproc name: proc_sss_GetRestrictedCredentials, Application Id: PPIVORA, Error code: 80630001, Error message: Credentials were not found for the current user within the target application 'PPIVORA'. Please set the credentials for the current user. 423dbd9e-5d81-e070-ca0c-21267ad6b241
01:13:15.80 w3wp.exe (Servername:0x85F8) 0x41E0 Secure Store Service Secure Store efp6 Medium GetRestricted
```

Credentials failed with the following exception:

```
System.ServiceModel.FaultException`1[Microsoft.Office.SecureStoreService.Server.SecureStoreServiceCredentialsNotFoundFault]: Credentials were not found for the current user within the target application 'PPIVORA'. Please set the credentials for the current user. (Fault Detail is equal to Microsoft.Office.SecureStoreService.Server.SecureStoreServiceCredentialsNotFoundFault). 423dbd9e-5d81-e070-ca0c-21267ad6b241
```

## Cause
PowerPivot and farm admin service accounts must be present in the **Members** groups under the **Secure TargetId** in the Secure Store Service (SSS).

## Resolution
Two SSIDs (one using Oracle credentials and other using Windows credentials) are required for a third party data source, such as Oracle.

Perform the following steps to see the error:

1. Browse to the **PowerPivot Gallery**.
2. Locate the workbook for which you want to **Schedule a Data Refresh**.
3. Select **Manage Data Refresh**.
4. Select **Use the data refresh account configured by the administrator**.
5. Select **Connect using the credentials saved in the Secure Store Service (SSS) to log on to the data source**.
6. Enter the ID used to look up the credentials in the SSS ID box.

Since the farm account is different from the PowerPivot account, the error appears due to a lack of permission.

## More information

The target ID created in the SSS should be a "Group" type.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).

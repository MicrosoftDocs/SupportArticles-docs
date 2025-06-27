---
title: MapiFxProxyTransientException when doing migration
description: Describes a problem in which you receive a StalledDueToTarget_Processor error message when you perform an Exchange migration in Microsoft 365. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: benjak, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# StalledDueToTarget_Processor error during Exchange migration in Microsoft 365

_Original KB number:_ &nbsp; 3162761

## Symptoms

When you perform a Microsoft Exchange Server migration, you receive a **StalledDueToTarget_Processor** error message. This problem occurs in Microsoft 365.

When you view the data in the move report, the report contains an error message that resembles the following:

> {DataExportTransientException: MapiFxProxyTransientException: The data export was cancelled  
due to a timeout. The destination didn't respond in time. --> The data export was cancelled  
due to a timeout. The destination didn't respond in time., DataExportTransientException:  
MapiFxProxyTransientException: The data export was cancelled due to a timeout. The  
destination didn't respond in time. --> The data export was cancelled due to a timeout. The  
destination didn't respond in time., DataExportTransientException:  
MapiFxProxyTransientException: The data export was cancelled due to a timeout.

To view the move report, run the following command:

```powershell
Get-MoveRequest -Identity <User> | Get-MoveRequestStatistics -IncludeReport | FL
```

## Cause

This problem occurs when the MRS Proxy for the mailbox move request is a configuration on the on-premises Exchange Server 2013 Client Access server (CAS).

## Resolution

To fix this problem, you must change the MSExchangeMailboxReplication.exe.config file. To make the required change, follow these steps:

1. Locate the MSExchangeMailboxReplication.exe.config file in the following path:

   \<Exchange Installation Path>\Program Files\Microsoft\Exchange Server\V15\Bin\MSExchangeMailboxReplication.exe.config

2. Change the **DataImportTimeout** setting from the default value to **20**.
3. Save the changes to the file.
4. Restart the MSExchangeMailboxReplication service.
5. On all CA servers, change the **DataImportTimeout** setting to **20**.
6. Allow up to four hours for the migration batches to resume as usual.

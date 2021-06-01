---
title: Offline synchronization fails
description: This article discusses how to used advanced configuration options available in the registry for the Microsoft Dynamics CRM client for Outlook offline sync process to improve or resolve errors with data transfer.
ms.reviewer: clintwa
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Offline synchronization fails in Microsoft Dynamics CRM client for Outlook

This article provides a resolution for the issue that offline synchronization fails when you change offline synchronization filters for the offline synchronization process in Microsoft Dynamics CRM client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2715857

## Symptoms

When you modify your offline synchronization filters for the offline synchronization process in the Microsoft Dynamics CRM client for Outlook with offline access, you might experience errors like the following:

> BCP file size is incorrect. Actual:1151232800. Expected:1151232478"  
"Crm Exception: Message: Client was not able to download BCP file. ErrorCode: -2147204572"  
"BCP file size is incorrect. Actual:516357050. Expected:516356728"  
"BCP file size is incorrect. Actual:293877994. Expected:293877672"  
"Downloaded 0 bytes for entity Annotation, batchSize= 146"  
"Crm Exception: Message: Failed move data for entity 'Note' during action Insert, countRows=584, ErrorCode: -2147204571"

> [!NOTE]
> Actual and Expected are measured in bytes. The entity listed might be different as well.

## Cause

The size of the BCP files might be too large or are taking too much time to download from the Microsoft Dynamics CRM server because they contain too much data.

## Resolution

Adjust the registry for the Microsoft Dynamics CRM client for Outlook with offline access to tune the values used to synchronize data from Microsoft Dynamics CRM to the SQL Express database used while offline in the Microsoft Dynamics CRM client for Outlook with offline access.

All registry entries listed below exist in the following location:

`HKCU\Software\Microsoft\MSCRMClient`

Name: OfflineRowsBatchSize  
Type: DWORD  
Valid Value: Positive integer value greater than or equal to 1  
Default Value: 10000  
Purpose: Size for each initial batch of data downloaded from the CRM Server.

Name: OfflineMaxRetryCount  
Type: DWORD  
Valid Value: Positive integer value greater than or equal to 1  
Default Value: 3  
Purpose: Number of times a batch is retried before failing. Each failure may retry with a smaller batch size depending on the rate of decrease.

Name: OfflineIncreaseRate  
Type: DWORD  
Valid Value: Positive integer value greater than or equal to 1  
Default Value: 2  
Purpose: How much next batch is increased in size (previous batch size * OfflineIncreaseRate) if the previous batch was completed successfully in the allow time span.

Name: OfflineDecreaseRate  
Type: DWORD  
Valid Value: Positive integer value greater than or equal to 1  
Default Value: 2  
Purpose: How much next batch is decreased in size (previous batch size / OfflineDecreaseRate) if the previous batch failed to complete successfully or did not complete in the allowed time span.

Name: OfflineMaxBatchTimeMillSec  
Type: DWORD  
Valid Value: Positive integer value greater than or equal to 1 measured in milliseconds  
Default Value: 60000  
Purpose: The max time in milliseconds that is acceptable to download a batch before the batch size is decreased.

Name: OfflineMinBatchTimeMilliSec  
Type: DWORD  
Valid Value: Positive integer value greater than or equal to 1 measured in milliseconds  
Default Value: 10000  
Purpose: The min time in milliseconds that is acceptable to download a batch before the batch size is increased.

> [!NOTE]
> `OfflineMinBatchTimeMilliSec` must be less than or equal to `OfflineMaxBatchTimeMilliSec`.

> [!IMPORTANT]
> If you set `OfflineMinBatchTimeMilliSec` equal to `OfflineMaxBatchTimeMilliSec` then the batch size will stay the same and never increase or decrease. This may cause the sync process to take much longer than normal, but may allow the process to complete if the errors received are due to too large of files attempting to be downloaded from the CRM Server.

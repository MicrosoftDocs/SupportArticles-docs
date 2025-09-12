---
title: Microsoft Azure Backup offline seeding is stuck at waiting for Azure import job to complete
description: Describes an issue that occurs when you try to use the Microsoft Azure Backup (MAB) offline seeding feature.
ms.date: 10/10/2020
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: 
ms.custom: sap:I need help with Azure Backup
---
# Microsoft Azure Backup offline seeding is stuck at waiting for Azure import job to complete

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3119587

## Symptoms

When you try to use the Microsoft Azure Backup (MAB) offline seeding feature, the import job doesn't continue after it sends the drive to Azure for importing. Additionally, the MAB interface displays the following message and doesn't continue:

> Waiting for Azure Import Job to complete. Please check on Azure management portal for more information on job status

Additionally, you may see entries that resemble the following in _C:\Program Files\Microsoft Azure Recovery Services Agent\Temp\CBEngineCurr.errlog_:

```
... 44B4 3968 10/21 21:02:21.611 69 AzureServiceManagementHelper.cs(320) 0517B3DB-347D-45A8-9DAB-FD7D1EA7D134 FATAL GetImportJobStatus:: Import job with name 'ImportJobName' is not found 44B4 3968 10/21 21:02:21.611 71 backupasync.cpp(1589) [000000001B73B830] 0517B3DB-347D-45A8-9DAB-FD7D1EA7D134 NORMAL PollAzureImportJob :: Import Job: 'ImportJobName' is in pending state: '1' 44B4 3968 10/21 21:02:21.611 71 backupasync.cpp(1607) [000000001B73B830] 0517B3DB-347D-45A8-9DAB-FD7D1EA7D134 WARNING PollAzureImportJob failed with error code: 1b7afbe0 44B4 3968 10/21 21:02:21.611 71 backupasync.cpp(1184) [000000001B73B830] 0517B3DB-347D-45A8-9DAB-FD7D1EA7D134 WARNING Failed: Hr: = [0x80780054] Offline Backup Progress: Failed" .....
```

## Cause

This issue can occur if the name that you entered for Azure Import Job Name when you configured offline seeding does not match the name that you entered for Job Name  in the Azure portal when you created the import job. Both job names must be identical before offline seeding can continue.

## Resolution

To fix this issue, remove the backup policy by using the **Stop protection and delete data**  option, and then schedule a new policy that has the correct offline backup parameters by providing a new import job name that matches the job name in the Azure portal.

For detailed information about how to do this, see the following article:
[Offline Backup workflow in Azure Backup](/azure/backup/backup-azure-backup-import-export).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

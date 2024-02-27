---
title: .NET Framework 4.7.2 updates fail to sync
description: Address an issue in which August 2019 .NET 4.7.2 updates fail to synchronize in Configuration Manager.
ms.date: 12/05/2023
ms.custom: sap:Boot images
ms.reviewer: kaushika, umaikhan, sccmcsscontent
---
# August 2019 .NET Framework 4.7.2 updates fail to synchronize in Configuration Manager

This article describes an issue in which .NET Framework 4.7.2 updates that were released in August 2019 fail to synchronize in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4517482

## Symptoms

The synchronization of the following updates that were released in August 2019 between Configuration Manager (ConfigMgr) and Windows Server Update Service (WSUS) fails:

- Microsoft .NET Framework 4.7.2 for Windows Server 2012 for x64 (KB4054542)
- Microsoft .NET Framework 4.7.2 for Windows Server 2008 R2 for x64 (KB4054530)
- Microsoft .NET Framework 4.7.2 for Windows 7 for x64 (KB4054530)
- Microsoft .NET Framework 4.7.2 for Windows 7 (KB4054530)
- Microsoft .NET Framework 4.7.2 for Windows Server 2012 R2 for x64 (KB4054566)

You may see entries resembling the following in the WSyncMgr.log:

> 08-14-2019 08:37:30.102 Synchronizing update 7155376c-87e9-4f55-80f1-0d7c64eb8b5d - **Microsoft .NET Framework 4.7.2 for Windows 7 (KB4054530)**  
> 08-14-2019 08:37:30.421 *** declare @rc int, @errxml xml, @errmsg nvarchar(max); EXEC @rc=sp_SetupCI 16916014, default, @errxml output, @errmsg output; select @rc, @errxml, @errmsg  
> 08-14-2019 08:37:30.421 \*** [25000][266][Microsoft][SQL Server Native Client 11.0][SQL Server] **Transaction count after EXECUTE indicates a mismatching number of BEGIN and COMMIT statements. Previous count = 1, current count = 0**. : sp_SetupCI  
> 08-14-2019 08:37:30.422 \*** declare @rc int, @errxml xml, @errmsg nvarchar(max); EXEC @rc=sp_SetupCI 16916014, default, @errxml output, @errmsg output; select @rc, @errxml, @errmsg  
> 08-14-2019 08:37:30.423 \*** [42000][50000][Microsoft][SQL Server Native Client 11.0][SQL Server] **ERROR 2627, Level 14, State 1, Procedure** tr_vCI_ContentFiles_upd, Line 17, Message: **Violation of UNIQUE KEY constraint 'CI_Files_AK'. Cannot insert duplicate key in object** 'dbo.CI_Files'. The duplicate key value is (SHA1:A1C5F3C6AC7519F692791960092C07C745C48481, windows6.1-kb4019990-x86.cab, 0xc591f16ff97c9725c03e10528996d059f3dd936f). : spRethrowError  
> 08-14-2019 08:37:30.426 Failed to sync update 7155376c-87e9-4f55-80f1-0d7c64eb8b5d. **Error: Failed to save update** 9f6cfa34-72f4-4fe6-9131-5fb03d1af361. CCISource error: -1. Source: Microsoft.SystemsManagementServer.SoftwareUpdatesManagement.UpdatesManager.UpdatesManagerClass.DefineUpdate

## Cause

This intermittent issue only occurs if the update is revised and the `SourceURL` already present in Configuration Manager metadata is changed. This causes a violation of a unique key constraint. Not all customers will encounter this issue.

## Resolution

This issue only occurs in Configuration Manager current branch version 1810 and later versions. The Microsoft .NET team is working to expire these updates and will republish them soon. This article will be revised when the updates are republished. The subsequent synchronization should complete successfully.

- If the listed updates aren't required in your environment, you can decline them in WSUS to prevent them from synchronizing to Configuration Manager.
- If you need these updates and cannot wait for the republishing, you can manually download and distribute them using software distribution.

> [!NOTE]
> This issue only affects the updates that are listed in this article and does not block synchronization of other updates.

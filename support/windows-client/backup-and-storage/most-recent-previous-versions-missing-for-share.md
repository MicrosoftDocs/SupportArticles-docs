---
title: Most recent previous versions are missing for a share that has Previous Versions enabled in Windows
description: Works around an issue in which most recent previous versions aren't displayed for a share in Windows that has the Previous Versions feature enabled.
ms.date: 12/03/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, robsim, cpuckett, v-jesits, v-six
ms.prod-support-area-path: Volume Shadow Copy Service (VSS)
ms.technology: windows-client-backup-and-storage
---
# Most recent previous versions are missing for a share that has Previous Versions enabled in Windows

This article provides a workaround for an issue in which most recent previous versions aren't displayed for a share in Windows that has the **Previous Versions** feature enabled.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4032986

## Symptoms

When you connect to a share that has the **Previous Versions** feature enabled, you can see only older previous versions. The most recent previous versions are missing for the share.

## Cause

This issue occurs because Windows 8, Windows Server 2012, and later Windows versions are limited to view 500 previous versions. Therefore, only the oldest 500 previous versions are displayed.

## Workaround

To work around this issue, limit the number of previous versions that are kept on the server to 500 per volume.

## More Information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

By default, Windows keeps only 64 snapshots per volume for previous versions. You can adjust this limit by creating or changing the following registry key:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VSS\Settings\MaxShadowCopies`  

See [Registry Keys and Values for Backup and Restore](/windows/win32/backup/registry-keys-for-backup-and-restore) for more information.

Setting this key to a value higher than the client system can handle prevents users from seeing the most recent previous versions. The client-side limit for each operating system is as follows:

- Windows 8, Windows Server 2012, and later versions have a client-side limit of 500.
- Windows Vista, Windows 7, Windows Server 2008, and Windows Server 2008 R2 have a client-side limit of 500 for the [Server Message Block](/windows/win32/fileio/microsoft-smb-protocol-and-cifs-protocol-overview) (SMB) version 1 (SMBv1) protocol and 64 for the SMB version 2 (SMBv2) protocol.
- Windows XP and Windows Server 2003 have a client-side limit of 64.

> [!Note]
> The client-side limit isn't adjustable. It is only on the server that you can adjust the number of previous versions that are kept.

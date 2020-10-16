---
title: FSRM quota usage is incorrect
description: Resolves an issue in which the FSRM quota usage is incorrect.
ms.date: 09/17/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, daised
ms.prod-support-area-path: File Server Resource Manager (FSRM)
ms.technology: BackupStorage
---
# The FSRM quota usage is incorrect when you change the size of the page file in Windows

This article provides a workaround for an issue where the File Server Resource Manager (FSRM) quota usage is incorrect.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3034439

## Symptoms

This issue occurs on a computer that is running Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008 and that has the [FSRM](https://technet.microsoft.com/library/hh831701.aspx) feature enabled.

## Cause

This issue occurs because FSRM detects that the size of the page file is excluded in the FSRM quota.

## Workaround

To work around this issue, run one of the following commands to perform the scan again and recalculate quota usage information:

In Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008, at a command prompt, type the following command, and then press ENTER: Dirquota quota scan/path: **paths**  

In Windows Server 2012 R2, run the following command in Windows PowerShell: Update-FsrmQuota-path **paths**  

## Status

This behavior is expected.

## More information

For more information about how to configure the Availability service for cross-forest topologies, visit the following Microsoft website:
- [General information about the Dirquota quota](https://technet.microsoft.com/library/cc770384%28v=ws.10%29)
- [General information about the Update-FsrmQuota cmdlet](/powershell/module/fileserverresourcemanager/update-fsrmquota?view=win10-ps)

See an issue that [the FSRM quota report for the system root folder shows a smaller available size than Windows Explorer](https://support.microsoft.com/help/977522).

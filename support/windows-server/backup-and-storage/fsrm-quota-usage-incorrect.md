---
title: FSRM quota usage is incorrect when you change the size of the page file
description: Resolves an issue in which the FSRM quota usage is incorrect when you change the size of the page file.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, daised
ms.custom: sap:file-server-resource-manager-fsrm, csstroubleshoot
---
# The FSRM quota usage is incorrect when you change the size of the page file in Windows

This article provides a workaround for an issue where the File Server Resource Manager (FSRM) quota usage is incorrect.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3034439

## Symptoms

This issue occurs on a computer that is running Windows Server 2012 R2 that has the [FSRM](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831701(v=ws.11)) feature enabled.

## Cause

This issue occurs because FSRM detects that the size of the page file is excluded in the FSRM quota.

## Workaround

Run the `Update-FsrmQuota-path paths` command in Windows PowerShell to perform the scan again and recalculate quota usage information.

## Status

This behavior is expected.

## References

- [Dirquota quota](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770384(v=ws.10))
- [General information about the Update-FsrmQuota cmdlet](/powershell/module/fileserverresourcemanager/update-fsrmquota?view=win10-ps&preserve-view=true)

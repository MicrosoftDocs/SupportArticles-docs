---
title: VSS GetBackupMetadata may return incorrect path
description: This article describes an issue that may occur when a VSS requestor calls GetBackupMetadata.
ms.date: 01/04/2021
ms.custom: sap:TBD
ms.reviewer: jlaborde
ms.topic: article
ms.subservice: general
---
# VSS GetBackupMetadata may return incorrect path for Terminal Services

This article describes an issue that may occur when a VSS requestor calls `GetBackupMetadata`.

_Applies to:_ &nbsp; Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows Server 2012 Datacenter, Windows Server 2012 Standard  
_Original KB number:_ &nbsp; 3069994

## Summary

When a Volume Shadow Copy Service (VSS) requestor calls `GetBackupMetadata`, the Terminal Services writer may return an incorrect path. This may cause failures in backup applications that are trying to back up this path and these files.

## More information

The path that is returned by the Terminal Services writer may be of the form `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Terminal Services`. In this example, the *Terminal Services* folder name is incorrect and should be `Remote Desktop Services` instead.

If you encounter a failure to locate a reported file or folder that is related to Terminal Services or Remote Desktop Services, you can work around the issue by replacing `Terminal Services` with `Remote Desktop Services` in paths that are returned in the metadata.

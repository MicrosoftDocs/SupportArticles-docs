---
title: Diskshadow error when creating VSS snapshot
description: Describes an issue that triggers an error message when you try to create a Volume Shadow Services (VSS) diskshadow snapshot. The error message reflects a benign condition that doesn't disrupt the backup operation.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# Diskshadow error when you try to create a VSS snapshot  

This article describes an issue that triggers an error message when you try to create a Volume Shadow Services (VSS) diskshadow snapshot.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3025158

## Symptoms  

When you open an administrator command prompt and create a VSS diskshadow snapshot in Windows Server 2012 R2, the output may contain an error:  

Commands:

```console
DISKSHADOW> add volume c:  
DISKSHADOW> create
```

Output:

> COM call "lvssObject4->GetRootAndLogicalPrefixPaths" failed.

## Cause

This error occurs when the backup operation reaches a point, where it tries to process the boot configuration data (BCD) store data. BCD store is in the system partition. But because this partition isn't in the list of mounted devices, the error is triggered.

## Resolution

This particular COM call failure message is harmless. Despite the message, the shadowcopy backup is completed successfully. So, no resolution is required.

## More information

Microsoft is aware of this issue and will continue to investigate for future updates.

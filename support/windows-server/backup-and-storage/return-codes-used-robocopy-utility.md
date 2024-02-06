---
title: Return codes used by the Robocopy utility
description: Discusses the return codes that are used by the Robocopy utility in Windows Server 2008 or Windows Server 2008 R2.
ms.date: 06/30/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# Return codes that are used by the Robocopy utility in Windows Server 2008 or Windows Server 2008 R2

This article discusses the return codes that are used by the Robocopy utility in Windows Server 2008 or Windows Server 2008 R2.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954404

## Introduction

The following table lists and describes the return codes that are used by the Robocopy utility.

|Value|Description|
|---|---|
|0|No files were copied. No failure was met. No files were mismatched. The files already exist in the destination directory; so the copy operation was skipped.|
|1|All files were copied successfully.|
|2|There are some additional files in the destination directory that aren't present in the source directory. No files were copied.|
|3|Some files were copied. Additional files were present. No failure was met.|
|5|Some files were copied. Some files were mismatched. No failure was met.|
|6|Additional files and mismatched files exist. No files were copied and no failures were met. Which means that the files already exist in the destination directory.|
|7|Files were copied, a file mismatch was present, and additional files were present.|
|8|Several files didn't copy.|
  
> [!NOTE]
> Any value greater than or equal to 8 indicates that there was at least one failure during the copy operation.

## More information

For more information about how to use the Robocopy utility, open a command prompt, type the following command, and then press **ENTER**:  
    `Robocopy /?`

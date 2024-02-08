---
title: Variables are resolved incorrectly
description: Provides a solution to an issue where the `%HOMEPATH%`, `%HOMESHARE%`, and `%HOMEDRIVE%` variables are resolved incorrectly.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, darolt
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.subservice: networking
---
# %HOMEPATH%, %HOMESHARE%, and %HOMEDRIVE% variables are resolved incorrectly

This article provides a solution to an issue where the `%HOMEPATH%`, `%HOMESHARE%`, and `%HOMEDRIVE%` variables are resolved incorrectly.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 237566

## Symptoms

One of the features of the Microsoft Distributed File System (DfS) is to allow users to map drives directly to folders and subfolders under a DfS share. If a user's home folder is on a DfS share, the `%HOMEDRIVE%` variable is mapped only to the DfS root, and not to the complete path. This behavior is evident when it's viewed from Windows NT Explorer. In addition, the `%HOMEPATH%` and `%HOMESHARE%` variables are not resolved correctly.

For example, if "Dfs_root" is the DFS root on \\\\Pkdfs and the user's home folder is `\\Pkdfs\Dfs_root\Home\User1`:

`%HOMEDRIVE%` (for example, drive Z) is mapped to `\\Pkdfs\Dfs_root`  
`%HOMESHARE%` resolves to `\\Pkdfs\Dfs_root`  
`%HOMEPATH%` resolves to `\Home\User1`.

Instead, `%HOMEDRIVE%%HOMESHARE%` should resolve to `\\Pkdfs\Dfs_root\Home\User1`, `%HOMEPATH%` should resolve to \\, and `%HOMEDRIVE%` (Z:) should map to `\\Pkdfs\Dfs_root\Home\User1`.

## Resolution

To resolve this problem, obtain the latest service pack for Windows NT Server 4.0, Terminal Server Edition.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows NT 4.0 Server, Terminal Server Edition, Service Pack 5.

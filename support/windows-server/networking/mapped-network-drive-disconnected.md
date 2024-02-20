---
title: Mapped network drive is disconnected
description: Describes a problem that occurs after you install or upgrade to Symantec AntiVirus 10.0 or to Symantec Client Security 3.0. Describes how to resolve the problem.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# A mapped network drive appears to be disconnected after you install or upgrade to Symantec AntiVirus 10.0 or to Symantec Client Security 3.0

This article provides a solution to an issue where mapped network drive is disconnected after you install or upgrade to Symantec AntiVirus 10.0 or to Symantec Client Security 3.0.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 932463

## Symptoms

After you install or upgrade to Symantec AntiVirus 10.0 or to Symantec Client Security 3.0 on a Microsoft Windows Server 2003-based computer or on a Microsoft Windows XP-based computer, you receive the following message for a mapped network drive in Windows Explorer:

> Disconnected Network Drive

However, you can still access the contents of the mapped drive. Additionally, when you try to remove the mapped drive in Windows Explorer, you receive the following error message:

> The network connection could not be found.

## Cause

This problem occurs because of an issue in Symantec AntiVirus 10.0 and in Symantec Client Security 3.0.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To remove the incorrectly labeled mapped drive, follow these steps:

1. Click **Start**, point to **Run**, type *regedit*, and then click **OK**.
2. In Registry Editor, locate the following registry subkey:  `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2`  

3. Right-click the mapped drive that you want to remove. For example, right-click **##Server_Name#Share_Name**, and then click **Delete**.

> [!NOTE]
> Replace the **Server_Name** placeholder with the name of the server that hosts the mapped network drive. Replace the **Share_Name** placeholder with the name of the mapped network drive.

## More information

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

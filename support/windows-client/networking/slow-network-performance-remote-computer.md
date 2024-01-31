---
title: Slow network performance on remote network computer
description: Fixes a slow network performance issue that can occur when you open a file that is located in a shared folder on a remote network computer.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.subservice: networking
---
# Slow network performance when you open a file that is located in a shared folder on a remote network computer

This article helps fix a slow network performance issue that can occur when you open a file that is located in a shared folder on a remote network computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 829700

## Symptoms

When you use Windows Explorer to connect to a shared folder on a remote computer on your network, and you double-click a file in that shared folder to open it, it may take a longer time than expected to open the file. For example, you may experience this issue when you open a Microsoft Office document over a slow connection, such as a 64-kilobits-per-second (kbps) Integrated Services Digital Network (ISDN) connection on a wide area network (WAN).

## Cause

This issue occurs because Windows Explorer tries to obtain detailed information about the remote share and about the file that you are opening. This operation may take a long time over a slow connection.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Add the **SuppressionPolicy** DWORD value to the following registry key: `HKEY_CLASSES_ROOT\*\Shellex\PropertySheetHandlers\CryptoSignMenu`  
To do so:  

    1. Click **Start**, and then click **Run**.
    2. In the **Open** box, type regedit, and then click **OK**.
    3. Locate and then click the following registry key: `HKEY_CLASSES_ROOT\*\Shellex\PropertySheetHandlers\CryptoSignMenu`  

    4. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
    5. Type SuppressionPolicy, and then press ENTER.
    6. On the **Edit** menu, click **Modify**.
    7. Click **Hexadecimal**, type 100000 in the **Value data** box, and then click **OK**.
2. Add the **SuppressionPolicy** DWORD value to the following registry key: **HKEY_CLASSES_ROOT\\*\Shellex\PropertySheetHandlers\\{3EA48300-8CF6-101B-84FB-666CCB9BCD32}**  
To do so:
    1. In Registry Editor, locate and then click the following registry key: **HKEY_CLASSES_ROOT\\*\Shellex\PropertySheetHandlers\\{3EA48300-8CF6-101B-84FB-666CCB9BCD32}**  

    2. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
    3. Type SuppressionPolicy, and then press ENTER.
    4. On the **Edit** menu, click **Modify**.
    5. Click **Hexadecimal**, type 100000 in the **Value data** box, and then click **OK**.
3. Add the **SuppressionPolicy** DWORD value to the following registry key: **HKEY_CLASSES_ROOT\\*\Shellex\PropertySheetHandlers\\{883373C3-BF89-11D1-BE35-080036B11A03}**  
To do so:
    1. In Registry Editor, locate and then click the following registry key: **HKEY_CLASSES_ROOT\\*\Shellex\PropertySheetHandlers\\{883373C3-BF89-11D1-BE35-080036B11A03}**  
    2. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
    3. Type SuppressionPolicy, and then press ENTER.
    4. On the **Edit** menu, click **Modify**.
    5. Click **Hexadecimal**, type 100000 in the **Value data** box, and then click **OK**.
4. Add the **Flags** DWORD value to the following registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SCAPI`  
To do so:
    1. In Registry Editor, locate and then click the following registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SCAPI`  

    2. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
    3. Type Flags, and then press ENTER.
    4. On the **Edit** menu, click **Modify**.
    5. Click **Hexadecimal**, type 00100c02 in the **Value data** box, and then click **OK**.
    6. Quit Registry Editor.

### Adding a Group Policy

Besides the direct registry modifications that are described in the "Changing the registry" section, you can also resolve this issue by using a Group Policy. Administrators can control which shell extensions can run by using the **Approved** key and the EnforceShellExtensionSecurity policy. The SuppressionPolicy value is tied to the EnforceShellExtensionSecurity policy. You can add this policy to enable the modified shell behavior.

To do this, follow these steps:  

1. Click **Start**, click **Run**, type Gpedit.msc, and then click **OK**.
2. Under **User Configuration** in the left pane, expand **Administrative Templates**, expand **Windows Components**, and then click **Windows Explorer**.
3. In the right pane, double-click **Allow only per user or approved shell extensions**, click **Enabled**, and then click **OK**.

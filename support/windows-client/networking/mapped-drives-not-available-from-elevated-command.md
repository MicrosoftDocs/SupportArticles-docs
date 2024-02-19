---
title: Mapped drives are not available
description: Describes an issue in which mapped drives are unavailable from an elevated command prompt.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ntuttle, ardenw
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Mapped drives are not available from an elevated prompt when UAC is configured to Prompt for credentials

This article provides methods to solve the issue that mapped drives are unavailable in an elevated command prompt.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3035277

## Symptoms

This issue occurs when the following conditions are true:

- You use Group Policy Preference (GPP) or logon scripts to map network drives during logon.
- User Account Control (UAC) is enabled.
- The following UAC Group Policy setting is configured to Prompt for credentials:  
  **User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode**
- The `EnableLinkedConnections` registry entry is configured. See the [detail to configure the EnableLinkedConnections registry entry](#detail-to-configure-the-enablelinkedconnections-registry-entry).

Under these conditions, you experience the following situation:

- When you sign in to the client, mapped drives are available as expected.
- When you run an elevated command prompt as administrator, the mapped drives are unavailable in the elevated command prompt.

> [!NOTE]
> This issue also affects other applications that run in an elevated context (run as administrator) and use drive letters to access mapped drives.

## Cause

When UAC is enabled, the system creates two logon sessions at user logon. Both logon sessions are linked to one another. One session represents the user during an elevated session, and the other session where you run under least user rights.

When drive mappings are created, the system creates symbolic link objects (DosDevices) that associate the drive letters to the UNC paths. These objects are specific for a logon session and are not shared between logon sessions.

> [!NOTE]
> The `EnableLinkedConnections` registry entry forces the symbolic links to be written to both linked logon sessions that are created, when UAC is enabled.

When the UAC policy is configured to **Prompt for credentials**, a new logon session is created in addition to the existing two linked logon sessions. Previously created symbolic links that represent the drive mappings will be unavailable in the new logon session.

## Workaround - Method 1

1. In Local Group Policy Editor, locate the following Group Policy path:  
   Local Computer Policy\Windows Settings\Security Settings\Local Policies\Security Options
2. Configure the following policy to **Prompt for consent**:
   **User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode**

## Workaround - Method 2

Map the required drives again in the elevated session, for example, by using a .bat script file.

## Detail to configure the EnableLinkedConnections registry entry

1. In Registry Editor, locate and then click the following registry subkey:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
2. Right-click **Configuration**, select **New**, and then select **DWORD (32-bit) Value**.
3. Name the new registry entry as *EnableLinkedConnections*.
4. Double-click the **EnableLinkedConnections** registry entry.
5. In the **Edit DWORD Value** dialog box, type *1* in the **Value data** field, and then select **OK**.
6. Exit Registry Editor, and then restart the computer.

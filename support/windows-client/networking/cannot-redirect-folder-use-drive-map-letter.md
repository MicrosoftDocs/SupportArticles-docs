---
title: Folder Redirection fails to apply when redirected to mapped drive letter, instead of UNC path
description: Fixes an issue in which folder redirection fails to apply when redirected to mapped drive letter instead of UNC path.
ms.date: 04/15/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# Folder Redirection fails to apply when redirected to mapped drive letter, instead of UNC path

This article fixes an issue in which folder redirection fails to apply when redirected to mapped drive letter instead of UNC path.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2859465

## Symptoms

Consider the following scenario:

- Home drive is configured for the users (for example: H:).

- Redirecting the folder to home drive using "Redirect to following location" and specify the drive letter (for example: H:\\Documents) instead of using UNC path.

- The user is an administrator.

In this scenario, folder redirection fails to apply and the following event is logged:

> Log Name:      Application
>
> Source:        Microsoft-Windows-Folder Redirection
>
> Date:          \<DateTime>
>
> Event ID:      502
>
> Task Category: None
>
> Level:         Error
>
> Keywords:
>
> User:          Contoso\\raj
>
> Computer:      `TestPC.Contoso.com`
>
> Description:
>
> Failed to apply policy and redirect folder "Documents" to "H:\\Documents".
>
> Redirection options=0x1001.
>
> The following error occurred: "Cannot create folder "H:\\Documents"".
>
> Error details: "The system cannot find the path specified.

## Cause

When an administrator logs on to Windows, the Local Security Authority (LSA) creates two access tokens. If LSA is notified that the user is a member of the Administrators group, LSA creates the second logon that has the administrator rights removed (filtered). Because LSA created the access tokens during two separate logon sessions, the access tokens contain separate logon IDs. The standard user access token is used to map the drive.

When the policy applies, it uses the highest token (admin token) and thus it fails to see the map drive.

## Resolution

It's always recommended to use UNC path, not the drive map letter while redirecting a folder.

To resolve this issue, redirect the folder using UNC path instead of using map drive letter. You may use "Redirect to user's home directory" option if you want to redirect the folder to home drive.

## Workaround

To work around this issue, use one of the following methods:

- Use "EnableLinkedConnections" registry. This value enables Windows to share network connections between the filtered access token and the full administrator access token for a member of the Administrators group. After you configure this registry value, LSA checks whether there's another access token that is associated with the current user session if a network resource is mapped to an access token. If LSA determines that there's a linked access token, it adds the network share to the linked location.

    To configure the EnableLinkedConnections registry value, follow these steps:

    1. Click **Start**, type *regedit* in the **Start Search** box, and then press Enter.
    2. Locate and then right-click the following registry subkey:      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
    3. Point to **New**, and then click **DWORD Value**.
    4. Type *EnableLinkedConnections*, and then press Enter.
    5. Right-click **EnableLinkedConnections**, and then click **Modify**.
    6. In the **Value data** box, type *1*, and then click **OK**.
    7. Exit Registry Editor, and then restart the computer.

    > [!IMPORTANT]
    > This workaround may make your system unsafe. Microsoft doesn't support this workaround. Use this workaround at your own risk.

- Disable UAC. Disabling UAC will stop splitting the token, but it's not recommended to disable UAC.

    [Disabling User Account Control (UAC) on Windows Server](https://support.microsoft.com/help/2526083)

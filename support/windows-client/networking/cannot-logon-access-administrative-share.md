---
title: Error when you access an administrative share on a Windows Vista-based computer
description: Describes a logon unsuccessful behavior when you try to access an administrative share on a Windows Vista-based computer from another Windows Vista-based computer that's a member of a workgroup.
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
# Error when you try to access an administrative share on a Windows Vista-based computer from another Windows Vista-based computer that's a member of a workgroup: Logon unsuccessful: Windows is unable to log you on

This article describes a logon unsuccessful behavior when you try to access an administrative share on a Windows Vista-based computer from another Windows Vista-based computer that's a member of a workgroup.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 947232

Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

## Error message description

Consider the following scenario:

- You work on a Windows Vista-based computer that's a member of a workgroup.
- From this computer, you try to access an administrative share that's located on another Windows Vista-based computer.
- The computer that you try to access is a member of a workgroup or a member of a domain. For example, you try to access the C$ administrative share.
- When you're prompted for your user credentials, you provide the user credentials of an administrative user account on the destination computer.

In this scenario, you receive the following error message:

> Logon unsuccessful:  
> Windows is unable to log you on.  
> Make sure that your user name and password are correct.

If you try to map a network drive to the administrative share by using the Net Use command, you receive the following error message after you provide the correct credentials:

> System error 5  
> has occurred. Access is denied.

## Cause

By default, Windows Vista and newer versions of Windows prevent local accounts from accessing administrative shares through the network.

## Resolution

To let users have access, we recommend that you create shares on the Windows Vista-based computer by using the appropriate permissions. If, for some reason, you can't apply this resolution, you might want to try the [workaround](#workaround).

To share a folder on a Windows Vista-based computer that has file sharing enabled, follow these steps:

1. Click **Start** > **Computer**.
2. Locate the folder that you want to share.
3. Right-click the folder that you want to share, and then click **Share**.
4. If you have password protected sharing enabled, select which users can access the shared folder and their permission level. To let all users have access, select **Everyone** in the list of users. By default, the permission level is "Reader." Users who have this permission level can't change files or create new files in the share. To let a user change files, change folders, create new files, and create new folders, use the "Co-owner" permission level.

    If you have password protected sharing disabled, select the **Guest** account or the **Everyone** account. This is the same as simple sharing in Windows XP.
5. Click **Share** > **Done**.

## Workaround

To allow administrative share access in a workgroup for Windows, use the following workaround.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, type *regedit* in the **Start Search** box, and then press Enter.
    > [!NOTE]
    > If you're prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
3. On the **Edit** menu, point to **New**, and then click **DWORD (32-bit) Value**.
4. Type LocalAccountTokenFilterPolicy to name the new entry, and then press Enter.
5. Right-click **LocalAccountTokenFilterPolicy**, and then click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.
7. Exit Registry Editor.

The LocalAccountTokenFilterPolicy entry in the registry can have a value of 0 or 1. These values set the behavior of the entry as follows:

- 0 = build a filtered token

This is the default value. The administrator credentials are removed. These credentials are required for remote administration of the print drivers.

- 1 = build an elevated token

This value enables the remote administration of the print drivers on a server within a workgroup.

## Did this fix the problem?

Check whether the problem is fixed. If it's fixed, you're finished with this article. If it isn't fixed, you can contact support.

## Status

This behavior is by design.

## More information

When the destination Windows Vista-based computer and the computer from which you want to access the administrative share are on the same domain, you can access the share by using domain administrator credentials.

You can't access this administrative share if the destination Windows Vista-based computer is joined to a domain and you try to connect to it by using a computer that is joined to a workgroup. This is true even if you supply correct domain administrator credentials for the domain where the destination computer is located.

For more information about how to share folders or printers in Windows Vista, visit the following Microsoft Web site:

[File and Printer Sharing in Windows Vista](https://technet.microsoft.com/library/bb727037.aspx)

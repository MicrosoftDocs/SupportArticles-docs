---
title: Saving and restoring existing Windows shares
description: Provides some information about saving and restoring existing Windows shares.
ms.date: 12/31/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, peterlo
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Saving and restoring existing Windows shares

This article provides some information about saving and restoring existing Windows shares.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 125996

## Summary

If you need to complete any of the following procedures, you can save the share names that exist on the original Microsoft Windows installation, including any permissions assigned to those shares:

- Reinstall Windows over an existing installation (a clean install, not an upgrade).
- Move all of your data drives from one server to another.
- Install Windows to another folder or drive on a computer that already has Windows installed.

## More information

For information on how administrators can migrate data safely and reliably from one file server to another file server, visit the following Microsoft Web site:  
[Microsoft File Server Migration Toolkit](https://www.microsoft.com/windowsserver2008/en/us/fsmt.aspx).

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows.  

To save only the existing share names and their permissions on Windows follow these steps.

> [!NOTE]
> This procedure applies only to NetBIOS shares and not to Macintosh volumes.

1. On the existing Windows installation that contains the share names and permissions that you want to save, start **Registry Editor** (Regedt32.exe).
2. From the HKEY_LOCAL_MACHINE subtree, go to the following key:  
`SYSTEM\CurrentControlSet\Services\LanmanServer\Shares`.
3. Save or export the registry key.
   - For Windows NT and Windows 2000, click **Save Key** on the Registry menu.
   - For Windows Server 2003, click **Export** on the **File** menu.
4. Type a new file name (a file extension is not necessary), and then save the file to a floppy disk.
5. Reinstall Windows.
6. Run **Registry Editor** (Regedt32.exe).
7. From the HKEY_LOCAL_MACHINE subtree, go to the following key:  
`SYSTEM\CurrentControlSet\Services\LanmanServer\Shares`.
8. Restore or import the registry key.
   - For Windows NT and Windows 2000, click **Restore** on the Registry menu.
   - For Windows Server 2003, click **Import** on the **File** menu.
9. Type the path and file name of the file that you saved in steps 3 and 4.

    > [!CAUTION]
    > This step overrides the shares that already exist on the Windows computer with the share names and permissions that exist in the file you are restoring. You are warned about this before you restore the key.

10. Restart the server.

> [!NOTE]
> After you complete this procedure, if you decide that you should not have restored the Shares key, restart the computer and press the SPACEBAR to use the last known good configuration. After you restore the shares key, the shares can be used by network clients. If you run the net shares command on the server, the server displays the shares; however, File Manager does not display the shares. To make File Manager aware of the newly restored shares, create any new share on the server. File Manager displays all of the other shares after you restart the server or stop and restart the Server service.

In Windows NT 3.5, if you click Stop Sharing in File Manager, the restored shares are still displayed, but they are dimmed.

Only permissions for domain users are restored. If a local user was created in the previous Windows NT installation, that local user's unique security identifier (SID) is lost. NTFS permissions on folders and files are not affected when you save and restore the shares key.

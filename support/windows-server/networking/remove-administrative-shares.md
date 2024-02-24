---
title: Remove administrative shares
description: Describes how to remove administrative shares in Windows Server, and how to prevent Windows Server from automatically creating administrative shares.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# How to remove administrative shares in Windows Server

This article describes how to remove default administrative shares, and how to prevent these shares from being automatically created in Windows Server.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 954422

## Introduction

By default, Windows Server automatically creates special hidden administrative shares that administrators, programs, and services can use to manage the computer environment or network. These special shared resources aren't visible in Windows Explorer or in My Computer. However, you can view them by using the Shared Folders tool in Computer Management. Depending on the configuration of your computer, some or all of the following special shared resources may be listed in the Shares folder in Shared Folders:

- **DriveLetter**$: It's a shared root partition or volume. Shared root partitions and volumes are displayed as the drive letter name appended with the dollar sign ($). For example, when drive letters C and D are shared, they're displayed as C$ and D$.

- ADMIN$: It's a resource that is used during remote administration of a computer.

- IPC$: It's a resource that shares the named pipes that you must have for communication between programs. This resource cannot be deleted.

- NETLOGON: It's a resource that is used on domain controllers.

- SYSVOL: It's a resource that is used on domain controllers.

- PRINT$: It's a resource that is used during the remote administration of printers.

- FAX$: It's a shared folder on a server that is used by fax clients during fax transmission.

> [!NOTE]
> NETLOGON and SYSVOL aren't hidden shares. Instead, they are special administrative shares.

Generally, we recommend that you don't modify these special shared resources. However, if you want to remove the special shared resources and prevent them from being created automatically, you can do it by editing the registry.

## Remove administrative shares by editing the registry

To have us do this for you, go to the [Fix it for me](#fix-it-for-me) section. If you would rather fix this problem yourself, go to the [Let me fix it myself](#let-me-fix-it-myself) section.

### Fix it for me

To fix this problem automatically, select the Fix this problem link. Then, select **Run** in the **File Download** dialog box, and follow the steps in this wizard.

Notes

- This wizard may be in English only; however, the automatic fix also works for other language versions of Windows.
- If you aren't on the computer that has the problem, you can save the automatic fix to a flash drive or to a CD, and then you can run it on the computer that has the problem. Now go to the [Did this fix the problem?](#did-this-fix-the-problem) section.

### Let me fix it myself

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To remove administrative shares and prevent them from being automatically created in Windows, follow these steps:

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type regedit, and then select **OK**.
3. Locate, and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\AutoShareServer`  

    > [!NOTE]
    > The registry subkey AutoShareServer must be set as type REG_DWORD. When this value is set to 0 (zero), Windows does not automatically create administrative shares. Be aware that this does not apply to the IPC$ share or shares that you create manually.
4. On the **Edit** menu, select **Modify**. In the **Value data** box, type 0, and then select **OK**.
5. Exit Registry Editor.
6. Stop and then start the Server service. To do it, follow these steps:

    1. Select **Start**, and then select **Run**.
    2. In the **Open** box, type cmd, and then select **OK**.
    3. At the command prompt, type the following lines. Press **Enter** after each line:  
        net stop server  
        net start server
    4. Type exit to close the Command Prompt window.

Now go to the [Did this fix the problem](#did-this-fix-the-problem) section.

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you're finished with this article. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus/).

## References

For more information about how to manage shared resources by using Shared Folders in Windows Server, see the Shared Folders Help files. To do it, select **Start**, point to **Administrative Tools**, and then select **Computer Management**. In the console tree, right-click **Shared Folders**, and then select **Help**.

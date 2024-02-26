---
title: Can access offline files even though the file server is removed from the network
description: Describes a problem in which you can still access offline files on a Windows Vista-based or Windows 7-based client computer even though the file server is removed from the network. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: markusr, cochen, kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# You can still access offline files even though the file server is removed from the network on a Windows 7-based client computer

This article describes an issue where you can still access offline files even though the file server is removed from the network.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 942974

## Symptoms

On a Windows Vista-based or Windows 7-based client computer, you can still access offline files even though the file server is removed from the network. Additionally, you can delete the offline files and the temporary files in the **Offline Files** item in Control Panel.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this problem, reinitialize the cache of offline files. To do this, follow these steps:

1. Click **Start**, type *regedit* in the **Start Search** box, and then press Enter.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type the password or click **Continue**.
2. Locate the following registry subkey, and then right-click it:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\CSC`
3. Point to **New**, and then click **Key**.
4. Type *Parameters* in the box.
5. Right-click **Parameters**, point to **New**, and then click **DWORD (32-bit) Value**.
6. Type *FormatDatabase*, and then press Enter.
7. Right-click **FormatDatabase**, and then click **Modify**.
8. In the **Value data** box, type *1*, and then click **OK**.
9. Exit Registry Editor, and then restart the computer.

> [!NOTE]
> Make sure that files are synchronized before you add this registry entry. Otherwise, unsynchronized changes will be lost.

You can also automate the process of setting this registry value by using the Reg.exe command line tool. To do this, run the following command from an administrative command prompt:

```console
REG ADD "HKLM\System\CurrentControlSet\Services\CSC\Parameters" /v FormatDatabase /t REG_DWORD /d 1 /f
```  

> [!NOTE]
>
> - Make sure that files are synchronized before you add this registry entry. Otherwise, unsynchronized changes will be lost.
> - The actual value of the new registry key is ignored.
> - This registry change requires a restart. When the computer is restarting, the shell will re-initialize the CSC cache, and then delete the registry key if the registry entry exists.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

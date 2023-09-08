---
title: Reserve a range of ephemeral ports
description: Describes how to reserve a range of ephemeral ports on a computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# Reserve a range of ephemeral ports on a computer that is running Windows Server 2003 or Windows 2000 Server

This article describes how to reserve a range of ephemeral ports on a computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 812873

## Summary

In some situations, you may want to reserve a range of ports so that a program or process that requests a random port will not be assigned a port that is in the reserved range. When you reserve a range of ports, only a program or process that specifically requests a port that is in the reserved range can use the port.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
To reserve a range of ports so that only a program or process that specifically requests a port that is in the reserved range can use the port, follow these steps.

### Windows Server 2003 or Windows XP Professional

1. Start Registry Editor (Regedit.exe).
2. Locate and then click the following registry subkey:   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`  

3. On the **Edit** menu, point to **New**, and then click **Multi-string Value**.
4. Right-click the new value, click **Rename**, type ReservedPorts, and then press ENTER.
5. Double-click the ReservedPorts value, type the range of ports that you want to reserve, and then click **OK**.

    > [!NOTE]
    > You must type the range of ports in the following format: **xxxx-yyyy**  
    To specify a single port, use the same value for **x** and **y**. For example, to specify port 4000, type 4000-4000 .

    > [!WARNING]
    > If you specify the continuous ports separately and if one port is reserved and not used, the next port is not correctly reserved, and it is used.  

6. Click **OK**.
7. Quit Registry Editor.

### Windows 2000

1. Start Registry Editor (Regedt32.exe).
2. Locate and then click the following registry key:   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`  

3. On the **Edit** menu, click **Add Value**.
4. In the **Value Name** box, type ReservedPorts.
5. In the **Data Type** list, click **REG_MULTI_SZ**, and then click **OK**.
6. In the **Multi-String Editor** dialog box, type the range of ports that you want to reserve.

    > [!NOTE]
    > You must type the range of ports in the following format: **xxxx-yyyy**. To specify a single port, use the same value for **x** and **y**. For example, to specify port 4000, type 4000-4000.

    > [!WARNING]
    > If you specify the continuous ports separately and if one port is reserved and not used, the next port is not correctly reserved, and it is used.
7. Click **OK**.
8. Quit Registry Editor.

> [!NOTE]
> You must restart the computer after you make these changes for the changes to take effect.

Windows Vista and later operating systems  

> [!Note]
> the registry setting ReservedPorts are not implemented in Windows Vista, Windows 2008 and later operating systems.

For more information about adjusting the dynamic port range by using the netsh  command, click the following article number to view the article in the Microsoft Knowledge Base:
929851 The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008  
[The default dynamic port range for TCP/IP has changed since Windows Vista and in Windows Server 2008](https://support.microsoft.com/help/929851)

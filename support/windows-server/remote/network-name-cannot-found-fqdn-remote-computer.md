---
title: System error 67 has occurred when you use FQDN to connect to a remote computer
description: Describes an issue where you may receive an error message when you try to connect to a remote computer by using an FQDN.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: markusr, kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Error when you use the fully qualified domain name to connect to a remote computer from a Windows Server based computer: The network name cannot be found

This article describes an issue where you receive an error message when you try to connect to a remote computer by using an FQDN.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 875441

## Symptoms

When you use the `net use` command on a computer that is running one of the operating systems that is listed in the "Applies to" section to access the shared resources of a remote computer, you may receive the following error message if you use the fully qualified domain name (FQDN) of the remote computer:

> System error 67 has occurred
>
> The network name cannot be found

When you use the **Open** box of the **Run** dialog box to connect to the remote computer, you may receive the following error message if you use the FQDN of the remote computer:

> No network provider accepted the given network path

> [!NOTE]
> You may be able to ping the remote computer by using the FQDN of the remote computer. No entries may be recorded in the Domain Name System (DNS) cache or in the NetBIOS over TCP/IP (NetBT) cache when you try to connect to the remote computer.

## Cause

When the name resolution request for FQDN is queued inside NetBT, the request times out, the redirector closes the connection after about eight seconds, and the FQDN name isn't resolved. The issue occurs because of contention for the NetBT user mode DNS resolver. This resolver can only resolve names serially.

## Workaround 1: Increase the value of the LmhostsTimeout registry entry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

You can increase the value of the `LmhostsTimeout` registry entry to increase the timeout interval of NetBT queries to the Lmhosts file and to DNS. You can use this method to give more time for NetBT queries to resolve the FQDN of the remote computer.

To modify the value of the `LmhostsTimeout` registry entry, follow these steps:

1. Click **Start** > **Run**, type *regedit*, and then click **OK**.
2. In the left pane, locate and then click the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters`
3. In the right pane, double-click **LmhostsTimeout**, type a value that is larger than the current value in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > If you don't find the LmhostsTimeout registry entry in Registry Editor, create a new registry entry. To do this, follow these steps:
    >
    > 1. In the left pane, right-click the **Parameters** subkey, point to **New**, and then click **DWORD Value**.
    > 2. Type LmhostsTimeout and then press ENTER.
    > 3. Double-click **LmhostsTimeout**, click **Decimal**, and then type a time in milliseconds between 1000 and 4294967295 in the **Value data** box. Click **OK**.
    >
    > The valid hexadecimal base range for the LmhostsTimeout entry is 3E8 to 0xFFFFFFFF.
4. Quit Registry Editor.
5. Restart your computer.

## Workaround 2: Install Internet Protocol version 6 (IPv6) on the local computer

> [!NOTE]
> You can use this method only if the following conditions are true:
>
> - The local computer is running Microsoft Windows Server 2003 or Microsoft Windows XP.
> - The remote computer that you connect to is running Windows Server 2003, Windows XP or Microsoft Windows 2000.

1. Click **Start** > **Run**, type *ncpa.cpl*, and then click **OK**.
2. Right-click the local area connection that you want to modify, and then click **Properties**.
3. Click **Install**.
4. In the **Click the type of network component you want to install** list, click **Protocol** > **Add**.
5. Click **Microsoft TCP/IP version 6** > **OK**.
6. Click **Close** to save the changes that you made to your network connection.

## More information

For more information about how to configure IPv6 in Windows Server 2003, click the following article number to view the article in the Microsoft Knowledge Base:

[325449](https://support.microsoft.com/help/325449) How to install and configure IP version 6 in Windows Server 2003 Enterprise Server  

### LmhostsTimeout registry entry details

Entry name: LmhostsTimeout

Subkey: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters  
 Value type: REG_DWORD (Time in milliseconds)  
 Valid range: Decimal: 1000 to 4294967295 (Hexadecimal: 3E8-0xFFFFFFFF)  
 Default: 6000 (6 seconds)  
 Description: This parameter specifies the time-out value for NetBT queries to the Lmhosts file and to DNS. The timer has a granularity of the time-out value. Therefore, the actual time-out could be as much as two times the value.

### Technical support for x64-based versions of Windows

If your hardware came with a Windows x64 edition already installed, your hardware manufacturer provides technical support and assistance for the Windows x64 edition. In this case, your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation by using unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with a Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware. If you purchased a Windows x64 edition such as a Windows Server 2003 x64 edition separately, contact Microsoft for technical support.

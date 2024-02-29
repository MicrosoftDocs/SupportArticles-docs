---
title: Error 633 the modem is already in use
description: Describes an issue where you may not be able to establish a VPN connection because of a TCP port conflict. Workarounds are provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, santoshc
ms.custom: sap:remote-access, csstroubleshoot
---
# "Error 633 - the modem (or other connecting device) is already in use" error message when you try to establish a VPN connection

This article provides a workaround for the issue where you may not be able to establish a VPN connection because of a TCP port conflict.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 885959

>[!IMPORTANT]
>This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Symptoms

When you try to use a virtual private network (VPN) connection on a Microsoft Windows Server 2003-based computer, you may receive the following error message:  
>Error 633 - the modem (or other connecting device) is already in use or is not configured properly.

## Cause

This issue may occur if the TCP port that is used by the VPN connection is already being used by another program. The VPN connection uses TCP port 1723 to establish a connection. If another program is already using this port, you cannot establish a VPN connection.

## Workaround

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

To work around this issue, use one of the following methods:  

- Explicitly reserve the TCP port that is used for the VPN connection. To do it, follow these steps:
  1. Click **Start**, click **Run**, type regedit.exe in the **Open** box, and then click **OK**.
  2. In Registry Editor, locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`
  3. On the **Edit** menu, point to **New**, and then click **Multi-String Value**.
  4. Rename the multi-string value as "ReservedPorts," and then double-click **ReservedPorts**.
  5. In the **Value data** box, type 1723-1723, and then click **OK**.
  6. Quit Registry Editor.
- Use the netstat command to find the program that uses port 1723. Then, end the process for that program. To do it, follow these steps:
  1. Click **Start**, click **Run**, type cmd.exe in the **Open** box, and then click **OK**.
  2. At the command prompt, type the following command, and then press ENTER:  
    `netstat -aon`  

  3. In the output that is displayed, identify the process ID for the program, if any, that uses TCP port 1723.
  4. At the command prompt, type the following command, and then press ENTER:  
      `taskkill /PID PID /F`  
      > [!NOTE]
      > The taskkill command ends the process that corresponds to the process ID number. The `/F` option is used to forcefully end the process.
  5. At the command prompt, type exit, and then press ENTER to quit the command prompt.  
- Restart your computer. It may cause the program that uses TCP port 1723 to use a different port.

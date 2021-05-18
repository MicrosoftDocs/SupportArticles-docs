---
title: Description of the Portqry.exe command-line utility
description: This article introduces the Portqry.exe command-line utility.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, timr, masoudh
ms.prod-support-area-path: TCP/IP communications
ms.technology: networking
---
# Description of the Portqry.exe command-line utility

Portqry.exe is a command-line utility that you can use to help troubleshoot TCP/IP connectivity issues. The utility reports the port status of TCP and UDP ports on a computer that you select.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 310099

> [!NOTE]
> Version 2 of Portqry.exe is now available. The Microsoft Download Center link at the end of this article has been updated to reflect the new version. Version 1.0 of Portqry.exe has been removed from the Microsoft Download Center.

## More information

Portqry.exe reports the status of a TCP/IP port in one of the following three ways:

- Listening

  A process is listening on the port on the computer that you selected. Portqry.exe received a response from the port.

- Not Listening

  No process is listening on the target port on the target system. Portqry.exe received an Internet Control Message Protocol (ICMP) **Destination Unreachable - Port Unreachable** message back from the target UDP port. Or if the target port is a TCP port, Portqry received a TCP acknowledgment packet with the *Reset* flag set.

- Filtered

  The port on the computer that you selected is being filtered. Portqry.exe didn't receive a response from the port. A process may or may not be listening on the port. By default, TCP ports are queried three times, and UDP ports are queried one time before a report indicates that the port is filtered.

Portqry.exe can query a single port, an ordered list of ports, or a sequential range of ports.

## Examples

The following command tries to resolve `reskit.com` to an IP address and then queries TCP port 25 on the corresponding host:

```console
portqry -n reskit.com -p tcp -e 25
```

The following command tries to resolve 169.254.0.11 to a host name. It then queries TCP ports 143,110, and 25 (in that order) on the host that you selected. This command also creates a log file (Portqry.log) that contains a log of the command that you ran and its output.

```console
portqry -n 169.254.0.11 -p tcp -o 143,110,25 -l portqry.log
```

The following command tries to resolve `my_server` to an IP address and then queries the specified range of UDP ports (135-139) in sequential order on the corresponding host. This command also creates a log file (`my_server.txt`) that contains a log of the command that you ran and its output.

```console
portqry -n my_server -p udp -r 135:139 -l my_server.txt
```

Portqry.exe is available for download from the Microsoft Download Center. To download Portqry.exe, see [PortQry Command Line Port Scanner Version 2.0](https://www.microsoft.com/download/details.aspx?id=17148).

> [!IMPORTANT]
> The PortQueryUI tool provides a graphical user interface and is available for download. PortQueryUI has several features that can make using PortQry easier. You can download the PortQueryUI tool from [https://download.microsoft.com/download/3/f/4/3f4c6a54-65f0-4164-bdec-a3411ba24d3a/PortQryUI.exe](https://download.microsoft.com/download/3/f/4/3f4c6a54-65f0-4164-bdec-a3411ba24d3a/portqryui.exe).

For more information about PortQry version 2.0, see [New features and functionality in PortQry version 2.0](https://support.microsoft.com/help/832919).

For more information about Port requirements for the Microsoft Windows Server System, see:  
[Service overview and network port requirements for Windows](https://support.microsoft.com/help/832017).

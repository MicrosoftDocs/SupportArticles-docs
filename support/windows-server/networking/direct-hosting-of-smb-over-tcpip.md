---
title: Direct host SMB over TCP/IP
description: Describes the direct hosting of Server Message Block (SMB) over TCP/IP.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: TCP/IP communications
ms.technology: networking
---
# Direct host SMB over TCP/IP

This article describes how to direct host Server Message Block (SMB) over TCP/IP.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 204279

## Summary

Windows supports file and printer sharing traffic by using the SMB protocol directly hosted on TCP. This differs from earlier operating systems, in which SMB traffic requires the NetBIOS over TCP (NBT) protocol to work on a TCP/IP transport. Removing the NetBIOS transport has several advantages, including:

- Simplifying the transport of SMB traffic.
- Removing WINS and NetBIOS broadcast as a means of name resolution.
- Standardizing name resolution on DNS for file and printer sharing.

If both the direct hosted and NBT interfaces are enabled, both methods are tried at the same time and the first to respond is used. This allows Windows to function properly with operating systems that don't support direct hosting of SMB traffic.

## More information

NetBIOS over TCP traditionally uses the following ports:

- nbname: 137/UDP
- nbname: 137/TCP
- nbdatagram: 138/UDP
- nbsession: 139/TCP

Direct hosted *NetBIOS-less* SMB traffic uses port 445 (TCP and UDP). In this situation, a four-byte header precedes the SMB traffic. The first byte of this header is always 0x00, and the next 3 bytes are the length of the remaining data.

Use the following steps to disable NetBIOS over TCP/IP; this procedure forces all SMB traffic to be direct hosted. Take care in implementing this setting because it causes the Windows-based computer to be unable to communicate with earlier operating systems using SMB traffic:

1. Select **Start**, point to **Settings**, and then click **Network and Dial-up Connection**.
2. Right-click **Local Area Connection**, and then click **Properties**.
3. Click **Internet Protocol (TCP/IP)**, and then click **Properties**.
4. Click **Advanced**.
5. Click the **WINS** tab, and then click **Disable NetBIOS over TCP/IP**.

You can also disable NetBIOS over TCP/IP by using a DHCP server with Microsoft vendor-specific option code 1 (Disable NetBIOS over TCP/IP). Setting this option to a value of 2 disables NBT. For more information about using this method, see the DHCP Server Help file in Windows.

To determine if NetBIOS over TCP/IP is enabled on a Windows-based computer, issue a `net config redirector` or `net config server` command at a command prompt. The output shows bindings for the NetbiosSmb device (which is the NetBIOS-less transport) and for the NetBT_Tcpip device (which is the NetBIOS over TCP transport). For example, the following sample output shows both the direct hosted and the NBT transport bound to the adapter:

```console
Workstation active on
NetbiosSmb (000000000000)
NetBT_Tcpip_{610E2A3A-16C7-4E66-A11D-A483A5468C10} (02004C4F4F50)
NetBT_Tcpip_{CAF8956D-99FB-46E3-B04B-D4BB1AE93982} (009027CED4C2)
```

NetBT_Tcpip is bound to each adapter individually; an instance of NetBT_Tcpip is shown for each network adapter that it's bound to. NetbiosSmb is a global device, and isn't bound on a per-adapter basis. This means that direct-hosted SMB's can't be disabled in Windows without disabling File and Printer Sharing for Microsoft Networks completely.

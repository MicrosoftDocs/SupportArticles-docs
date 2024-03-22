---
title: Direct host Server Message Block (SMB) over TCP/IP
description: Describes the direct hosting of SMB over TCP/IP.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Direct host SMB over TCP/IP

This article describes how to direct host Server Message Block (SMB) over TCP/IP.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 204279

## Summary

Windows supports file and printer-sharing traffic by using the SMB protocol directly hosted on TCP. SMB 1.0 and older CIFS traffic supported the NetBIOS over TCP (NBT) protocol supported the UDP transport, but starting in Windows Vista and Windows Server 2008 with SMB 2.0.2, requires TCP/IP over port 445. Removing the NetBIOS transport has several advantages, including:

- Simplifying the transport of SMB traffic.
- Removing WINS and NetBIOS broadcast as a means of name resolution.
- Standardizing name resolution on DNS for file and printer sharing.
- Removing the less secure NetBIOS protocol as a method of attack

If both the direct hosted and NBT interfaces are enabled, both methods are tried at the same time and the first to respond is used. This mechanism enables Windows to function properly with operating systems that don't support direct hosting of SMB traffic.

## More information

NetBIOS over TCP traditionally uses the following ports:

- NBName: 137/UDP
- NBName: 137/TCP
- NBDatagram: 138/UDP
- NBSession: 139/TCP

Direct hosted *NetBIOS-less* SMB traffic uses port 445 (TCP). In this situation, a four-byte header precedes the SMB traffic. The first byte of this header is always 0x00, and the next 3 bytes are the length of the remaining data.

Use the following steps to disable NetBIOS over TCP/IP. This procedure forces all SMB traffic to be direct hosted SMB traffic. Take care in implementing this setting because it causes the Windows-based computer to be unable to communicate with earlier operating systems using SMB traffic:

1. Select **Start**, point to **Settings**, and then select **Network and Dial-up Connection**.
2. Right-click **Local Area Connection**, and then select **Properties**.
3. Select **Internet Protocol (TCP/IP)**, and then select **Properties**.
4. Select **Advanced**.
5. Select the **WINS** tab, and then select **Disable NetBIOS over TCP/IP**.

You can also disable NetBIOS over TCP/IP by using a DHCP server that has Microsoft vendor-specific option configured to code 1, **Disable NetBIOS over TCP/IP**. Setting this option to a value of 2 disables NBT. For more information about using this method, see the DHCP Server Help file in Windows.

To determine if NetBIOS over TCP/IP is enabled on a Windows-based computer, run a `net config redirector` or `net config server` command at a command prompt. The output shows bindings for the NetbiosSmb device (which is the NetBIOS-less transport) and for the NetBT_Tcpip device (which is the NetBIOS over TCP transport). For example, the following sample output shows both the direct hosted and the NBT transport bound to the adapter:

```console
Workstation active on
NetbiosSmb (000000000000)
NetBT_Tcpip_{610E2A3A-16C7-4E66-A11D-A483A5468C10} (02004C4F4F50)
NetBT_Tcpip_{CAF8956D-99FB-46E3-B04B-D4BB1AE93982} (009027CED4C2)
```

NetBT_Tcpip is bound to each adapter individually. An instance of NetBT_Tcpip is shown for each network adapter that it's bound to. NetbiosSmb is a global device, and isn't bound on a per-adapter basis. So, direct hosted SMB can't be disabled in Windows unless you disable File and Printer Sharing for Microsoft Networks completely.

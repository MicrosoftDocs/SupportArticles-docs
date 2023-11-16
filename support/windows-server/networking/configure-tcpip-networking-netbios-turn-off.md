---
title: Configure TCP/IP networking while NetBIOS is turned off on a server running Windows Server 2003
description: Describes how to configure a computer running Windows Server 2003 with TCP/IP networking while NetBIOS is turned off.
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
# How to configure TCP/IP networking while NetBIOS is turned off on a server running Windows Server 2003

This step-by-step article describes how to configure a computer running Windows Server 2003 with TCP/IP networking while NetBIOS is turned off.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323357

## Summary

On a computer running Windows Server 2003, you can turn off NetBIOS over TCP/IP (NetBT) for selected clients on an "as needed" basis. If you prefer to only use DNS to provide name registration and resolution on a specified computer that is used in a specialized or secured role for your network, you can turn off NetBT services for one or all of the network adapters that are installed on that computer.

### Configuration

To turn off WINS/NetBT name resolution, follow these steps:

1. Click **Start**, point to **Settings**, and then click **Network Connections**.
2. Right-click the local area connection that you want to be statically configured, and then click **Properties**.
3. Click **Internet Protocol (TCP/IP)** > **Properties** > **Advanced**, and then click the **WINS** tab.
4. Click **Disable NetBIOS over TCP/IP**.
    > [!NOTE]
    > Before you turn off WINS/NetBT name resolution, verify that you don't need to use WINS or earlier NetBT-type applications for this network connection. For example, you can turn off WINS/NetBT name resolution if you communicate only with other that run a product in Windows Server 2003 (Microsoft Windows XP, or Microsoft Windows 2000) that use DNS and that register their names with DNS, or if you communicate with Internet computers using DNS-aware applications. Do not turn off WINS/NetBT name resolution if you communicate with computers that run a version of Windows that may use WINS or earlier NetBT-type applications (such as Microsoft Windows NT, Microsoft Windows Millennium Edition, Microsoft Windows 98, or Microsoft Windows 95).
5. Click **OK** > **OK** >**OK**.
    > [!NOTE]
    > Optionally, you can select the **Use NetBIOS** setting from the Dynamic Host Configuration Protocol (DHCP) server if you use a DHCP server that can selectively turn on and turn off NetBIOS configurations through DHCP option types. When you use DHCP option types that are supported by the Windows Server 2003 DHCP Server service, you can turn off NetBIOS over TCP/IP for computers that run Windows Server 2003.

### Troubleshooting

### Computers That Run Windows Server 2003 Operating Systems

- The computer no longer listens for traffic on the NetBIOS datagram service at User Datagram Protocol (UDP) port 138, the NetBIOS name service at UDP port 137, or the NetBIOS session service at Transmission Control Protocol (TCP) port 139.
- If the computer needs to participate in WINS as a client, it must be physically multihomed (that is, it must have other physical network connections active and available for its use) for it to continue to communicate with and use a WINS server.

### Computers That Operate as WINS Clients

- The computer can no longer function as a WINS server to service WINS clients over the connection unless you turn NetBT on again.
- For those adapters to use WINS, you must either manually configure a list of WINS servers on the NetBT connections that are turned on, or you must use a DHCP server to provide a list of WINS servers to these connections.

    > [!NOTE]
    > WINS servers that are configured in TCP/IP properties for the network adapter that is turned off do not apply to other installed network adapters.

### Down-Level Clients, Services, and Programs

- NetBIOS defines a software interface and a naming convention. It doesn't define a protocol. NetBIOS over TCP/IP provides the NetBIOS programming interface over the TCP/IP protocol. It extends the reach of NetBIOS client and server programs to the wide area network (WAN). It also provides interoperability with various other operating systems.
- The Workstation service, Server service, Browser service, Messenger service, and Net Logon service are all direct NetBT clients. They use Transport Driver Interface (TDI) to communicate with NetBT. Microsoft Windows NT, Windows 2000, and Windows Server 2003 also include NetBIOS emulators. The emulator takes standard NetBIOS requests from NetBIOS programs and translates them to equivalent TDI primitives.
- Windows Server 2003 uses NetBIOS over TCP/IP to communicate with earlier versions of Windows NT and other clients, such as Microsoft Windows 95.

    You must do careful testing before you turn off NetBIOS over TCP/IP in any production environment. Programs and services that depend on NetBIOS no longer work after you turn off NetBT services, so it's important that you verify that your clients and programs no longer require NetBIOS support before you turn it off.

    > [!NOTE]
    > Computers that run an operating system earlier than Windows 2000 will not be able to browse, locate, or create file and print share connections to a computer that runs a product in Windows Server 2003 with NetBIOS turned off.

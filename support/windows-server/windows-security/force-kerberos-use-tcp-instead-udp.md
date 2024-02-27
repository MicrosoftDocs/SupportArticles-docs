---
title: How to force Kerberos to use TCP instead of UDP in Windows
description: Describes how to force Kerberos to use TCP instead of UDP in Windows Server 2003, in Windows XP, and in Windows 2000.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# How to force Kerberos to use TCP instead of UDP in Windows

This article describes how to force Kerberos to use TCP instead of UDP.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 244474

## Summary

The Windows Kerberos authentication package is the default authentication package in Windows Server 2003, in Windows Server 2008, and in Windows Vista. It coexists with the NTLM challenge/response protocol and is used in instances where both a client and a server can negotiate Kerberos. Request for Comments (RFC) 1510 states that the client should send a User Datagram Protocol (UDP) datagram to port 88 at the IP address of the Key Distribution Center (KDC) when a client contacts the KDC. The KDC should respond with a reply datagram to the sending port at the sender's IP address. The RFC also states that UDP must be the first protocol that is tried.

> [!NOTE]
> RFC 4120 now obsoletes RFC 1510. RFC 4120 specifies that a KDC must accept TCP requests and should listen for such requests on port 88 (decimal). By default, Windows Server 2008 and Windows Vista will try TCP first for Kerberos because the MaxPacketSize default is now 0. You can still use the MaxPacketSize registry value to override that behavior.

A limitation on the UDP packet size may cause the following error message at domain logon:

> Event Log Error 5719  
Source NETLOGON  
>
> No Windows NT or Windows 2000 Domain Controller is available for domain **Domain**. The following error occurred:
>
> There are currently no logon servers available to service the logon request.

Additionally, the Netdiag tool may display the following error messages:

- Error message 1

    > DC list test . . . . . . . . . . . : Failed [WARNING] Cannot call DsBind to `COMPUTERNAMEDC.domain.com` (159.140.176.32). [ERROR_DOMAIN_CONTROLLER_NOT_FOUND]

- Error message 2

    > Kerberos test. . . . . . . . . . . : Failed [FATAL] Kerberos does not have a ticket for MEMBERSERVER$.]
The Windows XP event logs which are symptoms of this issue are SPNegotiate 40960 and Kerberos 10.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

If you use UDP for Kerberos, your client computer may stop responding (hang) when you receive the following message:
Loading your personal settings.

By default, the maximum size of datagram packets for which Windows Server 2003 uses UDP is 1,465 bytes. For Windows XP and for Windows 2000, this maximum is 2,000 bytes. Transmission Control Protocol (TCP) is used for any datagrampacket that is larger than this maximum. The maximum size of datagram packets for which UDP is used can be changed by modifying a registry key and value.

By default, Kerberos uses connectionless UDP datagram packets. Depending on a variety of factors including security identifier (SID) history and group membership, some accounts will have larger Kerberos authentication packet sizes. Depending on the virtual private network (VPN) hardware configuration, these larger packets have to be fragmented when going through a VPN. The problem is caused by fragmentation of these large UDP Kerberos packets. Because UDP is a connectionless protocol, fragmented UDP packets will be dropped if they arrive at the destination out of order.

If you change MaxPacketSize to a value of 1, you force the client to use TCP to send Kerberos traffic through the VPN tunnel. Because TCP is connection oriented, it is a more reliable means of transport across the VPN tunnel. Even if the packets are dropped, the server will re-request the missing data packet.

You can change MaxPacketSize to 1 to force the clients to use Kerberos traffic over TCP. To do this, follow these steps:

1. Start Registry Editor.

2. Locate and then click the registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos\Parameters`.

    > [!NOTE]
    > If the Parameters key does not exist, create it now.

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *MaxPacketSize*, and then press ENTER.
5. Double-click **MaxPacketSize**, type *1* in the **Value data** box, click to select the **Decimal** option, and then click **OK**.
6. Quit Registry Editor.
7. Restart your computer.

This is the solution approach for Windows 2000, XP, and Server 2003. Windows Vista and newer use a default of "0" for MaxPacketSize which also turns off the use of UDP for the Kerberos Client.

The following template is an administrative template that can be imported into Group Policy to let the MaxPacketSize value be set for all enterprise computers that are running Windows Server 2003, Windows XP, or Windows 2000. To view the MaxPacketSize settings in Group Policy Object Editor, click **Show Policies Only** on the **View** menu so that **Show Policies Only** is not selected. This template modifies registry keys outside the Policies section. By default, Group Policy Object Editor does not display these registry settings.

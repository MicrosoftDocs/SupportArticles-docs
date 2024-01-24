---
title: Active Directory communication fails
description: Describes an issue in which Active Directory communication, including replication fails intermittently.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: smondal, kaushika
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
ms.subservice: active-directory
---
# Active Directory communication fails on multihomed domain controllers

This article describes an issue in which Active Directory communication, including replication fails intermittently.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 272294

## Symptoms

In a Windows 2000 domain that has multihomed domain controllers, Active Directory communication, including replication, may fail intermittently.

## Cause

This issue can occur if one of the network adapters is attached to an external network (such as the Internet) on the multihomed domain controller, and if Lightweight Directory Access Protocol (LDAP) and Kerberos traffic between the internal and external networks is partially or completely restricted because of a Proxy, ISA Server, NAT Server, or another firewall device.

In this scenario, network adapters on the multihomed domain controllers are registering both the inside and outside Internet Protocol (IP) addresses with the DNS server. DNS name resolution lookup requests return records in a "round robin" fashion, alternating the internal and external IP addresses. Replication operations require multiple lookup requests of SRV records. In this case, half of the DNS lookup requests return an IP address that can't be contacted, and the replication operation fails.

## Resolution

To resolve this issue:

1. Disable registration on the outside network adapter on the multihomed domain controller. To do so:  

      1. Click Start, click Settings, and then click **Network and Dial-Up Connections**.
      2. Right-click the outside local area network (LAN) connection, and then click Properties.
      3. Click TCP/IP, and then click Properties.
      4. Click Advanced, and then click to clear the **Register DNS for this connection** check box.  

2. Disable the round robin functionality on the DNS server. To do so:  

      1. Click Start, click Settings, click Administrative Tools, and then click DNS.
      2. Open the properties for the DNS server's name.
      3. Click the Advanced tab, and then click to clear the **Enable round robin** check box.  

3. Remove the existing entries in DNS. To do so:  

      1. Browse to the following location: Under DNS\\**DNS Servername** \Forward Lookup Zones\\**Domain Name**  
      2. Remove Host (A) record entries that refer to the domain controller's computer name for the outside network adapter IP addresses.
      3. Remove Host (A) record entries for the same name as the parent folder for the network adapter IP addresses.  

4. Start the DNS Management Console, right-click the server name, and then click Properties.
5. Click the Interfaces tab, and then remove the external IP address so that DNS does not listen on it.
6. Open a command prompt, type ipconfig /flushdns, press ENTER, type ipconfig /registerdns, and then press ENTER.
7. Change the binding order of your network adapters so that the Internal adapter is the first bound adapter. To do this, follow these steps:  

      1. Click **Start**, click **Settings**, and then click **Network and Dial-Up Connections**.
      2. On the **Advanced** menu, click **Advanced**.
      3. Verify that the internal network adapter is listed first in the **Connections** box.

## Status

This behavior is by design.  

## More information

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[246804](https://support.microsoft.com/help/246804) How to enable or disable DNS updates in Windows 2000 and in Windows Server 2003

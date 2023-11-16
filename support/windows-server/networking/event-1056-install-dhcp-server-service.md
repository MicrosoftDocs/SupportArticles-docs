---
title: Event ID 1056 after installing DHCP
description: Fixes an issue where event ID 1056 is logged after you install the DHCP Server service on a Windows Server 2003 domain controller that's also running the DNS Server service.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
ms.technology: networking
---
# Event ID 1056 is logged after installing DHCP

This article fixes an issue where event ID 1056 is logged after you install the DHCP Server service on a Windows Server 2003 domain controller.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 282001

## Symptoms

After you install the DHCP Server service on a Windows Server 2003 domain controller that's also running the DNS Server service, the following event may be logged in the System log:

> Event Type: Warning  
Event Source: DhcpServer  
Event ID: 1056  
Description:  
The DHCP service has detected that it's running on a domain controller and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCP service. This isn't a recommended security configuration. Credentials for Dynamic DNS registrations may be configured using the command line "netsh dhcp server set dnscredentials" or via the DHCP Administrative tool.

## Cause

This behavior occurs because you didn't configure the DHCP Credentials on the domain controller on which you installed the DHCP Server service and DNS services. This isn't a recommended configuration; see the [More Information](#more-information) section of this article for more detail.

## Resolution

To resolve this behavior, configure DNSCredentials by using one of the following methods:

### Use the DHCP Server snap-in

1. In the DHCP Server snap-in, which is located in the Administrative Tools folder, right-click the DHCP server that you want to configure, and then click Properties.
2. On the **Advanced** tab, click **Credentials**.
3. Type the username, domain, and password of the account under which you want the DHCP Server service to run. You can use any valid existing user account for this, such as a Domain User account. The account shouldn't be set to expire or have any other restrictions.
4. Click **OK**, and then OK again to exit the **Properties** dialog box.

### Use the Netsh.exe command line

1. From a command prompt, type *netsh*, and then press ENTER.
2. From the netsh prompt, type `dhcp server ipaddress` (where **ipaddress** is the IP address of the DHCP server that you want to configure), and then press ENTER.
3. Type `set dnscredentials username domain password` (where **username domain password** is the user account information for the account under which you want the DHCP Server to run), and then press ENTER. You can use any valid existing user account for this, such as a Domain User account. The account shouldn't be set to expire or have any other restrictions.
4. Type quit, and then press ENTER to exit.

## More information

The DHCP Server service runs under the domain controller's computer account and therefore has full control of all DNS objects. As a result, DNS records that you've dynamically registered with DNS are susceptible to having their name records overwritten by an earlier version of DHCP Client. This behavior may be undesirable, especially if you've configured the DNS zone for Secure Updates only. By using the `DNSCredentials` parameter, you can run the DHCP Server service under a specified user account that doesn't have the ability to overwrite the DNS records.

Microsoft strongly recommends the use of `DNSCredentials` when you are running the DHCP Server service and DNS services on the same domain controller to ensure the integrity of Secure Dynamic Updates. If you do not use `DNSCredentials`, Microsoft recommends that you run the services on different computers.

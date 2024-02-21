---
title: Install and Configure a DHCP Server
description: Describes how to install and configure a DHCP Server in a Workgroup.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Johnf
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# How To Install and Configure a DHCP Server in a Workgroup  

This article describes how to install and configure a Dynamic Host Configuration Protocol (DHCP) Server in a Workgroup.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 323416

## Summary

This step-by-step article describes how to configure a new Windows Server 2003-based Dynamic Host Configuration Protocol (DHCP) server on a stand-alone server, which can provide centralized management of IP addresses and other TCP/IP configuration settings for the client computers on a network.

## How to Install the DHCP Service

Before you configure the DHCP service, you must install it on the server. DHCP is not installed by default during a typical installation of Windows Standard Server 2003 or Windows Enterprise Server 2003. You can install DHCP during the initial installation of Windows Server 2003, or after the initial installation is completed.

### How to Install the DHCP Service on an Existing Server

1. Click Start, point to Control Panel, and then click **Add or Remove Programs**.
2. In the **Add or Remove Programs** dialog box, click Add/Remove Windows Components.
3. In the Windows Components Wizard, click Networking Services in the Components list, and then click Details.
4. In the Networking Services dialog box, click to select the **Dynamic Host Configuration Protocol (DHCP)** check box, and then click OK.
5. In the Windows Components Wizard, click Next to start Setup. Insert the Windows Server 2003 CD-ROM into the computer's CD-ROM or DVD-ROM drive if it is prompted to do so. Setup copies the DHCP server and tool files to your computer.
6. When Setup is completed, click Finish.

## How to Configure the DHCP Service

After you have installed the DHCP service and started it, you must create a scope. The scope is a range of valid IP addresses available for lease to the DHCP client computers on the network. Microsoft recommends that, each DHCP server in your environment has at least one scope that does not overlap with any other DHCP server scope in your environment. In Windows Server 2003, DHCP servers in an Active Directory-based domain must be authorized to prevent *rogue* DHCP servers from coming online. Any Windows Server 2003 DHCP Server that determines itself to be unauthorized will not manage clients.

### How to Create a New Scope

1. Click Start, point to Programs, point to Administrative Tools, and then click DHCP.
2. In the console tree, right-click the DHCP server on which you want to create the new DHCP scope, and then click New Scope.
3. In the New Scope Wizard, click Next, and then type a name and description for the scope. The name can be anyone that you want, but it should be descriptive enough so that you can identify the purpose of the scope on your network (for example, you can use a name such as "Administration Building Client Addresses"). Click Next.
4. Type the range of addresses that can be leased as part of this scope. For example, use a range of IP addresses from a starting IP address of 192.168.100.1 to an ending address of 192.168.100.100. Because these addresses are given to clients, they must all be valid addresses for your network and not currently in use. If you want to use a different subnet mask, type the new subnet mask. Click Next.
5. Type any IP addresses that you want to exclude from the range that you entered. These addresses include any one in the range described in step 4 that may have already been statically assigned to various computers in your organization. Typically, domain controllers, Web servers, DHCP servers, Domain Name System (DNS) servers, and other servers, have statically assigned IP addresses. Click Next.
6. Type the number of days, hours, and minutes before an IP address lease from this scope expires. It determines how long a client can hold a leased address without renewing it. Click Next, and then click **Yes, I want to configure these options now** to extend the wizard to include settings for the most common DHCP options. Click Next.
7. Type the IP address for the default gateway that should be used by clients that obtain an IP address from this scope. Click Add to add the default gateway address in the list, and then click Next.
8. If you are using DNS servers on your network, type your organization's domain name in the **Parent domain** box. Type the name of your DNS server, and then click Resolve to make sure that your DHCP server can contact the DNS server and determine its address. Click Add to include that server in the list of DNS servers that are assigned to the DHCP clients. Click Next, and then follow the same steps. If you are using a Windows Internet Naming Service (WINS) server, by adding its name and IP address, click Next.
9. Click **Yes, I want to activate this scope now** to activate the scope and allow clients to obtain leases from it, and then click Next.
10. Click Finish.
11. In the console tree, click the server name, and then click Authorize on the Action menu.

## Troubleshooting

The following sections explain how to troubleshoot some of the issues that you may experience, when you try to install and configure a Windows Server 2003-based DHCP server in a workgroup.

### Clients Cannot Obtain an IP Address

If a DHCP client does not have a configured IP address, it typically indicates that the client was not able to contact a DHCP server. This issue can be caused by a network problem, or because the DHCP server is unavailable. When the DHCP server started and other clients can obtain valid addresses, verify that the client has a valid network connection and that all the related client hardware devices (including cables and network adapters) are working properly.

### The DHCP Server Is Unavailable

When a DHCP server does not provide leased addresses to clients, it is frequently because the DHCP service did not start. In this case, the server may not be authorized to operate on the network. If you were previously able to start the DHCP service, use Event Viewer to check the System log for any entries. These logs may explain why you cannot start the DHCP service.

To restart the DHCP service:

1. Click Start, and then click Run.
2. Type cmd, and then press ENTER.
3. Type net start `dhcpserver`, and then press ENTER.

-or-

1. Click Start, point to Control Panel, point to Administrative Tools, and then click Computer Management.
2. Expand **Services and Applications**, and then click Services.
3. Locate and then double-click DHCP Server.
4. Verify that Startup is set to Automatic and that Service Status is set to Started. If not, click Start.
5. Click OK, and then close the Computer Management window.

## References

For additional information about DHCP in Windows Server 2003, click the following article number to view the article in the Microsoft Knowledge Base:  
 [169289](https://support.microsoft.com/help/169289) DHCP (Dynamic Host Configuration Protocol) Basics  
 [167014](https://support.microsoft.com/help/167014) DHCP Client May Fail to Obtain a DHCP-Assigned IP Address  
 [133490](https://support.microsoft.com/help/133490) Resolving Duplicate IP Address Conflicts on a DHCP Network  

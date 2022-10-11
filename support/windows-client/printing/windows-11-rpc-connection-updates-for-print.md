---
title: Windows 11 RPC connection updates for print
description: Introduce the Windows 11 RPC connection updates for print and the recommended configrations.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 
ms.prod: windows-client
ms.technology: windows-client-printing
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
---
# RPC connection updates for print in Windows 11

_applies to:_   Windows 11, version 22H2 and later versions of Windows

Windows 11, version 22H2 introduces print components changes that modify how Windows machines communicate with each other during printing or print related operations. 
For example, the changes come into effect when you print to a printer shared out by a print server or another computer on the network. These changes were made to further improve the overall security of printing in Windows.
The default configuration of the RPC connection settings enforces newer and more secure communication methods. Home users and enterprise administrators can also customize the settings for their environment.

## Update details

* For print related communications, by default, RPC over TCP is used for client – server communications.

  * Using RPC over Named Pipes for print related communication between computers is still available but is disabled by default.
  * Using RPC over TCP or RPC over Named Pipes for print related communication can be controlled by Group Policy or through the registry.

* By default, the client or server only listens for incoming connections via RPC over TCP.
  * The Spooler service can be configured to also listen for incoming connections via RPC over Named Pipes. This is not the default configuration.
  * This behavior can be controlled by Group Policy or through the registry.
* When using RPC over TCP, a specific port can be configured to use for communication instead of dynamic ports.
* Environments in which all computer are domain joined and support Kerberos can now enforce Kerberos authentication.

## Recommendations on configuring an environment

The following contains recommendations on how to properly configure the environment to avoid or resolve issues with communication between computers.

### Allow RPC over TCP communication

The most common issue is that firewall rules are preventing communication between the computers. To resolve issues with the firewall, follow these steps:

1. Ensure that the RPC Endpoint Mapper port (135) is not blocked.
2. Open up the high range ephemeral ports (49152 – 65535) on the server or follow the guidance in the [Configuring RPC to use certain ports](#configuring-rpc-to-use-certain-ports) section below to specify a range of ports for RPC.

For more information on the different ports, and their usage by system services, see [Service overview and network port requirements - Windows Server | Microsoft Learn](https://learn.microsoft.com/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements).

### Using RPC over Named Pipes

This configuration is not recommended. However, it can be used if RPC over TCP is not an option in the current environment.

* To enable a Windows 11, version 22H2 computer to use RPC over Named Pipes instead of RPC over TCP for communication, see the [Use RPC over Named Pipes for client - server communication]() section.
* To enable a Windows 11, version 22H2 computer to listen for incoming connections via RPC over Named Pipes and RPC over TCP, see the [Enable listening for incoming connections on RPC over Named Pipes]() section

The following additional configurations might also be needed to properly support RPC over Named Pipes in the environment.

* Set the **RpcAuthnLevelPrivacyEnabled** registry value to **0** on the server/host machine. See [Managing deployment of Printer RPC binding changes for CVE-2021-1678 (KB4599464) (microsoft.com)](https://support.microsoft.com/topic/managing-deployment-of-printer-rpc-binding-changes-for-cve-2021-1678-kb4599464-12a69652-30b9-3d61-d9f7-7201623a8b25)
* Some scenarios also require guest access in SMB2/SMB3, which is disabled by default. To enable it, see [Guest access in SMB2 and SMB3 is disabled - Windows Server | Microsoft Docs](/troubleshoot/windows-server/networking/guest-access-in-smb2-is-disabled-by-default)


## Configuring RPC to use certain ports

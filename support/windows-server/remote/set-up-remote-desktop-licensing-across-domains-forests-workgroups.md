---
title: Set up RD licensing across domains forests or workgroups
description: This article talks about the questions around the supportability (or recommended approach) of setting up Remote Desktop (RD) licensing across domain, forest, or work groups.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, akhleshs, sabinn
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# Best practices for setting up RDS licensing across Active Directory domains/forests or work groups

This article provides information on the questions around the supportability (or recommended approach) of setting up Remote Desktop (RD) licensing across domain, forest, or work groups.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2473823

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services is renamed to Remote Desktop Services (RDS).

## Question

Can the RD licensing server issue a Client Access License (CAL) to users or devices connecting to RD Session Host (Terminal Server) servers under any of the following conditions?

- RD Session Host servers are in an Active Directory Domain and RD licensing server is in a work group environment.
- RD Session Host servers are in a work group and the RD licensing server in an Active Directory Domain.
- RD Session Host servers and RD licensing server are in different forests. No trusts exist (One-way or Two-way trust) between these forests.
- RD Session Host servers and RD licensing servers are in the same work group.

## Answer

For both Per Device and Per User CALs issuance to work, the RD Session Host and RD licensing server in any one of the following three configurations:

- Both in the same work group
- Both in the same domain
- Both in the trusted (Two-way trust) Active Directory Domains or Forest

Here is more information on these scenarios:

- RDS Host and RDS licensing servers are in the same work group

  Consider the following points while configuring RDS and RDS licensing servers in a work group environment:

  - We can use ONLY Per Device CALs in a work group environment. So, you should install only Per Device CALs on RDS licensing server.
  - Per User CAL tracking and reporting is not supported in work group mode.
  - RDS Host and RDS licensing server roles can both be installed on the same server.
  - If you install RDS licensing server on a different server in the work group, ensure that the RDS server is able to access RDS licensing server.

  In Windows 2008 R2, automatic license server discovery is no longer supported for RD Session Host servers. You must specify the name of a license server for the RD Session Host server to use by using Remote Desktop Session Host Configuration snap-in. For more information, see [Specify a License Server for an RD Session Host Server to Use](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770585(v=ws.11)).

- RDS Host and RDS licensing servers are in the same domain

  In an Active Directory Domain scenario, we can have RDS Host and RDS licensing servers either on the same server or different servers. Consider the following points while configuring RDS environment in a domain scenario:

  - You can install both (Per Device and Per User) CALs on RDS licensing server.

  - The computer account for the license server must be a member of the Terminal Server License Servers group in AD DS. If the license server is installed on a domain controller, the Network Service account must also be a member of the Terminal Server License Servers group.

  - To restrict the issuance of RDS CALs, you can add RDS Host Servers into Terminal Server Computers group on RDS licensing server and then enable the License server security group policy setting on RDS licensing server.

  - The License server security group policy setting is located in Computer Configuration\Policies\Administrative Templates\Windows Components\Remote \RD licensing and can be configured by using either the Local Group Policy Editor or the Group Console (GPMC).

- RDS Host Servers are in one domain/forest and RDS licensing server is in another domain/forest

  In this kind of scenario, you should consider the following points:

  - There should be a two-way trust between these domains/forests. It can be either Forest Trust or External Trust.

  - All the required ports should be opened on the firewall. If you have any questions about the ports that need to be opened, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).

  - To issue RDS Per User CALs to users in other domains, there must be a two-way trust between the domains, and the license server must be a member of the Terminal Server License Servers group in those domains.

  - To restrict the issuance of RDS CALs, you can add RDS Host Servers into Terminal Server Computers group on RDS licensing servers.

  - Configure RDS licensing server on all RDS Host Servers in each domain/forest. You can do it through RDS host configuration snap-in or through a group policy.

  - Add administrators group of each domain/forest in the local administrators of RDS licensing server. This way, you'll not get a prompt to enter your credentials when you'll open RDS host configuration snap-ins in trusted domains/forests.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#terminal-server-licensing).

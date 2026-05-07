---
title: Support for Active Directory over NAT
description: Describes the support boundaries for Active Directory over NAT. Additionally, the scenario is not tested by Active Directory.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, khoffman
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Description of support boundaries for Active Directory over NAT

This article describes the support boundaries for Active Directory over NAT.

_Original KB number:_ &nbsp; 978772

## Summary

Network Address Translation (NAT) is a selection of network techniques that alter the address information of network traffic while in transit so as to remove details about the originating network. This is most often done by network devices, and is intended to enable the easy use of private network address schemes, and sometimes as a less than ideal security measure.

Microsoft does not support NAT devices, you need to contact the vendor of the device for support.

Domain Controller (DC)-to-DC communication and Client-to-DC communication over a NAT is a scenario that customers may encounter in merger and acquisition scenarios. One required service when connecting the networks of the two companies is the authentication, authorization and directory services offered by Active Directory (AD). AD is only one of the many services you need to handle in such a situation.

Microsoft hasn't tested this scenario with Active Directory, and other technologies that are related with Active Directory. Examples of other technologies include the Kerberos protocol or DFS.

## Microsoft statement regarding Active Directory over NAT

- Active Directory over NAT has not been tested by Microsoft, and is therefore not supported.
- We do not recommend Active Directory over NAT.

The only configuration with NAT that was tested by Microsoft, and is supported, is running clients on the private side of a NAT and all servers located on the public side of the NAT. In most cases, the NAT would also function as a DNS server.

---
title: Support for Active Directory over NAT
description: Learn about the support boundaries for Active Directory over NAT, including untested scenarios and Microsoft's official recommendations. Read more.
ms.date: 05/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
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

Network Address Translation (NAT) is a selection of network techniques that alter the address information of network traffic while in transit to remove details about the originating network. Network devices most often perform this action. NAT is intended to enable the easy use of private network address schemes, and sometimes as a less than ideal security measure.

Microsoft doesn't support NAT devices. You need to contact the vendor of the device for support.

Domain Controller (DC)-to-DC communication and Client-to-DC communication over a NAT are scenarios that customers might encounter in merger and acquisition scenarios. One required service when connecting the networks of the two companies is the authentication, authorization, and directory services offered by Active Directory (AD). AD is only one of the many services you need to handle in such a situation.

Microsoft didn't test this scenario with Active Directory, and other technologies that are related to Active Directory. Examples of other technologies include the Kerberos protocol or DFS.


## Microsoft statement regarding Active Directory over NAT

- Microsoft didn't test Active Directory over NAT, and therefore doesn't support it.
- Don't use Active Directory over NAT.

If you're tasked with configuring a network with NAT and you plan to run any Microsoft Server solution (including Active Directory) across the NAT, contact Microsoft customer technical support by using your preferred approach. Additionally, you can contact Microsoft Consulting Services.

There's no explicit or implied guarantee that following any provided guidance works in any given scenario because it's untested. The support teams work on issues that arise from using the provided guidance to the limits of commercially reasonable effort.

The only configuration with NAT that Microsoft tested and supports is running client on the private side of a NAT and all servers located on the public side of the NAT. In most cases, the NAT also functions as a DNS server.

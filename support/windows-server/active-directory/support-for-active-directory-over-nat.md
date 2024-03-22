---
title: Support for Active Directory over NAT
description: Describes the support boundaries for Active Directory over NAT. Additionally, the scenario is not tested by Active Directory.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, khoffman
ms.custom: sap:Active Directory\On-premises Active Directory domain join, csstroubleshoot
---
# Description of support boundaries for Active Directory over NAT

This article describes the support boundaries for Active Directory over NAT.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 978772

## Summary

Network Address Translation (NAT) is a selection of network techniques that alter the address information of network traffic while in transit so as to remove details about the originating network. This is most often done by network devices, and is intended to enable the easy use of private network address schemes, and sometimes as a less than ideal security measure.

Domain Controller (DC)-to-DC communication and Client-to-DC communication over a NAT is a scenario that customers frequently encounter in merger and acquisition scenarios. One required service when connecting the networks of the two companies is the authentication, authorization and directory services offered by Active Directory.

There's no evidence to indicate that a NAT cross-forest configuration inherently breaks DC-to-DC communications, or Client-to-DC communications. Microsoft hasn't tested this scenario with Active Directory, and other technologies that are related with Active Directory. Examples of other technologies include the Kerberos protocol or DFS.

## Microsoft statement regarding Active Directory over NAT

- Active Directory over NAT has not been tested by Microsoft.
- We do not recommend Active Directory over NAT.
- Support for issues related to Active Directory over NAT will be limited and will reach the bounds of commercially reasonable efforts quickly.

If you are tasked with configuring a network with NAT and you plan to run any Microsoft Server solution (including Active Directory) across the NAT, please contact Microsoft customer technical support using your preferred approach or visit [Microsoft Support](https://support.microsoft.com/). Additionally, you can contact Microsoft Consulting Sevices.

There is no explicit or implied guarantee that following any provided guidance will work in any given scenario because it is untested. The support teams will work on issues that arise from using the provided guidance to the limits of commercially reasonable effort.

The only configuration with NAT that was tested by Microsoft is running client on the private side of a NAT and have all servers located on the public side of the NAT. The NAT would also function as a DNS server.

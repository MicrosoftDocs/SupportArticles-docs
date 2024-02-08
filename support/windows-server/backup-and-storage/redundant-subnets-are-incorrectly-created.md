---
title: Redundant subnets are incorrectly created
description: Discusses an issue in which redundant subnets are incorrectly created in an iSCSI IPv6 network.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, Roger.Blume, winciccore
ms.custom: sap:iscsi, csstroubleshoot
ms.subservice: backup-and-storage
---
# Redundant subnets are incorrectly created in an iSCSI IPv6 network

This article provides a solution to an issue where redundant subnets are incorrectly created in an iSCSI IPv6 network.

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4536782

## Symptoms

You design an iSCSI IPv6 network that contains servers and storage devices. In this network, some servers use link-local addresses.

In this situation, you encounter an issue in which multiple gateways try to create separate storage subnets to isolate the traffic. However, the subnets are redundant.

## Workaround

To work around this issue, configure the initiator and the target on different subnets.

## References

- [iSCSI Boot Firmware Table (iBFT) as Defined in ACPI 3.0b Specification](https://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/iBFT.docx)  (download file)

- [Storage Services Protocols Overview](/openspecs/windows_protocols/ms-storod/313252b5-9146-40cc-9eb2-8372e108597f)

- [Windows Hardware Compatibility Program specifications and policies for the iSCSI industry and Microsoft](/windows-hardware/design/compatibility/whcp-specifications-policies)

- [IPv6 Link-local and Site-local Addresses](/windows/win32/winsock/link-local-and-site-local-addresses-2)

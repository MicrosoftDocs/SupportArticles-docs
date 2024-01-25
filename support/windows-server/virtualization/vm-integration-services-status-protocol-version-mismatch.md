---
title: VM Integration Services status reports protocol version mismatch on pre-Windows 10, Windows Server 2016, or Windows Server 2019 VM guests
description: Discusses an issue in which VM Integration Services status reports protocol version mismatch on pre-Windows 10, Windows Server 2016, or Windows Server 2019 VM guests.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-jesits, arrenc, ajayps, sarathm
ms.custom: sap:integration-components, csstroubleshoot
ms.subservice: hyper-v
---
# VM Integration Services status reports protocol version mismatch on pre-Windows 10, Windows Server 2016, or Windows Server 2019 VM guests

This article discusses an issue in which VM Integration Services status reports protocol version mismatch on pre-Windows 10, Windows Server 2016, or Windows Server 2019 VM guests.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4014894

## Symptoms

When you enable Integration Services on a pre-Windows 10, Windows Server 2016, or Windows Server 2019 virtual machine, and then you verify the status of the Integration Services service state by using a command such as `Get-vmintegrationservice`, you receive an error message that resembles the following:
> **Get-vmintegrationservice-vmname \<VMName>**  
>
> The protocol version of the component installed in the virtual machine does not match the version expected by the hosting system

## Resolution

This is expected behavior that can be safely ignored.

## More Information

Windows Server 2016, Windows Server 2019, and Windows 10 include an updated Hyper-V Time Sync service and a new VMIC channel handshake or protocol that is intentionally not backported to previous operating system releases.

In the reported issue, the down-level guest is behaving correctly. The secondary status that is reported through WMI or Windows PowerShell includes an error string that sounds alarming but that you can safely ignore.

## Status

This behavior is by design.

---
title: FCoE IO failures on Hyper-V guests
description: FCoE IO failures on Hyper-V guests for Windows Server 2016.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:storage-configuration, csstroubleshoot
ms.subservice: hyper-v
---
# FCoE IO failures on Hyper-V guests for Windows Server 2016

This article provides a solution to an issue where FCoE IO failures on Hyper-V guests for Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4557869

## Symptoms

In a situation when Windows Server 2016 Hyper-V is supporting Windows Server 2019 guest VMs with CNA adapters and MPIO, when paths are disconnected the connection is intermittent. I/O starts to fail when MPIO path failover occurs.
This is a known issue.

## More information

A typical system configuration is similar to those in the Repro Steps that follow.

**Configure a Windows 2016 Hyper-V system with a Windows 2019 guest:**

1. Configure multiple FC LUNs and present them to the Hyper-V system and have the Hyper-V system present these LUNs to the 2019 guest.
2. Use a storage IO generation tool to run IO to all FC LUNs on the 2019 guest.
3. Disable one CNA port.
4. Wait 30 seconds.
5. Enable the CNA port.
6. Wait 2 minutes.
7. Repeat the port disables/enables above, test failures will be intermittent.

An IRP field being zeroed out at a lower level is being accessed while resubmitting at the MPIO level, causing the failures.

The issue has been addressed with Windows Server 2019 in the Windows Server 2019 July Rollup.

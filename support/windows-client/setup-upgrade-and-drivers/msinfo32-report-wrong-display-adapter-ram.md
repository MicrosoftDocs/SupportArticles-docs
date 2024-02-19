---
title: Msinfo32.exe reports wrong values for Adapter RAM
description: Discusses an issue where Microsoft System Information (Msinfo32.exe) tool reports incorrect Adapter RAM values under Components > Display.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Msinfo32.exe reports an unexpected value for the Display Adapter RAM when the graphics adapter has 2 GB or more of dedicated video memory

This article discusses an issue where Microsoft System Information (Msinfo32.exe) tool reports incorrect Adapter RAM values under **Components** > **Display**.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2495801

## Symptoms

Consider the following scenario:

1. You have a graphics adapter that has 2 GB or more of dedicated (on board) video memory.
2. You run the inbox Windows tool MSInfo32.exe and look at the Adapter RAM value under **Components** > **Display**.

In this scenario, the dedicated video memory on the graphics adapter is reported incorrectly under Adapter RAM. Instead of the expected value showing the memory in gigabytes and bytes, you may instead only see an incorrect value in bytes.

## Cause

The value that holds the dedicated video memory size and that MSInfo32.exe uses to populate Adapter RAM is stored in the registry as a signed 32-bit integer. As a result, the value is only capable of storing a positive integer that is under 2 GB in size. If the dedicated video memory on the graphics adapter is 2 GB or greater, MSInfo32.exe will incorrectly report the amount and will also display it as a negative number.

## Resolution

Microsoft has confirmed that this is a problem.

## More information

The following are some examples of what MSInfo32.exe will report for Adapter RAM under the Display component when the graphics adapter has between 1GB and 3GB of dedicated memory.

Dedicated Video Memory Reported by MSInfo32:

- 1GB 1.00 GB (1,073,741,824 bytes)
- 1.5GB 1.50 GB (1,610,612,736 bytes)
- 2GB (2,147,483,648) bytes
- 2.5GB (1,610,612,736) bytes
- 3GB (1,073,741,824) bytes

MSInfo32 will report the exact same number of bytes for 1GB of dedicated video memory as it does for 3GB. The same holds true for 1.5GB and 2.5GB.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
